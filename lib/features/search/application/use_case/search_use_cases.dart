import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart';
import 'package:culcul/features/search/search_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_use_cases.g.dart';

class SearchQuery {
  final String keyword;
  final int page;
  final int pageSize;
  final String searchType;
  final String order;
  final int duration;

  const SearchQuery({
    required this.keyword,
    this.page = 1,
    this.pageSize = 20,
    this.searchType = 'all',
    this.order = 'totalrank',
    this.duration = 0,
  });
}

@riverpod
SearchUseCases searchUseCases(Ref ref) {
  return SearchUseCases(ref.read(searchRepositoryProvider));
}

class SearchUseCases {
  final SearchRepository _repository;

  const SearchUseCases(this._repository);

  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term,
  ) async {
    try {
      return Success(await _repository.getSuggestions(term));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch() async {
    try {
      return Success(await _repository.getDefaultSearch());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking() async {
    try {
      return Success(await _repository.getTrendingRanking());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<SearchResultPage, AppError>> search(SearchQuery query) async {
    try {
      return Success(
        await _repository.search(
          keyword: query.keyword,
          page: query.page,
          pageSize: query.pageSize,
          searchType: query.searchType,
          order: query.order,
          duration: query.duration,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
