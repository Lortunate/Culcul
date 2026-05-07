import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_query.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';

abstract class SearchRepository {
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  });

  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch({
    bool forceRefresh = false,
  });

  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  });

  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    RequestCancelToken? cancelToken,
  });
}
