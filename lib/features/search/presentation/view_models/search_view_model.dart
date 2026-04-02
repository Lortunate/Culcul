import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchSuggestionsProvider = FutureProvider.autoDispose
    .family<List<SearchSuggestionEntry>, String>((ref, term) async {
      if (term.isEmpty) return [];
      final result = await ref.watch(searchRepositoryProvider).getSuggestions(term);
      return result.when(
        success: (items) => items,
        failure: (error) => throw error.toException(),
      );
    });

final defaultSearchProvider = FutureProvider<SearchDefaultHint?>((ref) async {
  final result = await ref.watch(searchRepositoryProvider).getDefaultSearch();
  return result.when(
    success: (hint) => hint,
    failure: (error) => throw error.toException(),
  );
});

final trendingRankingProvider = FutureProvider<List<SearchTrendingKeyword>>((ref) async {
  final result = await ref.watch(searchRepositoryProvider).getTrendingRanking();
  return result.when(
    success: (items) => items,
    failure: (error) => throw error.toException(),
  );
});

class SearchResultParams {
  final String keyword;
  final String searchType;
  final String order;
  final int duration;

  const SearchResultParams({
    required this.keyword,
    this.searchType = 'all',
    this.order = 'totalrank',
    this.duration = 0,
  });

  @override
  bool operator ==(Object other) {
    return other is SearchResultParams &&
        other.keyword == keyword &&
        other.searchType == searchType &&
        other.order == order &&
        other.duration == duration;
  }

  @override
  int get hashCode => Object.hash(keyword, searchType, order, duration);
}

SearchResultParams searchResultParams(
  String keyword, {
  String searchType = 'all',
  String order = 'totalrank',
  int duration = 0,
}) {
  return SearchResultParams(
    keyword: keyword,
    searchType: searchType,
    order: order,
    duration: duration,
  );
}

final searchResultProvider = AsyncNotifierProvider.autoDispose
    .family<SearchResultController, SearchResultPage?, SearchResultParams>(
      SearchResultController.new,
    );

class SearchResultController extends AsyncNotifier<SearchResultPage?> {
  SearchResultController(this._params);

  final SearchResultParams _params;

  @override
  Future<SearchResultPage?> build() async {
    if (_params.keyword.isEmpty) return null;
    final result = await ref
        .watch(searchRepositoryProvider)
        .search(
          keyword: _params.keyword,
          searchType: _params.searchType,
          order: _params.order,
          duration: _params.duration,
        );
    return result.when(
      success: (page) => page,
      failure: (error) => throw error.toException(),
    );
  }

  Future<void> fetchMore() async {
    final oldState = state.value;
    if (oldState == null || state.isLoading || oldState.page >= oldState.numPages) {
      return;
    }

    state = const AsyncLoading<SearchResultPage?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(searchRepositoryProvider)
          .search(
            keyword: _params.keyword,
            searchType: _params.searchType,
            order: _params.order,
            duration: _params.duration,
            page: oldState.page + 1,
          );
      final newData = result.when(
        success: (page) => page,
        failure: (error) => throw error.toException(),
      );
      return newData.copyWith(items: [...oldState.items, ...newData.items]);
    });
  }
}
