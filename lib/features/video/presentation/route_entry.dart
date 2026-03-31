import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/presentation/pages/comment_reply_page.dart';
import 'package:culcul/features/video/presentation/pages/video_detail_page.dart';
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

