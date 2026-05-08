import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:dio/dio.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.feed_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.local_read_store.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_send_service.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.session_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.stream_watchers.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository_impl.g.dart';

@riverpod
domain.NotificationRepository notificationRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return NotificationRepositoryImpl(
    NotificationApi(dio),
    ref.watch(notificationLocalDatabaseProvider),
    dio,
  );
}

class NotificationRepositoryImpl
    with RequestExecutorBinding
    implements domain.NotificationRepository {
  NotificationRepositoryImpl(
    this.api,
    this.database,
    this.dio, {
    RequestExecutor? requestExecutor,
  }) : requestExecutor = requestExecutor ?? const RequestExecutor() {
    localReadStore = NotificationLocalReadStore(this);
    streamWatchers = NotificationStreamWatchers(this);
    messageSendService = NotificationMessageSendService(this);
    cleanupPolicy = NotificationCleanupPolicy(this);
    sessionSync = NotificationSessionSync(this);
    messageSync = NotificationMessageSync(this);
    feedSync = NotificationFeedSync(this);
  }

  final NotificationApi api;
  final NotificationLocalDatabase database;
  final Dio dio;
  @override
  final RequestExecutor requestExecutor;
  late final NotificationLocalReadStore localReadStore;
  late final NotificationStreamWatchers streamWatchers;
  late final NotificationMessageSendService messageSendService;
  late final NotificationCleanupPolicy cleanupPolicy;
  late final NotificationSessionSync sessionSync;
  late final NotificationMessageSync messageSync;
  late final NotificationFeedSync feedSync;

  static const int pageSize = 20;
  static const int syncThrottleSeconds = 60;
  static const int retentionDays = 90;
  static const String cleanupScope = '__cleanup__';
  static const NotificationSummary emptySummary = NotificationSummary(
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

  int nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  PrivateSessionType sessionTypeFromReceiver(PrivateMessageReceiverType type) {
    return type == PrivateMessageReceiverType.group
        ? PrivateSessionType.group
        : PrivateSessionType.user;
  }

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) {
    return localReadStore.getUnreadCountFromLocal(ownerUid: ownerUid);
  }

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) {
    return localReadStore.pageSessionsFromLocal(
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
    return localReadStore.pageMessagesFromLocal(
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
    return localReadStore.getMessageEmojiMapFromLocal(
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
    return localReadStore.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursor: cursor,
    );
  }

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return streamWatchers.watchUnreadCount(ownerUid: ownerUid);
  }

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return streamWatchers.watchSystemNotices(ownerUid: ownerUid);
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return sessionSync.syncUnreadCount(ownerUid: ownerUid, force: force);
  }

  @override
  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return sessionSync.syncSessions(ownerUid: ownerUid, force: force);
  }

  @override
  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return sessionSync.syncSessionsOlder(
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
    return messageSync.syncMessagesHead(
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
    return messageSync.syncMessagesOlder(
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
    return feedSync.syncFeedHead(ownerUid: ownerUid, type: type);
  }

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) {
    return feedSync.syncFeedOlder(ownerUid: ownerUid, type: type, cursor: cursor);
  }

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) {
    return messageSendService.uploadImage(bytes, filename);
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) {
    return messageSendService.sendPrivateMessage(
      ownerUid: ownerUid,
      receiverId: receiverId,
      receiverType: receiverType,
      messageType: messageType,
      content: content,
    );
  }
}
