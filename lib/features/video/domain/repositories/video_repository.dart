import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';

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

  Future<VideoDetail> fetchVideoView(String bvid);
  Future<VideoDimension?> fetchVideoEntryDimension(String bvid);

  Future<List<VideoTag>> fetchVideoTags(String bvid);

  Future<PlayUrl> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
  });

  Future<PlayerInfo> fetchPlayerInfo({required int aid, required int cid});

  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid);

  Future<CommentResponse> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
  });

  Future<CommentResponse> fetchReply({required int oid, required int root, int page = 1});

  Future<SubtitleContent> fetchSubtitleContent(String url);

  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  });
}
