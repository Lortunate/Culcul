import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'comment_reply_state.dart';

part 'comment_reply_controller.g.dart';

@riverpod
class CommentReplyController extends _$CommentReplyController {
  @override
  CommentReplyState build(int oid, int rootId) {
    Future.microtask(_init);
    return const CommentReplyState();
  }

  void setRootComment(CommentItem comment) {
    state = state.copyWith(rootComment: comment);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);

    final repo = ref.read(videoRepositoryProvider);
    try {
      final response = await repo.fetchReply(oid: oid, root: rootId, pn: 1);
      state = state.copyWith(
        replies: response.replies,
        page: 2,
        hasMore: response.replies.isNotEmpty,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> _init() async {
    await refresh();
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    final repo = ref.read(videoRepositoryProvider);
    try {
      final response = await repo.fetchReply(oid: oid, root: rootId, pn: state.page);
      state = state.copyWith(
        replies: [...state.replies, ...response.replies],
        page: state.page + 1,
        hasMore: response.replies.isNotEmpty,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {
    _updateCommentLikeStatus(rpid, !isLiked);

    final action = isLiked ? 0 : 1;
    final repo = ref.read(videoRepositoryProvider);
    try {
      await repo.actionComment(oid: oid, rpid: rpid, action: action);
    } catch (_) {
      _updateCommentLikeStatus(rpid, isLiked);
    }
  }

  Future<void> toggleCommentDislike(int oid, int rpid) async {
    final repo = ref.read(videoRepositoryProvider);
    await repo.hateComment(oid: oid, rpid: rpid, action: 1);
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
    final repo = ref.read(videoRepositoryProvider);
    await repo.addReply(
      oid: oid,
      root: root,
      parent: parent,
      message: message,
    );
    await refresh();
  }
}

