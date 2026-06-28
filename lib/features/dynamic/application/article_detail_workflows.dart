import 'package:culcul/core/models/comment_contract.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/models/article_detail_data.dart';

class ArticleDetailCommentWorkflow {
  final DynamicRepositoryImpl _repository;

  const ArticleDetailCommentWorkflow(this._repository);

  Future<
    ({
      bool submitted,
      bool clearComposer,
      bool unfocusComposer,
      bool commentsDisabled,
      String? errorMessage,
    })?
  >
  submitComment({
    required ArticleDetailData? article,
    required bool commentsEnabled,
    required String rawMessage,
  }) async {
    if (article == null) {
      return null;
    }
    if (!commentsEnabled) {
      return _commentsDisabledResult();
    }

    final message = rawMessage.trim();
    if (message.isEmpty) {
      return null;
    }

    final result = await _repository.addArticleCommentReply(
      article: article,
      root: 0,
      parent: 0,
      message: message,
    );
    if (result.errorOrNull case final error?) {
      return _failureResult(error.message);
    }

    return _submittedResult(clearComposer: true, unfocusComposer: true);
  }

  Future<
    ({
      bool submitted,
      bool clearComposer,
      bool unfocusComposer,
      bool commentsDisabled,
      String? errorMessage,
    })?
  >
  submitReply({
    required ArticleDetailData? article,
    required bool commentsEnabled,
    required CommentItem item,
    required String message,
  }) async {
    if (article == null) {
      return null;
    }
    if (!commentsEnabled) {
      return _commentsDisabledResult();
    }

    final result = await _repository.addArticleCommentReply(
      article: article,
      root: item.root == 0 ? item.rpid : item.root,
      parent: item.rpid,
      message: message,
    );
    if (result.errorOrNull case final error?) {
      return _failureResult(error.message);
    }

    return _submittedResult();
  }
}

({
  bool submitted,
  bool clearComposer,
  bool unfocusComposer,
  bool commentsDisabled,
  String? errorMessage,
})
_submittedResult({bool clearComposer = false, bool unfocusComposer = false}) {
  return (
    submitted: true,
    clearComposer: clearComposer,
    unfocusComposer: unfocusComposer,
    commentsDisabled: false,
    errorMessage: null,
  );
}

({
  bool submitted,
  bool clearComposer,
  bool unfocusComposer,
  bool commentsDisabled,
  String? errorMessage,
})
_commentsDisabledResult() {
  return (
    submitted: false,
    clearComposer: false,
    unfocusComposer: false,
    commentsDisabled: true,
    errorMessage: null,
  );
}

({
  bool submitted,
  bool clearComposer,
  bool unfocusComposer,
  bool commentsDisabled,
  String? errorMessage,
})
_failureResult(String message) {
  return (
    submitted: false,
    clearComposer: false,
    unfocusComposer: false,
    commentsDisabled: false,
    errorMessage: message,
  );
}
