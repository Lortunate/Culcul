import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/search_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_view_model.g.dart';

@riverpod
class SearchSuggestions extends _$SearchSuggestions {
  @override
  FutureOr<List<SearchSuggestionEntry>> build(String term) async {
    if (term.isEmpty) return [];
    return ref.watch(searchRepositoryProvider).getSuggestions(term);
  }
}

@Riverpod(keepAlive: true)
FutureOr<SearchDefaultHint?> defaultSearch(Ref ref) async {
  return ref.watch(searchRepositoryProvider).getDefaultSearch();
}

@Riverpod(keepAlive: true)
FutureOr<List<SearchTrendingKeyword>> trendingRanking(Ref ref) async {
  return ref.watch(searchRepositoryProvider).getTrendingRanking();
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
    return ref.watch(searchRepositoryProvider).search(
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
    state = AsyncLoading<SearchResultPage?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final newData = await ref.read(searchRepositoryProvider).search(
        keyword: keyword,
        searchType: searchType,
        order: order,
        duration: duration,
        page: oldState.page + 1,
      );
      return newData.copyWith(items: [...oldState.items, ...newData.items]);
    });
  }
}
