// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_extra_workflows.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(videoExtraWorkflows)
final videoExtraWorkflowsProvider = VideoExtraWorkflowsProvider._();

final class VideoExtraWorkflowsProvider
    extends
        $FunctionalProvider<VideoExtraWorkflows, VideoExtraWorkflows, VideoExtraWorkflows>
    with $Provider<VideoExtraWorkflows> {
  VideoExtraWorkflowsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoExtraWorkflowsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoExtraWorkflowsHash();

  @$internal
  @override
  $ProviderElement<VideoExtraWorkflows> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VideoExtraWorkflows create(Ref ref) {
    return videoExtraWorkflows(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoExtraWorkflows value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoExtraWorkflows>(value),
    );
  }
}

String _$videoExtraWorkflowsHash() => r'9c389ec2239bb642d1b69dda22f109137408789b';

@ProviderFor(loadDanmakuMask)
final loadDanmakuMaskProvider = LoadDanmakuMaskFamily._();

final class LoadDanmakuMaskProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<DanmakuMasks?, AppError>>,
          Result<DanmakuMasks?, AppError>,
          FutureOr<Result<DanmakuMasks?, AppError>>
        >
    with
        $FutureModifier<Result<DanmakuMasks?, AppError>>,
        $FutureProvider<Result<DanmakuMasks?, AppError>> {
  LoadDanmakuMaskProvider._({
    required LoadDanmakuMaskFamily super.from,
    required ({int oid, int pid}) super.argument,
  }) : super(
         retry: null,
         name: r'loadDanmakuMaskProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadDanmakuMaskHash();

  @override
  String toString() {
    return r'loadDanmakuMaskProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Result<DanmakuMasks?, AppError>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Result<DanmakuMasks?, AppError>> create(Ref ref) {
    final argument = this.argument as ({int oid, int pid});
    return loadDanmakuMask(ref, oid: argument.oid, pid: argument.pid);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadDanmakuMaskProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadDanmakuMaskHash() => r'a405263cb571cf1b10f51960e95c833f03176bf3';

final class LoadDanmakuMaskFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Result<DanmakuMasks?, AppError>>,
          ({int oid, int pid})
        > {
  LoadDanmakuMaskFamily._()
    : super(
        retry: null,
        name: r'loadDanmakuMaskProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoadDanmakuMaskProvider call({required int oid, required int pid}) =>
      LoadDanmakuMaskProvider._(argument: (oid: oid, pid: pid), from: this);

  @override
  String toString() => r'loadDanmakuMaskProvider';
}
