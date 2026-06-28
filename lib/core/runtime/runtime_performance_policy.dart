import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:flutter/widgets.dart';

enum PerformanceProfile { active, background }

enum RuntimeTimerBehavior { normal, suspended }

class RuntimePerformancePolicy {
  final PerformanceProfile profile;
  final RuntimeTimerBehavior timerBehavior;
  final double networkPrefetchLimitFactor;
  final int networkPrefetchMaxConcurrency;
  final bool allowImagePrefetch;
  final bool allowStaleCache;

  const RuntimePerformancePolicy({
    required this.profile,
    required this.timerBehavior,
    required this.networkPrefetchLimitFactor,
    required this.networkPrefetchMaxConcurrency,
    required this.allowImagePrefetch,
    required this.allowStaleCache,
  });

  bool get allowsNonCriticalPrefetch =>
      profile == PerformanceProfile.active && networkPrefetchMaxConcurrency > 0;

  static RuntimePerformancePolicy resolve({
    required NetworkQualityProfile networkProfile,
    required AppLifecycleState lifecycleState,
    required PerformancePolicy renderPolicy,
  }) {
    if (lifecycleState != AppLifecycleState.resumed) {
      return background();
    }

    final networkPolicy = NetworkQualityPolicy.forProfile(networkProfile);
    final isConstrained = networkProfile == NetworkQualityProfile.constrained ||
        renderPolicy.level == RenderDegradeLevel.minimalEffects;

    return RuntimePerformancePolicy(
      profile: PerformanceProfile.active,
      timerBehavior: RuntimeTimerBehavior.normal,
      networkPrefetchLimitFactor: networkPolicy.prefetchLimitFactor,
      networkPrefetchMaxConcurrency: networkPolicy.prefetchMaxConcurrency,
      allowImagePrefetch: !isConstrained,
      allowStaleCache: true,
    );
  }

  static RuntimePerformancePolicy background() {
    return const RuntimePerformancePolicy(
      profile: PerformanceProfile.background,
      timerBehavior: RuntimeTimerBehavior.suspended,
      networkPrefetchLimitFactor: 0,
      networkPrefetchMaxConcurrency: 0,
      allowImagePrefetch: false,
      allowStaleCache: true,
    );
  }
}
