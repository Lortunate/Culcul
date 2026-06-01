// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveRepository)
final liveRepositoryProvider = LiveRepositoryProvider._();

final class LiveRepositoryProvider
    extends
        $FunctionalProvider<LiveRepositoryImpl, LiveRepositoryImpl, LiveRepositoryImpl>
    with $Provider<LiveRepositoryImpl> {
  LiveRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveRepositoryHash();

  @$internal
  @override
  $ProviderElement<LiveRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LiveRepositoryImpl create(Ref ref) {
    return liveRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveRepositoryImpl>(value),
    );
  }
}

String _$liveRepositoryHash() => r'c442c40a0c64ef1c53345eb015743ccfc73abe18';
