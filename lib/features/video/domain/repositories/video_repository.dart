import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:culcul/features/video/data/dtos/player_info_dto.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart';
import 'package:culcul/features/video/data/dtos/subtitle_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';

abstract class VideoRepository {
  Future<Result<void, AppError>> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  });

  Future<Result<void, AppError>> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  });

  Future<Result<CommentItem, AppError>> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  });

  Future<Result<VideoDetail, AppError>> fetchVideoView(
    String bvid, {
    RequestCancelToken? cancelToken,
  });
  Future<Result<VideoDimension?, AppError>> fetchVideoEntryDimension(String bvid);

  Future<Result<List<VideoTag>, AppError>> fetchVideoTags(
    String bvid, {
    RequestCancelToken? cancelToken,
  });

  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
    RequestCancelToken? cancelToken,
  });

  Future<Result<PlayerInfo, AppError>> fetchPlayerInfo({
    required int aid,
    required int cid,
  });

  Future<Result<List<RelatedVideo>, AppError>> fetchRelatedVideos(
    String bvid, {
    RequestCancelToken? cancelToken,
  });

  Future<Result<CommentResponse, AppError>> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
    RequestCancelToken? cancelToken,
  });

  Future<Result<CommentResponse, AppError>> fetchReply({
    required int oid,
    required int root,
    int page = 1,
    RequestCancelToken? cancelToken,
  });

  Future<Result<SubtitleContent, AppError>> fetchSubtitleContent(String url);

  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  });
}
