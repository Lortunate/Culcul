import 'dart:async';

import 'package:culcul/core/perf/dev_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract interface class PlayerWakelock {
  Future<void> enable();

  Future<void> disable();
}

final class PlatformPlayerWakelock implements PlayerWakelock {
  const PlatformPlayerWakelock();

  @override
  Future<void> enable() => WakelockPlus.enable();

  @override
  Future<void> disable() => WakelockPlus.disable();
}

Future<void> syncPlayerWakelock(PlayerWakelock wakelock, {required bool playing}) {
  return playing ? wakelock.enable() : wakelock.disable();
}

ValueNotifier<double> usePlayerSystemSettings(
  Player player, {
  PlayerWakelock wakelock = const PlatformPlayerWakelock(),
}) {
  final brightness = useState(0.5);

  useEffect(() {
    final sub = player.stream.playing.listen((playing) {
      unawaited(syncPlayerWakelock(wakelock, playing: playing));
    });
    final errorSub = player.stream.error.listen((_) {
      unawaited(wakelock.disable());
    });
    return () {
      unawaited(sub.cancel());
      unawaited(errorSub.cancel());
      unawaited(wakelock.disable());
    };
  }, [player, wakelock]);

  useEffect(() {
    ScreenBrightness().application
        .then((val) {
          brightness.value = val;
        })
        .catchError((e) {
          DevLogger.log('video', 'player.brightness_read_failed', <String, Object?>{
            'error': e,
          });
        });
    return null;
  }, []);

  return brightness;
}
