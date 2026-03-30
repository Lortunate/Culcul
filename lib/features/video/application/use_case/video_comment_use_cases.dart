import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/domain/entities/video_models.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_comment_use_cases.g.dart';

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
VideoCommentUseCases videoCommentUseCases(Ref ref) {
  return VideoCommentUseCases(ref.read(videoRepositoryProvider));
}

class VideoCommentUseCases {
  final VideoRepository _repository;

  const VideoCommentUseCases(this._repository);

  Future<Result<CommentResponse, AppError>> loadComments(VideoCommentsQuery query) async {
    try {
      return Success(
        await _repository.fetchComments(
          oid: query.oid,
          sort: query.sort,
          page: query.page,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<CommentResponse, AppError>> loadReplies(VideoReplyQuery query) async {
    try {
      return Success(
        await _repository.fetchReply(oid: query.oid, root: query.root, page: query.page),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> toggleLike(ToggleVideoCommentLikeCommand command) async {
    try {
      await _repository.setCommentLike(
        oid: command.oid,
        rpid: command.rpid,
        isLiked: command.isLiked,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> toggleDislike(
    ToggleVideoCommentDislikeCommand command,
  ) async {
    try {
      await _repository.setCommentDislike(oid: command.oid, rpid: command.rpid);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> addReply(AddVideoCommentReplyCommand command) async {
    try {
      await _repository.replyToComment(
        oid: command.oid,
        root: command.root,
        parent: command.parent,
        message: command.message,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
