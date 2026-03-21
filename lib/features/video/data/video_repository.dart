import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
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

  Future<Result<void, AppException>> actionComment({
    required int oid,
    required int rpid,
    required int action, // 1: like, 0: cancel
    int type = 1,
  }) {
    return safeVoidApiCall(() => api.actionComment(oid, rpid, action, type));
  }

  Future<Result<void, AppException>> hateComment({
    required int oid,
    required int rpid,
    required int action, // 1: dislike, 0: cancel
    int type = 1,
  }) {
    return safeVoidApiCall(() => api.hateComment(oid, rpid, action, type));
  }

  Future<Result<CommentItem, AppException>> addReply({
    required int oid,
    required int root,
    required int parent,
    required String message,
    int type = 1,
  }) {
    return safeApiCall(() => api.addReply(oid, root, parent, message, type));
  }

  Future<Result<VideoDetail, AppException>> fetchVideoView(String bvid) {
    return safeApiCall(() => api.fetchVideoView(bvid));
  }

  Future<Result<List<VideoTag>, AppException>> fetchVideoTags(String bvid) {
    return safeApiCall(() => api.fetchVideoTags(bvid));
  }

  Future<Result<PlayUrl, AppException>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int qn = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
  }) {
    return safeApiCall(() => api.fetchVideoPlayUrl(aid, cid, qn, fnval, fnver, fourk));
  }

  Future<Result<PlayerInfo, AppException>> fetchPlayerInfo({
    required int aid,
    required int cid,
  }) {
    return safeApiCall(() => api.fetchPlayerInfo(aid, cid));
  }

  Future<Result<List<RelatedVideo>, AppException>> fetchRelatedVideos(String bvid) {
    return safeApiCall(() => api.fetchRelatedVideos(bvid));
  }

  Future<Result<CommentResponse, AppException>> fetchComments({
    required int oid,
    int type = 1,
    int sort = 1,
    int ps = 20,
    int pn = 1,
  }) {
    return safeApiCall(() => api.fetchComments(oid, type, sort, ps, pn));
  }

  Future<Result<CommentResponse, AppException>> fetchReply({
    required int oid,
    required int root,
    int type = 1,
    int ps = 20,
    int pn = 1,
  }) {
    return safeApiCall(() => api.fetchReply(oid, root, type, ps, pn));
  }

  Future<Result<SubtitleContent, AppException>> fetchSubtitleContent(String url) {
    return safeCall(() async {
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      final response = await resourceApi.fetchJson(fullUrl);
      return SubtitleContent.fromJson(Map<String, dynamic>.from(response as Map));
    });
  }

  Future<Result<void, AppException>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
    String platform = 'android',
    int type = 3,
  }) {
    return safeVoidApiCall(
      () => api.reportVideoProgress(aid, cid, progress, platform, type),
    );
  }
}
