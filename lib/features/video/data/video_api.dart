import 'package:culcul/shared/constants/api_constants.dart';
import 'package:culcul/shared/contracts/comment_contract.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/features/video/data/dtos/video_dtos.dart';
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

  @GET(ApiConstants.reply)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> fetchComments(
    @Query('oid') int oid,
    @Query('type') int type,
    @Query('sort') int sort,
    @Query('ps') int ps,
    @Query('pn') int pn, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ApiConstants.replyReply)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> fetchReply(
    @Query('oid') int oid,
    @Query('root') int root,
    @Query('type') int type,
    @Query('ps') int ps,
    @Query('pn') int pn, {
    @CancelRequest() CancelToken? cancelToken,
  });

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
