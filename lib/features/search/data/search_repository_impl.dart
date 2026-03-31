import 'dart:convert';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/features/search/data/search_mapper.dart';
import 'package:culcul/features/search/data/search_api.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:culcul/features/search/domain/entities/search_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository_impl.g.dart';

@riverpod
domain.SearchRepository searchRepository(Ref ref) {
  return SearchRepositoryImpl(api: SearchApi(ref.watch(dioClientProvider)));
}

class SearchRepositoryImpl extends BaseRepository implements domain.SearchRepository {
  final SearchApi api;

  SearchRepositoryImpl({required this.api});

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

  @override
  Future<List<SearchSuggestionEntry>> getSuggestions(String term) async {
    final suggestions = await fetchSearchSuggestions(term);
    return suggestions
        .map((item) => item.toDomain())
        .whereType<SearchSuggestionEntry>()
        .toList();
  }

  @override
  Future<SearchDefaultHint?> getDefaultSearch() async {
    final result = await fetchDefaultSearch();
    return result.toDomain();
  }

  @override
  Future<List<SearchTrendingKeyword>> getTrendingRanking() async {
    final result = await fetchTrendingRanking();
    return result.list.map((item) => item.toDomain()).toList();
  }

  @override
  Future<SearchResultPage> search({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    final result = await fetchSearchAll(
      keyword: keyword,
      page: page,
      pageSize: pageSize,
      searchType: searchType,
      order: order,
      duration: duration,
    );
    return result.toDomain();
  }
}

