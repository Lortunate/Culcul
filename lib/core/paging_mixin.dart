import 'package:culcul/core/utils/list_utils.dart';
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

      final mergedItems = ListUtils.mergeUnique(previousItems, newItems, idGetter: getId);

      page = nextPage;
      updateState(AsyncValue.data(mergedItems));
    } catch (e, st) {
      updateState(AsyncValue<List<T>>.error(e, st).copyWithPrevious(currentState));
    }
  }
}

