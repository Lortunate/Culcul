// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRepositoryImpl)
final homeRepositoryImplProvider = HomeRepositoryImplProvider._();

final class HomeRepositoryImplProvider
    extends
        $FunctionalProvider<HomeRepositoryImpl, HomeRepositoryImpl, HomeRepositoryImpl>
    with $Provider<HomeRepositoryImpl> {
  HomeRepositoryImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryImplHash();

  @$internal
  @override
  $ProviderElement<HomeRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepositoryImpl create(Ref ref) {
    return homeRepositoryImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepositoryImpl>(value),
    );
  }
}

String _$homeRepositoryImplHash() => r'b37cc8e22eac2666c533b66d914c358ed6b062e8';
