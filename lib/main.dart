import 'package:culcul/app/app.dart';
import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/bootstrap/deferred_app_init.dart';
import 'package:culcul/app/bootstrap/provider_overrides.dart';
import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/core/perf/startup_perf_logger.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final bootstrapStopwatch = Stopwatch()..start();
  StartupPerfLogger.log(StartupPerfEvent.bootstrapStart);
  final dependencies = await AppBootstrap.initialize();
  StartupPerfLogger.log(
    StartupPerfEvent.bootstrapReady,
    fields: {'bootstrap_ms': bootstrapStopwatch.elapsedMilliseconds},
  );
  FrameTimingSampler.start();
  StartupPerfLogger.log(StartupPerfEvent.runApp);

  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: createProviderOverrides(dependencies),
        child: const CulculApp(),
      ),
    ),
  );

  DeferredAppInitController.instance.scheduleAfterFirstFrame();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    StartupPerfLogger.log(StartupPerfEvent.firstFrame);
  });
}
