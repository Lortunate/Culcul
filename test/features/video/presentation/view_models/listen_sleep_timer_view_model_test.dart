import 'dart:async';

import 'package:culcul/features/video/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('setForDuration expires and triggers stop callback', () async {
    final expired = Completer<void>();

    final container = ProviderContainer(
      overrides: [
        listenSleepTimerOnExpireProvider.overrideWith((ref) {
          return () async {
            if (!expired.isCompleted) {
              expired.complete();
            }
          };
        }),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(listenSleepTimerControllerProvider.notifier);
    notifier.setForDuration(const Duration(milliseconds: 600));

    await expired.future.timeout(const Duration(seconds: 3));
    final state = container.read(listenSleepTimerControllerProvider);
    expect(state.isActive, isFalse);
  });

  test('setCustomMinutes clamps range to 1..720 minutes', () {
    final container = ProviderContainer(
      overrides: [
        listenSleepTimerOnExpireProvider.overrideWith((ref) {
          return () async {};
        }),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(listenSleepTimerControllerProvider.notifier);
    notifier.setCustomMinutes(0);
    expect(container.read(listenSleepTimerControllerProvider).isActive, isTrue);
    expect(
      container.read(listenSleepTimerControllerProvider).total,
      const Duration(minutes: 1),
    );

    notifier.setCustomMinutes(9999);
    expect(
      container.read(listenSleepTimerControllerProvider).total,
      const Duration(minutes: 720),
    );
  });
}
