import 'package:cilixili/core/constants/api_constants.dart';
import 'package:cilixili/data/models/common/api_response.dart';
import 'package:cilixili/data/models/home/feed_response.dart';
import 'package:cilixili/data/models/video/index.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'video_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VideoApi {
  factory VideoApi(Dio dio, {String baseUrl}) = _VideoApi;

  /// Recommended feed videos (formerly in HomeApi)
  @GET(ApiConstants.feedRcmd)
  Future<ApiResponse<FeedResponse>> fetchRecommend(
    @Queries() Map<String, dynamic> queries,
  );

  /// Video details including title, description, owner, etc.
  @GET(ApiConstants.videoView)
  Future<ApiResponse<VideoDetail>> fetchVideoView(@Query('bvid') String bvid);

  /// Video play URL (streaming address)
  @GET(ApiConstants.videoPlayUrl)
  Future<ApiResponse<PlayUrl>> fetchVideoPlayUrl(
    @Queries() Map<String, dynamic> queries,
  );

  /// Related videos recommendation
  @GET(ApiConstants.related)
  Future<ApiResponse<List<RelatedVideo>>> fetchRelatedVideos(
    @Query('bvid') String bvid,
  );

  /// Video comments
  @GET('/x/v2/reply')
  Future<ApiResponse<CommentResponse>> fetchComments(
    @Queries() Map<String, dynamic> queries,
  );

  /// Video comment replies
  @GET('/x/v2/reply/reply')
  Future<ApiResponse<CommentResponse>> fetchReply(
    @Queries() Map<String, dynamic> queries,
  );
}
