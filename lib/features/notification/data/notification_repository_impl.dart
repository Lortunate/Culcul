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
part 'notification_repository_impl.session_sync.dart';
part 'notification_repository_impl.message_sync.dart';
part 'notification_repository_impl.feed_sync.dart';
part 'notification_repository_impl.message_send_service.dart';
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
    with RequestExecutorBinding
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
  final RequestExecutor _requestExecutor;

  late final _NotificationLocalReadStore _localReadStore;
  late final _NotificationStreamWatchers _streamWatchers;
  late final _NotificationSyncService _syncService;
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

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) {
    return _localReadStore.getUnreadCountFromLocal(ownerUid: ownerUid);
  }

  @override
  Future<List<SystemNotice>> listSystemNoticesFromLocal({required int ownerUid}) {
    return _localReadStore.listSystemNoticesFromLocal(ownerUid: ownerUid);
  }

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) {
    return _localReadStore.pageSessionsFromLocal(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
    );
  }

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) {
    return _localReadStore.pageMessagesFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
    );
  }

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _localReadStore.getMessageEmojiMapFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    int? cursorId,
    int? cursorTime,
  }) {
    return _localReadStore.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursorId,
      cursorTime: cursorTime,
    );
  }

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return _streamWatchers.watchUnreadCount(ownerUid: ownerUid);
  }

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return _streamWatchers.watchSystemNotices(ownerUid: ownerUid);
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return _syncService.syncUnreadCount(ownerUid: ownerUid, force: force);
  }

  @override
  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _syncService.syncSessions(ownerUid: ownerUid, force: force);
  }

  @override
  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return _syncService.syncSessionsOlder(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
    );
  }

  @override
  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _syncService.syncMessagesHead(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  @override
  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) {
    return _syncService.syncMessagesOlder(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
    );
  }

  @override
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    return _syncService.syncFeedHead(ownerUid: ownerUid, type: type);
  }

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required int cursorId,
    required int cursorTime,
  }) {
    return _syncService.syncFeedOlder(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursorId,
      cursorTime: cursorTime,
    );
  }

  Future<void> retryFailedOutbox({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _messageSendService.retryFailedOutbox(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(File file) {
    return _messageSendService.uploadImage(file);
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) {
    return _messageSendService.sendPrivateMessage(
      ownerUid: ownerUid,
      receiverId: receiverId,
      receiverType: receiverType,
      messageType: messageType,
      content: content,
    );
  }

  int _nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  PrivateSessionType _sessionTypeFromReceiver(PrivateMessageReceiverType type) {
    return type == PrivateMessageReceiverType.group
        ? PrivateSessionType.group
        : PrivateSessionType.user;
  }
}
