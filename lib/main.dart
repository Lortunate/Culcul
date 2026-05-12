import 'package:culcul/app/app.dart';
import 'package:culcul/app/bootstrap/deferred_app_init.dart';
import 'package:culcul/app/runtime/bootstrap_coordinator.dart';
import 'package:culcul/app/runtime/root_overrides.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final runtime = await BootstrapCoordinator.initialize();
  final overrides = createRootOverrides(runtime);
  verifyRootOverrides(overrides);
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
