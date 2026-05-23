import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/features/notification/application/notification_resume_sync_application_providers.dart';
import 'package:culcul/features/notification/application/notification_resume_sync_port.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('lifecycle resume sync reads through the application resume provider', () async {
    final resumeSyncPort = _FakeNotificationResumeSyncPort();
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        notificationOwnerUidProvider.overrideWith((ref) => 42),
        notificationResumeSyncPortProvider.overrideWithValue(resumeSyncPort),
        dioClientProvider.overrideWith(
          (ref) => throw StateError(
            'notificationRepositoryProvider dependencies should not be read by lifecycle UI state',
          ),
        ),
        notificationLocalDatabaseProvider.overrideWith(
          (ref) => throw StateError(
            'notificationRepositoryProvider dependencies should not be read by lifecycle UI state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(notificationLifecycleSyncProvider), isTrue);

    container
        .read(notificationLifecycleSyncProvider.notifier)
        .didChangeAppLifecycleState(AppLifecycleState.resumed);

    await _waitForResumeSync(resumeSyncPort);

    expect(resumeSyncPort.ownerUids, [42]);
  });
}

Future<void> _waitForResumeSync(_FakeNotificationResumeSyncPort port) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (port.ownerUids.isNotEmpty) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Expected app resume to trigger notification resume sync.');
}

final class _FakeNotificationResumeSyncPort implements NotificationResumeSyncPort {
  final ownerUids = <int>[];

  @override
  Future<void> syncOnResume({required int ownerUid}) async {
    ownerUids.add(ownerUid);
  }
}
