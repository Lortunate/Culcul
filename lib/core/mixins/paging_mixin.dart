import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin PagingMixin<T> {
  int page = 1;
  bool hasMore = true;

  Future<List<T>> fetchItems(int page);

  Future<void> handleLoadMore(
    AsyncValue<List<T>> state,
    void Function(AsyncValue<List<T>> state) updateState,
    Object? Function(T item) getId,
  ) async {
    if (state.isLoading || state.isRefreshing || !hasMore) return;

    final currentItems = state.value;
    if (currentItems == null) return;

    try {
      final nextPage = page + 1;
      final newItems = await fetchItems(nextPage);

      if (newItems.isEmpty) {
        hasMore = false;
        return;
      }

      final existingIds = currentItems.map(getId).toSet();
      final uniqueNewItems = newItems
          .where((e) => !existingIds.contains(getId(e)))
          .toList();

      if (uniqueNewItems.isNotEmpty) {
        page = nextPage;
        updateState(AsyncValue.data([...currentItems, ...uniqueNewItems]));
      } else if (newItems.isNotEmpty) {
        page = nextPage;
        await handleLoadMore(state, updateState, getId);
      }
    } catch (e, st) {
      updateState(AsyncValue.error(e, st));
    }
  }
}
