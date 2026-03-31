import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/home/models/feed_response.dart';
import 'package:culcul/features/home/models/popular_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'home_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApi {
  factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;

  @GET(ApiConstants.feedRcmd)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<FeedResponse>> fetchRecommend({
    @Query('fresh_type') int freshType = 4,
    @Query('ps') int ps = 20,
    @Query('fresh_idx') int freshIdx = 1,
    @Query('fresh_idx_1h') int freshIdx1h = 1,
    @Query('force_refresh') bool? forceRefresh,
  });

  @GET(ApiConstants.popular)
  Future<ApiResponse<PopularResponse>> fetchPopular({
    @Query('pn') int pn = 1,
    @Query('ps') int ps = 20,
    @Query('force_refresh') bool? forceRefresh,
  });
}
