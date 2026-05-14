import 'package:culcul/app/app.dart';
import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/bootstrap/deferred_app_init.dart';
import 'package:culcul/app/runtime/root_overrides.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final bootstrapStopwatch = Stopwatch()..start();
  DevLogger.log('startup', 'bootstrap_start');

  final bootstrapOverrides = await AppBootstrap.initialize();

  DevLogger.log(
    'startup',
    'bootstrap_ready',
    {'bootstrap_ms': bootstrapStopwatch.elapsedMilliseconds},
  );

  final overrides = [...bootstrapOverrides, ...createRootOverrides()];
  verifyRootOverrides(overrides);
  FrameTimingSampler.start();
  DevLogger.log('startup', 'run_app');

  runApp(
    TranslationProvider(
      child: ProviderScope(overrides: overrides, child: const CulculApp()),
    ),
  );

  DeferredAppInitController.instance.scheduleAfterFirstFrame();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    DevLogger.log('startup', 'first_frame');
  });
}
