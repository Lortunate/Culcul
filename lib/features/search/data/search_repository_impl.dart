import 'dart:convert';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/data/dtos/search_dtos.dart';
import 'package:culcul/features/search/data/search_mapper.dart';
import 'package:culcul/features/search/data/search_api.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository_impl.g.dart';

@riverpod
domain.SearchRepository searchRepository(Ref ref) {
  return SearchRepositoryImpl(api: SearchApi(ref.watch(dioClientProvider)));
}

class SearchRepositoryImpl with RequestExecutorBinding implements domain.SearchRepository {
  static const int _defaultSearchPageSize = 20;
  final SearchApi api;
  final RequestExecutor _requestExecutor;

  SearchRepositoryImpl({required this.api, RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

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
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    final response = await request(() async {
      return searchType == 'all'
          ? await api.fetchSearchAll(
              keyword: keyword,
              page: page,
              pageSize: _defaultSearchPageSize,
              searchType: searchType,
              order: order,
              duration: duration,
            )
          : await api.fetchSearchByType(
              keyword: keyword,
              page: page,
              pageSize: _defaultSearchPageSize,
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
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(String term) async {
    return requestResult(() async {
      final suggestions = await fetchSearchSuggestions(term);
      return suggestions
          .map((item) => item.toDomain())
          .whereType<SearchSuggestionEntry>()
          .toList();
    });
  }

  @override
  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch() async {
    return requestResult(() async {
      final result = await fetchDefaultSearch();
      return result.toDomain();
    });
  }

  @override
  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking() async {
    return requestResult(() async {
      final result = await fetchTrendingRanking();
      return result.list.map((item) => item.toDomain()).toList();
    });
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required String keyword,
    int page = 1,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    return requestResult(() async {
      final result = await fetchSearchAll(
        keyword: keyword,
        page: page,
        searchType: searchType,
        order: order,
        duration: duration,
      );
      return result.toDomain();
    });
  }
}
