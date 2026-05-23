import 'package:dio/dio.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/application/search_trending_item.dart';

/// Search feature application boundary.
abstract interface class SearchPort {
  Future<Result<String?, AppError>> getDefaultSearch({bool forceRefresh = false});

  Future<Result<List<String>, AppError>> getSuggestions(
    String term, {
    CancelToken? cancelToken,
  });

  Future<Result<List<SearchTrendingItem>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  });

  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    CancelToken? cancelToken,
  });
}
