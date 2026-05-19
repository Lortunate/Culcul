import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/data/dtos/default_search.dart';
import 'package:culcul/features/search/data/dtos/search_result.dart';
import 'package:culcul/features/search/data/dtos/search_suggestion.dart';
import 'package:culcul/features/search/data/dtos/trending_ranking.dart';
import 'package:culcul/features/search/data/search_mapper.dart';
import 'package:culcul/features/search/data/search_api.dart';
import 'package:culcul/features/search/application/search_port.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository_impl.g.dart';

@riverpod
SearchRepositoryImpl searchRepository(Ref ref) {
  return SearchRepositoryImpl(api: SearchApi(ref.watch(dioClientProvider)));
}

class SearchRepositoryImpl implements SearchPort {
  final SearchApi api;
  final RequestExecutor _requestExecutor;

  SearchRepositoryImpl({required this.api, RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<List<SearchSuggestionTag>, AppError>> _fetchSearchSuggestions(
    String term, {
    CancelToken? cancelToken,
  }) async {
    if (term.isEmpty) return const Success(<SearchSuggestionTag>[]);
    final options = _requestOptions(
      requestClass: EndpointRequestClass.search,
      cancelToken: cancelToken,
    );
    final result = await _requestExecutor.run(
      () => api.fetchSearchSuggestions(
        term,
        extras: options.toDioExtras(),
        cancelToken: cancelToken,
      ),
      options: options,
    );
    return result.map(_parseSuggestionsResponse);
  }

  List<SearchSuggestionTag> _parseSuggestionsResponse(String responseStr) {
    try {
      // Intentionally synchronous: suggestion responses are small (<1KB)
      // and this runs inside result.map() which requires a sync callback.
      final json = jsonDecode(responseStr) as Map<String, dynamic>;
      final response = SearchSuggestionResponse.fromJson(json);
      return response.result?.tags ?? [];
    } catch (e) {
      return const <SearchSuggestionTag>[];
    }
  }

  Future<Result<DefaultSearchData, AppError>> _fetchDefaultSearch({
    bool forceRefresh = false,
  }) {
    final options = _requestOptions(requestClass: EndpointRequestClass.search);
    return _requestExecutor.runApiDirect(
      () => api.fetchDefaultSearch(
        forceRefresh: _forceRefreshQuery(forceRefresh),
        extras: options.toDioExtras(),
      ),
      options: options,
    );
  }

  Future<Result<TrendingRankingData, AppError>> _fetchTrendingRanking({
    bool forceRefresh = false,
  }) {
    final options = _requestOptions(requestClass: EndpointRequestClass.search);
    return _requestExecutor.runResponse(
      () => api.fetchTrendingRanking(
        forceRefresh: _forceRefreshQuery(forceRefresh),
        extras: options.toDioExtras(),
      ),
      isSuccess: (response) => response.code == 0,
      data: (response) => response.data,
      message: (response) => response.message,
      code: (response) => response.code,
      options: options,
    );
  }

  Future<Result<SearchResultData, AppError>> _fetchSearchResult({
    required SearchQuery query,
    CancelToken? cancelToken,
  }) {
    final options = _requestOptions(
      requestClass: EndpointRequestClass.search,
      cancelToken: cancelToken,
    );
    return _requestExecutor.runResponse(
      () async => query.type == SearchType.all
          ? api.fetchSearchAll(
              keyword: query.keyword,
              page: query.page,
              searchType: query.type.apiValue,
              order: query.order.apiValue,
              duration: query.duration.apiValue,
              extras: options.toDioExtras(),
              cancelToken: cancelToken,
            )
          : api.fetchSearchByType(
              keyword: query.keyword,
              page: query.page,
              searchType: query.type.apiValue,
              order: query.order.apiValue,
              duration: query.duration.apiValue,
              extras: options.toDioExtras(),
              cancelToken: cancelToken,
            ),
      isSuccess: (response) => response.code == 0,
      data: (response) => response.data,
      message: (response) => response.message,
      code: (response) => response.code,
      options: options,
    );
  }

  RequestExecutionOptions _requestOptions({
    required EndpointRequestClass requestClass,
    CancelToken? cancelToken,
  }) {
    return RequestExecutionOptions(requestClass: requestClass, cancelToken: cancelToken);
  }

  bool? _forceRefreshQuery(bool forceRefresh) {
    return forceRefresh ? true : null;
  }

  Future<Result<List<String>, AppError>> getSuggestions(
    String term, {
    CancelToken? cancelToken,
  }) async {
    final result = await _fetchSearchSuggestions(term, cancelToken: cancelToken);
    return result.map(
      (suggestions) => suggestions
          .map((item) => item.toDomain())
          .whereType<String>()
          .where((s) => s.isNotEmpty)
          .toList(),
    );
  }

  @override
  Future<Result<String?, AppError>> getDefaultSearch({bool forceRefresh = false}) async {
    final result = await _fetchDefaultSearch(forceRefresh: forceRefresh);
    return result.map((data) => data.toDomain());
  }

  Future<Result<List<TrendingItem>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    final result = await _fetchTrendingRanking(forceRefresh: forceRefresh);
    return result.map((data) => data.list);
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    CancelToken? cancelToken,
  }) async {
    final result = await _fetchSearchResult(query: query, cancelToken: cancelToken);
    return result.map((data) => data.toDomain());
  }
}
