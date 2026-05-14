import 'package:culcul/features/video/presentation/player/hooks/use_player_system_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('syncPlayerWakelock', () {
    test('enables wakelock only for active playback', () async {
      final wakelock = _FakePlayerWakelock();

      await syncPlayerWakelock(wakelock, playing: true);
      await syncPlayerWakelock(wakelock, playing: false);

      expect(wakelock.calls, <String>['enable', 'disable']);
    });
  });
}

final class _FakePlayerWakelock implements PlayerWakelock {
  final List<String> calls = <String>[];

  @override
  Future<void> enable() async {
    calls.add('enable');
  }

  @override
  Future<void> disable() async {
    calls.add('disable');
  }
}
