import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'endpoint_policy_provider.g.dart';

@riverpod
EndpointPolicyResolver endpointPolicyResolver(Ref ref) {
  return EndpointPolicyResolver(
    runtimePolicy: ref.watch(runtimePerformancePolicyProvider),
  );
}
