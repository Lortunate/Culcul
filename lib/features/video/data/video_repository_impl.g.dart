// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(videoRepository)
final videoRepositoryProvider = VideoRepositoryProvider._();

final class VideoRepositoryProvider
    extends
        $FunctionalProvider<VideoRepositoryImpl, VideoRepositoryImpl, VideoRepositoryImpl>
    with $Provider<VideoRepositoryImpl> {
  VideoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoRepositoryHash();

  @$internal
  @override
  $ProviderElement<VideoRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VideoRepositoryImpl create(Ref ref) {
    return videoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoRepositoryImpl>(value),
    );
  }
}

String _$videoRepositoryHash() => r'4642bdcee9d6c063e6bfb30d5d2e452c29a41ccd';
