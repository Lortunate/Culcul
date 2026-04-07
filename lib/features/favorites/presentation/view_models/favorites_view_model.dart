import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/favorites.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_view_model.g.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
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

    final foldersWithCovers = await Future.wait(
      folders.map((folder) async {
        if (folder.cover != null && folder.cover!.isNotEmpty) {
          return folder;
        }

        final resourcesResult = await repository.getFolderResources(
          mediaId: folder.id,
          page: 1,
        );
        final resources = resourcesResult.dataOrNull;
        if (resources == null) {
          return folder;
        }

        String cover = resources.info.cover;
        if (cover.isEmpty && resources.medias.isNotEmpty) {
          cover = resources.medias.first.cover;
        }
        if (cover.isNotEmpty) {
          return folder.copyWith(cover: cover);
        }

        return folder;
      }),
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
        .getCollectedFolders(upMid: _mid, page: page);
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
    final page = await _fetchItems(mediaId, 1);
    if (page == null) {
      return const FavFolderDetailState();
    }
    return FavFolderDetailState(
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
  }

  Future<FavoriteResourcePage?> _fetchItems(int mediaId, int page) async {
    final result = await ref
        .read(favRepositoryProvider)
        .getFolderResources(mediaId: mediaId, page: page);
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
          .getFolderResources(mediaId: mediaId, page: current.paging.nextPage);
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

