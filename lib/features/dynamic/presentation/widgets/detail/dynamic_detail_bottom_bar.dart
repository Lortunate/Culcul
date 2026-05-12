import 'package:culcul/features/dynamic/domain/entities/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_extension.dart';
import 'package:culcul/core/utils/share_utils.dart';
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
          _buildActionIcon(
            context,
            post.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
            post.likeCount,
            onLike,
            color: post.isLiked ? colorScheme.primary : null,
          ),
          const SizedBox(width: 16),
          _buildActionIcon(
            context,
            Icons.reply_rounded,
            post.forwardCount,
            () => ShareUtils.shareDynamic(post.id, post.contentText ?? ''),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(
    BuildContext context,
    IconData icon,
    int count,
    VoidCallback onTap, {
    Color? color,
  }) {
    final contentColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: contentColor),
          if (count > 0)
            Text('$count', style: TextStyle(fontSize: 10, color: contentColor)),
        ],
      ),
    );
  }
}
