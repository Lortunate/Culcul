// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavCreatedFolders)
final favCreatedFoldersProvider = FavCreatedFoldersProvider._();

final class FavCreatedFoldersProvider
    extends $AsyncNotifierProvider<FavCreatedFolders, List<FavFolderModel>> {
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

String _$favCreatedFoldersHash() => r'b3e851f6225c7f52390207bf63822910805b3ca6';

abstract class _$FavCreatedFolders
    extends $AsyncNotifier<List<FavFolderModel>> {
  FutureOr<List<FavFolderModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<FavFolderModel>>, List<FavFolderModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FavFolderModel>>,
                List<FavFolderModel>
              >,
              AsyncValue<List<FavFolderModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FavCollectedFolders)
final favCollectedFoldersProvider = FavCollectedFoldersProvider._();

final class FavCollectedFoldersProvider
    extends $AsyncNotifierProvider<FavCollectedFolders, List<FavFolderModel>> {
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

String _$favCollectedFoldersHash() =>
    r'fe3a2790c0ae3869af15bfb1565d571cf1514086';

abstract class _$FavCollectedFolders
    extends $AsyncNotifier<List<FavFolderModel>> {
  FutureOr<List<FavFolderModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<FavFolderModel>>, List<FavFolderModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FavFolderModel>>,
                List<FavFolderModel>
              >,
              AsyncValue<List<FavFolderModel>>,
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

String _$favFolderResourcesHash() =>
    r'a2681dd088551ebba2038540d6f887f832e6921a';

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

abstract class _$FavFolderResources
    extends $AsyncNotifier<FavFolderDetailState> {
  late final _$args = ref.$arg as int;
  int get mediaId => _$args;

  FutureOr<FavFolderDetailState> build(int mediaId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<FavFolderDetailState>, FavFolderDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<FavFolderDetailState>,
                FavFolderDetailState
              >,
              AsyncValue<FavFolderDetailState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
