import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PerformancePolicy', () {
    test('keeps normal rendering until enough frame samples exist', () {
      final policy = PerformancePolicy.fromFrameSummary(
        const FrameTimingSummary(
          samples: 59,
          buildP50Us: 4000,
          buildP95Us: 20000,
          rasterP50Us: 4000,
          rasterP95Us: 20000,
          jankRatio: 0.90,
        ),
      );

      expect(policy.level, RenderDegradeLevel.normal);
      expect(policy.blurEnabled, isTrue);
      expect(policy.shimmerEnabled, isTrue);
    });

    test('reduces effects for moderate frame pressure', () {
      final policy = PerformancePolicy.fromFrameSummary(
        const FrameTimingSummary(
          samples: 60,
          buildP50Us: 5000,
          buildP95Us: 10000,
          rasterP50Us: 5000,
          rasterP95Us: 9000,
          jankRatio: 0.18,
        ),
      );

      expect(policy.level, RenderDegradeLevel.reducedEffects);
      expect(policy.blurEnabled, isFalse);
      expect(policy.shimmerEnabled, isTrue);
    });

    test('uses minimal effects for severe frame pressure', () {
      final policy = PerformancePolicy.fromFrameSummary(
        const FrameTimingSummary(
          samples: 60,
          buildP50Us: 5000,
          buildP95Us: 14000,
          rasterP50Us: 5000,
          rasterP95Us: 9000,
          jankRatio: 0.20,
        ),
      );

      expect(policy.level, RenderDegradeLevel.minimalEffects);
      expect(policy.blurEnabled, isFalse);
      expect(policy.shimmerEnabled, isFalse);
    });
  });

  group('RuntimePerformancePolicy', () {
    test('uses interactive profile for fast connectivity and resumed lifecycle', () {
      final policy = RuntimePerformancePolicy.resolve(
        networkProfile: NetworkQualityProfile.fast,
        lifecycleState: AppLifecycleState.resumed,
        renderPolicy: const PerformancePolicy.normal(),
      );

      expect(policy.profile, PerformanceProfile.interactive);
      expect(policy.requestConcurrencyClass, RequestConcurrencyClass.foreground);
      expect(policy.timerBehavior, RuntimeTimerBehavior.normal);
      expect(policy.allowImagePrefetch, isTrue);
      expect(policy.allowsNonCriticalPrefetch, isTrue);
    });

    test('lowers prefetch and concurrency for constrained connectivity', () {
      final policy = RuntimePerformancePolicy.resolve(
        networkProfile: NetworkQualityProfile.constrained,
        lifecycleState: AppLifecycleState.resumed,
        renderPolicy: const PerformancePolicy.normal(),
      );

      expect(policy.profile, PerformanceProfile.constrained);
      expect(policy.requestConcurrencyClass, RequestConcurrencyClass.limited);
      expect(policy.timerBehavior, RuntimeTimerBehavior.throttled);
      expect(policy.networkPrefetchLimitFactor, 0.5);
      expect(policy.networkPrefetchMaxConcurrency, 1);
      expect(policy.allowImagePrefetch, isFalse);
    });

    test('background lifecycle disables non-critical prefetch and polling', () {
      final policy = RuntimePerformancePolicy.resolve(
        networkProfile: NetworkQualityProfile.fast,
        lifecycleState: AppLifecycleState.paused,
        renderPolicy: const PerformancePolicy.normal(),
      );

      expect(policy.profile, PerformanceProfile.background);
      expect(policy.requestConcurrencyClass, RequestConcurrencyClass.suspended);
      expect(policy.timerBehavior, RuntimeTimerBehavior.suspended);
      expect(policy.networkPrefetchMaxConcurrency, 0);
      expect(policy.allowImagePrefetch, isFalse);
      expect(policy.allowsNonCriticalPrefetch, isFalse);
    });

    test('bridges severe render degradation to constrained runtime policy', () {
      final policy = RuntimePerformancePolicy.fromRenderPolicy(
        const PerformancePolicy.minimalEffects(),
      );

      expect(policy.profile, PerformanceProfile.constrained);
      expect(policy.requestConcurrencyClass, RequestConcurrencyClass.limited);
      expect(policy.allowStaleCache, isTrue);
    });
  });
}
