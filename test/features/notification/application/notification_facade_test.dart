import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:culcul/features/notification/application/notification_facade.dart';
import 'package:culcul/features/notification/application/use_cases/refresh_unread_and_feed_use_case.dart';
import 'package:culcul/features/notification/application/use_cases/send_private_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepository implements NotificationRepository {
  int sentMessages = 0;
  List<String> refreshCalls = [];

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    sentMessages++;
    return const Success(SendMessageResult(msgKey: 1));
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) async {
    refreshCalls.add('unread');
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) async {
    refreshCalls.add('feed');
    return const Success(null);
  }

  // --- Unused Overrides ---

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async => {};

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) async => null;

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async => [];

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async => [];

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async => [];

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) async => const Success(null);

  @override
  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async => const Success(null);

  @override
  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) async => const Success(null);

  @override
  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) async => const Success(null);

  @override
  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) async => const Success(null);

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) async => Failure(AppError.data('not implemented'));

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) => const Stream.empty();

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) => const Stream.empty();
}

void main() {
  group('NotificationFacade', () {
    late NotificationFacade facade;
    late _FakeRepository fakeRepository;

    setUp(() {
      fakeRepository = _FakeRepository();
      facade = NotificationFacade(
        repository: fakeRepository,
        sendPrivateMessageUseCase: SendPrivateMessageUseCase(fakeRepository),
        refreshUnreadAndFeedUseCase: RefreshUnreadAndFeedUseCase(fakeRepository),
      );
    });

    test('notification facade sends chat messages through an application service', () async {
      final result = await facade.sendPrivateMessage(
        ownerUid: 1,
        receiverId: 2,
        receiverType: PrivateMessageReceiverType.user,
        messageType: PrivateMessageType.text,
        content: PrivateMessageContent.text('hi'),
      );

      expect(result.isSuccess, isTrue);
      expect(fakeRepository.sentMessages, 1);
    });

    test('notification facade refreshes unread and feed state through explicit workflows', () async {
      await facade.refreshUnreadAndFeed(ownerUid: 1, feedType: NotificationFeedType.reply);
      
      // Since it's a Future.wait, order could be either way but both should be present
      expect(fakeRepository.refreshCalls, containsAll(['unread', 'feed']));
      expect(fakeRepository.refreshCalls.length, 2);
    });
  });
}
