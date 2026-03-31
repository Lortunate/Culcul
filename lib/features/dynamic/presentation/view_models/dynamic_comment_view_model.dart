import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'dart:async';

import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/dynamic/dynamic_providers.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_comment_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_comment_view_model.g.dart';

@riverpod
class DynamicCommentController extends _$DynamicCommentController {
  @override
  DynamicCommentState build(DynamicItem post) {
    unawaited(refresh());
    return const DynamicCommentState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await runResult(
      () => ref.read(dynamicRepositoryProvider).getComments(
        post,
        sort: state.sort,
        page: 1,
      ),
    );
    state = result.when(
      success: (data) => state.copyWith(
        comments: data.replies,
        isLoading: false,
        hasMore: _resolveHasMore(data, currentPage: 1),
        page: 1,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    final nextPage = state.page + 1;
    final result = await runResult(
      () => ref.read(dynamicRepositoryProvider).getComments(
        post,
        sort: state.sort,
        page: nextPage,
      ),
    );
    if (result.isFailure) {
      return;
    }
    final data = result.dataOrNull!;
    state = state.copyWith(
      comments: [...state.comments, ...data.replies],
      hasMore: _resolveHasMore(data, currentPage: nextPage),
      page: nextPage,
    );
  }

  Future<void> toggleLike(int rpid, bool isLiked) async {
    // Optimistic update
    final oldComments = [...state.comments];
    final index = state.comments.indexWhere((c) => c.rpid == rpid);
    if (index == -1) return;

    final oldItem = state.comments[index];
    final newItem = oldItem.copyWith(
      action: isLiked ? 1 : 0,
      like: isLiked ? oldItem.like + 1 : oldItem.like - 1,
    );

    final newComments = [...state.comments];
    newComments[index] = newItem;
    state = state.copyWith(comments: newComments);

    final result = await runVoidResult(
      () => ref.read(dynamicRepositoryProvider).likeComment(
        post: post,
        rpid: rpid,
        isLiked: isLiked,
      ),
    );
    if (result.isFailure) {
      state = state.copyWith(comments: oldComments);
    }
  }

  Future<void> addReply(int root, int parent, String message) async {
    final result = await runVoidResult(
      () => ref.read(dynamicRepositoryProvider).addReply(
        post: post,
        root: root,
        parent: parent,
        message: message,
      ),
    );
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
