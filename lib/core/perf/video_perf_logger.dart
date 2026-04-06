import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum VideoPerfEvent {
  criticalLoaded,
  playurlLoaded,
  firstFrameReady,
  controlsFirstInteraction,
}

extension on VideoPerfEvent {
  String get value => switch (this) {
    VideoPerfEvent.criticalLoaded => 'critical_loaded',
    VideoPerfEvent.playurlLoaded => 'playurl_loaded',
    VideoPerfEvent.firstFrameReady => 'first_frame_ready',
    VideoPerfEvent.controlsFirstInteraction => 'controls_first_interaction',
  };
}

class VideoPerfLogger {
  VideoPerfLogger._();

  static const String _loggerName = 'video.performance';

  static void log(
    VideoPerfEvent event, {
    Map<String, Object?> fields = const <String, Object?>{},
  }) {
    if (!kDebugMode && !kProfileMode) {
      return;
    }

    final payload = StringBuffer('video_perf ${event.value}');
    for (final entry in fields.entries) {
      final value = entry.value;
      if (value == null) {
        continue;
      }
      payload.write(' ${entry.key}=$value');
    }

    developer.log(payload.toString(), name: _loggerName);
  }
}
