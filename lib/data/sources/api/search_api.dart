import 'package:cilixili/data/models/common/api_response.dart';
import 'package:cilixili/data/models/search/default_search.dart';
import 'package:cilixili/data/models/search/search_suggestion.dart';
import 'package:cilixili/data/models/search/trending_ranking.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: 'https://s.search.bilibili.com')
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET('/main/suggest')
  Future<SearchSuggestionResponse> fetchSearchSuggestions(
    @Query('term') String term, {
    @Query('main_ver') String mainVer = 'v1',
    @Query('highlight') String highlight = '',
  });

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/default')
  Future<ApiResponse<DefaultSearchData>> fetchDefaultSearch(
    @Queries() Map<String, dynamic> params,
  );

  @GET('https://app.bilibili.com/x/v2/search/trending/ranking')
  Future<TrendingRankingResponse> fetchTrendingRanking();
}
