import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/video_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_comment_workflows.g.dart';

class VideoCommentsQuery {
  final int oid;
  final int sort;
  final int page;

  const VideoCommentsQuery({required this.oid, required this.sort, required this.page});
}

class VideoReplyQuery {
  final int oid;
  final int root;
  final int page;

  const VideoReplyQuery({required this.oid, required this.root, required this.page});
}

class ToggleVideoCommentLikeCommand {
  final int oid;
  final int rpid;
  final bool isLiked;

  const ToggleVideoCommentLikeCommand({
    required this.oid,
    required this.rpid,
    required this.isLiked,
  });
}

class ToggleVideoCommentDislikeCommand {
  final int oid;
  final int rpid;

  const ToggleVideoCommentDislikeCommand({required this.oid, required this.rpid});
}

class AddVideoCommentReplyCommand {
  final int oid;
  final int root;
  final int parent;
  final String message;

  const AddVideoCommentReplyCommand({
    required this.oid,
    required this.root,
    required this.parent,
    required this.message,
  });
}

@riverpod
VideoCommentWorkflows videoCommentWorkflows(Ref ref) {
  return VideoCommentWorkflows(ref.read(videoRepositoryProvider));
}

class VideoCommentWorkflows {
  final VideoRepository _repository;

  const VideoCommentWorkflows(this._repository);

  Future<Result<CommentResponse, AppError>> loadComments(VideoCommentsQuery query) async {
    return runResult(
      () => _repository.fetchComments(
        oid: query.oid,
        sort: query.sort,
        page: query.page,
      ),
    );
  }

  Future<Result<CommentResponse, AppError>> loadReplies(VideoReplyQuery query) async {
    return runResult(
      () => _repository.fetchReply(oid: query.oid, root: query.root, page: query.page),
    );
  }

  Future<Result<void, AppError>> toggleLike(ToggleVideoCommentLikeCommand command) async {
    return runVoidResult(
      () => _repository.setCommentLike(
        oid: command.oid,
        rpid: command.rpid,
        isLiked: command.isLiked,
      ),
    );
  }

  Future<Result<void, AppError>> toggleDislike(
    ToggleVideoCommentDislikeCommand command,
  ) async {
    return runVoidResult(
      () => _repository.setCommentDislike(oid: command.oid, rpid: command.rpid),
    );
  }

  Future<Result<void, AppError>> addReply(AddVideoCommentReplyCommand command) async {
    return runVoidResult(
      () => _repository.replyToComment(
        oid: command.oid,
        root: command.root,
        parent: command.parent,
        message: command.message,
      ),
    );
  }
}
