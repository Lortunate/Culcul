import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/contracts/search_service_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/session/search_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bridges core's SearchService contract with search's repository.
class SearchServiceAdapter implements SearchService {
  final Ref _ref;
  SearchServiceAdapter(this._ref);

  @override
  Future<Result<SearchResultPage, AppError>> search({required SearchQuery query}) {
    return _ref.read(crossSearchRepositoryProvider).search(query: query);
  }
}
