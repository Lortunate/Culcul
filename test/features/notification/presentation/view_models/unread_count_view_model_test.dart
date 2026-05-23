import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/notification_unread_count_application_providers.dart';
import 'package:culcul/features/notification/application/notification_unread_count_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:culcul/features/notification/presentation/view_models/unread_count_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('unread count reads through the application unread count provider', () async {
    final port = _FakeNotificationUnreadCountPort(
      initialSummary: const NotificationSummary(reply: 3, at: 2),
    );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 42),
        notificationUnreadCountPortProvider.overrideWithValue(port),
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

    final firstSummary = await container.read(unreadCountProvider.future);
    await _waitForBackgroundSync(port);
    expect(port.syncForceFlags, [false]);

    await container.read(unreadCountProvider.notifier).refresh();

    expect(firstSummary, const NotificationSummary(reply: 3, at: 2));
    expect(port.watchOwnerUids, [42]);
    expect(port.syncOwnerUids, [42, 42]);
    expect(port.syncForceFlags, [false, true]);
  });
}

Future<void> _waitForBackgroundSync(_FakeNotificationUnreadCountPort port) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (port.syncForceFlags.isNotEmpty) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Expected initial unread count load to trigger a background sync.');
}

final class _FakeNotificationUnreadCountPort implements NotificationUnreadCountPort {
  _FakeNotificationUnreadCountPort({required this.initialSummary});

  final NotificationSummary initialSummary;
  final _controller = StreamController<NotificationSummary>.broadcast();
  final watchOwnerUids = <int>[];
  final syncOwnerUids = <int>[];
  final syncForceFlags = <bool>[];

  bool _initialSummaryScheduled = false;

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    watchOwnerUids.add(ownerUid);
    if (!_initialSummaryScheduled) {
      _initialSummaryScheduled = true;
      scheduleMicrotask(() => _controller.add(initialSummary));
    }
    return _controller.stream;
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) async {
    syncOwnerUids.add(ownerUid);
    syncForceFlags.add(force);
    return const Success(null);
  }

  Future<void> dispose() {
    return _controller.close();
  }
}
