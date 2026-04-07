import 'dart:async';

import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/core/pagination/paged_list_state_transitions.dart';
import 'package:culcul/features/video/video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'video_comments_state.dart';
import 'video_detail_view_model.dart';

part 'video_comments_view_model.g.dart';

@riverpod
class VideoCommentsController extends _$VideoCommentsController {
  @override
  VideoCommentsState build(String bvid) {
    return const VideoCommentsState(
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
    final nextComments = _updateComment(previousComments, rpid, isLiked: !isLiked);
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
        .fetchComments(oid: aid, sort: state.sort, page: page);
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

  List<CommentItem> _updateComment(
    List<CommentItem> comments,
    int rpid, {
    required bool isLiked,
  }) {
    CommentItem? update(CommentItem item) {
      if (item.rpid == rpid) {
        return item.copyWith(
          like: isLiked ? item.like + 1 : item.like - 1,
          action: isLiked ? 1 : 0,
        );
      }

      final replyIndex = item.replies.indexWhere((reply) => reply.rpid == rpid);
      if (replyIndex == -1) {
        return null;
      }

      final replies = List<CommentItem>.from(item.replies);
      final oldReply = replies[replyIndex];
      replies[replyIndex] = oldReply.copyWith(
        like: isLiked ? oldReply.like + 1 : oldReply.like - 1,
        action: isLiked ? 1 : 0,
      );
      return item.copyWith(replies: replies);
    }

    var changed = false;
    final result = <CommentItem>[];
    for (final comment in comments) {
      final updated = update(comment);
      if (updated != null) {
        result.add(updated);
        changed = true;
      } else {
        result.add(comment);
      }
    }

    return changed ? result : comments;
  }
}
