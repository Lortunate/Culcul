import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/features/search/application/search_port.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/application/search_trending_item.dart';
import 'package:culcul/features/search/data/search_api.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('search suggestions read through the search application port', () async {
    final port = _FakeSearchPort(suggestions: const ['alpha', 'beta']);
    final container = _searchContainer(port);
    addTearDown(container.dispose);

    final suggestions = await container.read(searchSuggestionsProvider('a').future);

    expect(suggestions, const ['alpha', 'beta']);
    expect(port.suggestionTerms, const ['a']);
    expect(port.lastSuggestionCancelToken, isNotNull);
  });

  test('trending ranking reads through the search application port', () async {
    final item = _trendingItem(keyword: 'flutter');
    final port = _FakeSearchPort(trending: [item]);
    final container = _searchContainer(port);
    addTearDown(container.dispose);

    final ranking = await container.read(trendingRankingProvider.future);

    expect(ranking, [item]);
    expect(port.trendingForceRefreshValues, const [false]);
  });

  test('search results read through the search application port', () async {
    const query = SearchQuery(keyword: 'riverpod');
    const page = SearchResultPage(
      page: 1,
      numPages: 1,
      items: [
        SearchTopicEntry(
          topicId: 1,
          title: 'riverpod',
          description: null,
          coverUrl: null,
          updateCount: null,
        ),
      ],
    );
    final port = _FakeSearchPort(searchPage: page);
    final container = _searchContainer(port);
    addTearDown(container.dispose);

    final result = await container.read(searchResultProvider(query).future);

    expect(result, page);
    expect(port.searchQueries, const [query]);
    expect(port.lastSearchCancelToken, isNotNull);
  });
}

ProviderContainer _searchContainer(_FakeSearchPort port) {
  return ProviderContainer(
    overrides: [
      cacheStoreProvider.overrideWithValue(MemCacheStore()),
      searchPortProvider.overrideWithValue(port),
      searchRepositoryProvider.overrideWithValue(_ThrowingSearchRepository()),
    ],
  );
}

SearchTrendingItem _trendingItem({required String keyword}) {
  return SearchTrendingItem(
    position: 1,
    keyword: keyword,
    label: 'hot',
    wordType: 1,
    hotId: 1,
  );
}

final class _FakeSearchPort implements SearchPort {
  _FakeSearchPort({
    this.suggestions = const <String>[],
    this.trending = const <SearchTrendingItem>[],
    SearchResultPage? searchPage,
  }) : searchPage = searchPage ?? const SearchResultPage(page: 1, numPages: 1, items: []);

  final List<String> suggestions;
  final List<SearchTrendingItem> trending;
  final SearchResultPage searchPage;
  final List<String> suggestionTerms = [];
  final List<bool> trendingForceRefreshValues = [];
  final List<SearchQuery> searchQueries = [];
  CancelToken? lastSuggestionCancelToken;
  CancelToken? lastSearchCancelToken;

  @override
  Future<Result<String?, AppError>> getDefaultSearch({bool forceRefresh = false}) async {
    return const Success('default');
  }

  @override
  Future<Result<List<String>, AppError>> getSuggestions(
    String term, {
    CancelToken? cancelToken,
  }) async {
    suggestionTerms.add(term);
    lastSuggestionCancelToken = cancelToken;
    return Success(suggestions);
  }

  @override
  Future<Result<List<SearchTrendingItem>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    trendingForceRefreshValues.add(forceRefresh);
    return Success(trending);
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    CancelToken? cancelToken,
  }) async {
    searchQueries.add(query);
    lastSearchCancelToken = cancelToken;
    return Success(searchPage);
  }
}

final class _ThrowingSearchRepository extends SearchRepositoryImpl {
  _ThrowingSearchRepository() : super(api: _UnsupportedSearchApi());

  @override
  Future<Result<List<String>, AppError>> getSuggestions(
    String term, {
    CancelToken? cancelToken,
  }) {
    throw StateError('searchRepositoryProvider should not be read by UI state');
  }

  @override
  Future<Result<String?, AppError>> getDefaultSearch({bool forceRefresh = false}) {
    throw StateError('searchRepositoryProvider should not be read by UI state');
  }

  @override
  Future<Result<List<SearchTrendingItem>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) {
    throw StateError('searchRepositoryProvider should not be read by UI state');
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    CancelToken? cancelToken,
  }) {
    throw StateError('searchRepositoryProvider should not be read by UI state');
  }
}

final class _UnsupportedSearchApi implements SearchApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
