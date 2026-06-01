import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/live/application/models/live_danmu_info_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_play_url_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/features/live/data/live_paging_constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'live_api.g.dart';

const int _liveDanmakuDefaultColor = 0xffffff;
const int _liveDanmakuDefaultFontSize = 25;
const int _liveDanmakuDefaultMode = 1;
const int _liveDanmakuDefaultBubble = 0;

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
  Future<ApiResponse<Object>> getRecommendList({
    @Query('platform') String platform = 'web',
    @Query('web_location') String? webLocation,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = liveRecommendPageSize,
  });

  @GET('/live_user/v1/Master/info')
  Future<ApiResponse<Object>> getAnchorInfo(@Query('uid') int uid);

  @GET('/xlive/general-interface/v1/rank/getOnlineGoldRank')
  Future<ApiResponse<LiveGoldRankModel>> getOnlineGoldRank({
    @Query('ruid') required int ruid,
    @Query('roomId') required int roomId,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = liveGoldRankPageSize,
  });

  @GET('/xlive/app-room/v2/guardTab/topListNew')
  Future<ApiResponse<LiveGuardListModel>> getGuardList({
    @Query('ruid') required int ruid,
    @Query('roomid') required int roomId,
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = liveGuardListPageSize,
  });

  @POST('/msg/send')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> sendDanmaku({
    @Field('msg') required String msg,
    @Field('roomid') required int roomId,
    @Field('rnd') required int rnd,
    @Field('color') int color = _liveDanmakuDefaultColor,
    @Field('fontsize') int fontsize = _liveDanmakuDefaultFontSize,
    @Field('mode') int mode = _liveDanmakuDefaultMode,
    @Field('bubble') int bubble = _liveDanmakuDefaultBubble,
  });
}
