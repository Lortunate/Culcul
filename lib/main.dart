import 'package:culcul/app/app.dart';
import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/runtime/root_overrides.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void main() async {
  final bootstrapStopwatch = Stopwatch()..start();
  DevLogger.log('startup', 'bootstrap_start');

  final bootstrapOverrides = await AppBootstrap.initialize();

  DevLogger.log('startup', 'bootstrap_ready', {
    'bootstrap_ms': bootstrapStopwatch.elapsedMilliseconds,
  });

  final overrides = [...bootstrapOverrides, ...createRootOverrides()];
  verifyRootOverrides(overrides);
  FrameTimingSampler.start();
  DevLogger.log('startup', 'run_app');

  runApp(
    TranslationProvider(
      child: ProviderScope(overrides: overrides, child: const CulculApp()),
    ),
  );

  // Defer MediaKit initialization to after first frame for faster startup
  WidgetsBinding.instance.addPostFrameCallback((_) {
    DevLogger.log('startup', 'first_frame');
    final sw = Stopwatch()..start();
    MediaKit.ensureInitialized();
    DevLogger.log('startup', 'media_kit_ready', {
      'task_ms': sw.elapsedMilliseconds,
    });
  });
}
