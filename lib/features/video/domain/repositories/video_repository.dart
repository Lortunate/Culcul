import 'package:culcul/features/video/domain/entities/video_entities.dart';

abstract class VideoRepository {
  Future<void> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  });

  Future<void> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  });

  Future<CommentItem> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  });

  Future<VideoDetail> fetchVideoView(String bvid);

  Future<List<VideoTag>> fetchVideoTags(String bvid);

  Future<PlayUrl> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
  });

  Future<PlayerInfo> fetchPlayerInfo({required int aid, required int cid});

  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid);

  Future<CommentResponse> fetchComments({required int oid, int sort = 1, int page = 1});

  Future<CommentResponse> fetchReply({required int oid, required int root, int page = 1});

  Future<SubtitleContent> fetchSubtitleContent(String url);

  Future<void> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  });
}
