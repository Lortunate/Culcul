import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'dart:async';

import 'package:culcul/features/video/application/video_comment_workflows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'comment_reply_state.dart';

part 'comment_reply_view_model.g.dart';

@riverpod
class CommentReplyController extends _$CommentReplyController {
  @override
  CommentReplyState build(int oid, int rootId) {
    unawaited(refresh());
    return const CommentReplyState();
  }

  void setRootComment(CommentItem comment) {
    state = state.copyWith(rootComment: comment);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await ref
        .read(videoCommentWorkflowsProvider)
        .loadReplies(oid: oid, root: rootId, page: 1);
    state = result.when(
      success: (response) => state.copyWith(
        replies: response.replies,
        page: 2,
        hasMore: response.replies.isNotEmpty,
        isLoading: false,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    final result = await ref
        .read(videoCommentWorkflowsProvider)
        .loadReplies(oid: oid, root: rootId, page: state.page);
    state = result.when(
      success: (response) => state.copyWith(
        replies: [...state.replies, ...response.replies],
        page: state.page + 1,
        hasMore: response.replies.isNotEmpty,
        isLoading: false,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }

  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {
    _updateCommentLikeStatus(rpid, !isLiked);

    final result = await ref
        .read(videoCommentWorkflowsProvider)
        .toggleLike(oid: oid, rpid: rpid, isLiked: !isLiked);
    if (result.isFailure) {
      _updateCommentLikeStatus(rpid, isLiked);
    }
  }

  Future<void> toggleCommentDislike(int oid, int rpid) async {
    await ref
        .read(videoCommentWorkflowsProvider)
        .toggleDislike(oid: oid, rpid: rpid);
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

    final index = state.replies.indexWhere((r) => r.rpid == rpid);
    if (index != -1) {
      final newReplies = List<CommentItem>.from(state.replies);
      newReplies[index] = updateItem(newReplies[index]);
      state = state.copyWith(replies: newReplies);
    }
  }

  Future<void> addReply(int oid, int root, int parent, String message) async {
    await ref
        .read(videoCommentWorkflowsProvider)
        .addReply(oid: oid, root: root, parent: parent, message: message);
    await refresh();
  }
}
