// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_popular_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePopular)
final homePopularProvider = HomePopularProvider._();

final class HomePopularProvider
    extends $AsyncNotifierProvider<HomePopular, List<VideoModel>> {
  HomePopularProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePopularProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homePopularHash();

  @$internal
  @override
  HomePopular create() => HomePopular();
}

String _$homePopularHash() => r'76b4e4993b7fb247c33725e122d9a3da5fbf7625';

abstract class _$HomePopular extends $AsyncNotifier<List<VideoModel>> {
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
