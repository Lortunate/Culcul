import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'search_api.g.dart';

const int _searchResultPageSize = 20;

@RestApi(baseUrl: 'https://s.search.bilibili.com')
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET('/main/suggest')
  Future<String> fetchSearchSuggestions(
    @Query('term') String term, {
    @Query('main_ver') String mainVer = 'v1',
    @Extras() Map<String, dynamic>? extras,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ApiConstants.searchDefaultUrl)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<Object>> fetchDefaultSearch({
    @Query('force_refresh') bool? forceRefresh,
    @Extras() Map<String, dynamic>? extras,
  });

  @GET(ApiConstants.searchTrendingRanking)
  Future<ApiResponse<Object>> fetchTrendingRanking({
    @Query('force_refresh') bool? forceRefresh,
    @Extras() Map<String, dynamic>? extras,
  });

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/all/v2')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<Object>> fetchSearchAll({
    @Query('keyword') required String keyword,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = _searchResultPageSize,
    @Query('search_type') String searchType = 'all',
    @Query('order') String order = 'totalrank',
    @Query('duration') int duration = 0,
    @Query('tids') int? tids,
    @Extras() Map<String, dynamic>? extras,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('https://api.bilibili.com/x/web-interface/wbi/search/type')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<Object>> fetchSearchByType({
    @Query('keyword') required String keyword,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = _searchResultPageSize,
    @Query('search_type') String searchType = 'video',
    @Query('order') String order = 'totalrank',
    @Query('duration') int duration = 0,
    @Query('tids') int? tids,
    @Extras() Map<String, dynamic>? extras,
    @CancelRequest() CancelToken? cancelToken,
  });
}
