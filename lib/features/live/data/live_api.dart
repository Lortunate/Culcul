import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/live/data/dtos/live_dtos.dart';
import 'package:culcul/features/live/data/dtos/live_history_danmaku_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'live_api.g.dart';

@RestApi(baseUrl: ApiConstants.liveBaseUrl)
abstract class LiveApi {
  factory LiveApi(Dio dio, {String baseUrl}) = _LiveApi;

  @GET('/room/v1/Room/get_info')
  Future<ApiResponse<LiveRoomDetailModel>> getRoomInfo(@Query('room_id') int roomId);

  @GET('/room/v1/Room/playUrl')
  Future<ApiResponse<LivePlayUrlModel>> getPlayUrl({
    @Query('cid') required int roomId,
    @Query('qn') int? qn,
    @Query('platform') String? platform,
  });

  @GET('/xlive/web-room/v1/dM/GetDMConfigByGroup')
  Future<ApiResponse<LiveDanmakuConfigModel>> getDanmakuConfig(
    @Query('room_id') int roomId,
  );

  @GET('/xlive/web-room/v1/dM/gethistory')
  Future<ApiResponse<LiveHistoryDanmakuModel>> getHistoryDanmaku(
    @Query('roomid') int roomId,
  );

  @GET('/xlive/web-room/v1/index/getDanmuInfo')
  Future<ApiResponse<LiveDanmuInfoModel>> getDanmuInfo(
    @Query('id') int roomId,
    @Query('type') int type,
  );

  @GET('/xlive/web-interface/v1/webMain/getMoreRecList')
  Future<ApiResponse<LiveRecommendResponse>> getRecommendList({
    @Query('platform') String platform = 'web',
    @Query('web_location') String? webLocation,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 30,
  });

  @GET('/live_user/v1/Master/info')
  Future<ApiResponse<LiveAnchorInfoModel>> getAnchorInfo(@Query('uid') int uid);

  @GET('/xlive/general-interface/v1/rank/getOnlineGoldRank')
  Future<ApiResponse<LiveGoldRankModel>> getOnlineGoldRank({
    @Query('ruid') required int ruid,
    @Query('roomId') required int roomId,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET('/xlive/app-room/v2/guardTab/topListNew')
  Future<ApiResponse<LiveGuardListModel>> getGuardList({
    @Query('ruid') required int ruid,
    @Query('roomid') required int roomId,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
  });

  @POST('/msg/send')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> sendDanmaku({
    @Field('msg') required String msg,
    @Field('roomid') required int roomId,
    @Field('rnd') required int rnd,
    @Field('color') int color = 16777215,
    @Field('fontsize') int fontsize = 25,
    @Field('mode') int mode = 1,
    @Field('bubble') int bubble = 0,
  });
}
