// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavCreatedFolders)
final favCreatedFoldersProvider = FavCreatedFoldersProvider._();

final class FavCreatedFoldersProvider
    extends $AsyncNotifierProvider<FavCreatedFolders, List<FavoriteFolder>> {
  FavCreatedFoldersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favCreatedFoldersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favCreatedFoldersHash();

  @$internal
  @override
  FavCreatedFolders create() => FavCreatedFolders();
}

String _$favCreatedFoldersHash() => r'74153e5425bd3b1ef3ff8035ccf39292672647eb';

abstract class _$FavCreatedFolders extends $AsyncNotifier<List<FavoriteFolder>> {
  FutureOr<List<FavoriteFolder>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<FavoriteFolder>>, List<FavoriteFolder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FavoriteFolder>>, List<FavoriteFolder>>,
              AsyncValue<List<FavoriteFolder>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(videoFavoriteFolders)
final videoFavoriteFoldersProvider = VideoFavoriteFoldersFamily._();

final class VideoFavoriteFoldersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FavoriteFolder>>,
          List<FavoriteFolder>,
          FutureOr<List<FavoriteFolder>>
        >
    with $FutureModifier<List<FavoriteFolder>>, $FutureProvider<List<FavoriteFolder>> {
  VideoFavoriteFoldersProvider._({
    required VideoFavoriteFoldersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'videoFavoriteFoldersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$videoFavoriteFoldersHash();

  @override
  String toString() {
    return r'videoFavoriteFoldersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FavoriteFolder>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<FavoriteFolder>> create(Ref ref) {
    final argument = this.argument as int;
    return videoFavoriteFolders(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoFavoriteFoldersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$videoFavoriteFoldersHash() => r'131d9467d763106a17418514c3c05fa9d48d8ee1';

final class VideoFavoriteFoldersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FavoriteFolder>>, int> {
  VideoFavoriteFoldersFamily._()
    : super(
        retry: null,
        name: r'videoFavoriteFoldersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VideoFavoriteFoldersProvider call(int aid) =>
      VideoFavoriteFoldersProvider._(argument: aid, from: this);

  @override
  String toString() => r'videoFavoriteFoldersProvider';
}

@ProviderFor(FavCollectedFolders)
final favCollectedFoldersProvider = FavCollectedFoldersProvider._();

final class FavCollectedFoldersProvider
    extends $AsyncNotifierProvider<FavCollectedFolders, List<FavoriteFolder>> {
  FavCollectedFoldersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favCollectedFoldersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favCollectedFoldersHash();

  @$internal
  @override
  FavCollectedFolders create() => FavCollectedFolders();
}

String _$favCollectedFoldersHash() => r'59baefad18d8ad716663e7b0615e29138f4c54c2';

abstract class _$FavCollectedFolders extends $AsyncNotifier<List<FavoriteFolder>> {
  FutureOr<List<FavoriteFolder>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<FavoriteFolder>>, List<FavoriteFolder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FavoriteFolder>>, List<FavoriteFolder>>,
              AsyncValue<List<FavoriteFolder>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FavFolderResources)
final favFolderResourcesProvider = FavFolderResourcesFamily._();

final class FavFolderResourcesProvider
    extends $AsyncNotifierProvider<FavFolderResources, FavFolderDetailState> {
  FavFolderResourcesProvider._({
    required FavFolderResourcesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'favFolderResourcesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$favFolderResourcesHash();

  @override
  String toString() {
    return r'favFolderResourcesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FavFolderResources create() => FavFolderResources();

  @override
  bool operator ==(Object other) {
    return other is FavFolderResourcesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$favFolderResourcesHash() => r'8b23b5242959ae7187ef9f2a37faaa28cc10bbf8';

final class FavFolderResourcesFamily extends $Family
    with
        $ClassFamilyOverride<
          FavFolderResources,
          AsyncValue<FavFolderDetailState>,
          FavFolderDetailState,
          FutureOr<FavFolderDetailState>,
          int
        > {
  FavFolderResourcesFamily._()
    : super(
        retry: null,
        name: r'favFolderResourcesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FavFolderResourcesProvider call(int mediaId) =>
      FavFolderResourcesProvider._(argument: mediaId, from: this);

  @override
  String toString() => r'favFolderResourcesProvider';
}

abstract class _$FavFolderResources extends $AsyncNotifier<FavFolderDetailState> {
  late final _$args = ref.$arg as int;
  int get mediaId => _$args;

  FutureOr<FavFolderDetailState> build(int mediaId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FavFolderDetailState>, FavFolderDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FavFolderDetailState>, FavFolderDetailState>,
              AsyncValue<FavFolderDetailState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
