import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/controllers/dynamic_comment_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_comment_controller.g.dart';

@riverpod
class DynamicCommentController extends _$DynamicCommentController {
  @override
  DynamicCommentState build(DynamicItem post) {
    // Initial load
    Future.microtask(() => refresh());
    return const DynamicCommentState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(dynamicRepositoryProvider);

    try {
      final data = await repository.getComments(post, sort: state.sort, page: 1);
      final hasMore = _resolveHasMore(data, currentPage: 1);
      state = state.copyWith(
        comments: data.replies,
        isLoading: false,
        hasMore: hasMore,
        page: 1,
      );
    } catch (error) {
      final exception = error is AppException
          ? error
          : UnknownException(error.toString(), cause: error);
      state = state.copyWith(isLoading: false, error: exception);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    final repository = ref.read(dynamicRepositoryProvider);
    final nextPage = state.page + 1;

    // Set loading state if needed, or just rely on UI showing a loader at bottom
    // Ideally we don't want to clear comments, just append.
    // We don't set global isLoading to true to avoid full screen loader.

    try {
      final data = await repository.getComments(post, sort: state.sort, page: nextPage);
      final hasMore = _resolveHasMore(data, currentPage: nextPage);
      state = state.copyWith(
        comments: [...state.comments, ...data.replies],
        hasMore: hasMore,
        page: nextPage,
      );
    } catch (_) {
      // Handle error gracefully.
    }
  }

  Future<void> toggleLike(int rpid, bool isLiked) async {
    final repository = ref.read(dynamicRepositoryProvider);

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

    try {
      await repository.likeComment(post: post, rpid: rpid, isLiked: isLiked);
    } catch (_) {
      // Revert on failure
      state = state.copyWith(comments: oldComments);
    }
  }

  Future<void> addReply(int root, int parent, String message) async {
    final repository = ref.read(dynamicRepositoryProvider);

    await repository.addReply(
      post: post,
      root: root,
      parent: parent,
      message: message,
    );
    await refresh();
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

