import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
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
    final response = await repository.getCreatedFolders(upMid: mid);
    final folders = response.folders;
    if (folders.isEmpty) return <FavoriteFolder>[];

    final foldersWithCovers = await Future.wait(
      folders.map((folder) async {
        if (folder.cover != null && folder.cover!.isNotEmpty) {
          return folder;
        }

        final result = await const RequestExecutor().run(
          () => repository.getFolderResources(
            mediaId: folder.id,
            page: 1,
          ),
        );
        final resources = result.dataOrNull;
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
  Future<List<FavoriteFolder>> fetchPage(int page, {bool refresh = false}) async {
    final response = await ref
        .read(favRepositoryProvider)
        .getCollectedFolders(upMid: _mid, page: page);
    return response.folders;
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
  final List<FavoriteResource> list;

  FavFolderDetailState({this.info, required this.list});
}

@riverpod
class FavFolderResources extends _$FavFolderResources {
  int _page = 1;
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
        .getFolderResources(mediaId: mediaId, page: page);
    _hasMore = response.hasMore;
    return FavFolderDetailState(info: response.info, list: response.medias);
  }

  Future<void> loadMore(int mediaId) async {
    if (!_hasMore || state.isLoading) return;

    final currentList = state.value?.list ?? [];
    final result = await const RequestExecutor().run(() => _fetchItems(mediaId, _page + 1));
    final newState = result.dataOrNull;
    if (newState == null) {
      state = AsyncError(result.errorOrNull!, StackTrace.current);
      return;
    }

    _page++;
    state = AsyncValue.data(
      FavFolderDetailState(
        info: newState.info,
        list: [...currentList, ...newState.list],
      ),
    );
  }
}
