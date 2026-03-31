import 'package:culcul/features/video/models/video_models.dart';
import 'package:culcul/features/video/presentation/comment_reply_page.dart';
import 'package:culcul/features/video/presentation/video_detail_page.dart';
import 'package:flutter/widgets.dart';

class CommentReplyRouteInput {
  final CommentItem comment;
  final int? upperMid;

  const CommentReplyRouteInput({required this.comment, this.upperMid});
}

Widget buildVideoDetailRoutePage(String bvid) => VideoDetailPage(bvid: bvid);

Widget buildCommentReplyRoutePage({
  required int oid,
  required int rootId,
  required CommentReplyRouteInput input,
}) {
  return CommentReplyPage(
    oid: oid,
    rootId: rootId,
    comment: input.comment,
    upperMid: input.upperMid,
  );
}
