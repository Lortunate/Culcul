import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _OffsetHarness with OffsetPagedAsyncNotifier<int> {
  _OffsetHarness(this._pages);

  final Map<int, List<int>> _pages;

  @override
  AsyncValue<List<int>> state = const AsyncValue.data([]);

  @override
  Future<List<int>> fetchPage(int page) async {
    return _pages[page] ?? const [];
  }

  @override
  Object itemId(int item) => item;

  Future<List<int>> buildInitial() => buildFirstPage();

  Future<void> refreshItems() => refreshPage();

  Future<void> loadMoreItems() => loadNextPage();
}

class _OffsetFailureHarness with OffsetPagedAsyncNotifier<int> {
  @override
  AsyncValue<List<int>> state = const AsyncValue.data([1, 2]);

  @override
  Future<List<int>> fetchPage(int page) async {
    if (isRefreshing) {
      throw StateError('refresh failed');
    }
    return const [];
  }

  @override
  Object itemId(int item) => item;

  Future<void> refreshItems() => refreshPage();
}

class _CursorHarness with CursorPagedAsyncNotifier<int, String> {
  _CursorHarness(this._pages);

  final Map<String?, CursorPage<int, String>> _pages;

  @override
  AsyncValue<List<int>> state = const AsyncValue.data([]);

  @override
  Future<CursorPage<int, String>> fetchPage(String? cursor) async {
    return _pages[cursor]!;
  }

  @override
  Object itemId(int item) => item;

  Future<List<int>> buildInitial() => buildFirstPage();

  Future<void> refreshItems() => refreshPage();

  Future<void> loadMoreItems() => loadNextPage();
}

void main() {
  test('OffsetPagedAsyncNotifier builds, refreshes and merges unique items', () async {
    final harness = _OffsetHarness({
      1: const [1, 2],
      2: const [2, 3],
      3: const [],
    });

    expect(await harness.buildInitial(), [1, 2]);

    harness.state = const AsyncValue.data([1, 2]);
    await harness.loadMoreItems();
    expect(harness.state.requireValue, [1, 2, 3]);

    await harness.loadMoreItems();
    expect(harness.state.requireValue, [1, 2, 3]);

    harness.state = const AsyncValue.data([9]);
    await harness.refreshItems();
    expect(harness.state.requireValue, [1, 2]);
  });

  test('OffsetPagedAsyncNotifier keeps previous data on refresh failure', () async {
    final harness = _OffsetFailureHarness();

    await harness.refreshItems();

    expect(harness.state.hasError, isTrue);
    expect(harness.state.asError?.error, isA<StateError>());
  });

  test(
    'CursorPagedAsyncNotifier appends items and refreshes from the first cursor',
    () async {
      final harness = _CursorHarness({
        null: const CursorPage(items: [1, 2], nextCursor: 'a', hasMore: true),
        'a': const CursorPage(items: [2, 3], nextCursor: 'b', hasMore: true),
        'b': const CursorPage(items: [], nextCursor: 'b', hasMore: false),
      });

      expect(await harness.buildInitial(), [1, 2]);

      harness.state = const AsyncValue.data([1, 2]);
      await harness.loadMoreItems();
      expect(harness.state.requireValue, [1, 2, 3]);

      await harness.loadMoreItems();
      expect(harness.state.requireValue, [1, 2, 3]);

      harness.state = const AsyncValue.data([99]);
      await harness.refreshItems();
      expect(harness.state.requireValue, [1, 2]);
    },
  );
}
