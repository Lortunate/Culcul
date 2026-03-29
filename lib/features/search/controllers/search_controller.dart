import 'package:culcul/features/search/data/search_repository.dart';
import 'package:culcul/data/models/feed/trending_ranking.dart';
import 'package:culcul/data/models/search/default_search.dart';
import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/data/models/search/search_suggestion.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

@riverpod
class SearchSuggestions extends _$SearchSuggestions {
  @override
  FutureOr<List<SearchSuggestionTag>> build(String term) async {
    if (term.isEmpty) return [];
    final repository = ref.watch(searchRepositoryProvider);
    return repository.fetchSearchSuggestions(term);
  }
}

@Riverpod(keepAlive: true)
FutureOr<DefaultSearchData?> defaultSearch(Ref ref) async {
  return ref.watch(searchRepositoryProvider).fetchDefaultSearch();
}

@Riverpod(keepAlive: true)
FutureOr<TrendingRankingData?> trendingRanking(Ref ref) async {
  return ref.watch(searchRepositoryProvider).fetchTrendingRanking();
}

@Riverpod(keepAlive: true)
class SearchResult extends _$SearchResult {
  @override
  FutureOr<SearchResultData?> build(
    String keyword, {
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) async {
    if (keyword.isEmpty) return null;
    return ref
        .watch(searchRepositoryProvider)
        .fetchSearchAll(
          keyword: keyword,
          searchType: searchType,
          order: order,
          duration: duration,
        );
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
    state = AsyncLoading<SearchResultData?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final newData = await ref
          .read(searchRepositoryProvider)
          .fetchSearchAll(
            keyword: keyword,
            searchType: searchType,
            order: order,
            duration: duration,
            page: oldState.page + 1,
          );
      return newData.copyWith(result: [...oldState.result, ...newData.result]);
    });
  }
}

