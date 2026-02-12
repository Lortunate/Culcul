import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/providers/dynamic/dynamic_comment_state.dart';
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

    final result = await repository.getComments(
      post,
      sort: state.sort,
      page: 1,
    );

    result.when(
      success: (data) {
        state = state.copyWith(
          comments: data.replies,
          isLoading: false,
          hasMore: !data.cursor!.is_end,
          page: 1,
        );
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error);
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    final repository = ref.read(dynamicRepositoryProvider);
    final nextPage = state.page + 1;

    // Set loading state if needed, or just rely on UI showing a loader at bottom
    // Ideally we don't want to clear comments, just append.
    // We don't set global isLoading to true to avoid full screen loader.

    final result = await repository.getComments(
      post,
      sort: state.sort,
      page: nextPage,
    );

    result.when(
      success: (data) {
        state = state.copyWith(
          comments: [...state.comments, ...data.replies],
          hasMore: !data.cursor!.is_end,
          page: nextPage,
        );
      },
      failure: (error) {
        // Handle error gracefully
      },
    );
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

    final result = await repository.likeComment(
      post: post,
      rpid: rpid,
      isLiked: isLiked,
    );

    if (result.isFailure) {
      // Revert on failure
      state = state.copyWith(comments: oldComments);
    }
  }

  Future<void> addReply(int root, int parent, String message) async {
    final repository = ref.read(dynamicRepositoryProvider);

    final result = await repository.addReply(
      post: post,
      root: root,
      parent: parent,
      message: message,
    );

    if (result.isSuccess) {
      // Refresh to show new comment
      refresh();
    }
  }
}
