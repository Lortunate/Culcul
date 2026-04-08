part of 'article_detail_view_model.dart';

mixin _ArticleDetailViewModelActions on _$ArticleDetailViewModel {
  String get _url;

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(dynamicRepositoryProvider).getArticleDetail(_url);
    state = result.when(
      success: (detail) => state.copyWith(
        setDetail: true,
        detail: detail,
        isLoading: false,
        clearError: true,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
    FeatureFlowPerfLogger.log(
      chain: 'dynamic.article_detail',
      stage: 'state_commit',
      fields: <String, Object?>{
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
    FeatureFlowPerfLogger.log(
      chain: 'dynamic.article_detail',
      stage: 'first_interactive',
      fields: <String, Object?>{
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
