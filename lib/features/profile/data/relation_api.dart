import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'relation_api.g.dart';

@RestApi()
abstract class RelationApi {
  factory RelationApi(Dio dio, {String baseUrl}) = _RelationApi;

  @GET('/x/relation/followings')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<RelationResponseData>> getFollowings(
    @Query('vmid') int vmid, {
    @Query('pn') int pn = 1,
    @Query('ps') int ps = 50,
    @Query('order_type') String? orderType,
  });

  @GET('/x/relation/followers')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<RelationResponseData>> getFollowers(
    @Query('vmid') int vmid, {
    @Query('pn') int pn = 1,
    @Query('ps') int ps = 50,
  });

  @POST('/x/relation/modify')
  @Headers({'content-type': 'application/x-www-form-urlencoded', 'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> modifyRelation(
    @Field('fid') int fid,
    @Field('act') int act, {
    @Field('re_src') int reSrc = 11,
  });
}
