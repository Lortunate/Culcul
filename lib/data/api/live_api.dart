import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'live_api.g.dart';

@RestApi(baseUrl: ApiConstants.liveBaseUrl)
abstract class LiveApi {
  factory LiveApi(Dio dio, {String baseUrl}) = _LiveApi;

  /// Get live room detail
  /// https://api.live.bilibili.com/room/v1/Room/get_info
  @GET('/room/v1/Room/get_info')
  Future<ApiResponse<LiveRoomDetailModel>> getRoomInfo(
    @Query('room_id') int roomId,
  );

  /// Get live stream url
  /// https://api.live.bilibili.com/room/v1/Room/playUrl
  @GET('/room/v1/Room/playUrl')
  Future<ApiResponse<LivePlayUrlModel>> getPlayUrl({
    @Query('cid') required int roomId,
    @Query('qn') int? qn,
    @Query('platform') String? platform,
  });

  /// Get danmaku config
  /// https://api.live.bilibili.com/xlive/web-room/v1/dM/GetDMConfigByGroup
  @GET('/xlive/web-room/v1/dM/GetDMConfigByGroup')
  Future<ApiResponse<LiveDanmakuConfigModel>> getDanmakuConfig(
    @Query('room_id') int roomId,
  );

  /// Get history danmaku
  /// https://api.live.bilibili.com/xlive/web-room/v1/dM/gethistory
  @GET('/xlive/web-room/v1/dM/gethistory')
  Future<ApiResponse<LiveHistoryDanmakuModel>> getHistoryDanmaku(
    @Query('roomid') int roomId,
  );

  /// Get danmu info (for websocket)
  /// https://api.live.bilibili.com/xlive/web-room/v1/index/getDanmuInfo
  @GET('/xlive/web-room/v1/index/getDanmuInfo')
  Future<ApiResponse<LiveDanmuInfoModel>> getDanmuInfo(
    @Query('id') int roomId,
    @Query('type') int type,
  );

  /// Get recommend live list
  /// https://api.live.bilibili.com/xlive/web-interface/v1/webMain/getMoreRecList
  @GET('/xlive/web-interface/v1/webMain/getMoreRecList')
  Future<ApiResponse<LiveRecommendResponse>> getRecommendList({
    @Query('platform') String platform = 'web',
    @Query('web_location') String? webLocation,
  });
}
