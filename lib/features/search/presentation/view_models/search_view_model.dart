import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/application/presentation_contracts/dtos/trending_ranking.dart';
import 'package:culcul/features/search/application/presentation_contracts/search_repository_impl.dart';
import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_view_model.g.dart';

@riverpod
Future<List<String>> searchSuggestions(Ref ref, String term) async {
  if (term.isEmpty) return [];
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel('search_suggestions_disposed'));
  final result = await ref
      .watch(searchRepositoryProvider)
      .getSuggestions(term, cancelToken: cancelToken);
  return result.when(success: (data) => data, failure: (error) => throw error);
}

@Riverpod(keepAlive: true)
class TrendingRanking extends _$TrendingRanking {
  @override
  Future<List<TrendingItem>> build() async {
    final stopwatch = Stopwatch()..start();
    final hasCachedValue = await _hasCachedValue(ApiConstants.searchTrendingRanking);
    final result = await ref.watch(searchRepositoryProvider).getTrendingRanking();
    final value = result.when(success: (data) => data, failure: (error) => throw error);
    DevLogger.log('feature', 'search.hot_ranking initial_data', <String, Object?>{
      'cache_present': hasCachedValue,
      'items': value.length,
      'ms': stopwatch.elapsedMilliseconds,
    });
    if (hasCachedValue && value.isNotEmpty) {
      unawaited(Future<void>.microtask(_refreshSilently));
    }
    return value;
  }

  Future<void> _refreshSilently() async {
    final previous = state.asData?.value;
    if (previous == null || previous.isEmpty || state.isLoading) {
      return;
    }

    final stopwatch = Stopwatch()..start();
    final result = await ref
        .read(searchRepositoryProvider)
        .getTrendingRanking(forceRefresh: true);
    if (!ref.mounted) {
      return;
    }

    final next = result.when(success: (data) => data, failure: (_) => previous);
    if (_sameTrendingItems(previous, next)) {
      DevLogger.log(
        'feature',
        'search.hot_ranking silent_refresh_skip',
        <String, Object?>{'items': next.length, 'ms': stopwatch.elapsedMilliseconds},
      );
      return;
    }
    DevLogger.log('feature', 'search.hot_ranking silent_refresh_apply', <String, Object?>{
      'items': next.length,
      'ms': stopwatch.elapsedMilliseconds,
    });
    state = AsyncData(next);
  }

  Future<bool> _hasCachedValue(String path) {
    return ref.read(cacheStoreProvider).exists('api_cache_$path');
  }

  bool _sameTrendingItems(List<TrendingItem> previous, List<TrendingItem> next) {
    if (previous.length != next.length) {
      return false;
    }

    for (var index = 0; index < previous.length; index++) {
      final previousItem = previous[index];
      final nextItem = next[index];
      if (previousItem.keyword != nextItem.keyword ||
          previousItem.label != nextItem.label ||
          previousItem.position != nextItem.position) {
        return false;
      }
    }
    return true;
  }
}

@riverpod
class SearchResult extends _$SearchResult {
  CancelToken? _activeCancelToken;

  @override
  Future<SearchResultPage?> build(SearchQuery query) async {
    ref.onDispose(() {
      _activeCancelToken?.cancel('search_result_disposed');
    });
    if (query.keyword.isEmpty) return null;
    _activeCancelToken?.cancel('search_result_rebuilt');
    final cancelToken = CancelToken();
    _activeCancelToken = cancelToken;
    final result = await ref
        .watch(searchRepositoryProvider)
        .search(query: query, cancelToken: cancelToken);
    return result.dataOrNull;
  }

  Future<void> fetchMore() async {
    final oldState = state.value;
    if (oldState == null || state.isLoading || oldState.page >= oldState.numPages) {
      return;
    }

    state = const AsyncLoading<SearchResultPage?>().copyWithPrevious(state);
    _activeCancelToken?.cancel('search_result_load_more_replaced');
    final cancelToken = CancelToken();
    _activeCancelToken = cancelToken;
    state = await AsyncValue.guard(() async {
      final nextQuery = query.copyWith(page: oldState.page + 1);
      final result = await ref
          .read(searchRepositoryProvider)
          .search(query: nextQuery, cancelToken: cancelToken);
      return result.when(
        success: (newData) =>
            newData.copyWith(items: [...oldState.items, ...newData.items]),
        failure: (_) => oldState,
      );
    });
  }
}
