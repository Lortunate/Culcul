import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/search/data/mappers/search_mapper.dart';
import 'package:culcul/features/search/data/search_repository.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
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
      final suggestions = await _repository.fetchSearchSuggestions(term);
      return Success(
        suggestions
            .map((item) => item.toDomain())
            .whereType<SearchSuggestionEntry>()
            .toList(),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch() async {
    try {
      final result = await _repository.fetchDefaultSearch();
      return Success(result?.toDomain());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking() async {
    try {
      final result = await _repository.fetchTrendingRanking();
      return Success(result?.list.map((item) => item.toDomain()).toList() ?? const []);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<SearchResultPage, AppError>> search(SearchQuery query) async {
    try {
      final result = await _repository.fetchSearchAll(
        keyword: query.keyword,
        page: query.page,
        pageSize: query.pageSize,
        searchType: query.searchType,
        order: query.order,
        duration: query.duration,
      );
      return Success(result.toDomain());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
