// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(relationService)
final relationServiceProvider = RelationServiceProvider._();

final class RelationServiceProvider
    extends $FunctionalProvider<RelationService, RelationService, RelationService>
    with $Provider<RelationService> {
  RelationServiceProvider._()
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
  $ProviderElement<RelationService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RelationService create(Ref ref) {
    return relationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RelationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RelationService>(value),
    );
  }
}

String _$relationServiceHash() => r'00a88abdc037cd70e5c2d6e91fbd68044ffd4ff3';
