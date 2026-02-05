import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin PagingMixin<T> {
  int page = 1;
  bool hasMore = true;

  Future<List<T>> fetchItems(int page);

  Future<void> handleLoadMore(
    AsyncValue<List<T>> currentState,
    void Function(AsyncValue<List<T>> state) updateState,
    Object? Function(T item) getId,
  ) async {
    if (!hasMore || currentState.isLoading || currentState.isRefreshing) return;

    final previousItems = currentState.asData?.value;
    if (previousItems == null) return;

    try {
      final nextPage = page + 1;
      final newItems = await fetchItems(nextPage);

      if (newItems.isEmpty) {
        hasMore = false;
        updateState(AsyncValue.data(previousItems));
        return;
      }

      final existingIds = previousItems.map(getId).toSet();
      final uniqueNewItems = newItems
          .where((e) => !existingIds.contains(getId(e)))
          .toList();

      page = nextPage;
      if (uniqueNewItems.isNotEmpty) {
        updateState(AsyncValue.data([...previousItems, ...uniqueNewItems]));
      } else {
        updateState(AsyncValue.data(previousItems));
      }
    } catch (e, st) {
      updateState(
        AsyncValue<List<T>>.error(e, st).copyWithPrevious(currentState),
      );
    }
  }
}
