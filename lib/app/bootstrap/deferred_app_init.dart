import 'dart:async';

import 'package:culcul/core/perf/dev_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';

class AppWarmupTask {
  final String label;
  final FutureOr<void> Function() run;

  const AppWarmupTask({required this.label, required this.run});
}

class DeferredAppInitController {
  DeferredAppInitController._();

  static final DeferredAppInitController instance = DeferredAppInitController._();

  final List<AppWarmupTask> _tasks = <AppWarmupTask>[
    AppWarmupTask(label: 'media_kit', run: MediaKit.ensureInitialized),
  ];

  bool _didSchedule = false;
  bool _mediaKitReady = false;
  Future<void>? _warmupFuture;

  void scheduleAfterFirstFrame() {
    if (_didSchedule) {
      return;
    }
    _didSchedule = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(runWarmups());
    });
  }

  void ensureMediaKitInitialized() {
    if (_mediaKitReady) {
      return;
    }
    MediaKit.ensureInitialized();
    _mediaKitReady = true;
  }

  Future<void> runWarmups() {
    final existing = _warmupFuture;
    if (existing != null) {
      return existing;
    }

    final future = _runWarmups();
    _warmupFuture = future;
    return future;
  }

  Future<void> _runWarmups() async {
    DevLogger.log(
      'startup',
      'deferred_warmup_start',
      <String, Object?>{'task_count': _tasks.length},
    );
    final stopwatch = Stopwatch()..start();
    await Future.wait(
      _tasks.map((task) async {
        final taskWatch = Stopwatch()..start();
        try {
          await Future<void>.sync(task.run);
          if (task.label == 'media_kit') {
            _mediaKitReady = true;
          }
          DevLogger.log(
            'startup',
            'deferred_warmup_ready',
            <String, Object?>{
              'task': task.label,
              'task_ms': taskWatch.elapsedMilliseconds,
            },
          );
        } catch (_) {
          // Defer-only warmups must never block the main app flow.
        }
      }),
      eagerError: false,
    );

    DevLogger.log(
      'startup',
      'deferred_warmup_ready',
      <String, Object?>{'total_ms': stopwatch.elapsedMilliseconds},
    );
  }
}
