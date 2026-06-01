import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'fav_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class FavApi {
  factory FavApi(Dio dio, {String baseUrl}) = _FavApi;

  @GET(ApiConstants.favCreatedList)
  Future<ApiResponse<Object>> getCreatedFolders(
    @Query('up_mid') int upMid, {
    @Query('rid') int? rid,
    @Query('type') int? type,
  });

  @GET(ApiConstants.favCollectedList)
  Future<ApiResponse<Object>> getCollectedFolders(
    @Query('up_mid') int upMid,
    @Query('pn') int pn,
    @Query('ps') int ps,
  );

  @GET(ApiConstants.favResourceList)
  Future<ApiResponse<Object>> getFolderResources(
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
  Future<ApiResponse<FavoriteFolder>> addFolder(
    @Field('title') String title, {
    @Field('intro') String? intro,
    @Field('privacy') int? privacy,
    @Field('cover') String? cover,
    @Field('csrf') String? csrf,
  });

  @POST(ApiConstants.favFolderEdit)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<FavoriteFolder>> editFolder(
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

  @POST(ApiConstants.favResourceDeal)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<dynamic>> dealResource(
    @Field('rid') int rid,
    @Field('type') int type, {
    @Field('add_media_ids') String? addMediaIds,
    @Field('del_media_ids') String? delMediaIds,
    @Field('platform') String platform = 'web',
  });

  @POST(ApiConstants.favResourceBatchDel)
  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> batchDelResource(
    @Field('resources') String resources,
    @Field('media_id') int mediaId, {
    @Field('platform') String platform = 'web',
    @Field('csrf') String? csrf,
  });
}
