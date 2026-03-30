import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'video_comments_state.dart';
import 'video_detail_controller.dart';

part 'video_comments_controller.g.dart';

@riverpod
class VideoCommentsController extends _$VideoCommentsController {
  @override
  VideoCommentsState build(String bvid) {
    Future.microtask(refresh);
    return const VideoCommentsState();
  }

  Future<void> refresh() async {
    final aid = await _awaitAid();
    if (aid == null) {
      state = state.copyWith(
        isInitialLoading: false,
        error: StateError('Video detail not loaded'),
      );
      return;
    }

    state = state.copyWith(
      isInitialLoading: true,
      isLoadingMore: false,
      error: null,
      nextPage: 1,
      hasMore: true,
      comments: const [],
    );

    await _loadPage(page: 1, replace: true);
  }

  Future<void> loadMore() async {
    if (state.isInitialLoading || state.isLoadingMore || !state.hasMore) {
      return;
    }

    await _loadPage(page: state.nextPage, replace: false);
  }

  Future<void> switchSort(int sort) async {
    if (state.sort == sort) {
      return;
    }

    state = state.copyWith(sort: sort);
    await refresh();
  }

  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {
    final previousComments = state.comments;
    final nextComments = _updateComment(previousComments, rpid, isLiked: !isLiked);
    if (identical(nextComments, previousComments)) {
      return;
    }

    state = state.copyWith(comments: nextComments);

    try {
      await ref
          .read(videoRepositoryProvider)
          .setCommentLike(oid: oid, rpid: rpid, isLiked: !isLiked);
    } catch (_) {
      state = state.copyWith(comments: previousComments);
    }
  }

  Future<void> toggleCommentDislike(int oid, int rpid) {
    return ref.read(videoRepositoryProvider).setCommentDislike(oid: oid, rpid: rpid);
  }

  Future<void> addReply(int oid, int root, int parent, String message) async {
    await ref
        .read(videoRepositoryProvider)
        .replyToComment(oid: oid, root: root, parent: parent, message: message);
    await refresh();
  }

  Future<void> _loadPage({required int page, required bool replace}) async {
    final aid = await _awaitAid();
    if (aid == null) {
      return;
    }

    if (replace) {
      state = state.copyWith(isInitialLoading: true, error: null);
    } else {
      state = state.copyWith(isLoadingMore: true, error: null);
    }

    try {
      final response = await ref
          .read(videoRepositoryProvider)
          .fetchComments(oid: aid, sort: state.sort, page: page);
      final comments = replace
          ? response.replies
          : [...state.comments, ...response.replies];
      state = state.copyWith(
        comments: comments,
        isInitialLoading: false,
        isLoadingMore: false,
        hasMore: response.replies.isNotEmpty,
        nextPage: page + 1,
      );
    } catch (error) {
      state = state.copyWith(isInitialLoading: false, isLoadingMore: false, error: error);
    }
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
