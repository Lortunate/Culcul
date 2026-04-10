import 'package:culcul/shared/pagination/paged_list_state.dart';
import 'package:culcul/shared/pagination/paged_list_state_transitions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PagedListStateTransitions', () {
    test('beginRefresh resets paging flags and clears error', () {
      final state = PagedListState<int>(
        items: <int>[1, 2],
        isInitialLoading: false,
        isLoadingMore: true,
        hasMore: false,
        nextPage: 3,
        error: StateError('x'),
      );

      final next = PagedListStateTransitions.beginRefresh(state);
      expect(next.items, isEmpty);
      expect(next.isInitialLoading, isTrue);
      expect(next.isLoadingMore, isFalse);
      expect(next.hasMore, isTrue);
      expect(next.nextPage, 1);
      expect(next.error, isNull);
    });

    test('completeLoadMore updates merged items and paging cursor', () {
      const state = PagedListState<int>(
        items: <int>[1, 2],
        isInitialLoading: false,
        isLoadingMore: true,
        hasMore: true,
        nextPage: 3,
      );

      final next = PagedListStateTransitions.completeLoadMore(
        state,
        items: const <int>[1, 2, 3, 4],
        hasMore: false,
        nextPage: 4,
      );
      expect(next.items, const <int>[1, 2, 3, 4]);
      expect(next.isInitialLoading, isFalse);
      expect(next.isLoadingMore, isFalse);
      expect(next.hasMore, isFalse);
      expect(next.nextPage, 4);
      expect(next.error, isNull);
    });

    test('fail always clears loading flags and preserves items', () {
      const state = PagedListState<int>(
        items: <int>[1, 2],
        isInitialLoading: true,
        isLoadingMore: true,
        hasMore: true,
        nextPage: 2,
      );

      final error = StateError('failed');
      final next = PagedListStateTransitions.fail(state, error);
      expect(next.items, const <int>[1, 2]);
      expect(next.isInitialLoading, isFalse);
      expect(next.isLoadingMore, isFalse);
      expect(next.error, error);
    });
  });
}
