import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/core/perf/startup_perf_logger.dart';

class BootstrapCoordinator {
  const BootstrapCoordinator._();

  static Future<AppRuntime> initialize() async {
    final bootstrapStopwatch = Stopwatch()..start();
    StartupPerfLogger.log(StartupPerfEvent.bootstrapStart);
    final runtime = await AppBootstrap.initialize();
    StartupPerfLogger.log(
      StartupPerfEvent.bootstrapReady,
      fields: {'bootstrap_ms': bootstrapStopwatch.elapsedMilliseconds},
    );
    FrameTimingSampler.start();
    return runtime;
  }
}
