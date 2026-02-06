import 'dart:io';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/comment_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'dynamic_api.g.dart';

@RestApi()
abstract class DynamicApi {
  factory DynamicApi(Dio dio, {String baseUrl}) = _DynamicApi;

  @GET('/x/polymer/web-dynamic/v1/feed/all')
  @Headers({'x-bili-wbi': 'true'})
  Future<DynamicResponse> getDynamicFeed({
    @Query('type') String type = 'all',
    @Query('offset') String? offset,
    @Query('timezone_offset') int timezoneOffset = -480,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
    @Query('page') int page = 1,
  });

  @GET('/x/polymer/web-dynamic/v1/feed/space')
  @Headers({'x-bili-wbi': 'true'})
  Future<DynamicResponse> getSpaceDynamicFeed({
    @Query('host_mid') required int hostMid,
    @Query('offset') String? offset,
    @Query('timezone_offset') int timezoneOffset = -480,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
  });

  @GET('/x/polymer/web-dynamic/v1/feed/topic')
  @Headers({'x-bili-wbi': 'true'})
  Future<DynamicResponse> getTopicFeed({
    @Query('topic_id') required int topicId,
    @Query('offset') String? offset,
    @Query('sort_by') int sortBy = 0,
    @Query('page_size') int pageSize = 20,
    @Query('timezone_offset') int timezoneOffset = -480,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
  });

  @GET('/x/v2/reply')
  Future<ApiResponse<CommentResponse>> getComments(
    @Queries() Map<String, dynamic> queries,
  );

  @POST('/x/v2/reply/add')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<CommentItem>> addReply({
    @Field('oid') required int oid,
    @Field('root') required int root,
    @Field('parent') required int parent,
    @Field('message') required String message,
    @Field('type') required int type,
  });

  @POST('/x/v2/reply/action')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> actionComment({
    @Field('oid') required int oid,
    @Field('rpid') required int rpid,
    @Field('action') required int action,
    @Field('type') required int type,
  });

  @GET('/x/polymer/web-dynamic/v1/detail')
  @Headers({'x-bili-wbi': 'true'})
  Future<DynamicDetailResponse> getDynamicDetail({
    @Query('id') required String id,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete,onlyfansQaCard,commentsNewVersion',
    @Query('timezone_offset') int timezoneOffset = -480,
  });

  @POST('/x/dynamic/feed/dyn/thumb')
  Future<void> likeDynamic({
    @Body() required Map<String, dynamic> body,
    @Query('csrf') required String csrf,
  });

  @POST('/x/dynamic/feed/create/dyn')
  Future<DynamicPublishResponse> createDynamic({
    @Query('csrf') required String csrf,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/x/dynamic/feed/draw/upload_bfs')
  @MultiPart()
  Future<DynamicUploadImageResponse> uploadImage({
    @Part(name: 'file_up') required File file,
    @Part(name: 'category') String category = 'daily',
    @Part(name: 'csrf') required String csrf,
  });
}
