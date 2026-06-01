part of 'favorites_view_model.dart';

final class FavFolderDetailState {
  const FavFolderDetailState({
    this.info,
    this.paging = const PagedListState<FavoriteResource>(isInitialLoading: false),
  });

  static const Object _unset = Object();

  final FavoriteFolder? info;
  final PagedListState<FavoriteResource> paging;

  FavFolderDetailState copyWith({
    Object? info = _unset,
    PagedListState<FavoriteResource>? paging,
  }) {
    return FavFolderDetailState(
      info: identical(info, _unset) ? this.info : info as FavoriteFolder?,
      paging: paging ?? this.paging,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavFolderDetailState && other.info == info && other.paging == paging;
  }

  @override
  int get hashCode => Object.hash(info, paging);

  @override
  String toString() {
    return 'FavFolderDetailState(info: $info, paging: $paging)';
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
