import 'package:flutter/foundation.dart' show listEquals;

const Object _pagedListStateUnset = Object();

final class PagedListState<T> {
  const PagedListState({
    this.items = const [],
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.nextPage = 1,
    this.error,
  });

  final List<T> items;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextPage;
  final Object? error;

  PagedListState<T> copyWith({
    List<T>? items,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextPage,
    Object? error = _pagedListStateUnset,
  }) {
    return PagedListState<T>(
      items: items ?? this.items,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      nextPage: nextPage ?? this.nextPage,
      error: identical(error, _pagedListStateUnset) ? this.error : error,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PagedListState<T> &&
            runtimeType == other.runtimeType &&
            listEquals(items, other.items) &&
            isInitialLoading == other.isInitialLoading &&
            isLoadingMore == other.isLoadingMore &&
            hasMore == other.hasMore &&
            nextPage == other.nextPage &&
            error == other.error;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      Object.hashAll(items),
      isInitialLoading,
      isLoadingMore,
      hasMore,
      nextPage,
      error,
    );
  }

  @override
  String toString() {
    return 'PagedListState<$T>('
        'items: $items, '
        'isInitialLoading: $isInitialLoading, '
        'isLoadingMore: $isLoadingMore, '
        'hasMore: $hasMore, '
        'nextPage: $nextPage, '
        'error: $error'
        ')';
  }

  // ── State transitions ──

  PagedListState<T> beginRefresh({int firstPage = 1, bool clearItems = true}) {
    return copyWith(
      isInitialLoading: true,
      isLoadingMore: false,
      hasMore: true,
      nextPage: firstPage,
      items: clearItems ? <T>[] : items,
      error: null,
    );
  }

  PagedListState<T> beginLoadMore() {
    return copyWith(isLoadingMore: true, error: null);
  }

  PagedListState<T> completeRefresh({
    required List<T> items,
    required bool hasMore,
    int nextPage = 2,
  }) {
    return copyWith(
      items: items,
      hasMore: hasMore,
      nextPage: nextPage,
      isInitialLoading: false,
      isLoadingMore: false,
      error: null,
    );
  }

  PagedListState<T> completeLoadMore({
    required List<T> items,
    required bool hasMore,
    required int nextPage,
  }) {
    return copyWith(
      items: items,
      hasMore: hasMore,
      nextPage: nextPage,
      isInitialLoading: false,
      isLoadingMore: false,
      error: null,
    );
  }

  PagedListState<T> fail(Object? error) {
    return copyWith(isInitialLoading: false, isLoadingMore: false, error: error);
  }
}
