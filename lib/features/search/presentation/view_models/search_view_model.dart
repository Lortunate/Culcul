import 'dart:async';

import 'package:culcul/shared/constants/api_constants.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/shared/perf/feature_flow_perf_logger.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/shared/contracts/search_result_contract.dart';
import 'package:culcul/features/search/feature_scope.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchSuggestionsProvider = FutureProvider.autoDispose
    .family<List<SearchSuggestionEntry>, String>((ref, term) async {
      if (term.isEmpty) return [];
      final cancelToken = RequestCancelToken();
      ref.onDispose(() => cancelToken.cancel('search_suggestions_disposed'));
      final result = await ref
          .watch(searchRepositoryProvider)
          .getSuggestions(term, cancelToken: cancelToken);
      return result.dataOrNull ?? const <SearchSuggestionEntry>[];
    });

final defaultSearchProvider =
    AsyncNotifierProvider<DefaultSearchController, SearchDefaultHint?>(
      DefaultSearchController.new,
    );

final trendingRankingProvider =
    AsyncNotifierProvider<TrendingRankingController, List<SearchTrendingKeyword>>(
      TrendingRankingController.new,
    );

final searchResultProvider = AsyncNotifierProvider.autoDispose
    .family<SearchResultController, SearchResultPage?, SearchQuery>(
      SearchResultController.new,
    );

class SearchResultController extends AsyncNotifier<SearchResultPage?> {
  SearchResultController(this._query);

  final SearchQuery _query;
  RequestCancelToken? _activeRequestCancelToken;

  @override
  Future<SearchResultPage?> build() async {
    ref.onDispose(() {
      _activeRequestCancelToken?.cancel('search_result_disposed');
    });
    if (_query.keyword.isEmpty) return null;
    _activeRequestCancelToken?.cancel('search_result_rebuilt');
    final cancelToken = RequestCancelToken();
    _activeRequestCancelToken = cancelToken;
    final result = await ref
        .watch(searchRepositoryProvider)
        .search(query: _query, cancelToken: cancelToken);
    return result.dataOrNull;
  }

  Future<void> fetchMore() async {
    final oldState = state.value;
    if (oldState == null || state.isLoading || oldState.page >= oldState.numPages) {
      return;
    }

    state = const AsyncLoading<SearchResultPage?>().copyWithPrevious(state);
    _activeRequestCancelToken?.cancel('search_result_load_more_replaced');
    final cancelToken = RequestCancelToken();
    _activeRequestCancelToken = cancelToken;
    state = await AsyncValue.guard(() async {
      final nextQuery = _query.copyWith(page: oldState.page + 1);
      final result = await ref
          .read(searchRepositoryProvider)
          .search(query: nextQuery, cancelToken: cancelToken);
      final newData = result.dataOrNull ?? oldState;
      return newData.copyWith(items: [...oldState.items, ...newData.items]);
    });
  }
}

class DefaultSearchController extends AsyncNotifier<SearchDefaultHint?> {
  @override
  Future<SearchDefaultHint?> build() async {
    final stopwatch = Stopwatch()..start();
    final hasCachedValue = await _hasCachedValue(ApiConstants.searchDefaultUrl);
    final result = await ref.watch(searchRepositoryProvider).getDefaultSearch();
    final value = result.dataOrNull;
    FeatureFlowPerfLogger.log(
      chain: 'search.default_hint',
      stage: 'initial_data',
      fields: <String, Object?>{
        'cache_present': hasCachedValue,
        'has_value': value != null,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    if (hasCachedValue && value != null) {
      unawaited(Future<void>.microtask(_refreshSilently));
    }
    return value;
  }

  Future<void> _refreshSilently() async {
    final previous = state.asData?.value;
    if (previous == null || state.isLoading) {
      return;
    }

    final stopwatch = Stopwatch()..start();
    final result = await ref
        .read(searchRepositoryProvider)
        .getDefaultSearch(forceRefresh: true);
    if (!ref.mounted) {
      return;
    }

    final next = result.dataOrNull;
    if (next == null || next.text == previous.text) {
      FeatureFlowPerfLogger.log(
        chain: 'search.default_hint',
        stage: 'silent_refresh_skip',
        fields: <String, Object?>{
          'has_value': next != null,
          'ms': stopwatch.elapsedMilliseconds,
        },
      );
      return;
    }
    FeatureFlowPerfLogger.log(
      chain: 'search.default_hint',
      stage: 'silent_refresh_apply',
      fields: <String, Object?>{'ms': stopwatch.elapsedMilliseconds},
    );
    state = AsyncData(next);
  }

  Future<bool> _hasCachedValue(String path) {
    return ref.read(cacheStoreProvider).exists('api_cache_$path');
  }
}

class TrendingRankingController extends AsyncNotifier<List<SearchTrendingKeyword>> {
  @override
  Future<List<SearchTrendingKeyword>> build() async {
    final stopwatch = Stopwatch()..start();
    final hasCachedValue = await _hasCachedValue(ApiConstants.searchTrendingRanking);
    final result = await ref.watch(searchRepositoryProvider).getTrendingRanking();
    final value = result.dataOrNull ?? const <SearchTrendingKeyword>[];
    FeatureFlowPerfLogger.log(
      chain: 'search.hot_ranking',
      stage: 'initial_data',
      fields: <String, Object?>{
        'cache_present': hasCachedValue,
        'items': value.length,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
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

    final next = result.dataOrNull ?? const <SearchTrendingKeyword>[];
    if (_sameTrendingItems(previous, next)) {
      FeatureFlowPerfLogger.log(
        chain: 'search.hot_ranking',
        stage: 'silent_refresh_skip',
        fields: <String, Object?>{
          'items': next.length,
          'ms': stopwatch.elapsedMilliseconds,
        },
      );
      return;
    }
    FeatureFlowPerfLogger.log(
      chain: 'search.hot_ranking',
      stage: 'silent_refresh_apply',
      fields: <String, Object?>{
        'items': next.length,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    state = AsyncData(next);
  }

  Future<bool> _hasCachedValue(String path) {
    return ref.read(cacheStoreProvider).exists('api_cache_$path');
  }

  bool _sameTrendingItems(
    List<SearchTrendingKeyword> previous,
    List<SearchTrendingKeyword> next,
  ) {
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
