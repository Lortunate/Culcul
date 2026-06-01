// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_view_repository_impl.dart';

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
          ToViewRepositoryImpl,
          ToViewRepositoryImpl,
          ToViewRepositoryImpl
        >
    with $Provider<ToViewRepositoryImpl> {
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
  $ProviderElement<ToViewRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToViewRepositoryImpl create(Ref ref) {
    return toViewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToViewRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToViewRepositoryImpl>(value),
    );
  }
}

String _$toViewRepositoryHash() => r'72bd5b718a9afd146d62bb637c2e37d83e262dba';
