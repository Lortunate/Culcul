import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/feed_response.dart';
import 'package:culcul/data/models/popular_response.dart';
import 'package:culcul/data/models/index.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'video_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VideoApi {
  factory VideoApi(Dio dio, {String baseUrl}) = _VideoApi;

  @GET(ApiConstants.feedRcmd)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<FeedResponse>> fetchRecommend(
    @Queries() Map<String, dynamic> queries,
  );

  @GET(ApiConstants.popular)
  Future<ApiResponse<PopularResponse>> fetchPopular(
    @Queries() Map<String, dynamic> queries,
  );

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
    @Queries() Map<String, dynamic> queries,
  );

  @GET(ApiConstants.related)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<List<RelatedVideo>>> fetchRelatedVideos(
    @Query('bvid') String bvid,
  );

  @GET('/x/v2/reply')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> fetchComments(
    @Queries() Map<String, dynamic> queries,
  );

  @GET('/x/v2/reply/reply')
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<CommentResponse>> fetchReply(
    @Queries() Map<String, dynamic> queries,
  );

  @POST('/x/v2/reply/action')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> actionComment(
    @Field('oid') int oid,
    @Field('rpid') int rpid,
    @Field('action') int action,
    @Field('type') int type,
  );

  @POST('/x/v2/reply/hate')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> hateComment(
    @Field('oid') int oid,
    @Field('rpid') int rpid,
    @Field('action') int action,
    @Field('type') int type,
  );

  @POST('/x/v2/reply/add')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<CommentItem>> addReply(
    @Field('oid') int oid,
    @Field('root') int root,
    @Field('parent') int parent,
    @Field('message') String message,
    @Field('type') int type,
  );
}
