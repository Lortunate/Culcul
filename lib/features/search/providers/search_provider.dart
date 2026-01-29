import 'package:cilixili/data/repositories/search_repository.dart';
import 'package:cilixili/data/models/search/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class SearchSuggestions extends _$SearchSuggestions {
  @override
  FutureOr<List<SearchSuggestionTag>> build(String term) async {
    if (term.isEmpty) {
      return [];
    }

    // Add a small delay to debounce requests if needed,
    // although typically debouncing is handled at the UI/Controller level.
    final repository = ref.watch(searchRepositoryProvider);
    return repository.fetchSearchSuggestions(term);
  }
}

@Riverpod(keepAlive: true)
FutureOr<DefaultSearchData?> defaultSearch(Ref ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.fetchDefaultSearch();
}

@Riverpod(keepAlive: true)
FutureOr<TrendingRankingData?> trendingRanking(Ref ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.fetchTrendingRanking();
}
