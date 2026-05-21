import 'package:culcul/core/perf/dev_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';

class DeferredAppInitController {
  DeferredAppInitController._() : _initializeMediaKit = MediaKit.ensureInitialized;

  @visibleForTesting
  DeferredAppInitController.testing({required void Function() initializeMediaKit})
    : _initializeMediaKit = initializeMediaKit;

  static final DeferredAppInitController instance = DeferredAppInitController._();

  final void Function() _initializeMediaKit;

  bool _mediaKitReady = false;

  void ensureMediaKitInitialized() {
    if (_mediaKitReady) return;
    _initializeMediaKit();
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
