import 'dart:convert';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
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

  Future<Result<List<SearchSuggestionTag>, AppException>> fetchSearchSuggestions(
    String term,
  ) async {
    if (term.isEmpty) return const Success([]);

    final result = await safeCall(() => api.fetchSearchSuggestions(term));

    return switch (result) {
      Success(value: final responseStr) => _parseSuggestions(responseStr),
      Failure(exception: final e) => Failure(e),
    };
  }

  Result<List<SearchSuggestionTag>, AppException> _parseSuggestions(String responseStr) {
    try {
      final Map<String, dynamic> json = jsonDecode(responseStr);
      final response = SearchSuggestionResponse.fromJson(json);
      return Success(response.result?.tags ?? []);
    } catch (e) {
      return const Success(<SearchSuggestionTag>[]);
    }
  }

  Future<Result<DefaultSearchData, AppException>> fetchDefaultSearch() {
    return safeApiCall(() => api.fetchDefaultSearch());
  }

  Future<Result<TrendingRankingData, AppException>> fetchTrendingRanking() async {
    final result = await safeCall(() => api.fetchTrendingRanking());

    return switch (result) {
      Success(value: final response) =>
        (response.code == 0)
            ? Success(response.data)
            : Failure(ServerException(response.message, code: response.code)),
      Failure(exception: final e) => Failure(e),
    };
  }

  Future<Result<SearchResultData, AppException>> fetchSearchAll({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    final result = await safeCall(() async {
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

    return switch (result) {
      Success(value: final response) =>
        (response.code == 0 && response.data != null)
            ? Success(response.data!)
            : Failure(ServerException(response.message, code: response.code)),
      Failure(exception: final e) => Failure(e),
    };
  }
}
