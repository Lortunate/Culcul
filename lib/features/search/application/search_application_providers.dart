import 'dart:async';

import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/search/application/search_port.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_application_providers.g.dart';

@riverpod
SearchPort searchPort(Ref ref) {
  return ref.watch(searchRepositoryProvider);
}

@Riverpod(keepAlive: true)
class DefaultSearch extends _$DefaultSearch {
  @override
  Future<String?> build() async {
    final stopwatch = Stopwatch()..start();
    final hasCachedValue = await _hasCachedValue(ApiConstants.searchDefaultUrl);
    final result = await ref.watch(searchPortProvider).getDefaultSearch();
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
        .read(searchPortProvider)
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

  Future<bool> _hasCachedValue(String path) {
    return ref.read(cacheStoreProvider).exists('api_cache_$path');
  }
}

@riverpod
Future<List<SearchTopicEntry>> topicSearch(Ref ref, String keyword) async {
  final trimmed = keyword.trim();
  if (trimmed.isEmpty) return const [];

  final data = await ref
      .read(searchPortProvider)
      .search(
        query: SearchQuery(keyword: trimmed, type: SearchType.topic),
      );
  final page = data.dataOrNull;
  if (page == null) return const <SearchTopicEntry>[];
  return page.items.whereType<SearchTopicEntry>().toList();
}
