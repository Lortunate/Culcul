import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_publish_command.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_workflows.g.dart';

@riverpod
PublishDynamicWorkflow publishDynamicWorkflow(Ref ref) {
  return PublishDynamicWorkflow(ref.read(dynamicRepositoryProvider));
}

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
  final DynamicRepositoryImpl _repository;

  const ArticleDetailCommentWorkflow(this._repository);

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

    final result = await _repository.addArticleCommentReply(
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

    final result = await _repository.addArticleCommentReply(
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

class PublishDynamicWorkflow {
  final DynamicRepositoryImpl _repository;

  const PublishDynamicWorkflow(this._repository);

  Future<Result<void, AppError>> call({
    required String content,
    required List<PublishMediaAsset> images,
    String? csrf,
  }) async {
    return (await _resolveCsrf(csrf)).when(
      success: (csrfToken) async {
        final uploadedImagesResult = await _repository.uploadImagesWithCsrf(
          files: images,
          csrf: csrfToken,
        );
        return uploadedImagesResult.when(
          success: (images) => _repository.publishDynamic(
            content: content,
            csrf: csrfToken,
            images: images,
          ),
          failure: (error) async => Failure(error),
        );
      },
      failure: (error) async => Failure(error),
    );
  }

  Future<Result<String, AppError>> _resolveCsrf(String? injectedCsrf) async {
    if (injectedCsrf != null && injectedCsrf.isNotEmpty) {
      return Success(injectedCsrf);
    }
    final csrfResult = await _repository.getPublishCsrf();
    final csrf = csrfResult.dataOrNull;
    if (csrf == null || csrf.isEmpty) {
      return Failure(csrfResult.errorOrNull ?? const AppError.auth('Missing csrf token'));
    }
    return Success(csrf);
  }
}
