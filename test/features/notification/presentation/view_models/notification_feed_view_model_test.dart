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
import 'package:culcul/features/notification/presentation/view_models/notification_feed_view_model.dart';
import 'package:culcul/features/notification/application/notification_facade.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FeedFakeRepository implements NotificationRepository {
  _FeedFakeRepository(this._itemsByType);

  final Map<NotificationFeedType, List<NotificationEntry>> _itemsByType;
  final List<NotificationFeedType> syncHeadCalls = [];
  final List<NotificationFeedType> syncOlderCalls = [];

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
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async => const [];

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async => const {};

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async {
    if (cursor != null) return const [];
    return _itemsByType[type] ?? const [];
  }

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
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) async {
    syncHeadCalls.add(type);
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) async {
    syncOlderCalls.add(type);
    return const Success(null);
  }

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

NotificationEntry _entry(int id, int time) {
  return NotificationEntry(
    id: id,
    actors: const [NotificationActor(mid: 1, nickname: 'alice', avatar: 'a.png')],
    detail: const NotificationEntryDetail(
      subjectId: 100,
      type: 'reply',
      business: 'archive',
      title: 'title',
      image: '',
      uri: '',
      nativeUri: '',
      sourceContent: 'source',
      targetReplyContent: 'target',
      message: 'hello',
    ),
    replyTime: time,
    likeTime: null,
  );
}

void main() {
  test(
    'notificationFeedListProvider uses one family provider for reply/at/like',
    () async {
      final fakeRepository = _FeedFakeRepository({
        NotificationFeedType.reply: [_entry(1, 100)],
        NotificationFeedType.at: [_entry(2, 200)],
        NotificationFeedType.like: [_entry(3, 300)],
      });

      final container = ProviderContainer(
        overrides: [
          notificationOwnerUidProvider.overrideWith((ref) => 1001),
          notificationInboxFacadeProvider.overrideWithValue(
            NotificationInboxFacade(
              repository: fakeRepository,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      for (final type in const [
        NotificationFeedType.reply,
        NotificationFeedType.at,
        NotificationFeedType.like,
      ]) {
        final provider = notificationFeedListProvider(type);
        final items = await container.read(provider.future);
        expect(items.length, 1);
        expect(items.first.id, isNonZero);
        await container.read(provider.notifier).refresh();
      }

      await Future<void>.delayed(Duration.zero);

      expect(fakeRepository.syncHeadCalls, contains(NotificationFeedType.reply));
      expect(fakeRepository.syncHeadCalls, contains(NotificationFeedType.at));
      expect(fakeRepository.syncHeadCalls, contains(NotificationFeedType.like));
    },
  );
}
