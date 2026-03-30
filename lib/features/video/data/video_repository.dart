import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/resource_api.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/subtitle.dart';
import 'package:culcul/data/models/video/play_url.dart';
import 'package:culcul/data/models/video/player_info.dart';
import 'package:culcul/data/models/video/related_video.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository.g.dart';

@riverpod
VideoRepository videoRepository(Ref ref) {
  return VideoRepository(
    api: ref.watch(videoApiProvider),
    resourceApi: ref.watch(resourceApiProvider),
  );
}

class VideoRepository extends BaseRepository {
  static const _videoCommentType = 1;
  static const _defaultCommentPageSize = 20;

  final VideoApi api;
  final ResourceApi resourceApi;

  VideoRepository({required this.api, required this.resourceApi});

  Future<void> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  }) {
    return requestVoid(
      () => api.actionComment(oid, rpid, isLiked ? 1 : 0, _videoCommentType),
    );
  }

  Future<void> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  }) {
    return requestVoid(
      () => api.hateComment(oid, rpid, isDisliked ? 1 : 0, _videoCommentType),
    );
  }

  Future<CommentItem> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  }) {
    return requestApi(() => api.addReply(oid, root, parent, message, _videoCommentType));
  }

  Future<VideoDetail> fetchVideoView(String bvid) {
    return requestApi(() => api.fetchVideoView(bvid));
  }

  Future<List<VideoTag>> fetchVideoTags(String bvid) {
    return requestApi(() => api.fetchVideoTags(bvid));
  }

  Future<PlayUrl> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
  }) {
    return requestApi(
      () => api.fetchVideoPlayUrl(aid, cid, quality, fnval, fnver, fourk),
    );
  }

  Future<PlayerInfo> fetchPlayerInfo({required int aid, required int cid}) {
    return requestApi(() => api.fetchPlayerInfo(aid, cid));
  }

  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid) {
    return requestApi(() => api.fetchRelatedVideos(bvid));
  }

  Future<CommentResponse> fetchComments({required int oid, int sort = 1, int page = 1}) {
    return requestApi(
      () =>
          api.fetchComments(oid, _videoCommentType, sort, _defaultCommentPageSize, page),
    );
  }

  Future<CommentResponse> fetchReply({
    required int oid,
    required int root,
    int page = 1,
  }) {
    return requestApi(
      () => api.fetchReply(oid, root, _videoCommentType, _defaultCommentPageSize, page),
    );
  }

  Future<SubtitleContent> fetchSubtitleContent(String url) {
    return request(() async {
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      final response = await resourceApi.fetchJson(fullUrl);
      return SubtitleContent.fromJson(Map<String, dynamic>.from(response as Map));
    });
  }

  Future<void> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  }) {
    return requestVoid(() => api.reportVideoProgress(aid, cid, progress, 'android', 3));
  }
}
