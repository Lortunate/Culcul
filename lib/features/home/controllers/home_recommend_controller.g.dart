// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_recommend_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeRecommend)
final homeRecommendProvider = HomeRecommendProvider._();

final class HomeRecommendProvider
    extends $AsyncNotifierProvider<HomeRecommend, List<VideoModel>> {
  HomeRecommendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRecommendProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRecommendHash();

  @$internal
  @override
  HomeRecommend create() => HomeRecommend();
}

String _$homeRecommendHash() => r'296bcbffee502a20d50c31fa24aa5b9d2423c13e';

abstract class _$HomeRecommend extends $AsyncNotifier<List<VideoModel>> {
  FutureOr<List<VideoModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<VideoModel>>, List<VideoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<VideoModel>>, List<VideoModel>>,
              AsyncValue<List<VideoModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
