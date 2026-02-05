import 'package:culcul/repositories/search_repository.dart';
import 'package:culcul/data/models/index.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

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
    if (oldState == null ||
        state.isLoading ||
        oldState.page >= oldState.numPages) {
      return;
    }

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
      return newData == null
          ? oldState
          : newData.copyWith(result: [...oldState.result, ...newData.result]);
    });
  }
}
