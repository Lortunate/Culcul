// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_quality_policy.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(networkQualityProfile)
final networkQualityProfileProvider = NetworkQualityProfileProvider._();

final class NetworkQualityProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<NetworkQualityProfile>,
          NetworkQualityProfile,
          Stream<NetworkQualityProfile>
        >
    with $FutureModifier<NetworkQualityProfile>, $StreamProvider<NetworkQualityProfile> {
  NetworkQualityProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkQualityProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkQualityProfileHash();

  @$internal
  @override
  $StreamProviderElement<NetworkQualityProfile> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<NetworkQualityProfile> create(Ref ref) {
    return networkQualityProfile(ref);
  }
}

String _$networkQualityProfileHash() => r'c535f5cd2a74aedf541193577b15dd8c27d9fbaf';

@ProviderFor(networkQualityPolicy)
final networkQualityPolicyProvider = NetworkQualityPolicyProvider._();

final class NetworkQualityPolicyProvider
    extends
        $FunctionalProvider<
          NetworkQualityPolicy,
          NetworkQualityPolicy,
          NetworkQualityPolicy
        >
    with $Provider<NetworkQualityPolicy> {
  NetworkQualityPolicyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkQualityPolicyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkQualityPolicyHash();

  @$internal
  @override
  $ProviderElement<NetworkQualityPolicy> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkQualityPolicy create(Ref ref) {
    return networkQualityPolicy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkQualityPolicy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkQualityPolicy>(value),
    );
  }
}

String _$networkQualityPolicyHash() => r'63470b7d8800cac87f63a596661aeab80c5defa1';
