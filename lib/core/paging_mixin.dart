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

class CursorPage<T, C> {
  final List<T> items;
  final C? nextCursor;
  final bool hasMore;

  const CursorPage({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
  });
}

mixin CursorPagingMixin<T, C> {
  C? cursor;
  bool hasMore = true;

  Future<CursorPage<T, C>> fetchItems(C? cursor);

  Future<void> handleCursorLoadMore(
    AsyncValue<List<T>> currentState,
    void Function(AsyncValue<List<T>> state) updateState,
    Object? Function(T item) getId,
  ) async {
    if (!hasMore || currentState.isLoading || currentState.isRefreshing) return;

    final previousItems = currentState.asData?.value;
    if (previousItems == null) return;

    updateState(AsyncLoading<List<T>>().copyWithPrevious(currentState));
    try {
      final pageResult = await fetchItems(cursor);
      cursor = pageResult.nextCursor;
      hasMore = pageResult.hasMore;

      if (pageResult.items.isEmpty) {
        updateState(AsyncValue.data(previousItems));
        return;
      }

      final mergedItems = ListUtils.mergeUnique(
        previousItems,
        pageResult.items,
        idGetter: getId,
      );
      updateState(AsyncValue.data(mergedItems));
    } catch (e, st) {
      updateState(AsyncValue<List<T>>.error(e, st).copyWithPrevious(currentState));
    }
  }

  Future<void> handleCursorRefresh(
    AsyncValue<List<T>> currentState,
    void Function(AsyncValue<List<T>> state) updateState,
  ) async {
    cursor = null;
    hasMore = true;
    updateState(AsyncLoading<List<T>>().copyWithPrevious(currentState));
    try {
      final pageResult = await fetchItems(cursor);
      cursor = pageResult.nextCursor;
      hasMore = pageResult.hasMore;
      updateState(AsyncValue.data(pageResult.items));
    } catch (e, st) {
      updateState(AsyncValue<List<T>>.error(e, st).copyWithPrevious(currentState));
    }
  }
}
