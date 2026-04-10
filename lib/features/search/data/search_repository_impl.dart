import 'dart:convert';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/network/request_cancel_token.dart';
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
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository_impl.g.dart';

@riverpod
domain.SearchRepository searchRepository(Ref ref) {
  return SearchRepositoryImpl(api: SearchApi(ref.watch(dioClientProvider)));
}

class SearchRepositoryImpl
    with RequestExecutorBinding
    implements domain.SearchRepository {
  static const int _defaultSearchPageSize = 20;
  final SearchApi api;
  final RequestExecutor _requestExecutor;

  SearchRepositoryImpl({required this.api, RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<List<SearchSuggestionTag>, AppError>> _fetchSearchSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  }) async {
    if (term.isEmpty) return const Success(<SearchSuggestionTag>[]);
    final result = await requestResult(
      () => api.fetchSearchSuggestions(term, cancelToken: cancelToken?.dioToken),
    );
    return result.map(_parseSuggestionsResponse);
  }

  List<SearchSuggestionTag> _parseSuggestionsResponse(String responseStr) {
    try {
      final Map<String, dynamic> json = jsonDecode(responseStr);
      final response = SearchSuggestionResponse.fromJson(json);
      return response.result?.tags ?? [];
    } catch (e) {
      return const <SearchSuggestionTag>[];
    }
  }

  Future<Result<DefaultSearchData, AppError>> _fetchDefaultSearch({
    bool forceRefresh = false,
  }) {
    return requestApiResult(
      () => api.fetchDefaultSearch(forceRefresh: _forceRefreshQuery(forceRefresh)),
    );
  }

  Future<Result<TrendingRankingData, AppError>> _fetchTrendingRanking({
    bool forceRefresh = false,
  }) async {
    return requestResult(() async {
      final response = await api.fetchTrendingRanking(
        forceRefresh: _forceRefreshQuery(forceRefresh),
      );
      if (response.code != 0) {
        throw ServerException(response.message, code: response.code);
      }
      return response.data;
    });
  }

  Future<Result<SearchResultData, AppError>> _fetchSearchResult({
    required SearchQuery query,
    RequestCancelToken? cancelToken,
  }) async {
    return requestResult(() async {
      final response = query.type == SearchType.all
          ? await api.fetchSearchAll(
              keyword: query.keyword,
              page: query.page,
              pageSize: _defaultSearchPageSize,
              searchType: query.type.apiValue,
              order: query.order.apiValue,
              duration: query.duration.apiValue,
              cancelToken: cancelToken?.dioToken,
            )
          : await api.fetchSearchByType(
              keyword: query.keyword,
              page: query.page,
              pageSize: _defaultSearchPageSize,
              searchType: query.type.apiValue,
              order: query.order.apiValue,
              duration: query.duration.apiValue,
              cancelToken: cancelToken?.dioToken,
            );
      if (response.code != 0 || response.data == null) {
        throw ServerException(response.message, code: response.code);
      }
      return response.data!;
    });
  }

  bool? _forceRefreshQuery(bool forceRefresh) {
    return forceRefresh ? true : null;
  }

  @override
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  }) async {
    final result = await _fetchSearchSuggestions(term, cancelToken: cancelToken);
    return result.map(
      (suggestions) => suggestions
          .map((item) => item.toDomain())
          .whereType<SearchSuggestionEntry>()
          .toList(),
    );
  }

  @override
  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch({
    bool forceRefresh = false,
  }) async {
    final result = await _fetchDefaultSearch(forceRefresh: forceRefresh);
    return result.map((data) => data.toDomain());
  }

  @override
  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    final result = await _fetchTrendingRanking(forceRefresh: forceRefresh);
    return result.map((data) => data.list.map((item) => item.toDomain()).toList());
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    RequestCancelToken? cancelToken,
  }) async {
    final result = await _fetchSearchResult(query: query, cancelToken: cancelToken);
    return result.map((data) => data.toDomain());
  }
}
