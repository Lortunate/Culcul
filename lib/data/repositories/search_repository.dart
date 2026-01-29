import 'package:cilixili/data/sources/api/api_provider.dart';
import 'package:cilixili/data/sources/api/search_api.dart';
import 'package:cilixili/data/sources/api/helpers/wbi_helper.dart';
import 'package:cilixili/data/sources/api/helpers/wbi_provider.dart';
import 'package:cilixili/data/models/search/default_search.dart';
import 'package:cilixili/data/models/search/search_suggestion.dart';
import 'package:cilixili/data/models/search/trending_ranking.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

@riverpod
SearchRepository searchRepository(Ref ref) {
  return SearchRepository(
    api: ref.watch(searchApiProvider),
    wbiHelper: ref.watch(wbiHelperProvider),
  );
}

class SearchRepository {
  final SearchApi api;
  final WbiHelper wbiHelper;

  SearchRepository({required this.api, required this.wbiHelper});

  /// Fetch search suggestions based on the term.
  /// Returns a list of [SearchSuggestionTag] or an empty list if no results.
  Future<List<SearchSuggestionTag>> fetchSearchSuggestions(String term) async {
    if (term.isEmpty) return [];

    try {
      final response = await api.fetchSearchSuggestions(term);
      return response.result?.tags ?? [];
    } catch (e) {
      // In search suggestions, we typically don't want to crash the UI on failure
      // Just return an empty list.
      return [];
    }
  }

  /// Fetch default search word shown in the search bar.
  Future<DefaultSearchData?> fetchDefaultSearch() async {
    try {
      final params = <String, dynamic>{};
      final signedParams = wbiHelper.sign(params);
      final response = await api.fetchDefaultSearch(signedParams);
      if (response.isSuccess) {
        return response.data;
      }
    } catch (e) {
      // Return null on failure to fallback to local placeholder
    }
    return null;
  }

  Future<TrendingRankingData?> fetchTrendingRanking() async {
    try {
      final response = await api.fetchTrendingRanking();
      if (response.code == 0) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
