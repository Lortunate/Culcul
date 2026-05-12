part of 'article_detail_view_model.dart';

mixin _ArticleDetailViewModelActions on _$ArticleDetailViewModel {
  String get _url;

  ArticleDetailCommentWorkflow get _commentWorkflow {
    return ArticleDetailCommentWorkflow(ref.read(dynamicRepositoryProvider));
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref.read(dynamicRepositoryProvider).getArticleDetail(_url);
    state = result.when(
      success: (detail) => state.copyWith(
        detail: detail,
        isLoading: false,
        error: null,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
    DevLogger.log(
      'feature',
      'dynamic.article_detail state_commit',
      <String, Object?>{
        'hasDetail': state.detail != null,
        'hasError': state.error != null,
      },
    );
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
        final mergedComments = refresh
            ? response.replies
            : _appendUniqueComments(previousComments, response.replies);

        state = state.copyWith(
          comments: mergedComments,
          commentsNext: response.cursor?.next,
          commentsHasMore: _resolveHasMore(response),
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

  Future<ArticleDetailCommentActionResult> submitComment(String message) async {
    if (state.isSendingComment) {
      return const ArticleDetailCommentActionResult.noop();
    }

    state = state.copyWith(isSendingComment: true);
    final result = await _commentWorkflow.submitComment(
      article: state.detail,
      commentsEnabled: state.commentsEnabled,
      rawMessage: message,
    );
    state = state.copyWith(isSendingComment: false);
    if (!result.submitted) {
      return result;
    }
    await loadComments(refresh: true);
    return result;
  }

  Future<ArticleDetailCommentActionResult> submitReply(
    CommentItem item,
    String message,
  ) async {
    final result = await _commentWorkflow.submitReply(
      article: state.detail,
      commentsEnabled: state.commentsEnabled,
      item: item,
      message: message,
    );
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
