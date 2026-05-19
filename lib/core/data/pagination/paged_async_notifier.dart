import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:culcul/core/data/pagination/page_merge.dart';

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

mixin OffsetPagedAsyncNotifier<T> {
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isRefreshing = false;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
  bool get isRefreshing => _isRefreshing;
  bool get isLoadingMore => _isLoadingMore;

  AsyncValue<List<T>> get state;
  set state(AsyncValue<List<T>> value);

  @protected
  Future<List<T>> fetchPage(int page);

  @protected
  Object? itemId(T item);

  @protected
  bool hasMoreAfterPage(List<T> items) => items.isNotEmpty;

  @protected
  Future<List<T>> buildFirstPage() async {
    _resetPagination();
    final items = await fetchPage(_currentPage);
    _hasMore = hasMoreAfterPage(items);
    return items;
  }

  @protected
  Future<void> refreshPage() async {
    final previousState = state;
    state = AsyncLoading<List<T>>().copyWithPrevious(previousState);

    try {
      _isRefreshing = true;
      _isLoadingMore = false;
      _resetPagination();
      final items = await fetchPage(_currentPage);
      _hasMore = hasMoreAfterPage(items);
      state = AsyncData(items);
    } catch (error, stackTrace) {
      state = AsyncError<List<T>>(error, stackTrace).copyWithPrevious(previousState);
    } finally {
      _isRefreshing = false;
    }
  }

  @protected
  Future<void> loadNextPage() async {
    final previousState = state;
    if (previousState is! AsyncData<List<T>> || !_hasMore || _isLoadingMore) {
      return;
    }

    _isLoadingMore = true;
    final previousItems = previousState.value;
    try {
      final nextPage = _currentPage + 1;
      final newItems = await fetchPage(nextPage);

      if (newItems.isEmpty) {
        _hasMore = false;
        state = AsyncData(previousItems);
        return;
      }

      _currentPage = nextPage;
      _hasMore = hasMoreAfterPage(newItems);
      state = AsyncData(mergeUnique(previousItems, newItems, idGetter: itemId));
    } catch (error, stackTrace) {
      state = AsyncError<List<T>>(error, stackTrace).copyWithPrevious(previousState);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _resetPagination() {
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
  }
}

mixin CursorPagedAsyncNotifier<T, C> {
  C? _cursor;
  bool _hasMore = true;
  bool _isRefreshing = false;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;
  C? get cursor => _cursor;
  bool get isRefreshing => _isRefreshing;
  bool get isLoadingMore => _isLoadingMore;

  AsyncValue<List<T>> get state;
  set state(AsyncValue<List<T>> value);

  @protected
  Future<CursorPage<T, C>> fetchPage(C? cursor);

  @protected
  Object? itemId(T item);

  @protected
  Future<List<T>> buildFirstPage() async {
    _resetPagination();
    final page = await fetchPage(_cursor);
    _cursor = page.nextCursor;
    _hasMore = page.hasMore;
    return page.items;
  }

  @protected
  Future<void> refreshPage() async {
    final previousState = state;
    state = AsyncLoading<List<T>>().copyWithPrevious(previousState);

    try {
      _isRefreshing = true;
      _isLoadingMore = false;
      _resetPagination();
      final page = await fetchPage(_cursor);
      _cursor = page.nextCursor;
      _hasMore = page.hasMore;
      state = AsyncData(page.items);
    } catch (error, stackTrace) {
      state = AsyncError<List<T>>(error, stackTrace).copyWithPrevious(previousState);
    } finally {
      _isRefreshing = false;
    }
  }

  @protected
  Future<void> loadNextPage() async {
    final previousState = state;
    if (!_hasMore || _isLoadingMore) {
      return;
    }

    final previousItems = previousState.asData?.value;
    if (previousItems == null) {
      return;
    }

    _isLoadingMore = true;
    try {
      final page = await fetchPage(_cursor);
      _cursor = page.nextCursor;
      _hasMore = page.hasMore;

      if (page.items.isEmpty) {
        state = AsyncData(previousItems);
        return;
      }

      state = AsyncData(mergeUnique(previousItems, page.items, idGetter: itemId));
    } catch (error, stackTrace) {
      state = AsyncError<List<T>>(error, stackTrace).copyWithPrevious(previousState);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _resetPagination() {
    _cursor = null;
    _hasMore = true;
    _isLoadingMore = false;
  }
}
