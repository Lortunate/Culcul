import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/notification_system_notice_application_providers.dart';
import 'package:culcul/features/notification/application/notification_system_notice_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:culcul/features/notification/presentation/view_models/system_notification_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('system notifications read through the application notice provider', () async {
    final notices = <SystemNotice>[
      const SystemNotice(id: 1, title: 'System', text: 'Notice', time: 1000),
    ];
    final port = _FakeNotificationSystemNoticePort(initialNotices: notices);
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 42),
        notificationSystemNoticePortProvider.overrideWithValue(port),
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

    final firstNotices = await container.read(systemNotificationListProvider.future);
    await _waitForBackgroundSync(port);
    expect(port.syncOwnerUids, [42]);

    await container.read(systemNotificationListProvider.notifier).refresh();

    expect(firstNotices, notices);
    expect(port.watchOwnerUids, [42]);
    expect(port.syncOwnerUids, [42, 42]);
  });
}

Future<void> _waitForBackgroundSync(_FakeNotificationSystemNoticePort port) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (port.syncOwnerUids.isNotEmpty) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Expected initial system notification load to trigger a background sync.');
}

final class _FakeNotificationSystemNoticePort implements NotificationSystemNoticePort {
  _FakeNotificationSystemNoticePort({required this.initialNotices});

  final List<SystemNotice> initialNotices;
  final _controller = StreamController<List<SystemNotice>>.broadcast();
  final watchOwnerUids = <int>[];
  final syncOwnerUids = <int>[];

  bool _initialNoticesScheduled = false;

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    watchOwnerUids.add(ownerUid);
    if (!_initialNoticesScheduled) {
      _initialNoticesScheduled = true;
      scheduleMicrotask(() => _controller.add(initialNotices));
    }
    return _controller.stream;
  }

  @override
  Future<Result<void, AppError>> syncSystemNotices({required int ownerUid}) async {
    syncOwnerUids.add(ownerUid);
    return const Success(null);
  }

  Future<void> dispose() {
    return _controller.close();
  }
}
