import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
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
    initializeCookieJar(runtime.cookieJar);
    initializeCacheStore(runtime.cacheStore);
    initializeSharedPreferences(runtime.prefs);
    FrameTimingSampler.start();
    return runtime;
  }
}
