import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  // x/space/wbi/acc/info?mid=xxx
  @GET('/x/space/wbi/acc/info')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<dynamic>> getAccountInfo(@Query('mid') int mid);

  // x/space/wbi/arc/search
  @GET('/x/space/wbi/arc/search')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<UserSpaceVideoListResponse>> getSpaceVideos({
    @Query('mid') required int mid,
    @Query('pn') int page = 1,
    @Query('ps') int pageSize = 30,
    @Query('order') String order = 'pubdate',
    @Query('keyword') String? keyword,
  });

  // x/space/top/arc
  @GET('/x/space/top/arc')
  Future<ApiResponse<UserSpaceVideoModel>> getStickyVideo(@Query('vmid') int vmid);

  // x/space/masterpiece
  @GET('/x/space/masterpiece')
  Future<ApiResponse<List<UserSpaceVideoModel>>> getMasterpiece(@Query('vmid') int vmid);

  // x/relation/stat?vmid=xxx
  @GET('/x/relation/stat')
  Future<ApiResponse<dynamic>> getRelationStat(@Query('vmid') int vmid);

  // x/space/upstat?mid=xxx
  @GET('/x/space/upstat')
  Future<ApiResponse<dynamic>> getUpStat(@Query('mid') int mid);

  // x/space/navnum?mid=xxx
  @GET('/x/space/navnum')
  Future<ApiResponse<dynamic>> getNavNum(@Query('mid') int mid);

  // x/web-interface/card?mid=xxx&photo=true
  @GET('/x/web-interface/card')
  Future<ApiResponse<dynamic>> getCard(
    @Query('mid') int mid, {
    @Query('photo') bool photo = true,
  });

  @GET(ApiConstants.nav)
  Future<ApiResponse<dynamic>> getNav();

  // x/relation/modify
  @POST('/x/relation/modify')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<dynamic>> modifyRelation(
    @Field('fid') int fid,
    @Field('act') int act,
    @Field('re_src') int reSrc,
  );
}
