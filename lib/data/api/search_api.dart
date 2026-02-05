import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/default_search.dart';
import 'package:culcul/data/models/search_result.dart';
import 'package:culcul/data/models/search_suggestion.dart';
import 'package:culcul/data/models/trending_ranking.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: 'https://s.search.bilibili.com')
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET('/main/suggest')
  Future<String> fetchSearchSuggestions(
    @Query('term') String term, {
    @Query('main_ver') String mainVer = 'v1',
  });

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/default')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<DefaultSearchData>> fetchDefaultSearch(
    @Queries() Map<String, dynamic> params,
  );

  @GET('https://app.bilibili.com/x/v2/search/trending/ranking')
  Future<TrendingRankingResponse> fetchTrendingRanking();

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/all/v2')
  @Headers({'x-bili-wbi': 'true'})
  Future<SearchResultResponse> fetchSearchAll(
    @Queries() Map<String, dynamic> params,
  );

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/type')
  @Headers({'x-bili-wbi': 'true'})
  Future<SearchResultResponse> fetchSearchByType(
    @Queries() Map<String, dynamic> params,
  );
}
