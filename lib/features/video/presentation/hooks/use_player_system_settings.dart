import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

ValueNotifier<double> usePlayerSystemSettings(Player player) {
  final brightness = useState(0.5);

  useEffect(() {
    final sub = player.stream.playing.listen((playing) {
      if (playing) {
        WakelockPlus.enable();
      } else {
        WakelockPlus.disable();
      }
    });
    return sub.cancel;
  }, []);

  useEffect(() {
    ScreenBrightness().application
        .then((val) {
          brightness.value = val;
        })
        .catchError((e) {
          debugPrint('Failed to get brightness: $e');
        });
    return null;
  }, []);

  return brightness;
}

