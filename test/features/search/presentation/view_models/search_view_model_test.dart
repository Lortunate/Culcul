import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/shared/contracts/search_result_contract.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('searchSuggestionsProvider cancels in-flight request on dispose', () async {
    final repository = _FakeSearchRepository(delaySuggestions: true);
    final container = ProviderContainer(
      overrides: [searchRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(
      searchSuggestionsProvider('flutter'),
      (_, _) {},
      fireImmediately: true,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    subscription.close();
    await Future<void>.delayed(Duration.zero);

    expect(repository.lastSuggestionsCancelToken?.isCancelled, isTrue);
    repository.completeSuggestions();
  });

  test('searchResultProvider fetchMore advances query page and merges items', () async {
    final repository = _FakeSearchRepository(
      searchPages: <int, SearchResultPage>{
        1: SearchResultPage(page: 1, numPages: 2, items: <SearchResultEntry>[_video('BV1')]),
        2: SearchResultPage(page: 2, numPages: 2, items: <SearchResultEntry>[_video('BV2')]),
      },
    );
    final container = ProviderContainer(
      overrides: [searchRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final query = SearchQuery(
      keyword: 'flutter',
      type: SearchType.video,
      order: SearchOrder.pubdate,
      duration: SearchDuration.short,
    );
    final provider = searchResultProvider(query);
    final firstPage = await container.read(provider.future);
    expect(firstPage?.items.length, 1);
    expect(repository.searchCalls.map((item) => item.page), <int>[1]);

    await container.read(provider.notifier).fetchMore();

    final merged = container.read(provider).value;
    expect(merged, isNotNull);
    expect(merged!.items.length, 2);
    expect(repository.searchCalls.map((item) => item.page), <int>[1, 2]);

    await container.read(provider.notifier).fetchMore();
    expect(repository.searchCalls.map((item) => item.page), <int>[1, 2]);
  });
}

class _FakeSearchRepository extends Fake implements domain.SearchRepository {
  final bool delaySuggestions;
  final Map<int, SearchResultPage> searchPages;
  final Completer<Result<List<SearchSuggestionEntry>, AppError>> _suggestionsCompleter =
      Completer<Result<List<SearchSuggestionEntry>, AppError>>();

  _FakeSearchRepository({this.delaySuggestions = false, this.searchPages = const {}});

  RequestCancelToken? lastSuggestionsCancelToken;
  final List<SearchQuery> searchCalls = <SearchQuery>[];

  @override
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  }) async {
    lastSuggestionsCancelToken = cancelToken;
    if (delaySuggestions) {
      return _suggestionsCompleter.future;
    }
    return const Success(<SearchSuggestionEntry>[]);
  }

  void completeSuggestions() {
    if (_suggestionsCompleter.isCompleted) {
      return;
    }
    _suggestionsCompleter.complete(const Success(<SearchSuggestionEntry>[]));
  }

  @override
  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch({
    bool forceRefresh = false,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    return const Success(<SearchTrendingKeyword>[]);
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    RequestCancelToken? cancelToken,
  }) async {
    searchCalls.add(query);
    final page =
        searchPages[query.page] ??
        SearchResultPage(page: query.page, numPages: query.page, items: const []);
    return Success(page);
  }
}

SearchVideoEntry _video(String bvid) {
  return SearchVideoEntry(
    bvid: bvid,
    title: bvid,
    author: 'author',
    coverUrl: 'https://example.com/$bvid.jpg',
    durationText: '01:00',
    typeName: 'video',
    playCount: 1,
    viewCount: 1,
    videoReviewCount: 0,
    danmakuCount: 0,
  );
}
