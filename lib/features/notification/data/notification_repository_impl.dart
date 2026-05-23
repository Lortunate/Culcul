import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:dio/dio.dart';
import 'package:culcul/features/notification/application/notification_feed_port.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_message_persistence.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.feed_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.local_read_store.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_send_service.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.session_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.stream_watchers.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository_impl.g.dart';

@riverpod
NotificationRepositoryImpl notificationRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return NotificationRepositoryImpl(
    NotificationApi(dio),
    ref.watch(notificationLocalDatabaseProvider),
    dio,
  );
}

class NotificationRepositoryImpl implements NotificationFeedPort {
  NotificationRepositoryImpl(
    this._api,
    this._database,
    this._dio, {
    RequestExecutor? requestExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor() {
    _persistence = NotificationMessagePersistence(_database);

    _cleanupPolicy = NotificationCleanupPolicy(
      database: _database,
      syncThrottleSeconds: syncThrottleSeconds,
      retentionDays: retentionDays,
      cleanupScope: cleanupScope,
      nowSeconds: nowSeconds,
    );

    _messageSupport = NotificationMessageSupport(
      api: _api,
      requestExecutor: _requestExecutor,
      pageSize: pageSize,
    );

    _streamWatchers = NotificationStreamWatchers(
      database: _database,
      emptySummary: emptySummary,
    );

    _localReadStore = NotificationLocalReadStore(
      database: _database,
      persistence: _persistence,
      pageSize: pageSize,
    );

    _messageSync = NotificationMessageSync(
      database: _database,
      api: _api,
      requestExecutor: _requestExecutor,
      cleanupPolicy: _cleanupPolicy,
      persistence: _persistence,
      pageSize: pageSize,
      nowSeconds: nowSeconds,
    );

    _sessionSync = NotificationSessionSync(
      database: _database,
      api: _api,
      requestExecutor: _requestExecutor,
      cleanupPolicy: _cleanupPolicy,
      persistence: _persistence,
      nowSeconds: nowSeconds,
    );

    _feedSync = NotificationFeedSync(
      database: _database,
      api: _api,
      requestExecutor: _requestExecutor,
      cleanupPolicy: _cleanupPolicy,
      messageSupport: _messageSupport,
      nowSeconds: nowSeconds,
    );

    _messageSendService = NotificationMessageSendService(
      database: _database,
      api: _api,
      dio: _dio,
      requestExecutor: _requestExecutor,
      persistence: _persistence,
      messageSupport: _messageSupport,
      nowSeconds: nowSeconds,
      syncMessagesHead:
          ({
            required int ownerUid,
            required int talkerId,
            required PrivateSessionType sessionType,
          }) async {
            await _messageSync.syncMessagesHead(
              ownerUid: ownerUid,
              talkerId: talkerId,
              sessionType: sessionType,
            );
          },
    );
  }

  final NotificationApi _api;
  final NotificationLocalDatabase _database;
  final Dio _dio;
  final RequestExecutor _requestExecutor;

  late final NotificationMessagePersistence _persistence;
  late final NotificationCleanupPolicy _cleanupPolicy;
  late final NotificationMessageSupport _messageSupport;
  late final NotificationStreamWatchers _streamWatchers;
  late final NotificationLocalReadStore _localReadStore;
  late final NotificationMessageSync _messageSync;
  late final NotificationSessionSync _sessionSync;
  late final NotificationFeedSync _feedSync;
  late final NotificationMessageSendService _messageSendService;

  static const int pageSize = 20;
  static const int syncThrottleSeconds = 60;
  static const int retentionDays = 90;
  static const String cleanupScope = '__cleanup__';
  static const NotificationSummary emptySummary = NotificationSummary();

  int nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) {
    return _localReadStore.getUnreadCountFromLocal(ownerUid: ownerUid);
  }

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
    NotificationFeedCursor? cursor,
  }) {
    return _localReadStore.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursor: cursor,
    );
  }

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return _streamWatchers.watchUnreadCount(ownerUid: ownerUid);
  }

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return _streamWatchers.watchSystemNotices(ownerUid: ownerUid);
  }

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return _sessionSync.syncUnreadCount(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _sessionSync.syncSessions(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return _sessionSync.syncSessionsOlder(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
    );
  }

  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _messageSync.syncMessagesHead(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) {
    return _messageSync.syncMessagesOlder(
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
    return _feedSync.syncFeedHead(ownerUid: ownerUid, type: type);
  }

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) {
    return _feedSync.syncFeedOlder(ownerUid: ownerUid, type: type, cursor: cursor);
  }

  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) {
    return _messageSendService.uploadImage(bytes, filename);
  }

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
}
