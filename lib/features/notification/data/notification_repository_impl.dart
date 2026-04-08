import 'dart:convert';
import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart'
    as domain;
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'notification_repository_impl.g.dart';
part 'notification_repository_impl.local_read_store.dart';
part 'notification_repository_impl.stream_watchers.dart';
part 'notification_repository_impl.sync_service.dart';
part 'notification_repository_impl.facade.dart';
part 'notification_repository_impl.facade_local.dart';
part 'notification_repository_impl.session_sync.dart';
part 'notification_repository_impl.message_sync.dart';
part 'notification_repository_impl.feed_sync.dart';
part 'notification_repository_impl.message_send_service.dart';
part 'notification_repository_impl.message_send_helpers.dart';
part 'notification_repository_impl.message_support.dart';
part 'notification_repository_impl.message_support_helpers.dart';
part 'notification_repository_impl.cleanup_policy.dart';

@riverpod
domain.NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    NotificationApi(ref.watch(dioClientProvider)),
    ref.watch(notificationLocalDatabaseProvider),
  );
}

class NotificationRepositoryImpl
    with
        RequestExecutorBinding,
        _NotificationRepositoryFacadeLocal,
        _NotificationRepositoryFacade
    implements domain.NotificationRepository {
  NotificationRepositoryImpl(
    this._api,
    this._database, {
    RequestExecutor? requestExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor() {
    _localReadStore = _NotificationLocalReadStore(this);
    _streamWatchers = _NotificationStreamWatchers(this);
    _syncService = _NotificationSyncService(this);
    _messageSendService = _NotificationMessageSendService(this);
    _cleanupPolicy = _NotificationCleanupPolicy(this);
  }

  final NotificationApi _api;
  final NotificationLocalDatabase _database;
  @override
  final RequestExecutor _requestExecutor;

  @override
  late final _NotificationLocalReadStore _localReadStore;
  @override
  late final _NotificationStreamWatchers _streamWatchers;
  @override
  late final _NotificationSyncService _syncService;
  @override
  late final _NotificationMessageSendService _messageSendService;
  late final _NotificationCleanupPolicy _cleanupPolicy;

  static const int _pageSize = 20;
  static const int _syncThrottleSeconds = 60;
  static const int _retentionDays = 90;
  static const String _cleanupScope = '__cleanup__';
  static const NotificationSummary _emptySummary = NotificationSummary(
    at: 0,
    chat: 0,
    coin: 0,
    danmu: 0,
    favorite: 0,
    like: 0,
    recvLike: 0,
    recvReply: 0,
    reply: 0,
    system: 0,
    up: 0,
  );

  int _nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  PrivateSessionType _sessionTypeFromReceiver(PrivateMessageReceiverType type) {
    return type == PrivateMessageReceiverType.group
        ? PrivateSessionType.group
        : PrivateSessionType.user;
  }
}
