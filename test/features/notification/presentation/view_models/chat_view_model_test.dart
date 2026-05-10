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
import 'package:culcul/features/notification/feature_scope.dart';
import 'package:culcul/features/notification/presentation/view_models/chat_view_model.dart';
import 'package:culcul/features/notification/application/notification_facade.dart';
import 'package:culcul/features/notification/application/use_cases/send_private_message_use_case.dart';
import 'package:culcul/features/notification/application/use_cases/refresh_unread_and_feed_use_case.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _ChatFakeRepository implements NotificationRepository {
  bool _olderSynced = false;

  static const String _dogeUrl = 'https://example.com/doge.png';
  static const String _catUrl = 'https://example.com/cat.png';

  final List<PrivateMessage> _headMessages = [
    PrivateMessage(
      senderUid: 2,
      receiverType: PrivateMessageReceiverType.user,
      receiverId: 1001,
      type: PrivateMessageType.text,
      content: PrivateMessageContent.text('[doge] hello'),
      msgSeqno: 100,
      timestamp: 1700000100,
      atUids: null,
      msgKey: null,
      msgStatus: 0,
      notifyCode: null,
      newFaceVersion: null,
      msgSource: null,
    ),
  ];

  final List<PrivateMessage> _olderMessages = [
    PrivateMessage(
      senderUid: 2,
      receiverType: PrivateMessageReceiverType.user,
      receiverId: 1001,
      type: PrivateMessageType.text,
      content: PrivateMessageContent.text('[cat] world'),
      msgSeqno: 90,
      timestamp: 1700000000,
      atUids: null,
      msgKey: null,
      msgStatus: 0,
      notifyCode: null,
      newFaceVersion: null,
      msgSource: null,
    ),
  ];

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async {
    if (endSeqno == null) {
      return _headMessages;
    }
    return _olderMessages;
  }

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final map = <String, String>{'[doge]': _dogeUrl, 'doge': _dogeUrl};
    if (_olderSynced) {
      map['[cat]'] = _catUrl;
      map['cat'] = _catUrl;
    }
    return map;
  }

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
  }) async {
    _olderSynced = true;
    return const Success(null);
  }

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) async =>
      null;

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async => const [];

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async => const [];

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return const Stream<NotificationSummary>.empty();
  }

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return const Stream<List<SystemNotice>>.empty();
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
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
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) async => const Success(null);

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) async => const Success(null);

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) async {
    return Failure(AppError.data('not supported'));
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    return Failure(AppError.data('not supported'));
  }
}

void main() {
  test('chat build loads emoji map from repository', () async {
    final fakeRepository = _ChatFakeRepository();
    final container = ProviderContainer(
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 1001),
        notificationFacadeEntryProvider.overrideWithValue(
          NotificationFacade(
            repository: fakeRepository,
            sendPrivateMessageUseCase: SendPrivateMessageUseCase(fakeRepository),
            refreshUnreadAndFeedUseCase: RefreshUnreadAndFeedUseCase(fakeRepository),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(
      chatProvider(2002, PrivateSessionType.user).future,
    );
    expect(state.emojiMap['[doge]'], 'https://example.com/doge.png');
    expect(state.emojiMap['doge'], 'https://example.com/doge.png');
  });

  test('chat loadMore refreshes and keeps emoji map', () async {
    final fakeRepository = _ChatFakeRepository();
    final container = ProviderContainer(
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 1001),
        notificationFacadeEntryProvider.overrideWithValue(
          NotificationFacade(
            repository: fakeRepository,
            sendPrivateMessageUseCase: SendPrivateMessageUseCase(fakeRepository),
            refreshUnreadAndFeedUseCase: RefreshUnreadAndFeedUseCase(fakeRepository),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final provider = chatProvider(2002, PrivateSessionType.user);
    await container.read(provider.future);
    await container.read(provider.notifier).loadMore();

    final latest = container.read(provider).value;
    expect(latest, isNotNull);
    expect(latest!.emojiMap['[cat]'], 'https://example.com/cat.png');
    expect(latest.emojiMap['cat'], 'https://example.com/cat.png');
    expect(latest.paging.items.any((item) => item.msgSeqno == 90), isTrue);
  });
}
