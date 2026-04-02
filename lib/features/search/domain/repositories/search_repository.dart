import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';

abstract class SearchRepository {
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(String term);

  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch();

  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking();

  Future<Result<SearchResultPage, AppError>> search({
    required String keyword,
    int page = 1,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  });
}
