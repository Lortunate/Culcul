// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favRepository)
final favRepositoryProvider = FavRepositoryProvider._();

final class FavRepositoryProvider
    extends $FunctionalProvider<FavRepository, FavRepository, FavRepository>
    with $Provider<FavRepository> {
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
  $ProviderElement<FavRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FavRepository create(Ref ref) {
    return favRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavRepository>(value),
    );
  }
}

String _$favRepositoryHash() => r'77fa1156ac6598c127d7d427af6a724e8a96ead6';
