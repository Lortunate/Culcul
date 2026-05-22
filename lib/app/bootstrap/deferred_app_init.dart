import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/runtime/media_runtime_initializer.dart';
import 'package:flutter/widgets.dart';

class DeferredAppInitController {
  DeferredAppInitController._()
    : _mediaRuntimeInitializer = MediaRuntimeInitializer.instance;

  @visibleForTesting
  DeferredAppInitController.testing({required void Function() initializeMediaKit})
    : _mediaRuntimeInitializer = MediaRuntimeInitializer.testing(
        initializeMediaKit: initializeMediaKit,
      );

  static final DeferredAppInitController instance = DeferredAppInitController._();

  final MediaRuntimeInitializer _mediaRuntimeInitializer;

  void ensureMediaKitInitialized() {
    _mediaRuntimeInitializer.ensureInitialized();
  }

  void scheduleAfterFirstFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sw = Stopwatch()..start();
      ensureMediaKitInitialized();
      DevLogger.log('startup', 'deferred_warmup_ready', {
        'task': 'media_kit',
        'task_ms': sw.elapsedMilliseconds,
      });
    });
  }
}
