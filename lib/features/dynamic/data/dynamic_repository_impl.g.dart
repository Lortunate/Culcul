// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dynamicRepository)
final dynamicRepositoryProvider = DynamicRepositoryProvider._();

final class DynamicRepositoryProvider
    extends
        $FunctionalProvider<
          DynamicRepositoryImpl,
          DynamicRepositoryImpl,
          DynamicRepositoryImpl
        >
    with $Provider<DynamicRepositoryImpl> {
  DynamicRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dynamicRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dynamicRepositoryHash();

  @$internal
  @override
  $ProviderElement<DynamicRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DynamicRepositoryImpl create(Ref ref) {
    return dynamicRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DynamicRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DynamicRepositoryImpl>(value),
    );
  }
}

String _$dynamicRepositoryHash() => r'3a19e4f9ef1e505a99704eb78c1e98df9559170e';
