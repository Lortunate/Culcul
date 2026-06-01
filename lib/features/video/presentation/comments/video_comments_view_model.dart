import 'dart:async';

import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/core/data/pagination/paged_list_state_transitions.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/ui/assemblies/comments/comment_list_state.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';

part 'video_comments_view_model.g.dart';

List<CommentItem> _updateCommentLikeState(
  List<CommentItem> comments,
  int rpid, {
  required bool isLiked,
}) {
  var changed = false;
  final updated = <CommentItem>[];

  for (final comment in comments) {
    final nextComment = _updateCommentLikeStateItem(comment, rpid, isLiked: isLiked);
    changed = changed || !identical(nextComment, comment);
    updated.add(nextComment);
  }

  return changed ? updated : comments;
}

CommentItem _updateCommentLikeStateItem(
  CommentItem comment,
  int rpid, {
  required bool isLiked,
}) {
  final replies = comment.replies;
  final nextReplies = replies.isEmpty
      ? replies
      : _updateCommentLikeState(replies, rpid, isLiked: isLiked);
  final repliesChanged = !identical(nextReplies, replies);

  if (comment.rpid != rpid) {
    return repliesChanged ? comment.copyWith(replies: nextReplies) : comment;
  }

  final nextLike = isLiked
      ? comment.like + 1
      : comment.like > 0
      ? comment.like - 1
      : 0;
  return comment.copyWith(
    like: nextLike,
    action: isLiked ? 1 : 0,
    replies: repliesChanged ? nextReplies : replies,
  );
}

@riverpod
class VideoCommentsController extends _$VideoCommentsController {
  int _loadRequestToken = 0;
  CancelToken? _activeLoadCancelToken;

  @override
  CommentListState build(String bvid) {
    ref.onDispose(() {
      _activeLoadCancelToken?.cancel('video_comments_disposed');
    });
    return const CommentListState(
      paging: PagedListState<CommentItem>(isInitialLoading: false, hasMore: true),
    );
  }

  Future<void> ensureLoaded() async {
    final paging = state.paging;
    if (paging.isInitialLoading || paging.items.isNotEmpty) {
      return;
    }
    await refresh();
  }

  Future<void> refresh() async {
    final aid = await _awaitAid();
    if (aid == null) {
      state = state.copyWith(
        paging: state.paging.copyWith(
          isInitialLoading: false,
          error: StateError('Video detail not loaded'),
        ),
      );
      return;
    }

    state = state.copyWith(paging: PagedListStateTransitions.beginRefresh(state.paging));

    await _loadPage(page: 1, replace: true);
  }

  Future<void> loadMore() async {
    if (state.paging.isInitialLoading ||
        state.paging.isLoadingMore ||
        !state.paging.hasMore) {
      return;
    }

    await _loadPage(page: state.paging.nextPage, replace: false);
  }

  Future<void> switchSort(CommentSort sort) async {
    if (state.sort == sort) {
      return;
    }

    state = state.copyWith(sort: sort);
    await refresh();
  }

  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {
    final previousComments = state.paging.items;
    final nextComments = _updateCommentLikeState(
      previousComments,
      rpid,
      isLiked: !isLiked,
    );
    if (identical(nextComments, previousComments)) {
      return;
    }

    state = state.copyWith(paging: state.paging.copyWith(items: nextComments));

    final result = await ref
        .read(videoRepositoryProvider)
        .setCommentLike(oid: oid, rpid: rpid, isLiked: !isLiked);
    if (result.isFailure) {
      state = state.copyWith(paging: state.paging.copyWith(items: previousComments));
    }
  }

  Future<void> toggleCommentDislike(int oid, int rpid) async {
    await ref.read(videoRepositoryProvider).setCommentDislike(oid: oid, rpid: rpid);
  }

  Future<void> addReply(int oid, int root, int parent, String message) async {
    final result = await ref
        .read(videoRepositoryProvider)
        .replyToComment(oid: oid, root: root, parent: parent, message: message);
    if (result.isSuccess) {
      await refresh();
    }
  }

  Future<void> _loadPage({required int page, required bool replace}) async {
    final aid = await _awaitAid();
    if (aid == null) {
      return;
    }
    final requestToken = ++_loadRequestToken;
    _activeLoadCancelToken?.cancel('video_comments_replaced');
    final cancelToken = CancelToken();
    _activeLoadCancelToken = cancelToken;

    if (replace) {
      state = state.copyWith(
        paging: PagedListStateTransitions.beginRefresh(state.paging, clearItems: false),
      );
    } else {
      state = state.copyWith(
        paging: PagedListStateTransitions.beginLoadMore(state.paging),
      );
    }

    final result = await ref
        .read(videoRepositoryProvider)
        .fetchComments(oid: aid, sort: state.sort, page: page, cancelToken: cancelToken);
    if (!ref.mounted || requestToken != _loadRequestToken) {
      return;
    }
    result.when(
      success: (response) {
        final comments = replace
            ? response.replies
            : [...state.paging.items, ...response.replies];
        state = state.copyWith(
          paging: replace
              ? PagedListStateTransitions.completeRefresh(
                  state.paging,
                  items: comments,
                  hasMore: response.replies.isNotEmpty,
                  nextPage: page + 1,
                )
              : PagedListStateTransitions.completeLoadMore(
                  state.paging,
                  items: comments,
                  hasMore: response.replies.isNotEmpty,
                  nextPage: page + 1,
                ),
        );
      },
      failure: (error) {
        if (error is CancelAppError) {
          return;
        }
        state = state.copyWith(
          paging: PagedListStateTransitions.fail(state.paging, error),
        );
      },
    );
  }

  Future<int?> _awaitAid() async {
    for (var attempt = 0; attempt < 10; attempt++) {
      final aid = ref.read(videoDetailControllerProvider(bvid)).videoDetail?.aid;
      if (aid != null) {
        return aid;
      }
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    return ref.read(videoDetailControllerProvider(bvid)).videoDetail?.aid;
  }
}
