import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'dart:async';

import 'package:culcul/features/dynamic/feature_scope.dart';
import 'package:culcul/core/data/pagination/paged_list_state_transitions.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_comment_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_comment_view_model.g.dart';

@riverpod
class DynamicCommentController extends _$DynamicCommentController {
  @override
  DynamicCommentState build(DynamicItem post) {
    unawaited(Future<void>.microtask(refresh));
    return const DynamicCommentState();
  }

  Future<void> refresh() async {
    state = state.copyWith(paging: PagedListStateTransitions.beginRefresh(state.paging));
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getComments(post, sort: state.sort, page: 1);
    state = result.when(
      success: (data) => state.copyWith(
        paging: PagedListStateTransitions.completeRefresh(
          state.paging,
          items: data.replies,
          hasMore: _resolveHasMore(data, currentPage: 1),
          nextPage: 2,
        ),
      ),
      failure: (error) =>
          state.copyWith(paging: PagedListStateTransitions.fail(state.paging, error)),
    );
  }

  Future<void> loadMore() async {
    if (state.paging.isInitialLoading ||
        state.paging.isLoadingMore ||
        !state.paging.hasMore) {
      return;
    }

    final nextPage = state.paging.nextPage;
    state = state.copyWith(paging: PagedListStateTransitions.beginLoadMore(state.paging));
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getComments(post, sort: state.sort, page: nextPage);
    result.when(
      success: (data) {
        state = state.copyWith(
          paging: PagedListStateTransitions.completeLoadMore(
            state.paging,
            items: [...state.paging.items, ...data.replies],
            hasMore: _resolveHasMore(data, currentPage: nextPage),
            nextPage: nextPage + 1,
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

  Future<void> toggleLike(int rpid, bool isLiked) async {
    // Optimistic update
    final oldComments = [...state.paging.items];
    final index = state.paging.items.indexWhere((c) => c.rpid == rpid);
    if (index == -1) return;

    final oldItem = state.paging.items[index];
    final newItem = oldItem.copyWith(
      action: isLiked ? 1 : 0,
      like: isLiked ? oldItem.like + 1 : oldItem.like - 1,
    );

    final newComments = [...state.paging.items];
    newComments[index] = newItem;
    state = state.copyWith(paging: state.paging.copyWith(items: newComments));

    final result = await ref
        .read(dynamicRepositoryProvider)
        .likeComment(post: post, rpid: rpid, isLiked: isLiked);
    if (result.isFailure) {
      state = state.copyWith(paging: state.paging.copyWith(items: oldComments));
    }
  }

  Future<void> addReply(int root, int parent, String message) async {
    final result = await ref
        .read(dynamicRepositoryProvider)
        .addReply(post: post, root: root, parent: parent, message: message);
    if (result.isSuccess) {
      await refresh();
    }
  }

  bool _resolveHasMore(CommentResponse data, {required int currentPage}) {
    final cursor = data.cursor;
    if (cursor != null) {
      return !cursor.isEnd;
    }

    final page = data.page;
    if (page != null && page.size > 0 && page.count > 0) {
      return currentPage * page.size < page.count;
    }

    // Fallback: if no pagination metadata, treat short page as end.
    return data.replies.length >= 20;
  }
}
