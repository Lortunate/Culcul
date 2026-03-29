import 'dart:convert';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/search_api.dart';
import 'package:culcul/data/models/feed/trending_ranking.dart';
import 'package:culcul/data/models/search/default_search.dart';
import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/data/models/search/search_suggestion.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

@riverpod
SearchRepository searchRepository(Ref ref) {
  return SearchRepository(api: ref.watch(searchApiProvider));
}

class SearchRepository extends BaseRepository {
  final SearchApi api;

  SearchRepository({required this.api});

  Future<List<SearchSuggestionTag>> fetchSearchSuggestions(String term) async {
    if (term.isEmpty) return [];
    final responseStr = await request(() => api.fetchSearchSuggestions(term));
    return _parseSuggestions(responseStr);
  }

  List<SearchSuggestionTag> _parseSuggestions(String responseStr) {
    try {
      final Map<String, dynamic> json = jsonDecode(responseStr);
      final response = SearchSuggestionResponse.fromJson(json);
      return response.result?.tags ?? [];
    } catch (e) {
      return const <SearchSuggestionTag>[];
    }
  }

  Future<DefaultSearchData> fetchDefaultSearch() {
    return requestApi(() => api.fetchDefaultSearch());
  }

  Future<TrendingRankingData> fetchTrendingRanking() async {
    final response = await request(() => api.fetchTrendingRanking());
    if (response.code != 0) {
      throw ServerException(response.message, code: response.code);
    }
    return response.data;
  }

  Future<SearchResultData> fetchSearchAll({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    final response = await request(() async {
      return searchType == 'all'
          ? await api.fetchSearchAll(
              keyword: keyword,
              page: page,
              pageSize: pageSize,
              searchType: searchType,
              order: order,
              duration: duration,
            )
          : await api.fetchSearchByType(
              keyword: keyword,
              page: page,
              pageSize: pageSize,
              searchType: searchType,
              order: order,
              duration: duration,
            );
    });
    if (response.code != 0 || response.data == null) {
      throw ServerException(response.message, code: response.code);
    }
    return response.data!;
  }
}
