import 'dart:async';

import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/application/search_trending_item.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_application_providers.g.dart';

Future<bool> _hasApiCacheValue(Ref ref, String path) {
  return ref.read(cacheStoreProvider).exists('api_cache_$path');
}

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
class DefaultSearch extends _$DefaultSearch {
  @override
  Future<String?> build() async {
    final stopwatch = Stopwatch()..start();
    final hasCachedValue = await _hasApiCacheValue(ref, ApiConstants.searchDefaultUrl);
    final result = await ref.watch(searchRepositoryProvider).getDefaultSearch();
    final value = result.dataOrNull;
    DevLogger.log('feature', 'search.default_hint initial_data', <String, Object?>{
      'cache_present': hasCachedValue,
      'has_value': value != null,
      'ms': stopwatch.elapsedMilliseconds,
    });
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
    if (next == null || next == previous) {
      DevLogger.log(
        'feature',
        'search.default_hint silent_refresh_skip',
        <String, Object?>{'has_value': next != null, 'ms': stopwatch.elapsedMilliseconds},
      );
      return;
    }
    DevLogger.log(
      'feature',
      'search.default_hint silent_refresh_apply',
      <String, Object?>{'ms': stopwatch.elapsedMilliseconds},
    );
    state = AsyncData(next);
  }
}

@Riverpod(keepAlive: true)
class TrendingRanking extends _$TrendingRanking {
  @override
  Future<List<SearchTrendingItem>> build() async {
    final stopwatch = Stopwatch()..start();
    final hasCachedValue = await _hasApiCacheValue(
      ref,
      ApiConstants.searchTrendingRanking,
    );
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
    if (listEquals(previous, next)) {
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
}

@riverpod
Future<List<SearchTopicEntry>> topicSearch(Ref ref, String keyword) async {
  final trimmed = keyword.trim();
  if (trimmed.isEmpty) return const [];

  final data = await ref
      .read(searchRepositoryProvider)
      .search(
        query: SearchQuery(keyword: trimmed, type: SearchType.topic),
      );
  final page = data.dataOrNull;
  if (page == null) return const <SearchTopicEntry>[];
  return page.items.whereType<SearchTopicEntry>().toList();
}
