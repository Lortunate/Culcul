import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/dynamic/dynamic_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_detail_view_model.g.dart';

class ArticleDetailUiState {
  final ArticleDetailData? detail;
  final bool isLoading;
  final AppError? error;
  final List<CommentItem> comments;
  final bool commentsLoading;
  final String? commentsError;
  final int? commentsNext;
  final bool commentsHasMore;
  final bool isSendingComment;

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

  bool get commentsEnabled => (detail?.commentOid ?? '').isNotEmpty;

  ArticleDetailUiState copyWith({
    ArticleDetailData? detail,
    bool setDetail = false,
    bool? isLoading,
    AppError? error,
    bool clearError = false,
    List<CommentItem>? comments,
    bool? commentsLoading,
    String? commentsError,
    bool clearCommentsError = false,
    int? commentsNext,
    bool clearCommentsNext = false,
    bool? commentsHasMore,
    bool? isSendingComment,
  }) {
    return ArticleDetailUiState(
      detail: setDetail ? detail : this.detail,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      comments: comments ?? this.comments,
      commentsLoading: commentsLoading ?? this.commentsLoading,
      commentsError: clearCommentsError ? null : (commentsError ?? this.commentsError),
      commentsNext: clearCommentsNext ? null : (commentsNext ?? this.commentsNext),
      commentsHasMore: commentsHasMore ?? this.commentsHasMore,
      isSendingComment: isSendingComment ?? this.isSendingComment,
    );
  }
}

@riverpod
class ArticleDetailViewModel extends _$ArticleDetailViewModel {
  late final String _url;

  @override
  ArticleDetailUiState build(String url) {
    _url = url;
    unawaited(refreshAll());
    return const ArticleDetailUiState();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await runResult(
      () => ref.read(dynamicRepositoryProvider).getArticleDetail(_url),
    );
    state = result.when(
      success: (detail) => state.copyWith(
        setDetail: true,
        detail: detail,
        isLoading: false,
        clearError: true,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }

  Future<void> refreshAll() async {
    await loadDetail();
    if (state.commentsEnabled) {
      await loadComments(refresh: true);
    }
  }

  Future<void> loadComments({bool refresh = false}) async {
    final detail = state.detail;
    if (detail == null) return;
    if (!state.commentsEnabled) {
      state = state.copyWith(
        commentsLoading: false,
        clearCommentsError: true,
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
      clearCommentsError: true,
      clearCommentsNext: refresh,
      commentsHasMore: refresh ? true : null,
    );

    final result = await runResult(
      () => ref
          .read(dynamicRepositoryProvider)
          .getArticleCommentList(
            article: detail,
            next: refresh ? null : state.commentsNext,
          ),
    );
    result.when(
      success: (response) {
        final mergedComments = refresh
            ? response.replies
            : _appendUniqueComments(previousComments, response.replies);

        state = state.copyWith(
          comments: mergedComments,
          commentsNext: response.cursor?.next,
          commentsHasMore: _resolveHasMore(response),
          commentsLoading: false,
          clearCommentsError: true,
        );
      },
      failure: (error) {
        state = state.copyWith(
          commentsLoading: false,
          commentsError: error.message,
          comments: refresh ? previousComments : null,
          commentsNext: refresh ? previousNext : null,
          commentsHasMore: refresh ? previousHasMore : null,
        );
      },
    );
  }

  Future<String?> submitComment(String message) async {
    final detail = state.detail;
    if (detail == null) return null;
    if (!state.commentsEnabled) return 'Comments disabled';
    if (message.trim().isEmpty || state.isSendingComment) return null;

    state = state.copyWith(isSendingComment: true);
    final result = await ref
        .read(dynamicRepositoryProvider)
        .addArticleCommentReply(
          article: detail,
          root: 0,
          parent: 0,
          message: message.trim(),
        );
    state = state.copyWith(isSendingComment: false);
    if (result.isFailure) {
      return result.errorOrNull!.message;
    }
    await loadComments(refresh: true);
    return null;
  }

  Future<String?> submitReply(CommentItem item, String message) async {
    final detail = state.detail;
    if (detail == null) return null;
    if (!state.commentsEnabled) return 'Comments disabled';

    final result = await ref
        .read(dynamicRepositoryProvider)
        .addArticleCommentReply(
          article: detail,
          root: item.root == 0 ? item.rpid : item.root,
          parent: item.rpid,
          message: message,
        );
    if (result.isFailure) {
      return result.errorOrNull!.message;
    }
    await loadComments(refresh: true);
    return null;
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

bool _resolveHasMore(CommentResponse data) {
  return !(data.cursor?.isEnd ?? true);
}

List<CommentItem> _appendUniqueComments(
  List<CommentItem> current,
  List<CommentItem> incoming,
) {
  if (incoming.isEmpty) return current;
  final merged = <int, CommentItem>{for (final item in current) item.rpid: item};
  for (final item in incoming) {
    merged[item.rpid] = item;
  }
  return merged.values.toList();
}
