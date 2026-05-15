import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Feature-neutral runtime port for cross-feature search access.
abstract interface class SearchPort {
  Future<Result<String?, AppError>> getDefaultSearch({bool forceRefresh = false});

  Future<Result<SearchResultPage, AppError>> search({required SearchQuery query});
}
