// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_recommend_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveRecommend)
final liveRecommendProvider = LiveRecommendProvider._();

final class LiveRecommendProvider
    extends $AsyncNotifierProvider<LiveRecommend, List<LiveRoomModel>> {
  LiveRecommendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveRecommendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveRecommendHash();

  @$internal
  @override
  LiveRecommend create() => LiveRecommend();
}

String _$liveRecommendHash() => r'8e26d38c686669db43404ab23c3be366bc8a292f';

abstract class _$LiveRecommend extends $AsyncNotifier<List<LiveRoomModel>> {
  FutureOr<List<LiveRoomModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<LiveRoomModel>>, List<LiveRoomModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LiveRoomModel>>, List<LiveRoomModel>>,
              AsyncValue<List<LiveRoomModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
