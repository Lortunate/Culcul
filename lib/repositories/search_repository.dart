import 'dart:convert';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/api/search_api.dart';
import 'package:culcul/data/models/index.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

@riverpod
SearchRepository searchRepository(Ref ref) {
  return SearchRepository(
    api: ref.watch(searchApiProvider),
  );
}

class SearchRepository {
  final SearchApi api;

  SearchRepository({required this.api});

  Future<List<SearchSuggestionTag>> fetchSearchSuggestions(String term) async {
    if (term.isEmpty) return [];
    try {
      final responseStr = await api.fetchSearchSuggestions(term);
      final Map<String, dynamic> json = jsonDecode(responseStr);
      final response = SearchSuggestionResponse.fromJson(json);
      return response.result?.tags ?? [];
    } catch (_) {
      return [];
    }
  }

  Future<DefaultSearchData?> fetchDefaultSearch() async {
    try {
      final params = <String, dynamic>{};
      final response = await api.fetchDefaultSearch(params);
      return response.isSuccess ? response.data : null;
    } catch (_) {
      return null;
    }
  }

  Future<TrendingRankingData?> fetchTrendingRanking() async {
    try {
      final response = await api.fetchTrendingRanking();
      return response.code == 0 ? response.data : null;
    } catch (_) {
      return null;
    }
  }

  Future<SearchResultData?> fetchSearchAll({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    try {
      final params = {
        'keyword': keyword,
        'page': page,
        'page_size': pageSize,
        'search_type': searchType,
        'order': order,
        'duration': duration,
      };

      final response = searchType == 'all'
          ? await api.fetchSearchAll(params)
          : await api.fetchSearchByType(params);

      return response.code == 0 ? response.data : null;
    } catch (_) {
      return null;
    }
  }
}
