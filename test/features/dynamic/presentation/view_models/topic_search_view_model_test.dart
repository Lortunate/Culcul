import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/presentation/view_models/topic_search_view_model.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('topicSearchViewModel uses topic query and filters topic entries', () async {
    final repository = _FakeSearchRepository();
    final container = ProviderContainer(
      overrides: [searchRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final result = await container.read(topicSearchViewModelProvider('  keyword  ').future);

    expect(repository.lastQuery, isNotNull);
    expect(repository.lastQuery!.keyword, 'keyword');
    expect(repository.lastQuery!.type, SearchType.topic);
    expect(result.length, 1);
    expect(result.first.topicId, 100);
  });

  test('topicSearchViewModel returns empty for blank keyword', () async {
    final repository = _FakeSearchRepository();
    final container = ProviderContainer(
      overrides: [searchRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final result = await container.read(topicSearchViewModelProvider('   ').future);

    expect(result, isEmpty);
    expect(repository.lastQuery, isNull);
  });
}

class _FakeSearchRepository extends Fake implements domain.SearchRepository {
  SearchQuery? lastQuery;

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    RequestCancelToken? cancelToken,
  }) async {
    lastQuery = query;
    return const Success(
      SearchResultPage(
        page: 1,
        numPages: 1,
        items: <SearchResultEntry>[
          SearchTopicEntry(
            topicId: 100,
            title: 'topic',
            description: null,
            coverUrl: null,
            updateCount: 1,
          ),
          SearchVideoEntry(
            bvid: 'BV1',
            title: 'video',
            author: 'author',
            coverUrl: '',
            durationText: '01:00',
            typeName: 'video',
            playCount: 0,
            viewCount: 0,
            videoReviewCount: 0,
            danmakuCount: 0,
          ),
        ],
      ),
    );
  }

  @override
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  }) async => const Success(<SearchSuggestionEntry>[]);

  @override
  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch({
    bool forceRefresh = false,
  }) async => const Success(null);

  @override
  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async => const Success(<SearchTrendingKeyword>[]);
}
