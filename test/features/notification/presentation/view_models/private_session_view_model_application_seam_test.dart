import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/notification_private_session_application_providers.dart';
import 'package:culcul/features/notification/application/notification_private_session_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:culcul/features/notification/presentation/view_models/private_session_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('private session list reads through the application session provider', () async {
    final firstPage = _sessions(20, startTs: 1000);
    final olderPage = _sessions(20, startTs: 2000);
    final port = _FakeNotificationPrivateSessionPort(
      firstPage: firstPage,
      olderPage: olderPage,
    );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 42),
        notificationPrivateSessionPortProvider.overrideWithValue(port),
        notificationRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'notificationRepositoryProvider should not be read by UI state',
          ),
        ),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await port.dispose();
    });

    final provider = privateSessionListProvider;
    final firstSessions = await container.read(provider.future);
    await _waitForBackgroundSync(port);
    expect(port.syncSessionsCalls.contains(false), isTrue);
    final forcedSyncsAfterBackground = port.syncSessionsCalls
        .where((force) => force)
        .length;

    await container.refresh(provider.future);
    await container.read(provider.notifier).loadMore();

    expect(firstSessions, firstPage);
    expect(port.pageRequests.any((cursor) => cursor == null), isTrue);
    expect(port.pageRequests.any((cursor) => cursor != null), isTrue);
    expect(
      port.syncSessionsCalls.where((force) => force).length,
      greaterThan(forcedSyncsAfterBackground),
    );
    expect(port.syncOlderCalls, isNotEmpty);
    expect(port.syncOlderSessionTypes, everyElement(PrivateSessionType.user));
  });
}

Future<void> _waitForBackgroundSync(_FakeNotificationPrivateSessionPort port) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (port.syncSessionsCalls.contains(false)) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Expected initial private session load to trigger a background sync.');
}

final class _FakeNotificationPrivateSessionPort
    implements NotificationPrivateSessionPort {
  _FakeNotificationPrivateSessionPort({required this.firstPage, required this.olderPage});

  final List<PrivateSession> firstPage;
  final List<PrivateSession> olderPage;
  final pageRequests = <int?>[];
  final syncSessionsCalls = <bool>[];
  final syncOlderCalls = <int>[];
  final syncOlderSessionTypes = <PrivateSessionType>[];

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async {
    pageRequests.add(endTs);
    return endTs == null ? firstPage : olderPage;
  }

  @override
  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) async {
    syncSessionsCalls.add(force);
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) async {
    syncOlderCalls.add(endTs);
    syncOlderSessionTypes.add(sessionType);
    return const Success(null);
  }

  Future<void> dispose() async {}
}

List<PrivateSession> _sessions(int count, {required int startTs}) {
  return List.generate(
    count,
    (index) => PrivateSession(
      talkerId: index + 1 + startTs,
      sessionType: PrivateSessionType.user,
      unreadCount: index,
      isFollow: 0,
      sessionTs: startTs + index,
    ),
  );
}
