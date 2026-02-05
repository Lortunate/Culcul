import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'fav_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class FavApi {
  factory FavApi(Dio dio, {String baseUrl}) = _FavApi;

  // x/v3/fav/folder/created/list-all
  @GET('/x/v3/fav/folder/created/list-all')
  Future<ApiResponse<FavFolderListResponse>> getCreatedFolders(
    @Query('up_mid') int upMid,
  );

  // x/v3/fav/folder/collected/list
  @GET('/x/v3/fav/folder/collected/list')
  Future<ApiResponse<FavFolderListResponse>> getCollectedFolders(
    @Query('up_mid') int upMid,
    @Query('pn') int pn,
    @Query('ps') int ps,
  );

  // x/v3/fav/resource/list
  @GET('/x/v3/fav/resource/list')
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

  @POST('/x/v3/fav/folder/add')
  @Headers(const {'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<FavFolderModel>> addFolder(
    @Field('title') String title, {
    @Field('intro') String? intro,
    @Field('privacy') int? privacy,
    @Field('cover') String? cover,
    @Field('csrf') String? csrf,
  });

  @POST('/x/v3/fav/folder/edit')
  @Headers(const {'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<FavFolderModel>> editFolder(
    @Field('media_id') int mediaId,
    @Field('title') String title, {
    @Field('intro') String? intro,
    @Field('privacy') int? privacy,
    @Field('cover') String? cover,
    @Field('csrf') String? csrf,
  });

  @POST('/x/v3/fav/folder/del')
  @Headers(const {'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> delFolder(
    @Field('media_ids') String mediaIds, {
    @Field('csrf') String? csrf,
  });

  @POST('/x/v3/fav/resource/batch-del')
  @Headers(const {'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> batchDelResource(
    @Field('resources') String resources,
    @Field('media_id') int mediaId, {
    @Field('platform') String platform = 'web',
    @Field('csrf') String? csrf,
  });

  @POST('/x/v3/fav/resource/clean')
  @Headers(const {'content-type': 'application/x-www-form-urlencoded'})
  Future<ApiResponse<dynamic>> cleanInvalidResources(
    @Field('media_id') int mediaId, {
    @Field('csrf') String? csrf,
  });
}
