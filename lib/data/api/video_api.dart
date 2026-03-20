import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/feed/feed_response.dart';
import 'package:culcul/data/models/feed/popular_response.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/video/play_url.dart';
import 'package:culcul/data/models/video/player_info.dart';
import 'package:culcul/data/models/video/related_video.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'video_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VideoApi {
  factory VideoApi(Dio dio, {String baseUrl}) = _VideoApi;

  @GET(ApiConstants.feedRcmd)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<FeedResponse>> fetchRecommend({
    @Query('fresh_type') int freshType = 4,
    @Query('ps') int ps = 20,
    @Query('fresh_idx') int freshIdx = 1,
    @Query('fresh_idx_1h') int freshIdx1h = 1,
    @Query('force_refresh') bool? forceRefresh,
  });

  @GET(ApiConstants.popular)
  Future<ApiResponse<PopularResponse>> fetchPopular({
    @Query('pn') int pn = 1,
    @Query('ps') int ps = 20,
    @Query('force_refresh') bool? forceRefresh,
  });

  @GET(ApiConstants.videoView)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<VideoDetail>> fetchVideoView(@Query('bvid') String bvid);

  @GET(ApiConstants.videoTags)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<List<VideoTag>>> fetchVideoTags(
    @Query('bvid') String bvid,
  );

  @GET(ApiConstants.videoPlayUrl)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<PlayUrl>> fetchVideoPlayUrl(
    @Query('avid') int aid,
    @Query('cid') int cid,
    @Query('qn') int qn,
    @Query('fnval') int fnval,
    @Query('fnver') int fnver,
    @Query('fourk') int fourk,
  );

  @GET(ApiConstants.playerInfo)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<PlayerInfo>> fetchPlayerInfo(
    @Query('aid') int aid,
    @Query('cid') int cid,
  );

  @GET(ApiConstants.related)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<List<RelatedVideo>>> fetchRelatedVideos(
    @Query('bvid') String bvid,
  );

  @GET(ApiConstants.reply)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> fetchComments(
    @Query('oid') int oid,
    @Query('type') int type,
    @Query('sort') int sort,
    @Query('ps') int ps,
    @Query('pn') int pn,
  );

  @GET(ApiConstants.replyReply)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> fetchReply(
    @Query('oid') int oid,
    @Query('root') int root,
    @Query('type') int type,
    @Query('ps') int ps,
    @Query('pn') int pn,
  );

  @POST(ApiConstants.replyAction)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> actionComment(
    @Field('oid') int oid,
    @Field('rpid') int rpid,
    @Field('action') int action,
    @Field('type') int type,
  );

  @POST(ApiConstants.replyHate)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> hateComment(
    @Field('oid') int oid,
    @Field('rpid') int rpid,
    @Field('action') int action,
    @Field('type') int type,
  );

  @POST(ApiConstants.replyAdd)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<CommentItem>> addReply(
    @Field('oid') int oid,
    @Field('root') int root,
    @Field('parent') int parent,
    @Field('message') String message,
    @Field('type') int type,
  );

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
}
