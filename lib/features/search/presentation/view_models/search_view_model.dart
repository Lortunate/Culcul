import 'package:culcul/features/search/application/use_case/search_use_cases.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_view_model.g.dart';

@riverpod
class SearchSuggestions extends _$SearchSuggestions {
  @override
  FutureOr<List<SearchSuggestionEntry>> build(String term) async {
    if (term.isEmpty) return [];
    final result = await ref.watch(searchUseCasesProvider).getSuggestions(term);
    return result.when(success: (value) => value, failure: (error) => throw error);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SearchDefaultHint?> defaultSearch(Ref ref) async {
  final result = await ref.watch(searchUseCasesProvider).getDefaultSearch();
  return result.when(success: (value) => value, failure: (error) => throw error);
}

@Riverpod(keepAlive: true)
FutureOr<List<SearchTrendingKeyword>> trendingRanking(Ref ref) async {
  final result = await ref.watch(searchUseCasesProvider).getTrendingRanking();
  return result.when(success: (value) => value, failure: (error) => throw error);
}

@Riverpod(keepAlive: true)
class SearchResult extends _$SearchResult {
  @override
  FutureOr<SearchResultPage?> build(
    String keyword, {
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    if (keyword.isEmpty) return null;
    final result = await ref
        .watch(searchUseCasesProvider)
        .search(
          SearchQuery(
            keyword: keyword,
            searchType: searchType,
            order: order,
            duration: duration,
          ),
        );
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  Future<void> fetchMore() async {
    final oldState = state.value;
    // Check if we already have data, aren't loading, and have more pages
    if (oldState == null ||
        state.isLoading ||
        state.isRefreshing ||
        oldState.page >= oldState.numPages) {
      return;
    }

    // Set state to loading but keep previous value to avoid UI flicker
    state = AsyncLoading<SearchResultPage?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(searchUseCasesProvider)
          .search(
            SearchQuery(
              keyword: keyword,
              searchType: searchType,
              order: order,
              duration: duration,
              page: oldState.page + 1,
            ),
          );
      final newData = result.when(
        success: (value) => value,
        failure: (error) => throw error,
      );
      return newData.copyWith(items: [...oldState.items, ...newData.items]);
    });
  }
}
