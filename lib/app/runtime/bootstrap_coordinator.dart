import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/core/perf/dev_logger.dart';

class BootstrapCoordinator {
  const BootstrapCoordinator._();

  static Future<AppRuntime> initialize() async {
    final bootstrapStopwatch = Stopwatch()..start();
    DevLogger.log('startup', 'bootstrap_start');
    final runtime = await AppBootstrap.initialize();
    DevLogger.log(
      'startup',
      'bootstrap_ready',
      {'bootstrap_ms': bootstrapStopwatch.elapsedMilliseconds},
    );
    FrameTimingSampler.start();
    return runtime;
  }
}
