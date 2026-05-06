import 'dart:async';

import 'package:culcul/shared/constants/api_constants.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('defaultSearchProvider silently refreshes when cached value exists', () async {
    final repository = _FakeSearchLandingRepository();
    final cacheStore = _FakeCacheStore(
      existingKeys: <String>{'api_cache_${ApiConstants.searchDefaultUrl}'},
    );
    final container = ProviderContainer(
      overrides: [
        searchRepositoryProvider.overrideWithValue(repository),
        cacheStoreProvider.overrideWithValue(cacheStore),
      ],
    );
    addTearDown(container.dispose);

    final initial = await container.read(defaultSearchProvider.future);
    expect(initial?.text, 'cached hint');
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(repository.defaultRefreshCalls, 1);

    repository.completeDefaultRefresh();
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(container.read(defaultSearchProvider).requireValue?.text, 'fresh hint');
  });
}

class _FakeSearchLandingRepository extends Fake implements domain.SearchRepository {
  int defaultRefreshCalls = 0;
  final Completer<Result<SearchDefaultHint?, AppError>> _defaultRefreshCompleter =
      Completer<Result<SearchDefaultHint?, AppError>>();

  @override
  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch({
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      defaultRefreshCalls++;
      return _defaultRefreshCompleter.future;
    }
    return const Success(SearchDefaultHint(text: 'cached hint'));
  }

  @override
  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    return const Success(<SearchTrendingKeyword>[]);
  }

  @override
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  }) async {
    return const Success(<SearchSuggestionEntry>[]);
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    RequestCancelToken? cancelToken,
  }) async {
    throw UnimplementedError();
  }

  void completeDefaultRefresh() {
    if (_defaultRefreshCompleter.isCompleted) {
      return;
    }
    _defaultRefreshCompleter.complete(
      const Success(SearchDefaultHint(text: 'fresh hint')),
    );
  }
}

class _FakeCacheStore implements CacheStore {
  final Set<String> existingKeys;

  _FakeCacheStore({required this.existingKeys});

  @override
  Future<bool> exists(String key) async => existingKeys.contains(key);

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {}

  @override
  Future<void> close() async {}

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {}

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {}

  @override
  Future<CacheResponse?> get(String key) async => null;

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    return const <CacheResponse>[];
  }

  @override
  bool pathExists(String url, RegExp pathPattern, {Map<String, String?>? queryParams}) {
    return false;
  }

  @override
  Future<void> set(CacheResponse response) async {}
}
