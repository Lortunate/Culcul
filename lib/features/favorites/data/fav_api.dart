import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/favorites/models/favorite_models.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'fav_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class FavApi {
  factory FavApi(Dio dio, {String baseUrl}) = _FavApi;

  @GET(ApiConstants.favCreatedList)
  Future<ApiResponse<FavFolderListResponse>> getCreatedFolders(
    @Query('up_mid') int upMid,
  );

  @GET(ApiConstants.favCollectedList)
  Future<ApiResponse<FavFolderListResponse>> getCollectedFolders(
    @Query('up_mid') int upMid,
    @Query('pn') int pn,
    @Query('ps') int ps,
  );

  @GET(ApiConstants.favResourceList)
  Future<ApiResponse<FavResourceListResponse>> getFolderResources(
    @Query('media_id') int mediaId,
    @Query('pn') int pn,
    @Query('ps') int ps, {
    @Query('keyword') String? keyword,
    @Query('order') String? order,
    @Query('type') int? type,
    @Query('tid') int? tid,
    @Query('platform') String platform = 'web',
  });

  @POST(ApiConstants.favFolderAdd)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<FavFolderModel>> addFolder(
    @Field('title') String title, {
    @Field('intro') String? intro,
    @Field('privacy') int? privacy,
    @Field('cover') String? cover,
    @Field('csrf') String? csrf,
  });

  @POST(ApiConstants.favFolderEdit)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<FavFolderModel>> editFolder(
    @Field('media_id') int mediaId,
    @Field('title') String title, {
    @Field('intro') String? intro,
    @Field('privacy') int? privacy,
    @Field('cover') String? cover,
    @Field('csrf') String? csrf,
  });

  @POST(ApiConstants.favFolderDel)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> delFolder(
    @Field('media_ids') String mediaIds, {
    @Field('csrf') String? csrf,
  });

  @POST(ApiConstants.favResourceBatchDel)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> batchDelResource(
    @Field('resources') String resources,
    @Field('media_id') int mediaId, {
    @Field('platform') String platform = 'web',
    @Field('csrf') String? csrf,
  });

  @POST(ApiConstants.favResourceClean)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> cleanInvalidResources(
    @Field('media_id') int mediaId, {
    @Field('csrf') String? csrf,
  });
}
