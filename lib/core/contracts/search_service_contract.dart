import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Cross-feature contract for search functionality.
/// Used by dynamic feature to search topics.
abstract interface class SearchService {
  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
  });
}
