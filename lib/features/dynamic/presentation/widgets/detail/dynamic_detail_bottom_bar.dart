import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:flutter/material.dart';

class DynamicDetailBottomBar extends StatelessWidget {
  final DynamicItem post;
  final VoidCallback onLike;
  final VoidCallback onSubmitComment;
  final TextEditingController commentController;

  const DynamicDetailBottomBar({
    super.key,
    required this.post,
    required this.onLike,
    required this.onSubmitComment,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8 + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: '发一条友善的评论',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSubmitComment(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSubmitComment,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          _buildActionIcon(
            context,
            post.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
            post.likeCount,
            onLike,
            color: post.isLiked
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          const SizedBox(width: 16),
          _buildActionIcon(
            context,
            Icons.reply_rounded,
            post.forwardCount,
            () => ShareUtils.shareDynamic(post.id, post.description ?? ''),
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
