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
}
