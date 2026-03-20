// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VideoDetailController)
final videoDetailControllerProvider = VideoDetailControllerFamily._();

final class VideoDetailControllerProvider
    extends $NotifierProvider<VideoDetailController, VideoDetailState> {
  VideoDetailControllerProvider._({
    required VideoDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'videoDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$videoDetailControllerHash();

  @override
  String toString() {
    return r'videoDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VideoDetailController create() => VideoDetailController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VideoDetailControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$videoDetailControllerHash() =>
    r'4d546df8923085c207fae152861c71840e7fe3de';

final class VideoDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          VideoDetailController,
          VideoDetailState,
          VideoDetailState,
          VideoDetailState,
          String
        > {
  VideoDetailControllerFamily._()
    : super(
        retry: null,
        name: r'videoDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VideoDetailControllerProvider call(String bvid) =>
      VideoDetailControllerProvider._(argument: bvid, from: this);

  @override
  String toString() => r'videoDetailControllerProvider';
}

abstract class _$VideoDetailController extends $Notifier<VideoDetailState> {
  late final _$args = ref.$arg as String;
  String get bvid => _$args;

  VideoDetailState build(String bvid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VideoDetailState, VideoDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VideoDetailState, VideoDetailState>,
              VideoDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
