import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_list_state.freezed.dart';

@freezed
sealed class PagedListState<T> with _$PagedListState<T> {
  const factory PagedListState({
    @Default([]) List<T> items,
    @Default(true) bool isInitialLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(1) int nextPage,
    Object? error,
  }) = _PagedListState<T>;
}
