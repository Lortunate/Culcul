import 'package:culcul/core/contracts/comment_contract.dart';

List<CommentItem> updateCommentLikeState(
  List<CommentItem> comments,
  int rpid, {
  required bool isLiked,
}) {
  var changed = false;
  final updated = <CommentItem>[];

  for (final comment in comments) {
    final nextComment = _updateCommentLikeState(comment, rpid, isLiked: isLiked);
    changed = changed || !identical(nextComment, comment);
    updated.add(nextComment);
  }

  return changed ? updated : comments;
}

CommentItem _updateCommentLikeState(
  CommentItem comment,
  int rpid, {
  required bool isLiked,
}) {
  final replies = comment.replies;
  final nextReplies = replies.isEmpty
      ? replies
      : updateCommentLikeState(replies, rpid, isLiked: isLiked);
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
