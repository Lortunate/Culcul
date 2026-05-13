part of 'favorites_view_model.dart';

@riverpod
class FavCollectedFolders extends _$FavCollectedFolders
    with OffsetPagedAsyncNotifier<FavoriteFolder> {
  late int _mid;

  @override
  Future<List<FavoriteFolder>> build() async {
    final session = ref.read(currentUserProvider);
    if (session == null || !session.isLoggedIn) {
      return [];
    }
    _mid = int.parse(session.uid);
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
