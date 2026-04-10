import 'dart:io';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('resume sync uses bounded background concurrency', () async {
    final tracker = _InFlightTracker();
    final repository = _FakeNotificationRepository(tracker);
    final container = ProviderContainer(
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 1001),
        notificationRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    container.read(notificationLifecycleSyncProvider);
    final notifier = container.read(notificationLifecycleSyncProvider.notifier);
    notifier.didChangeAppLifecycleState(AppLifecycleState.resumed);

    await _waitUntil(() => repository.attemptedSyncCalls == 5 && tracker.inFlight == 0);
    expect(repository.completedSyncCalls, 5);
    expect(tracker.maxInFlight, lessThanOrEqualTo(2));
  });

  test('resume sync continues other tasks when optional sync fails', () async {
    final tracker = _InFlightTracker();
    final repository = _FakeNotificationRepository(
      tracker,
      failScopes: const <String>{'sessions', 'feed_at'},
    );
    final container = ProviderContainer(
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 1001),
        notificationRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    container.read(notificationLifecycleSyncProvider);
    final notifier = container.read(notificationLifecycleSyncProvider.notifier);
    notifier.didChangeAppLifecycleState(AppLifecycleState.resumed);

    await _waitUntil(() => repository.attemptedSyncCalls == 5 && tracker.inFlight == 0);
    expect(repository.completedSyncCalls, 3);
    expect(tracker.maxInFlight, lessThanOrEqualTo(2));
  });
}

Future<void> _waitUntil(
  bool Function() predicate, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    if (predicate()) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  throw StateError('Timeout waiting for lifecycle sync');
}

class _InFlightTracker {
  int inFlight = 0;
  int maxInFlight = 0;
}

class _FakeNotificationRepository extends Fake implements NotificationRepository {
  _FakeNotificationRepository(this._tracker, {this.failScopes = const <String>{}});

  final _InFlightTracker _tracker;
  final Set<String> failScopes;
  int attemptedSyncCalls = 0;
  int completedSyncCalls = 0;

  Future<Result<void, AppError>> _syncCall({required String scope}) async {
    attemptedSyncCalls++;
    _tracker.inFlight++;
    if (_tracker.inFlight > _tracker.maxInFlight) {
      _tracker.maxInFlight = _tracker.inFlight;
    }
    try {
      await Future<void>.delayed(const Duration(milliseconds: 80));
      if (failScopes.contains(scope)) {
        return Failure(AppError.data('$scope failed'));
      }
      completedSyncCalls++;
      return const Success(null);
    } finally {
      _tracker.inFlight--;
    }
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return _syncCall(scope: 'unread');
  }

  @override
  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _syncCall(scope: 'sessions');
  }

  @override
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    final scope = switch (type) {
      NotificationFeedType.reply => 'feed_reply',
      NotificationFeedType.at => 'feed_at',
      NotificationFeedType.like => 'feed_like',
      NotificationFeedType.system => 'feed_system',
    };
    return _syncCall(scope: scope);
  }

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) async =>
      null;

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async => const <PrivateSession>[];

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async => const <PrivateMessage>[];

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async => const <String, String>{};

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async => const <NotificationEntry>[];

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) =>
      const Stream<NotificationSummary>.empty();

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) =>
      const Stream<List<SystemNotice>>.empty();

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
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) async => const Success(null);

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(File file) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    throw UnimplementedError();
  }
}
