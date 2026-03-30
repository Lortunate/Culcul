import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/favorites/data/fav_repository.dart';

part 'favorites_controller.g.dart';

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
    final response = await repository.getCreatedFolders(upMid: mid);
    final folders = response.list ?? [];
    if (folders.isEmpty) return <FavFolderModel>[];

    final foldersWithCovers = await Future.wait(
      folders.map((folder) async {
        if (folder.cover != null && folder.cover!.isNotEmpty) {
          return folder;
        }

        try {
          final resources = await repository.getFolderResources(
            mediaId: folder.id,
            pn: 1,
            ps: 1,
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
    final response = await ref
        .read(favRepositoryProvider)
        .getCollectedFolders(upMid: _mid, pn: page, ps: _pageSize);
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
    final response = await ref
        .read(favRepositoryProvider)
        .getFolderResources(mediaId: mediaId, pn: page, ps: _pageSize);
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
