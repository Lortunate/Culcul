// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_utils.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mediaService)
final mediaServiceProvider = MediaUtilsProvider._();

final class MediaUtilsProvider
    extends $FunctionalProvider<MediaUtils, MediaUtils, MediaUtils>
    with $Provider<MediaUtils> {
  MediaUtilsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaServiceHash();

  @$internal
  @override
  $ProviderElement<MediaUtils> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MediaUtils create(Ref ref) {
    return mediaService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaUtils value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaUtils>(value),
    );
  }
}

String _$mediaServiceHash() => r'2b9282bc1d3690806aa69e945a73b08f18b0358e';
