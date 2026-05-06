import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @GET('/x/space/wbi/acc/info')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<dynamic>> getAccountInfo(@Query('mid') int mid);

  @GET('/x/space/wbi/arc/search')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<UserSpaceVideoListResponse>> getSpaceVideos({
    @Query('mid') required int mid,
    @Query('pn') int page = 1,
    @Query('ps') int pageSize = 30,
    @Query('order') String order = 'pubdate',
    @Query('keyword') String? keyword,
    @Query('force_refresh') bool? forceRefresh,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('/x/space/top/arc')
  Future<ApiResponse<UserSpaceVideoModel>> getStickyVideo(@Query('vmid') int vmid);

  @GET('/x/space/masterpiece')
  Future<ApiResponse<List<UserSpaceVideoModel>>> getMasterpiece(@Query('vmid') int vmid);

  @GET('/x/relation/stat')
  Future<ApiResponse<dynamic>> getRelationStat(@Query('vmid') int vmid);

  @GET('/x/space/upstat')
  Future<ApiResponse<dynamic>> getUpStat(@Query('mid') int mid);

  @GET('/x/space/navnum')
  Future<ApiResponse<dynamic>> getNavNum(@Query('mid') int mid);

  @GET('/x/web-interface/card')
  Future<ApiResponse<dynamic>> getCard(
    @Query('mid') int mid, {
    @Query('photo') bool photo = true,
  });

  @GET(ApiConstants.nav)
  Future<ApiResponse<dynamic>> getNav();

  @POST('/x/relation/modify')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<dynamic>> modifyRelation(
    @Field('fid') int fid,
    @Field('act') int act,
    @Field('re_src') int reSrc,
  );
}
