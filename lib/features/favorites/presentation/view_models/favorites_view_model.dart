import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/core/network/network_concurrency_executor.dart';
import 'package:culcul/core/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/feature_flow_perf_logger.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/favorites.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_view_model.g.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
  static const NetworkConcurrencyExecutor _concurrencyExecutor =
      NetworkConcurrencyExecutor();

  @override
  Future<List<FavoriteFolder>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    final mid = int.parse(authState.user!.id);
    final repository = ref.read(favRepositoryProvider);
    final result = await repository.getCreatedFolders(upMid: mid);
    final response = result.dataOrNull;
    if (response == null) return <FavoriteFolder>[];
    final folders = response.folders;
    if (folders.isEmpty) return <FavoriteFolder>[];

    final foldersWithCovers = await _concurrencyExecutor
        .mapConcurrent<FavoriteFolder, FavoriteFolder>(
          items: folders,
          profile: NetworkConcurrencyProfile.enrich,
          scope: 'favorites_cover_enrich',
          mapper: (folder) async {
            if (folder.cover case final cover? when cover.isNotEmpty) {
              return folder;
            }

            try {
              final resourcesResult = await repository.getFolderResources(
                FavoriteFolderResourcesQuery(mediaId: folder.id, page: 1),
              );
              final resources = resourcesResult.dataOrNull;
              if (resources == null) {
                return folder;
              }

              var cover = resources.info.cover;
              if (cover.isEmpty && resources.medias.isNotEmpty) {
                cover = resources.medias.first.cover;
              }
              if (cover.isEmpty) {
                return folder;
              }
              return folder.copyWith(cover: cover);
            } catch (_) {
              return folder;
            }
          },
        );

    return foldersWithCovers;
  }
}

@riverpod
class FavCollectedFolders extends _$FavCollectedFolders
    with OffsetPagedAsyncNotifier<FavoriteFolder> {
  late int _mid;

  @override
  Future<List<FavoriteFolder>> build() async {
    final authState = ref.read(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    _mid = int.parse(authState.user!.id);
    return buildFirstPage();
  }

  @override
  Future<List<FavoriteFolder>> fetchPage(int page) async {
    final result = await ref
        .read(favRepositoryProvider)
        .getCollectedFolders(FavoriteFolderListQuery(upMid: _mid, page: page));
    return result.dataOrNull?.folders ?? const <FavoriteFolder>[];
  }

  @override
  Object itemId(FavoriteFolder item) => item.id;

  @override
  bool hasMoreAfterPage(List<FavoriteFolder> items) => items.isNotEmpty;

  Future<void> loadMore() {
    return loadNextPage();
  }
}

class FavFolderDetailState {
  final FavoriteFolderInfo? info;
  final PagedListState<FavoriteResource> paging;

  const FavFolderDetailState({
    this.info,
    this.paging = const PagedListState<FavoriteResource>(isInitialLoading: false),
  });

  FavFolderDetailState copyWith({
    FavoriteFolderInfo? info,
    PagedListState<FavoriteResource>? paging,
  }) {
    return FavFolderDetailState(info: info ?? this.info, paging: paging ?? this.paging);
  }
}

@riverpod
class FavFolderResources extends _$FavFolderResources {
  bool get hasMore => state.value?.paging.hasMore ?? false;

  bool get isLoadingMore => state.value?.paging.isLoadingMore ?? false;

  @override
  Future<FavFolderDetailState> build(int mediaId) async {
    final firstInteractiveStopwatch = Stopwatch()..start();
    final page = await _fetchItems(mediaId, 1);
    if (page == null) {
      FeatureFlowPerfLogger.log(
        chain: 'favorites.detail',
        stage: 'state_commit',
        fields: <String, Object?>{'mediaId': mediaId, 'hasData': false},
      );
      return const FavFolderDetailState();
    }
    final nextState = FavFolderDetailState(
      info: page.info,
      paging: PagedListState<FavoriteResource>(
        items: page.medias,
        hasMore: page.hasMore,
        isInitialLoading: false,
        isLoadingMore: false,
        nextPage: 2,
        error: null,
      ),
    );
    FeatureFlowPerfLogger.log(
      chain: 'favorites.detail',
      stage: 'state_commit',
      fields: <String, Object?>{
        'mediaId': mediaId,
        'hasData': true,
        'itemCount': page.medias.length,
        'hasMore': page.hasMore,
      },
    );
    FeatureFlowPerfLogger.log(
      chain: 'favorites.detail',
      stage: 'first_interactive',
      fields: <String, Object?>{
        'mediaId': mediaId,
        'ms': firstInteractiveStopwatch.elapsedMilliseconds,
        'itemCount': page.medias.length,
      },
    );
    return nextState;
  }

  Future<FavoriteResourcePage?> _fetchItems(int mediaId, int page) async {
    final requestStopwatch = Stopwatch()..start();
    final result = await ref
        .read(favRepositoryProvider)
        .getFolderResources(FavoriteFolderResourcesQuery(mediaId: mediaId, page: page));
    FeatureFlowPerfLogger.log(
      chain: 'favorites.detail',
      stage: 'request',
      fields: <String, Object?>{
        'mediaId': mediaId,
        'page': page,
        'ms': requestStopwatch.elapsedMilliseconds,
        'success': result.dataOrNull != null,
      },
    );
    return result.dataOrNull;
  }

  Future<void> loadMore(int mediaId) async {
    final current = state.value;
    if (current == null ||
        state.isLoading ||
        current.paging.isLoadingMore ||
        !current.paging.hasMore) {
      return;
    }

    state = AsyncData(
      current.copyWith(paging: current.paging.copyWith(isLoadingMore: true, error: null)),
    );
    try {
      final result = await ref
          .read(favRepositoryProvider)
          .getFolderResources(
            FavoriteFolderResourcesQuery(mediaId: mediaId, page: current.paging.nextPage),
          );
      final nextPageData = result.dataOrNull;
      if (nextPageData == null) {
        final error =
            result.errorOrNull ?? StateError('Failed to load favorite resources');
        state = AsyncData(
          current.copyWith(
            paging: current.paging.copyWith(isLoadingMore: false, error: error),
          ),
        );
        throw error;
      }

      state = AsyncValue.data(
        current.copyWith(
          info: nextPageData.info,
          paging: current.paging.copyWith(
            items: ListUtils.mergeUnique(
              current.paging.items,
              nextPageData.medias,
              idGetter: (item) => item.id,
            ),
            hasMore: nextPageData.hasMore,
            isLoadingMore: false,
            nextPage: current.paging.nextPage + 1,
            error: null,
          ),
        ),
      );
      FeatureFlowPerfLogger.log(
        chain: 'favorites.detail',
        stage: 'state_commit',
        fields: <String, Object?>{
          'mediaId': mediaId,
          'page': current.paging.nextPage,
          'itemCount': state.value?.paging.items.length ?? 0,
          'hasMore': state.value?.paging.hasMore ?? false,
        },
      );
    } finally {
      final latest = state.value;
      if (latest != null && latest.paging.isLoadingMore) {
        state = AsyncData(
          latest.copyWith(paging: latest.paging.copyWith(isLoadingMore: false)),
        );
      }
    }
  }
}
