import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/contracts/search_service_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/session/search_providers.dart';
import 'package:culcul/features/dynamic/presentation/view_models/topic_search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('topicSearchViewModel uses topic query and filters topic entries', () async {
    final service = _FakeSearchService();
    final container = ProviderContainer(
      overrides: [searchServiceProvider.overrideWithValue(service)],
    );
    addTearDown(container.dispose);

    final result = await container.read(
      topicSearchViewModelProvider('  keyword  ').future,
    );

    expect(service.lastQuery, isNotNull);
    expect(service.lastQuery!.keyword, 'keyword');
    expect(service.lastQuery!.type, SearchType.topic);
    expect(result.length, 1);
    expect(result.first.topicId, 100);
  });

  test('topicSearchViewModel returns empty for blank keyword', () async {
    final service = _FakeSearchService();
    final container = ProviderContainer(
      overrides: [searchServiceProvider.overrideWithValue(service)],
    );
    addTearDown(container.dispose);

    final result = await container.read(topicSearchViewModelProvider('   ').future);

    expect(result, isEmpty);
    expect(service.lastQuery, isNull);
  });
}

class _FakeSearchService implements SearchService {
  SearchQuery? lastQuery;

  @override
  Future<Result<SearchResultPage, AppError>> search({required SearchQuery query}) async {
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
}
