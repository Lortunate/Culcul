part of 'favorites_view_model.dart';

@freezed
sealed class FavFolderDetailState with _$FavFolderDetailState {
  const factory FavFolderDetailState({
    FavoriteFolderInfo? info,
    @Default(PagedListState<FavoriteResource>(isInitialLoading: false))
    PagedListState<FavoriteResource> paging,
  }) = _FavFolderDetailState;
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
      DevLogger.log('feature', 'favorites.detail state_commit', <String, Object?>{
        'mediaId': mediaId,
        'hasData': false,
      });
      return const FavFolderDetailState();
    }
    final nextState = FavFolderDetailState(
      info: page.info,
      paging: PagedListState<FavoriteResource>(
        items: page.medias,
        hasMore: page.hasMore,
        isInitialLoading: false,
        nextPage: 2,
      ),
    );
    DevLogger.log('feature', 'favorites.detail state_commit', <String, Object?>{
      'mediaId': mediaId,
      'hasData': true,
      'itemCount': page.medias.length,
      'hasMore': page.hasMore,
    });
    DevLogger.log('feature', 'favorites.detail first_interactive', <String, Object?>{
      'mediaId': mediaId,
      'ms': firstInteractiveStopwatch.elapsedMilliseconds,
      'itemCount': page.medias.length,
    });
    return nextState;
  }

  Future<FavoriteResourcePage?> _fetchItems(int mediaId, int page) async {
    final requestStopwatch = Stopwatch()..start();
    final result = await ref
        .read(favRepositoryProvider)
        .getFolderResources(mediaId: mediaId, page: page);
    DevLogger.log('feature', 'favorites.detail request', <String, Object?>{
      'mediaId': mediaId,
      'page': page,
      'ms': requestStopwatch.elapsedMilliseconds,
      'success': result.dataOrNull != null,
    });
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
            result.errorOrNull ??
            const AppError.data('Failed to load favorite resources');
        state = AsyncData(
          current.copyWith(
            paging: current.paging.copyWith(isLoadingMore: false, error: error),
          ),
        );
        return;
      }

      state = AsyncValue.data(
        current.copyWith(
          info: nextPageData.info,
          paging: current.paging.copyWith(
            items: mergeUnique(
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
      DevLogger.log('feature', 'favorites.detail state_commit', <String, Object?>{
        'mediaId': mediaId,
        'page': current.paging.nextPage,
        'itemCount': state.value?.paging.items.length ?? 0,
        'hasMore': state.value?.paging.hasMore ?? false,
      });
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
