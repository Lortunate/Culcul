// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favRepository)
final favRepositoryProvider = FavRepositoryProvider._();

final class FavRepositoryProvider
    extends $FunctionalProvider<FavRepositoryImpl, FavRepositoryImpl, FavRepositoryImpl>
    with $Provider<FavRepositoryImpl> {
  FavRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FavRepositoryImpl create(Ref ref) {
    return favRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavRepositoryImpl>(value),
    );
  }
}

String _$favRepositoryHash() => r'35d857f2d410c6d9b9754019ff8db9eea392c273';
