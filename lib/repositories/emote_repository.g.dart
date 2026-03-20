// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emoteRepository)
final emoteRepositoryProvider = EmoteRepositoryProvider._();

final class EmoteRepositoryProvider
    extends
        $FunctionalProvider<EmoteRepository, EmoteRepository, EmoteRepository>
    with $Provider<EmoteRepository> {
  EmoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emoteRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<EmoteRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmoteRepository create(Ref ref) {
    return emoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmoteRepository>(value),
    );
  }
}

String _$emoteRepositoryHash() => r'b440fe7cb09ddf332a4a9c7ebd32a291041a828f';
