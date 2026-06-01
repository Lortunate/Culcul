// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emoteRepository)
final emoteRepositoryProvider = EmoteRepositoryProvider._();

final class EmoteRepositoryProvider
    extends
        $FunctionalProvider<EmoteRepositoryImpl, EmoteRepositoryImpl, EmoteRepositoryImpl>
    with $Provider<EmoteRepositoryImpl> {
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
  $ProviderElement<EmoteRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmoteRepositoryImpl create(Ref ref) {
    return emoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmoteRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmoteRepositoryImpl>(value),
    );
  }
}

String _$emoteRepositoryHash() => r'2d3eca8325a4756d7931a9013ef06358c2bb2584';
