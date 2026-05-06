import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/features/search/data/dtos/search_dtos.dart';
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
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ApiConstants.searchDefaultUrl)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<DefaultSearchData>> fetchDefaultSearch({
    @Query('force_refresh') bool? forceRefresh,
  });

  @GET(ApiConstants.searchTrendingRanking)
  Future<TrendingRankingResponse> fetchTrendingRanking({
    @Query('force_refresh') bool? forceRefresh,
  });

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/all/v2')
  @Headers({'x-bili-wbi': 'true'})
  Future<SearchResultResponse> fetchSearchAll({
    @Query('keyword') required String keyword,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
    @Query('search_type') String searchType = 'all',
    @Query('order') String order = 'totalrank',
    @Query('duration') int duration = 0,
    @Query('tids') int? tids,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/type')
  @Headers({'x-bili-wbi': 'true'})
  Future<SearchResultResponse> fetchSearchByType({
    @Query('keyword') required String keyword,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
    @Query('search_type') String searchType = 'video',
    @Query('order') String order = 'totalrank',
    @Query('duration') int duration = 0,
    @Query('tids') int? tids,
    @CancelRequest() CancelToken? cancelToken,
  });
}
