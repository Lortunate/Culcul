import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/data/network/resource_api_provider.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/services/comment_service.dart';
import 'package:culcul/features/video/data/video_api.dart';
import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:culcul/features/video/data/dtos/player_info_dto.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart';
import 'package:culcul/features/video/data/dtos/subtitle_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository_impl.g.dart';

@riverpod
VideoRepositoryImpl videoRepository(Ref ref) {
  return VideoRepositoryImpl(
    api: VideoApi(ref.watch(dioClientProvider)),
    commentService: ref.watch(commentServiceProvider),
    resourceApi: ref.watch(resourceApiProvider),
  );
}

class VideoRepositoryImpl {
  static const _videoCommentType = 1;

  final VideoApi api;
  final CommentService commentService;
  final ResourceApi resourceApi;
  final RequestExecutor _requestExecutor;

  VideoRepositoryImpl({
    required this.api,
    required this.commentService,
    required this.resourceApi,
    RequestExecutor? requestExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<void, AppError>> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  }) {
    return _requestExecutor.runUnit(
      () => commentService.actionComment(
        oid: oid.toString(),
        rpid: rpid,
        action: isLiked ? 1 : 0,
        type: _videoCommentType,
      ),
    );
  }

  Future<Result<void, AppError>> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  }) {
    return _requestExecutor.runUnit(
      () => commentService.hateComment(
        oid: oid.toString(),
        rpid: rpid,
        action: isDisliked ? 1 : 0,
        type: _videoCommentType,
      ),
    );
  }

  Future<Result<CommentItem, AppError>> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  }) {
    return _requestExecutor.runApiDirect(
      () => commentService.addReply(
        oid: oid.toString(),
        root: root,
        parent: parent,
        message: message,
        type: _videoCommentType,
      ),
    );
  }

  Future<Result<VideoDetail, AppError>> fetchVideoView(
    String bvid, {
    CancelToken? cancelToken,
  }) {
    return _requestExecutor.runApiDirect(
      () => api.fetchVideoView(bvid, cancelToken: cancelToken),
    );
  }

  Future<Result<VideoDimension?, AppError>> fetchVideoEntryDimension(String bvid) {
    return _requestExecutor
        .runApiDirect(() => api.fetchVideoPagelist(bvid))
        .then(
          (result) => result.map((value) {
            if (value.isEmpty) {
              return null;
            }
            return value.first.dimension;
          }),
        );
  }

  Future<Result<List<VideoTag>, AppError>> fetchVideoTags(
    String bvid, {
    CancelToken? cancelToken,
  }) {
    return _requestExecutor.runApiDirect(
      () => api.fetchVideoTags(bvid, cancelToken: cancelToken),
    );
  }

  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
    CancelToken? cancelToken,
  }) {
    return _requestExecutor.runApiDirect(
      () => api.fetchVideoPlayUrl(
        aid,
        cid,
        quality,
        fnval: fnval,
        fnver: fnver,
        fourk: fourk,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Result<PlayerInfo, AppError>> fetchPlayerInfo({
    required int aid,
    required int cid,
  }) {
    return _requestExecutor.runApiDirect(() => api.fetchPlayerInfo(aid, cid));
  }

  Future<Result<List<RelatedVideo>, AppError>> fetchRelatedVideos(
    String bvid, {
    CancelToken? cancelToken,
  }) {
    return _requestExecutor.runApiDirect(
      () => api.fetchRelatedVideos(bvid, cancelToken: cancelToken),
    );
  }

  Future<Result<CommentResponse, AppError>> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
    CancelToken? cancelToken,
  }) {
    return _requestExecutor.runApiDirect(
      () => commentService.fetchComments(
        oid: oid.toString(),
        type: _videoCommentType,
        sort: sort,
        page: page,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Result<CommentResponse, AppError>> fetchReply({
    required int oid,
    required int root,
    int page = 1,
    CancelToken? cancelToken,
  }) {
    return _requestExecutor.runApiDirect(
      () => commentService.fetchReply(
        oid: oid.toString(),
        root: root,
        type: _videoCommentType,
        page: page,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Result<SubtitleContent, AppError>> fetchSubtitleContent(String url) {
    return _requestExecutor.run(() async {
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      final response = await resourceApi.fetchJson(fullUrl);
      final subtitleContent = SubtitleContent.fromJson(
        Map<String, dynamic>.from(response as Map),
      );
      return subtitleContent;
    });
  }

  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  }) {
    return _requestExecutor.runUnit(
      () => api.reportVideoProgress(aid, cid, progress, 'android', 3),
    );
  }
}
