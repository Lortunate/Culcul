import 'dart:math' as math;

import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/features/dynamic/data/article_detail_data.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_detail_view_model.g.dart';

class ArticleDetailUiState {
  final ArticleDetailData? detail;
  final bool isLoading;
  final Object? error;
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
    Object? error,
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
    Future.microtask(() async {
      await loadDetail();
      if (state.commentsEnabled) {
        await loadComments(refresh: true);
      }
    });
    return const ArticleDetailUiState();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final detail = await ref.read(dynamicRepositoryProvider).getArticleDetail(_url);
      state = state.copyWith(
        setDetail: true,
        detail: detail,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
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

    try {
      final response = await ref
          .read(dynamicRepositoryProvider)
          .getArticleCommentList(
            oid: detail.commentOid,
            next: refresh ? null : state.commentsNext,
            referer: detail.url,
          );
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
    } catch (e) {
      state = state.copyWith(
        commentsLoading: false,
        commentsError: e.toString(),
        comments: refresh ? previousComments : null,
        commentsNext: refresh ? previousNext : null,
        commentsHasMore: refresh ? previousHasMore : null,
      );
    }
  }

  Future<String?> submitComment(String message) async {
    final detail = state.detail;
    if (detail == null) return null;
    if (!state.commentsEnabled) return 'Comments disabled';
    if (message.trim().isEmpty || state.isSendingComment) return null;

    state = state.copyWith(isSendingComment: true);
    try {
      await ref
          .read(dynamicRepositoryProvider)
          .addCommentReply(
            oid: detail.commentOid,
            type: detail.commentType,
            root: 0,
            parent: 0,
            message: message.trim(),
            referer: detail.url,
          );
      await loadComments(refresh: true);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      state = state.copyWith(isSendingComment: false);
    }
  }

  Future<String?> submitReply(CommentItem item, String message) async {
    final detail = state.detail;
    if (detail == null) return null;
    if (!state.commentsEnabled) return 'Comments disabled';

    try {
      await ref
          .read(dynamicRepositoryProvider)
          .addCommentReply(
            oid: detail.commentOid,
            type: detail.commentType,
            root: item.root == 0 ? item.rpid : item.root,
            parent: item.rpid,
            message: message,
            referer: detail.url,
          );
      await loadComments(refresh: true);
      return null;
    } catch (e) {
      return e.toString();
    }
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

    try {
      await ref
          .read(dynamicRepositoryProvider)
          .likeCommentByTarget(
            oid: detail.commentOid,
            type: detail.commentType,
            rpid: item.rpid,
            isLiked: !isLiked,
            referer: detail.url,
          );
    } catch (_) {
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
