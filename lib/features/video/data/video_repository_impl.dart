import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dtos/comment_contract_dto.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/network/resource_api.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/data/dtos/subtitle_dto.dart' as subtitle_dto;
import 'package:culcul/features/video/data/video_mapper.dart';
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
    return requestResult(() async {
      final dto = await requestApi(
        () => api.addReply(oid, root, parent, message, _videoCommentType),
      );
      return dto.toContract();
    });
  }

  @override
  Future<VideoDetail> fetchVideoView(String bvid) {
    return requestApi(() => api.fetchVideoView(bvid)).then((value) => value.toDomain());
  }

  @override
  Future<List<VideoTag>> fetchVideoTags(String bvid) {
    return requestApi(
      () => api.fetchVideoTags(bvid),
    ).then((value) => value.map((item) => item.toDomain()).toList());
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
      () => api.fetchVideoPlayUrl(
        aid,
        cid,
        quality,
        fnval: fnval,
        fnver: fnver,
        fourk: fourk,
      ),
    ).then((value) => value.toDomain());
  }

  @override
  Future<PlayerInfo> fetchPlayerInfo({required int aid, required int cid}) {
    return requestApi(
      () => api.fetchPlayerInfo(aid, cid),
    ).then((value) => value.toDomain());
  }

  @override
  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid) {
    return requestApi(
      () => api.fetchRelatedVideos(bvid),
    ).then((value) => value.map((item) => item.toDomain()).toList());
  }

  @override
  Future<CommentResponse> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
  }) {
    return requestApi(
      () => api.fetchComments(
        oid,
        _videoCommentType,
        sort.apiValue,
        _defaultCommentPageSize,
        page,
      ),
    ).then((value) => value.toContract());
  }

  @override
  Future<CommentResponse> fetchReply({
    required int oid,
    required int root,
    int page = 1,
  }) {
    return requestApi(
      () => api.fetchReply(oid, root, _videoCommentType, _defaultCommentPageSize, page),
    ).then((value) => value.toContract());
  }

  @override
  Future<SubtitleContent> fetchSubtitleContent(String url) {
    return request(() async {
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      final response = await resourceApi.fetchJson(fullUrl);
      final dto = subtitle_dto.SubtitleContent.fromJson(
        Map<String, dynamic>.from(response as Map),
      );
      return dto.toDomain();
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
