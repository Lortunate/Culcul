import 'dart:io';

import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/data/dtos/dynamic_publish_response_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'dynamic_api.g.dart';

@RestApi()
abstract class DynamicApi {
  factory DynamicApi(Dio dio, {String baseUrl}) = _DynamicApi;

  @GET('/x/polymer/web-dynamic/v1/feed/all')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<DynamicData>> getDynamicFeed({
    @Query('type') String? type,
    @Query('offset') String? offset,
    @Query('timezone_offset') int timezoneOffset = -480,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
    @Query('platform') String platform = 'web',
    @Query('web_location') String webLocation = '333.1365',
    @Query('page') int page = 1,
  });

  @GET('/x/polymer/web-dynamic/v1/feed/space')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<DynamicData>> getSpaceDynamicFeed({
    @Query('host_mid') required int hostMid,
    @Query('offset') String? offset,
    @Query('timezone_offset') int timezoneOffset = -480,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
    @Query('force_refresh') bool? forceRefresh,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('/x/polymer/web-dynamic/v1/feed/topic')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<DynamicData>> getTopicFeed({
    @Query('topic_id') required int topicId,
    @Query('offset') String? offset,
    @Query('sort_by') int sortBy = 0,
    @Query('page_size') int pageSize = 20,
    @Query('timezone_offset') int timezoneOffset = -480,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
  });

  @GET('/x/v2/reply/wbi/main')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> getArticleComments({
    @Query('oid') required String oid,
    @Query('type') int type = 12,
    @Query('mode') int mode = 3,
    @Query('next') int? next,
    @Query('plat') int plat = 1,
    @Query('web_location') String webLocation = '1315875',
    @Header('Referer') String? referer,
    @Header('Origin') String? origin,
  });

  @GET('/x/polymer/web-dynamic/v1/detail')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<DynamicDetailData>> getDynamicDetail({
    @Query('id') required String id,
    @Query('features')
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete,onlyfansQaCard,commentsNewVersion',
    @Query('timezone_offset') int timezoneOffset = -480,
  });

  @POST('/x/dynamic/feed/dyn/thumb')
  Future<ApiResponse<void>> likeDynamic({
    @Body() required Map<String, dynamic> body,
    @Query('csrf') required String csrf,
  });

  @POST('/x/dynamic/feed/create/dyn')
  Future<ApiResponse<DynamicPublishResponseDto>> createDynamic({
    @Query('csrf') required String csrf,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/x/dynamic/feed/draw/upload_bfs')
  @MultiPart()
  Future<ApiResponse<DynamicUploadImageResponseDto>> uploadImage({
    @Part(name: 'file_up') required File file,
    @Part(name: 'category') String category = 'daily',
    @Part(name: 'csrf') required String csrf,
  });
}
