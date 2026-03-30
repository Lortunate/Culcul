import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/features/favorites/application/use_case/favorite_folder_use_cases.dart';
import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_view_model.g.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
  @override
  Future<List<FavFolderModel>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    final mid = int.parse(authState.user!.id);
    final query = ref.read(favoriteFolderQueryUseCaseProvider);
    final responseResult = await query.getCreatedFolders(mid);
    final response = responseResult.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
    final folders = response.list ?? [];
    if (folders.isEmpty) return <FavFolderModel>[];

    final foldersWithCovers = await Future.wait(
      folders.map((folder) async {
        if (folder.cover != null && folder.cover!.isNotEmpty) {
          return folder;
        }

        try {
          final resourcesResult = await query.getFolderResources(
            mediaId: folder.id,
            page: 1,
            pageSize: 1,
          );
          final resources = resourcesResult.when(
            success: (value) => value,
            failure: (error) => throw Exception(error.message),
          );
          String cover = resources.info.cover;

          if (cover.isEmpty && resources.medias != null && resources.medias!.isNotEmpty) {
            cover = resources.medias!.first.cover;
          }

          if (cover.isNotEmpty) {
            return folder.copyWith(cover: cover);
          }
        } catch (_) {
          return folder;
        }

        return folder;
      }),
    );

    return foldersWithCovers;
  }
}

@riverpod
class FavCollectedFolders extends _$FavCollectedFolders
    with OffsetPagedAsyncNotifier<FavFolderModel> {
  static const int _pageSize = 20;
  late int _mid;

  @override
  Future<List<FavFolderModel>> build() async {
    final authState = ref.read(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    _mid = int.parse(authState.user!.id);
    return buildFirstPage();
  }

  @override
  Future<List<FavFolderModel>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref
        .read(favoriteFolderQueryUseCaseProvider)
        .getCollectedFolders(upMid: _mid, page: page, pageSize: _pageSize);
    final response = result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
    return response.list ?? [];
  }

  @override
  Object itemId(FavFolderModel item) => item.id;

  @override
  bool hasMoreAfterPage(List<FavFolderModel> items) => items.length >= _pageSize;

  Future<void> loadMore() {
    return loadNextPage();
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
        .read(favoriteFolderQueryUseCaseProvider)
        .getFolderResources(mediaId: mediaId, page: page, pageSize: _pageSize);
    final response = result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
    _hasMore = response.hasMore;
    return FavFolderDetailState(info: response.info, list: response.medias ?? []);
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
