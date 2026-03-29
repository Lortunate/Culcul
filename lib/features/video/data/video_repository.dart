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
  final VideoApi api;
  final ResourceApi resourceApi;

  VideoRepository({required this.api, required this.resourceApi});

  Future<void> actionComment({
    required int oid,
    required int rpid,
    required int action, // 1: like, 0: cancel
    int type = 1,
  }) {
    return requestVoid(() => api.actionComment(oid, rpid, action, type));
  }

  Future<void> hateComment({
    required int oid,
    required int rpid,
    required int action, // 1: dislike, 0: cancel
    int type = 1,
  }) {
    return requestVoid(() => api.hateComment(oid, rpid, action, type));
  }

  Future<CommentItem> addReply({
    required int oid,
    required int root,
    required int parent,
    required String message,
    int type = 1,
  }) {
    return requestApi(() => api.addReply(oid, root, parent, message, type));
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
    int qn = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
  }) {
    return requestApi(() => api.fetchVideoPlayUrl(aid, cid, qn, fnval, fnver, fourk));
  }

  Future<PlayerInfo> fetchPlayerInfo({required int aid, required int cid}) {
    return requestApi(() => api.fetchPlayerInfo(aid, cid));
  }

  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid) {
    return requestApi(() => api.fetchRelatedVideos(bvid));
  }

  Future<CommentResponse> fetchComments({
    required int oid,
    int type = 1,
    int sort = 1,
    int ps = 20,
    int pn = 1,
  }) {
    return requestApi(() => api.fetchComments(oid, type, sort, ps, pn));
  }

  Future<CommentResponse> fetchReply({
    required int oid,
    required int root,
    int type = 1,
    int ps = 20,
    int pn = 1,
  }) {
    return requestApi(() => api.fetchReply(oid, root, type, ps, pn));
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
    String platform = 'android',
    int type = 3,
  }) {
    return requestVoid(() => api.reportVideoProgress(aid, cid, progress, platform, type));
  }
}
