// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_comments_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VideoCommentsController)
final videoCommentsControllerProvider = VideoCommentsControllerFamily._();

final class VideoCommentsControllerProvider
    extends $NotifierProvider<VideoCommentsController, CommentListState> {
  VideoCommentsControllerProvider._({
    required VideoCommentsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'videoCommentsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$videoCommentsControllerHash();

  @override
  String toString() {
    return r'videoCommentsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VideoCommentsController create() => VideoCommentsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentListState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VideoCommentsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$videoCommentsControllerHash() => r'039c251b6a5e77cc456430deb1e0e81b267ba274';

final class VideoCommentsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          VideoCommentsController,
          CommentListState,
          CommentListState,
          CommentListState,
          String
        > {
  VideoCommentsControllerFamily._()
    : super(
        retry: null,
        name: r'videoCommentsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VideoCommentsControllerProvider call(String bvid) =>
      VideoCommentsControllerProvider._(argument: bvid, from: this);

  @override
  String toString() => r'videoCommentsControllerProvider';
}

abstract class _$VideoCommentsController extends $Notifier<CommentListState> {
  late final _$args = ref.$arg as String;
  String get bvid => _$args;

  CommentListState build(String bvid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CommentListState, CommentListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CommentListState, CommentListState>,
              CommentListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
