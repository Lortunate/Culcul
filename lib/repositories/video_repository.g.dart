// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(videoRepository)
final videoRepositoryProvider = VideoRepositoryProvider._();

final class VideoRepositoryProvider
    extends
        $FunctionalProvider<VideoRepository, VideoRepository, VideoRepository>
    with $Provider<VideoRepository> {
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
  $ProviderElement<VideoRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VideoRepository create(Ref ref) {
    return videoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoRepository>(value),
    );
  }
}

String _$videoRepositoryHash() => r'8590d42421339d709642104676820236e2b93195';
