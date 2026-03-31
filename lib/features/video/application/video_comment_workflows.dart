import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/video_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_comment_workflows.g.dart';

@riverpod
VideoCommentWorkflows videoCommentWorkflows(Ref ref) {
  return VideoCommentWorkflows(ref.read(videoRepositoryProvider));
}

class VideoCommentWorkflows {
  final VideoRepository _repository;

  const VideoCommentWorkflows(this._repository);

  Future<Result<CommentResponse, AppError>> loadComments({
    required int oid,
    required int sort,
    required int page,
  }) async {
    return runResult(() => _repository.fetchComments(oid: oid, sort: sort, page: page));
  }

  Future<Result<CommentResponse, AppError>> loadReplies({
    required int oid,
    required int root,
    required int page,
  }) async {
    return runResult(() => _repository.fetchReply(oid: oid, root: root, page: page));
  }

  Future<Result<void, AppError>> toggleLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  }) async {
    return runVoidResult(
      () => _repository.setCommentLike(oid: oid, rpid: rpid, isLiked: isLiked),
    );
  }

  Future<Result<void, AppError>> toggleDislike({
    required int oid,
    required int rpid,
  }) async {
    return runVoidResult(() => _repository.setCommentDislike(oid: oid, rpid: rpid));
  }

  Future<Result<void, AppError>> addReply({
    required int oid,
    required int root,
    required int parent,
    required String message,
  }) async {
    return runVoidResult(
      () => _repository.replyToComment(
        oid: oid,
        root: root,
        parent: parent,
        message: message,
      ),
    );
  }
}
