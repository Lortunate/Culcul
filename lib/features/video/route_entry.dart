import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_page.dart';
import 'package:culcul/features/video/presentation/detail/video_entry_decision_page.dart';
import 'package:culcul/features/video/presentation/video_navigation_callbacks.dart';
import 'package:flutter/widgets.dart';

class CommentReplyRouteInput {
  final CommentItem comment;
  final int? upperMid;

  const CommentReplyRouteInput({required this.comment, this.upperMid});
}

Widget buildVideoDetailRoutePage(
  String bvid, {
  required VoidCallback onLogin,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required OpenVideoCommentReplies onOpenCommentReplies,
}) {
  return VideoEntryDecisionPage(
    bvid: bvid,
    onLogin: onLogin,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    onOpenCommentReplies: onOpenCommentReplies,
  );
}

Widget buildCommentReplyRoutePage({
  required int oid,
  required int rootId,
  required CommentReplyRouteInput input,
  required ValueChanged<int> onOpenUser,
}) {
  return CommentReplyPage(
    oid: oid,
    rootId: rootId,
    comment: input.comment,
    upperMid: input.upperMid,
    onOpenUser: onOpenUser,
  );
}
