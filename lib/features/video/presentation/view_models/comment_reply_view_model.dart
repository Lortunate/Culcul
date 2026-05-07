import 'dart:async';

import 'package:culcul/features/video/feature_scope.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_cancel_token.dart';
import 'package:culcul/core/data/pagination/paged_list_state_transitions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'comment_reply_state.dart';

part 'comment_reply_view_model.g.dart';

@riverpod
class CommentReplyController extends _$CommentReplyController {
  int _loadRequestToken = 0;
  RequestCancelToken? _activeLoadCancelToken;

  @override
  CommentReplyState build(int oid, int rootId) {
    ref.onDispose(() {
      _activeLoadCancelToken?.cancel('comment_reply_disposed');
    });
    unawaited(Future<void>.microtask(refresh));
    return const CommentReplyState();
  }

  void setRootComment(CommentItem comment) {
    state = state.copyWith(rootComment: comment);
  }

  Future<void> refresh() async {
    state = state.copyWith(paging: PagedListStateTransitions.beginRefresh(state.paging));
    final requestToken = ++_loadRequestToken;
    _activeLoadCancelToken?.cancel('comment_reply_refresh_replaced');
    final cancelToken = RequestCancelToken();
    _activeLoadCancelToken = cancelToken;

    final result = await ref
        .read(videoRepositoryProvider)
        .fetchReply(oid: oid, root: rootId, page: 1, cancelToken: cancelToken);
    if (!ref.mounted || requestToken != _loadRequestToken) {
      return;
    }
    state = result.when(
      success: (response) => state.copyWith(
        paging: PagedListStateTransitions.completeRefresh(
          state.paging,
          items: response.replies,
          nextPage: 2,
          hasMore: response.replies.isNotEmpty,
        ),
      ),
      failure: (error) {
        if (error is CancelAppError) {
          return state;
        }
        return state.copyWith(
          paging: PagedListStateTransitions.fail(state.paging, error),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.paging.isInitialLoading ||
        state.paging.isLoadingMore ||
        !state.paging.hasMore) {
      return;
    }

    state = state.copyWith(paging: PagedListStateTransitions.beginLoadMore(state.paging));
    final requestToken = ++_loadRequestToken;
    _activeLoadCancelToken?.cancel('comment_reply_load_more_replaced');
    final cancelToken = RequestCancelToken();
    _activeLoadCancelToken = cancelToken;

    final result = await ref
        .read(videoRepositoryProvider)
        .fetchReply(
          oid: oid,
          root: rootId,
          page: state.paging.nextPage,
          cancelToken: cancelToken,
        );
    if (!ref.mounted || requestToken != _loadRequestToken) {
      return;
    }
    state = result.when(
      success: (response) => state.copyWith(
        paging: PagedListStateTransitions.completeLoadMore(
          state.paging,
          items: [...state.paging.items, ...response.replies],
          nextPage: state.paging.nextPage + 1,
          hasMore: response.replies.isNotEmpty,
        ),
      ),
      failure: (error) {
        if (error is CancelAppError) {
          return state;
        }
        return state.copyWith(
          paging: PagedListStateTransitions.fail(state.paging, error),
        );
      },
    );
  }

  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {
    _updateCommentLikeStatus(rpid, !isLiked);

    final result = await ref
        .read(videoRepositoryProvider)
        .setCommentLike(oid: oid, rpid: rpid, isLiked: !isLiked);
    if (result.isFailure) {
      _updateCommentLikeStatus(rpid, isLiked);
    }
  }

  Future<void> toggleCommentDislike(int oid, int rpid) async {
    await ref.read(videoRepositoryProvider).setCommentDislike(oid: oid, rpid: rpid);
  }

  void _updateCommentLikeStatus(int rpid, bool liked) {
    CommentItem updateItem(CommentItem item) {
      return item.copyWith(
        like: liked ? item.like + 1 : item.like - 1,
        action: liked ? 1 : 0,
      );
    }

    if (state.rootComment?.rpid == rpid) {
      state = state.copyWith(rootComment: updateItem(state.rootComment!));
      return;
    }

    final index = state.paging.items.indexWhere((r) => r.rpid == rpid);
    if (index != -1) {
      final newReplies = List<CommentItem>.from(state.paging.items);
      newReplies[index] = updateItem(newReplies[index]);
      state = state.copyWith(paging: state.paging.copyWith(items: newReplies));
    }
  }

  Future<void> addReply(int oid, int root, int parent, String message) async {
    final result = await ref
        .read(videoRepositoryProvider)
        .replyToComment(oid: oid, root: root, parent: parent, message: message);
    if (result.isSuccess) {
      await refresh();
    }
  }
}
