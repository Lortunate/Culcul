// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runtime_performance_policy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(renderPerformancePolicy)
final renderPerformancePolicyProvider = RenderPerformancePolicyProvider._();

final class RenderPerformancePolicyProvider
    extends $FunctionalProvider<PerformancePolicy, PerformancePolicy, PerformancePolicy>
    with $Provider<PerformancePolicy> {
  RenderPerformancePolicyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'renderPerformancePolicyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$renderPerformancePolicyHash();

  @$internal
  @override
  $ProviderElement<PerformancePolicy> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PerformancePolicy create(Ref ref) {
    return renderPerformancePolicy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PerformancePolicy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PerformancePolicy>(value),
    );
  }
}

String _$renderPerformancePolicyHash() => r'559967d7422b0125dafc55b957b7987b827103ae';

@ProviderFor(runtimePerformancePolicy)
final runtimePerformancePolicyProvider = RuntimePerformancePolicyProvider._();

final class RuntimePerformancePolicyProvider
    extends
        $FunctionalProvider<
          RuntimePerformancePolicy,
          RuntimePerformancePolicy,
          RuntimePerformancePolicy
        >
    with $Provider<RuntimePerformancePolicy> {
  RuntimePerformancePolicyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runtimePerformancePolicyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runtimePerformancePolicyHash();

  @$internal
  @override
  $ProviderElement<RuntimePerformancePolicy> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RuntimePerformancePolicy create(Ref ref) {
    return runtimePerformancePolicy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuntimePerformancePolicy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuntimePerformancePolicy>(value),
    );
  }
}

String _$runtimePerformancePolicyHash() => r'ad7b85b3c769a43aad9efb2c47ccf7e25418de56';
