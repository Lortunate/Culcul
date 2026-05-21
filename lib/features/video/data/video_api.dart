import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/video/application/models/play_url.dart';
import 'package:culcul/features/video/data/dtos/player_info_dto.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'video_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VideoApi {
  factory VideoApi(Dio dio, {String baseUrl}) = _VideoApi;

  @GET(ApiConstants.videoView)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<VideoDetail>> fetchVideoView(
    @Query('bvid') String bvid, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ApiConstants.videoPagelist)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<List<VideoPage>>> fetchVideoPagelist(@Query('bvid') String bvid);

  @GET(ApiConstants.videoTags)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<List<VideoTag>>> fetchVideoTags(
    @Query('bvid') String bvid, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ApiConstants.videoPlayUrl)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<PlayUrl>> fetchVideoPlayUrl(
    @Query('avid') int aid,
    @Query('cid') int cid,
    @Query('qn') int qn, {
    @Query('fnval') int fnval = 1,
    @Query('fnver') int fnver = 0,
    @Query('fourk') int fourk = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ApiConstants.playerInfo)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<PlayerInfo>> fetchPlayerInfo(
    @Query('aid') int aid,
    @Query('cid') int cid,
  );

  @GET(ApiConstants.related)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<List<RelatedVideo>>> fetchRelatedVideos(
    @Query('bvid') String bvid, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(ApiConstants.historyReport)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> reportVideoProgress(
    @Field('aid') int aid,
    @Field('cid') int cid,
    @Field('progress') int progress,
    @Field('platform') String platform,
    @Field('type') int type,
  );

  @POST('/x/web-interface/archive/like')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> setVideoLike(@Field('aid') int aid, @Field('like') int like);

  @POST('/x/web-interface/coin/add')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> addVideoCoin(
    @Field('aid') int aid,
    @Field('multiply') int multiply, {
    @Field('select_like') int selectLike = 0,
  });
}
