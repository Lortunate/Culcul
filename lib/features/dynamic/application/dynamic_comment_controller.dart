import 'dart:async';

import 'package:culcul/features/video/comment_api.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/ui/widgets/comments/comment_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_comment_controller.g.dart';

@riverpod
class DynamicCommentController extends _$DynamicCommentController {
  @override
  CommentListState build(DynamicItem post) {
    unawaited(Future<void>.microtask(refresh));
    return const CommentListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(paging: state.paging.beginRefresh());
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getComments(post, sort: state.sort);
    state = result.when(
      success: (data) {
        final cursor = data.cursor;
        final page = data.page;
        var hasMore = data.replies.length >= CommentApi.defaultPageSize;
        if (page != null && page.size > 0 && page.count > 0) {
          hasMore = page.size < page.count;
        }
        if (cursor != null) {
          hasMore = !cursor.isEnd;
        }
        return state.copyWith(
          paging: state.paging.completeRefresh(items: data.replies, hasMore: hasMore),
        );
      },
      failure: (error) => state.copyWith(paging: state.paging.fail(error)),
    );
  }

  Future<void> loadMore() async {
    if (state.paging.isInitialLoading ||
        state.paging.isLoadingMore ||
        !state.paging.hasMore) {
      return;
    }

    final nextPage = state.paging.nextPage;
    state = state.copyWith(paging: state.paging.beginLoadMore());
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getComments(post, sort: state.sort, page: nextPage);
    result.when(
      success: (data) {
        final cursor = data.cursor;
        final page = data.page;
        var hasMore = data.replies.length >= CommentApi.defaultPageSize;
        if (page != null && page.size > 0 && page.count > 0) {
          hasMore = nextPage * page.size < page.count;
        }
        if (cursor != null) {
          hasMore = !cursor.isEnd;
        }
        state = state.copyWith(
          paging: state.paging.completeLoadMore(
            items: [...state.paging.items, ...data.replies],
            hasMore: hasMore,
            nextPage: nextPage + 1,
          ),
        );
      },
      failure: (error) {
        state = state.copyWith(paging: state.paging.fail(error));
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
}
