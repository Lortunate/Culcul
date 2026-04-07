import 'package:culcul/core/pagination/paged_list_state.dart';

class PagedListStateTransitions {
  const PagedListStateTransitions._();

  static PagedListState<T> beginRefresh<T>(
    PagedListState<T> state, {
    int firstPage = 1,
    bool clearItems = true,
  }) {
    return state.copyWith(
      isInitialLoading: true,
      isLoadingMore: false,
      hasMore: true,
      nextPage: firstPage,
      items: clearItems ? <T>[] : state.items,
      error: null,
    );
  }

  static PagedListState<T> beginLoadMore<T>(PagedListState<T> state) {
    return state.copyWith(isLoadingMore: true, error: null);
  }

  static PagedListState<T> completeRefresh<T>(
    PagedListState<T> state, {
    required List<T> items,
    required bool hasMore,
    int nextPage = 2,
  }) {
    return state.copyWith(
      items: items,
      hasMore: hasMore,
      nextPage: nextPage,
      isInitialLoading: false,
      isLoadingMore: false,
      error: null,
    );
  }

  static PagedListState<T> completeLoadMore<T>(
    PagedListState<T> state, {
    required List<T> items,
    required bool hasMore,
    required int nextPage,
  }) {
    return state.copyWith(
      items: items,
      hasMore: hasMore,
      nextPage: nextPage,
      isInitialLoading: false,
      isLoadingMore: false,
      error: null,
    );
  }

  static PagedListState<T> fail<T>(PagedListState<T> state, Object? error) {
    return state.copyWith(isInitialLoading: false, isLoadingMore: false, error: error);
  }
}
