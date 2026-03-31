import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';

abstract class SearchRepository {
  Future<List<SearchSuggestionEntry>> getSuggestions(String term);

  Future<SearchDefaultHint?> getDefaultSearch();

  Future<List<SearchTrendingKeyword>> getTrendingRanking();

  Future<SearchResultPage> search({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  });
}
