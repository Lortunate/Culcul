import 'dart:async';
import 'dart:math' as math;

import 'package:culcul/core/models/comment_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/dynamic/application/article_detail_workflows.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/models/article_detail_data.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_detail_view_model.g.dart';

final class ArticleDetailUiState {
  const ArticleDetailUiState({
    this.detail,
    this.isLoading = true,
    this.error,
    this.comments = const [],
    this.commentsLoading = false,
    this.commentsError,
    this.commentsNext,
    this.commentsHasMore = true,
    this.isSendingComment = false,
  });

  static const Object _unset = Object();

  final ArticleDetailData? detail;
  final bool isLoading;
  final AppError? error;
  final List<CommentItem> comments;
  final bool commentsLoading;
  final String? commentsError;
  final int? commentsNext;
  final bool commentsHasMore;
  final bool isSendingComment;

  bool get commentsEnabled => (detail?.commentOid ?? '').isNotEmpty;

  ArticleDetailUiState copyWith({
    Object? detail = _unset,
    bool? isLoading,
    Object? error = _unset,
    List<CommentItem>? comments,
    bool? commentsLoading,
    Object? commentsError = _unset,
    Object? commentsNext = _unset,
    bool? commentsHasMore,
    bool? isSendingComment,
  }) {
    return ArticleDetailUiState(
      detail: identical(detail, _unset) ? this.detail : detail as ArticleDetailData?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _unset) ? this.error : error as AppError?,
      comments: comments ?? this.comments,
      commentsLoading: commentsLoading ?? this.commentsLoading,
      commentsError: identical(commentsError, _unset)
          ? this.commentsError
          : commentsError as String?,
      commentsNext: identical(commentsNext, _unset)
          ? this.commentsNext
          : commentsNext as int?,
      commentsHasMore: commentsHasMore ?? this.commentsHasMore,
      isSendingComment: isSendingComment ?? this.isSendingComment,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleDetailUiState &&
            other.detail == detail &&
            other.isLoading == isLoading &&
            other.error == error &&
            listEquals(other.comments, comments) &&
            other.commentsLoading == commentsLoading &&
            other.commentsError == commentsError &&
            other.commentsNext == commentsNext &&
            other.commentsHasMore == commentsHasMore &&
            other.isSendingComment == isSendingComment;
  }

  @override
  int get hashCode => Object.hash(
    detail,
    isLoading,
    error,
    Object.hashAll(comments),
    commentsLoading,
    commentsError,
    commentsNext,
    commentsHasMore,
    isSendingComment,
  );

  @override
  String toString() {
    return 'ArticleDetailUiState('
        'detail: $detail, '
        'isLoading: $isLoading, '
        'error: $error, '
        'comments: $comments, '
        'commentsLoading: $commentsLoading, '
        'commentsError: $commentsError, '
        'commentsNext: $commentsNext, '
        'commentsHasMore: $commentsHasMore, '
        'isSendingComment: $isSendingComment'
        ')';
  }
}

@riverpod
class ArticleDetailViewModel extends _$ArticleDetailViewModel {
  late final String _url;

  ArticleDetailCommentWorkflow get _commentWorkflow {
    return ArticleDetailCommentWorkflow(ref.read(dynamicRepositoryProvider));
  }

  @override
  ArticleDetailUiState build(String url) {
    _url = url;
    unawaited(Future<void>.microtask(refreshAll));
    return const ArticleDetailUiState();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref.read(dynamicRepositoryProvider).getArticleDetail(_url);
    state = result.when(
      success: (detail) => state.copyWith(detail: detail, isLoading: false, error: null),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
    DevLogger.log('feature', 'dynamic.article_detail state_commit', <String, Object?>{
      'hasDetail': state.detail != null,
      'hasError': state.error != null,
    });
  }

  Future<void> refreshAll() async {
    final firstInteractiveStopwatch = Stopwatch()..start();
    await loadDetail();
    final commentsEnabled = state.commentsEnabled;
    if (commentsEnabled) {
      unawaited(loadComments(refresh: true));
    }
    DevLogger.log(
      'feature',
      'dynamic.article_detail first_interactive',
      <String, Object?>{
        'ms': firstInteractiveStopwatch.elapsedMilliseconds,
        'commentsEnabled': commentsEnabled,
        'commentCount': state.comments.length,
      },
    );
  }

  Future<void> loadComments({bool refresh = false}) async {
    final detail = state.detail;
    if (detail == null) return;
    if (!state.commentsEnabled) {
      state = state.copyWith(
        commentsLoading: false,
        commentsError: null,
        commentsHasMore: false,
      );
      return;
    }
    if (state.commentsLoading && !refresh) return;

    final previousComments = List<CommentItem>.from(state.comments);
    final previousNext = state.commentsNext;
    final previousHasMore = state.commentsHasMore;

    state = state.copyWith(
      commentsLoading: true,
      commentsError: null,
      commentsNext: refresh ? null : state.commentsNext,
      commentsHasMore: refresh ? true : state.commentsHasMore,
    );

    final result = await ref
        .read(dynamicRepositoryProvider)
        .getArticleCommentList(
          article: detail,
          next: refresh ? null : state.commentsNext,
        );
    result.when(
      success: (response) {
        late final List<CommentItem> mergedComments;
        if (refresh) {
          mergedComments = response.replies;
        } else if (response.replies.isEmpty) {
          mergedComments = previousComments;
        } else {
          mergedComments = <int, CommentItem>{
            for (final item in previousComments) item.rpid: item,
            for (final item in response.replies) item.rpid: item,
          }.values.toList();
        }

        state = state.copyWith(
          comments: mergedComments,
          commentsNext: response.cursor?.next,
          commentsHasMore: !(response.cursor?.isEnd ?? true),
          commentsLoading: false,
          commentsError: null,
        );
      },
      failure: (error) {
        state = state.copyWith(
          commentsLoading: false,
          commentsError: error.message,
          comments: refresh ? previousComments : state.comments,
          commentsNext: refresh ? previousNext : state.commentsNext,
          commentsHasMore: refresh ? previousHasMore : state.commentsHasMore,
        );
      },
    );
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
  submitComment(String message) async {
    if (state.isSendingComment) {
      return null;
    }

    state = state.copyWith(isSendingComment: true);
    final result = await _commentWorkflow.submitComment(
      article: state.detail,
      commentsEnabled: state.commentsEnabled,
      rawMessage: message,
    );
    state = state.copyWith(isSendingComment: false);
    if (result == null) {
      return null;
    }
    if (!result.submitted) {
      return result;
    }
    await loadComments(refresh: true);
    return result;
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
  submitReply(CommentItem item, String message) async {
    final result = await _commentWorkflow.submitReply(
      article: state.detail,
      commentsEnabled: state.commentsEnabled,
      item: item,
      message: message,
    );
    if (result == null) {
      return null;
    }
    if (!result.submitted) {
      return result;
    }
    await loadComments(refresh: true);
    return result;
  }

  Future<void> toggleCommentLike(CommentItem item) async {
    final detail = state.detail;
    if (detail == null) return;
    final isLiked = item.action == 1;
    final previous = state.comments;

    state = state.copyWith(
      comments: previous.map((comment) {
        if (comment.rpid == item.rpid) {
          return comment.copyWith(
            action: isLiked ? 0 : 1,
            like: isLiked ? math.max(0, comment.like - 1) : comment.like + 1,
          );
        }
        return comment;
      }).toList(),
    );

    final result = await ref
        .read(dynamicRepositoryProvider)
        .likeArticleComment(article: detail, rpid: item.rpid, isLiked: !isLiked);
    if (result.isFailure) {
      state = state.copyWith(comments: previous);
    }
  }
}
