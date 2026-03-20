// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toview_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(toViewRepository)
final toViewRepositoryProvider = ToViewRepositoryProvider._();

final class ToViewRepositoryProvider
    extends
        $FunctionalProvider<
          ToViewRepository,
          ToViewRepository,
          ToViewRepository
        >
    with $Provider<ToViewRepository> {
  ToViewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toViewRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toViewRepositoryHash();

  @$internal
  @override
  $ProviderElement<ToViewRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToViewRepository create(Ref ref) {
    return toViewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToViewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToViewRepository>(value),
    );
  }
}

String _$toViewRepositoryHash() => r'b8182cc10c51e7bed5725e33e52829a25f7a7985';
