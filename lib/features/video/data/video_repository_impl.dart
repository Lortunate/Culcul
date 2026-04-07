import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/network/resource_api.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart'
    as domain;
import 'package:culcul/features/video/data/video_api.dart';
import 'package:culcul/features/video/domain/entities/video_entities_exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository_impl.g.dart';

@riverpod
domain.VideoRepository videoRepository(Ref ref) {
  return VideoRepositoryImpl(
    api: VideoApi(ref.watch(dioClientProvider)),
    resourceApi: ResourceApi(ref.watch(dioClientProvider)),
  );
}

class VideoRepositoryImpl with RequestExecutorBinding implements domain.VideoRepository {
  static const _videoCommentType = 1;
  static const _defaultCommentPageSize = 20;

  final VideoApi api;
  final ResourceApi resourceApi;
  final RequestExecutor _requestExecutor;

  VideoRepositoryImpl({
    required this.api,
    required this.resourceApi,
    RequestExecutor? requestExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<Result<void, AppError>> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  }) {
    return requestVoidResult(
      () => api.actionComment(oid, rpid, isLiked ? 1 : 0, _videoCommentType),
    );
  }

  @override
  Future<Result<void, AppError>> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  }) {
    return requestVoidResult(
      () => api.hateComment(oid, rpid, isDisliked ? 1 : 0, _videoCommentType),
    );
  }

  @override
  Future<Result<CommentItem, AppError>> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  }) {
    return requestApiResult(
      () => api.addReply(oid, root, parent, message, _videoCommentType),
    );
  }

  @override
  Future<Result<VideoDetail, AppError>> fetchVideoView(String bvid) {
    return requestApiResult(() => api.fetchVideoView(bvid));
  }

  @override
  Future<Result<VideoDimension?, AppError>> fetchVideoEntryDimension(String bvid) {
    return requestApiResult(() => api.fetchVideoPagelist(bvid)).then(
      (result) => result.map((value) {
        if (value.isEmpty) {
          return null;
        }
        return value.first.dimension;
      }),
    );
  }

  @override
  Future<Result<List<VideoTag>, AppError>> fetchVideoTags(String bvid) {
    return requestApiResult(() => api.fetchVideoTags(bvid));
  }

  @override
  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
  }) {
    return requestApiResult(
      () => api.fetchVideoPlayUrl(
        aid,
        cid,
        quality,
        fnval: fnval,
        fnver: fnver,
        fourk: fourk,
      ),
    );
  }

  @override
  Future<Result<PlayerInfo, AppError>> fetchPlayerInfo({
    required int aid,
    required int cid,
  }) {
    return requestApiResult(() => api.fetchPlayerInfo(aid, cid));
  }

  @override
  Future<Result<List<RelatedVideo>, AppError>> fetchRelatedVideos(String bvid) {
    return requestApiResult(() => api.fetchRelatedVideos(bvid));
  }

  @override
  Future<Result<CommentResponse, AppError>> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
  }) {
    return requestApiResult(
      () => api.fetchComments(
        oid,
        _videoCommentType,
        sort.apiValue,
        _defaultCommentPageSize,
        page,
      ),
    );
  }

  @override
  Future<Result<CommentResponse, AppError>> fetchReply({
    required int oid,
    required int root,
    int page = 1,
  }) {
    return requestApiResult(
      () => api.fetchReply(oid, root, _videoCommentType, _defaultCommentPageSize, page),
    );
  }

  @override
  Future<Result<SubtitleContent, AppError>> fetchSubtitleContent(String url) {
    return requestResult(() async {
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      final response = await resourceApi.fetchJson(fullUrl);
      final subtitleContent = SubtitleContent.fromJson(
        Map<String, dynamic>.from(response as Map),
      );
      return subtitleContent;
    });
  }

  @override
  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  }) {
    return requestVoidResult(
      () => api.reportVideoProgress(aid, cid, progress, 'android', 3),
    );
  }
}
