import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_lifecycle_provider.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'runtime_performance_policy_provider.g.dart';

@riverpod
PerformancePolicy renderPerformancePolicy(Ref ref) {
  void listener() => ref.invalidateSelf();

  PerformancePolicyController.notifier.addListener(listener);
  ref.onDispose(() => PerformancePolicyController.notifier.removeListener(listener));
  return PerformancePolicyController.notifier.value;
}

@riverpod
RuntimePerformancePolicy runtimePerformancePolicy(Ref ref) {
  final networkProfile = ref
      .watch(networkQualityProfileProvider)
      .maybeWhen(data: (value) => value, orElse: () => NetworkQualityProfile.normal);
  final lifecycleState = ref.watch(runtimeLifecycleProvider);
  final renderPolicy = ref.watch(renderPerformancePolicyProvider);

  return RuntimePerformancePolicy.resolve(
    networkProfile: networkProfile,
    lifecycleState: lifecycleState,
    renderPolicy: renderPolicy,
  );
}
