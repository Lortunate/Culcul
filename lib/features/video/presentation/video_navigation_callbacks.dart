import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:flutter/widgets.dart';

typedef OpenVideoCommentReplies =
    void Function({
      required int oid,
      required int rootId,
      required CommentItem comment,
      int? upperMid,
    });

typedef VideoDetailPageBuilder =
    Widget Function({
      required String bvid,
      required VoidCallback onLogin,
      required ValueChanged<int> onOpenUser,
      required ValueChanged<String> onOpenVideo,
      required OpenVideoCommentReplies onOpenCommentReplies,
    });
