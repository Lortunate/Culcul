import 'package:culcul/core/perf/dev_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';

class DeferredAppInitController {
  DeferredAppInitController._();

  static final DeferredAppInitController instance = DeferredAppInitController._();

  bool _mediaKitReady = false;

  void ensureMediaKitInitialized() {
    if (_mediaKitReady) return;
    MediaKit.ensureInitialized();
    _mediaKitReady = true;
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
