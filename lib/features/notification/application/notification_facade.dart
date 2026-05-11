import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/use_cases/refresh_unread_and_feed_use_case.dart';
import 'package:culcul/features/notification/application/use_cases/send_private_message_use_case.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'dart:typed_data';
import 'package:culcul/features/notification/application/notification_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_facade.g.dart';

@riverpod
NotificationFacade notificationFacade(Ref ref) {
  return NotificationFacade(
    repository: ref.watch(notificationRepositoryEntryProvider),
    sendPrivateMessageUseCase: ref.watch(sendPrivateMessageUseCaseProvider),
    refreshUnreadAndFeedUseCase: ref.watch(refreshUnreadAndFeedUseCaseProvider),
  );
}

class NotificationFacade {
  NotificationFacade({
    required NotificationRepository repository,
    required SendPrivateMessageUseCase sendPrivateMessageUseCase,
    required RefreshUnreadAndFeedUseCase refreshUnreadAndFeedUseCase,
  })  : _repository = repository,
        _sendPrivateMessage = sendPrivateMessageUseCase,
        _refreshUnreadAndFeed = refreshUnreadAndFeedUseCase;

  final NotificationRepository _repository;
  final SendPrivateMessageUseCase _sendPrivateMessage;
  final RefreshUnreadAndFeedUseCase _refreshUnreadAndFeed;

  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) {
    return _sendPrivateMessage(SendPrivateMessageCommand(
      ownerUid: ownerUid,
      receiverId: receiverId,
      receiverType: receiverType,
      messageType: messageType,
      content: content,
    ));
  }

  Future<void> refreshUnreadAndFeed({
    required int ownerUid,
    required NotificationFeedType feedType,
  }) async {
    await _refreshUnreadAndFeed(RefreshUnreadAndFeedCommand(
      ownerUid: ownerUid,
      feedType: feedType,
    ));
  }

  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) {
    return _repository.getUnreadCountFromLocal(ownerUid: ownerUid);
  }

  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) {
    return _repository.pageSessionsFromLocal(
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
    return _repository.pageMessagesFromLocal(
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
    return _repository.getMessageEmojiMapFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) {
    return _repository.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursor: cursor,
    );
  }

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return _repository.watchUnreadCount(ownerUid: ownerUid);
  }

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return _repository.watchSystemNotices(ownerUid: ownerUid);
  }

  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) {
    return _repository.uploadImage(bytes, filename);
  }

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return _repository.syncUnreadCount(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _repository.syncSessions(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return _repository.syncSessionsOlder(
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
    return _repository.syncMessagesHead(
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
    return _repository.syncMessagesOlder(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
    );
  }

  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    return _repository.syncFeedHead(ownerUid: ownerUid, type: type);
  }

  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) {
    return _repository.syncFeedOlder(ownerUid: ownerUid, type: type, cursor: cursor);
  }
}
