import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/resource_api.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart'
    as domain;
import 'package:culcul/features/video/data/video_api.dart';
import 'package:culcul/features/video/models/video_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository.g.dart';

@riverpod
domain.VideoRepository videoRepository(Ref ref) {
  return VideoRepositoryImpl(
    api: ref.watch(videoApiProvider),
    resourceApi: ref.watch(resourceApiProvider),
  );
}

class VideoRepositoryImpl extends BaseRepository implements domain.VideoRepository {
  static const _videoCommentType = 1;
  static const _defaultCommentPageSize = 20;

  final VideoApi api;
  final ResourceApi resourceApi;

  VideoRepositoryImpl({required this.api, required this.resourceApi});

  @override
  Future<void> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  }) {
    return requestVoid(
      () => api.actionComment(oid, rpid, isLiked ? 1 : 0, _videoCommentType),
    );
  }

  @override
  Future<void> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  }) {
    return requestVoid(
      () => api.hateComment(oid, rpid, isDisliked ? 1 : 0, _videoCommentType),
    );
  }

  @override
  Future<CommentItem> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  }) {
    return requestApi(() => api.addReply(oid, root, parent, message, _videoCommentType));
  }

  @override
  Future<VideoDetail> fetchVideoView(String bvid) {
    return requestApi(() => api.fetchVideoView(bvid));
  }

  @override
  Future<List<VideoTag>> fetchVideoTags(String bvid) {
    return requestApi(() => api.fetchVideoTags(bvid));
  }

  @override
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

  @override
  Future<PlayerInfo> fetchPlayerInfo({required int aid, required int cid}) {
    return requestApi(() => api.fetchPlayerInfo(aid, cid));
  }

  @override
  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid) {
    return requestApi(() => api.fetchRelatedVideos(bvid));
  }

  @override
  Future<CommentResponse> fetchComments({required int oid, int sort = 1, int page = 1}) {
    return requestApi(
      () =>
          api.fetchComments(oid, _videoCommentType, sort, _defaultCommentPageSize, page),
    );
  }

  @override
  Future<CommentResponse> fetchReply({
    required int oid,
    required int root,
    int page = 1,
  }) {
    return requestApi(
      () => api.fetchReply(oid, root, _videoCommentType, _defaultCommentPageSize, page),
    );
  }

  @override
  Future<SubtitleContent> fetchSubtitleContent(String url) {
    return request(() async {
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      final response = await resourceApi.fetchJson(fullUrl);
      return SubtitleContent.fromJson(Map<String, dynamic>.from(response as Map));
    });
  }

  @override
  Future<void> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  }) {
    return requestVoid(() => api.reportVideoProgress(aid, cid, progress, 'android', 3));
  }
}
