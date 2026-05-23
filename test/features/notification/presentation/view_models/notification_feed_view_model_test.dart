import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/application/notification_feed_application_providers.dart';
import 'package:culcul/features/notification/application/notification_feed_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_feed_view_model.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('notification feed list reads through the application feed provider', () async {
    final port = _FakeNotificationFeedPort(entries: _entries(20));
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        currentUserProvider.overrideWith((ref) => const _FakeUserSession(uid: '42')),
        notificationOwnerUidProvider.overrideWith((ref) => 42),
        notificationFeedPortProvider.overrideWithValue(port),
        notificationRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'notificationRepositoryProvider should not be read by UI state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final provider = notificationFeedListProvider(NotificationFeedType.reply);
    final firstPage = await container.read(provider.future);
    await _waitForBackgroundSync(port);
    expect(port.syncHeadCalls.length, greaterThanOrEqualTo(2));

    await container.read(provider.notifier).refresh();
    await container.read(provider.notifier).loadMore();

    expect(firstPage, _entries(20));
    expect(port.syncOlderCalls, isNotEmpty);
    expect(port.pageFeedCursorRequests.any((cursor) => cursor == null), isTrue);
    expect(port.pageFeedCursorRequests.any((cursor) => cursor != null), isTrue);
    expect(port.syncHeadTypes, everyElement(NotificationFeedType.reply));
    expect(port.syncOlderTypes, everyElement(NotificationFeedType.reply));
  });
}

Future<void> _waitForBackgroundSync(_FakeNotificationFeedPort port) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (port.syncHeadCalls.length >= 2) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Expected initial load to trigger a background feed head sync.');
}

final class _FakeNotificationFeedPort implements NotificationFeedPort {
  _FakeNotificationFeedPort({required this.entries});

  final List<NotificationEntry> entries;
  final syncHeadCalls = <NotificationFeedType>[];
  final syncOlderCalls = <NotificationFeedType>[];
  final pageFeedCursorRequests = <NotificationFeedCursor?>[];
  final syncHeadTypes = <NotificationFeedType>[];
  final syncOlderTypes = <NotificationFeedType>[];

  @override
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) async {
    syncHeadCalls.add(type);
    syncHeadTypes.add(type);
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) async {
    syncOlderCalls.add(type);
    syncOlderTypes.add(type);
    return const Success(null);
  }

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async {
    pageFeedCursorRequests.add(cursor);
    return entries;
  }
}

final class _FakeUserSession implements UserSession {
  const _FakeUserSession({required this.uid});

  @override
  final String uid;

  @override
  bool get isLoggedIn => true;

  @override
  String? get avatarUrl => null;

  @override
  String? get nickname => null;
}

List<NotificationEntry> _entries(int count) {
  return List.generate(
    count,
    (index) => NotificationEntry(
      id: index + 1,
      actors: const [],
      detail: NotificationEntryDetail(
        subjectId: index + 100,
        type: 'reply',
        business: 'reply',
      ),
      replyTime: 1000 + index,
      likeTime: null,
    ),
  );
}
