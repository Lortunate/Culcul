import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/core/extensions/auth_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_provider.g.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
  @override
  Future<List<FavFolderModel>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    final mid = int.parse(authState.user!.id);
    final repository = ref.read(favRepositoryProvider);
    final result = await repository.getCreatedFolders(upMid: mid);

    return switch (result) {
      Success(value: final response) => () async {
        final folders = response.list ?? [];
        if (folders.isEmpty) return <FavFolderModel>[];

        // Fetch covers for created folders as they don't come with covers
        final foldersWithCovers = await Future.wait(
          folders.map((folder) async {
            // If cover exists and is not empty, use it
            if (folder.cover != null && folder.cover!.isNotEmpty) {
              return folder;
            }

            try {
              // Fetch folder info to get the cover
              // Use ps: 1 because we only need the info or the first video's cover
              final resResult = await repository.getFolderResources(
                mediaId: folder.id,
                pn: 1,
                ps: 1,
              );

              if (resResult case Success(value: final resources)) {
                String cover = resources.info.cover;

                // If info cover is empty, try to get from the first media
                if (cover.isEmpty &&
                    resources.medias != null &&
                    resources.medias!.isNotEmpty) {
                  cover = resources.medias!.first.cover;
                }

                if (cover.isNotEmpty) {
                  return folder.copyWith(cover: cover);
                }
              }
            } catch (e) {
              // Ignore errors for individual folder info fetch
            }

            return folder;
          }),
        );

        return foldersWithCovers;
      }(),
      Failure(exception: final e) => throw e,
    };
  }
}

@riverpod
class FavCollectedFolders extends _$FavCollectedFolders {
  int _page = 1;
  static const int _pageSize = 20;
  bool _hasMore = true;

  @override
  Future<List<FavFolderModel>> build() async {
    _page = 1;
    _hasMore = true;
    return _fetchItems(_page);
  }

  Future<List<FavFolderModel>> _fetchItems(int page) async {
    final authState = ref.read(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    final mid = int.parse(authState.user!.id);
    final result = await ref
        .read(favRepositoryProvider)
        .getCollectedFolders(upMid: mid, pn: page, ps: _pageSize);

    return switch (result) {
      Success(value: final response) => () {
        // Check if we have more data based on count or list size
        // API returns count, but we can also just check if list size < pageSize
        if ((response.list?.length ?? 0) < _pageSize) {
          _hasMore = false;
        }
        return response.list ?? [];
      }(),
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final currentList = state.value ?? [];
    try {
      final newItems = await _fetchItems(_page + 1);
      _page++;
      state = AsyncValue.data([...currentList, ...newItems]);
    } catch (e) {
      // Don't set state to error to preserve current list
      rethrow;
    }
  }
}

class FavFolderDetailState {
  final FavFolderInfoModel? info;
  final List<FavResourceModel> list;

  FavFolderDetailState({this.info, required this.list});
}

@riverpod
class FavFolderResources extends _$FavFolderResources {
  int _page = 1;
  static const int _pageSize = 20;
  bool _hasMore = true;

  @override
  Future<FavFolderDetailState> build(int mediaId) async {
    _page = 1;
    _hasMore = true;
    return _fetchItems(mediaId, _page);
  }

  Future<FavFolderDetailState> _fetchItems(int mediaId, int page) async {
    final result = await ref
        .read(favRepositoryProvider)
        .getFolderResources(mediaId: mediaId, pn: page, ps: _pageSize);

    return switch (result) {
      Success(value: final response) => () {
        _hasMore = response.hasMore;
        return FavFolderDetailState(
          info: response.info,
          list: response.medias ?? [],
        );
      }(),
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> loadMore(int mediaId) async {
    if (!_hasMore || state.isLoading) return;

    final currentList = state.value?.list ?? [];

    try {
      final newState = await _fetchItems(mediaId, _page + 1);
      _page++;
      state = AsyncValue.data(
        FavFolderDetailState(
          info: newState.info,
          list: [...currentList, ...newState.list],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
