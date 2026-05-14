import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:flutter/widgets.dart';

enum PerformanceProfile { interactive, balanced, constrained, background }

enum RequestConcurrencyClass { foreground, standard, limited, suspended }

enum RuntimeTimerBehavior { normal, throttled, suspended }

class RuntimePerformancePolicy {
  final PerformanceProfile profile;
  final RequestConcurrencyClass requestConcurrencyClass;
  final RuntimeTimerBehavior timerBehavior;
  final double networkPrefetchLimitFactor;
  final int networkPrefetchMaxConcurrency;
  final bool allowImagePrefetch;
  final bool allowStaleCache;

  const RuntimePerformancePolicy({
    required this.profile,
    required this.requestConcurrencyClass,
    required this.timerBehavior,
    required this.networkPrefetchLimitFactor,
    required this.networkPrefetchMaxConcurrency,
    required this.allowImagePrefetch,
    required this.allowStaleCache,
  });

  bool get allowsNonCriticalPrefetch =>
      profile != PerformanceProfile.background && networkPrefetchMaxConcurrency > 0;

  static RuntimePerformancePolicy resolve({
    required NetworkQualityProfile networkProfile,
    required AppLifecycleState lifecycleState,
    required PerformancePolicy renderPolicy,
  }) {
    if (lifecycleState != AppLifecycleState.resumed) {
      return background(networkProfile);
    }

    if (networkProfile == NetworkQualityProfile.constrained ||
        renderPolicy.level == RenderDegradeLevel.minimalEffects) {
      return constrained(networkProfile);
    }

    if (networkProfile == NetworkQualityProfile.fast &&
        renderPolicy.level == RenderDegradeLevel.normal) {
      return interactive(networkProfile);
    }

    return balanced(networkProfile);
  }

  static RuntimePerformancePolicy fromRenderPolicy(
    PerformancePolicy renderPolicy, {
    NetworkQualityProfile networkProfile = NetworkQualityProfile.normal,
    AppLifecycleState lifecycleState = AppLifecycleState.resumed,
  }) {
    return resolve(
      networkProfile: networkProfile,
      lifecycleState: lifecycleState,
      renderPolicy: renderPolicy,
    );
  }

  static RuntimePerformancePolicy interactive(NetworkQualityProfile networkProfile) {
    final networkPolicy = NetworkQualityPolicy.forProfile(networkProfile);
    return RuntimePerformancePolicy(
      profile: PerformanceProfile.interactive,
      requestConcurrencyClass: RequestConcurrencyClass.foreground,
      timerBehavior: RuntimeTimerBehavior.normal,
      networkPrefetchLimitFactor: networkPolicy.prefetchLimitFactor,
      networkPrefetchMaxConcurrency: networkPolicy.prefetchMaxConcurrency,
      allowImagePrefetch: true,
      allowStaleCache: false,
    );
  }

  static RuntimePerformancePolicy balanced(NetworkQualityProfile networkProfile) {
    final networkPolicy = NetworkQualityPolicy.forProfile(networkProfile);
    return RuntimePerformancePolicy(
      profile: PerformanceProfile.balanced,
      requestConcurrencyClass: RequestConcurrencyClass.standard,
      timerBehavior: RuntimeTimerBehavior.normal,
      networkPrefetchLimitFactor: networkPolicy.prefetchLimitFactor,
      networkPrefetchMaxConcurrency: networkPolicy.prefetchMaxConcurrency,
      allowImagePrefetch: true,
      allowStaleCache: true,
    );
  }

  static RuntimePerformancePolicy constrained(NetworkQualityProfile networkProfile) {
    final networkPolicy = NetworkQualityPolicy.forProfile(networkProfile);
    return RuntimePerformancePolicy(
      profile: PerformanceProfile.constrained,
      requestConcurrencyClass: RequestConcurrencyClass.limited,
      timerBehavior: RuntimeTimerBehavior.throttled,
      networkPrefetchLimitFactor: networkPolicy.prefetchLimitFactor,
      networkPrefetchMaxConcurrency: networkPolicy.prefetchMaxConcurrency,
      allowImagePrefetch: false,
      allowStaleCache: true,
    );
  }

  static RuntimePerformancePolicy background(NetworkQualityProfile networkProfile) {
    return const RuntimePerformancePolicy(
      profile: PerformanceProfile.background,
      requestConcurrencyClass: RequestConcurrencyClass.suspended,
      timerBehavior: RuntimeTimerBehavior.suspended,
      networkPrefetchLimitFactor: 0,
      networkPrefetchMaxConcurrency: 0,
      allowImagePrefetch: false,
      allowStaleCache: true,
    );
  }
}
