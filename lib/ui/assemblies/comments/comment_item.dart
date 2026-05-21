import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/comments/comment_images.dart';
import 'package:culcul/ui/assemblies/text/bilibili_emoji_text.dart';
import 'package:culcul/ui/assemblies/users/user_tags.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/inputs/app_selectable_text.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:flutter/material.dart';

part 'comment_item.header.dart';
part 'comment_item.content.dart';
part 'comment_item.footer.dart';
part 'comment_item.replies.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentItem item;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onReply;
  final bool showRepliesPreview;
  final VoidCallback? onTapReplies;
  final ValueChanged<int>? onTapUser;
  final int? upperMid;

  const CommentItemWidget({
    super.key,
    required this.item,
    this.onLike,
    this.onDislike,
    this.onReply,
    this.showRepliesPreview = true,
    this.onTapReplies,
    this.onTapUser,
    this.upperMid,
  });

  void _handleTapUser() {
    final mid = int.tryParse(item.member.mid);
    if (mid == null || mid <= 0) {
      return;
    }
    onTapUser?.call(mid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(url: item.member.avatar, size: 38, onTap: _handleTapUser),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  member: item.member,
                  upperMid: upperMid,
                  onTapUser: _handleTapUser,
                ),
                const SizedBox(height: 6),
                _Content(content: item.content, item: item),
                const SizedBox(height: 8),
                _Footer(
                  item: item,
                  onLike: onLike,
                  onDislike: onDislike,
                  onReply: onReply,
                ),
                if (showRepliesPreview && item.replies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _Replies(
                    replies: item.replies,
                    rcount: item.rcount,
                    onTap: onTapReplies,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
