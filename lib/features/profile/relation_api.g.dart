// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(relationService)
final relationServiceProvider = RelationApiProvider._();

final class RelationApiProvider
    extends $FunctionalProvider<RelationApi, RelationApi, RelationApi>
    with $Provider<RelationApi> {
  RelationApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'relationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$relationServiceHash();

  @$internal
  @override
  $ProviderElement<RelationApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RelationApi create(Ref ref) {
    return relationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RelationApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RelationApi>(value),
    );
  }
}

String _$relationServiceHash() => r'00a88abdc037cd70e5c2d6e91fbd68044ffd4ff3';
