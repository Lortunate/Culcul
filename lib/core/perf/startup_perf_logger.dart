import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum StartupPerfEvent {
  bootstrapStart,
  bootstrapReady,
  runApp,
  firstFrame,
  homeReady,
  deferredWarmupStart,
  deferredWarmupReady,
}

extension on StartupPerfEvent {
  String get value => switch (this) {
    StartupPerfEvent.bootstrapStart => 'bootstrap_start',
    StartupPerfEvent.bootstrapReady => 'bootstrap_ready',
    StartupPerfEvent.runApp => 'run_app',
    StartupPerfEvent.firstFrame => 'first_frame',
    StartupPerfEvent.homeReady => 'home_ready',
    StartupPerfEvent.deferredWarmupStart => 'deferred_warmup_start',
    StartupPerfEvent.deferredWarmupReady => 'deferred_warmup_ready',
  };
}

@immutable
class StartupPerfMark {
  final StartupPerfEvent event;
  final int elapsedMs;

  const StartupPerfMark({required this.event, required this.elapsedMs});
}

class StartupPerfTimeline {
  StartupPerfTimeline({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;
  DateTime? _startedAt;
  final List<StartupPerfMark> _marks = <StartupPerfMark>[];

  List<StartupPerfMark> get marks => List<StartupPerfMark>.unmodifiable(_marks);

  StartupPerfMark mark(StartupPerfEvent event) {
    _startedAt ??= _now();
    final elapsedMs = _now().difference(_startedAt!).inMilliseconds;
    final mark = StartupPerfMark(event: event, elapsedMs: elapsedMs);
    _marks.add(mark);
    return mark;
  }

  void reset() {
    _startedAt = null;
    _marks.clear();
  }
}

class StartupPerfLogger {
  StartupPerfLogger._();

  static const String _loggerName = 'startup.performance';
  static final StartupPerfTimeline _timeline = StartupPerfTimeline();

  static void log(
    StartupPerfEvent event, {
    Map<String, Object?> fields = const <String, Object?>{},
  }) {
    if (!kDebugMode && !kProfileMode) {
      return;
    }

    final mark = _timeline.mark(event);
    final payload = StringBuffer(
      'startup_perf ${event.value} elapsed_ms=${mark.elapsedMs}',
    );
    for (final entry in fields.entries) {
      final value = entry.value;
      if (value == null) {
        continue;
      }
      payload.write(' ${entry.key}=$value');
    }

    developer.log(payload.toString(), name: _loggerName);
  }

  @visibleForTesting
  static StartupPerfTimeline get debugTimeline => _timeline;

  @visibleForTesting
  static void debugReset() {
    _timeline.reset();
  }
}
