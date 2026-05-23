import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/dynamic/application/article_detail_port.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';

class ArticleDetailCommentActionResult {
  final bool submitted;
  final bool clearComposer;
  final bool unfocusComposer;
  final bool commentsDisabled;
  final String? errorMessage;

  const ArticleDetailCommentActionResult._({
    required this.submitted,
    required this.clearComposer,
    required this.unfocusComposer,
    required this.commentsDisabled,
    required this.errorMessage,
  });

  const ArticleDetailCommentActionResult.submitted({
    bool clearComposer = false,
    bool unfocusComposer = false,
  }) : this._(
         submitted: true,
         clearComposer: clearComposer,
         unfocusComposer: unfocusComposer,
         commentsDisabled: false,
         errorMessage: null,
       );

  const ArticleDetailCommentActionResult.commentsDisabled()
    : this._(
        submitted: false,
        clearComposer: false,
        unfocusComposer: false,
        commentsDisabled: true,
        errorMessage: null,
      );

  const ArticleDetailCommentActionResult.failure(String message)
    : this._(
        submitted: false,
        clearComposer: false,
        unfocusComposer: false,
        commentsDisabled: false,
        errorMessage: message,
      );
}

class ArticleDetailCommentWorkflow {
  final ArticleDetailPort _port;

  const ArticleDetailCommentWorkflow(this._port);

  Future<ArticleDetailCommentActionResult?> submitComment({
    required ArticleDetailData? article,
    required bool commentsEnabled,
    required String rawMessage,
  }) async {
    if (article == null) {
      return null;
    }
    if (!commentsEnabled) {
      return const ArticleDetailCommentActionResult.commentsDisabled();
    }

    final message = rawMessage.trim();
    if (message.isEmpty) {
      return null;
    }

    final result = await _port.addArticleCommentReply(
      article: article,
      root: 0,
      parent: 0,
      message: message,
    );
    if (result.errorOrNull case final error?) {
      return ArticleDetailCommentActionResult.failure(error.message);
    }

    return const ArticleDetailCommentActionResult.submitted(
      clearComposer: true,
      unfocusComposer: true,
    );
  }

  Future<ArticleDetailCommentActionResult?> submitReply({
    required ArticleDetailData? article,
    required bool commentsEnabled,
    required CommentItem item,
    required String message,
  }) async {
    if (article == null) {
      return null;
    }
    if (!commentsEnabled) {
      return const ArticleDetailCommentActionResult.commentsDisabled();
    }

    final result = await _port.addArticleCommentReply(
      article: article,
      root: item.root == 0 ? item.rpid : item.root,
      parent: item.rpid,
      message: message,
    );
    if (result.errorOrNull case final error?) {
      return ArticleDetailCommentActionResult.failure(error.message);
    }

    return const ArticleDetailCommentActionResult.submitted();
  }
}
