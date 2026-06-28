import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_share.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_comment_composer.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DynamicDetailBottomBar extends StatelessWidget {
  final DynamicItem post;
  final VoidCallback onLike;
  final VoidCallback onSubmitComment;
  final TextEditingController commentController;
  final bool isSending;

  const DynamicDetailBottomBar({
    super.key,
    required this.post,
    required this.onLike,
    required this.onSubmitComment,
    required this.commentController,
    this.isSending = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final likeColor = post.isLiked ? colorScheme.primary : colorScheme.onSurfaceVariant;
    final shareColor = colorScheme.onSurfaceVariant;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: DynamicCommentComposer(
              controller: commentController,
              isSending: isSending,
              onSend: onSubmitComment,
              hintText: t.moments.comment_hint,
              height: 36,
              radius: 18,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onLike,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  post.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                  size: 24,
                  color: likeColor,
                ),
                if (post.likeCount > 0)
                  Text(
                    '${post.likeCount}',
                    style: TextStyle(fontSize: 10, color: likeColor),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () =>
                shareDynamicItem(dynamicId: post.id, content: post.contentText ?? ''),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.reply_rounded, size: 24, color: shareColor),
                if (post.forwardCount > 0)
                  Text(
                    '${post.forwardCount}',
                    style: TextStyle(fontSize: 10, color: shareColor),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
