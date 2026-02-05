import 'package:culcul/core/router/router.dart';
import 'package:culcul/domain/entities/dynamic_post.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_content_widget.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:culcul/utils/share_utils.dart';
import 'package:flutter/material.dart';

class DynamicPostCard extends StatelessWidget {
  final DynamicPost post;
  final Function(DynamicPost)? onLike;

  const DynamicPostCard({super.key, required this.post, this.onLike});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            width: 8,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          DynamicDetailRoute(id: post.id).push(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              DynamicContentWidget(post: post),
              const SizedBox(height: 8),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: () {
        UserProfileRoute(mid: post.authorMid).push(context);
      },
      child: Row(
        children: [
          AppAvatar(url: post.authorAvatar, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.authorName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: post.authorName == '哔哩哔哩番剧' || post.authorName == '哔哩哔哩漫画' 
                        ? const Color(0xFFFB7299) 
                        : colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  post.timeText,
                  style: const TextStyle(
                    color: Color(0xFF9499A0),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 20, color: Color(0xFF9499A0)),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStat(
            context, 
            Icons.reply_rounded, 
            post.forwardCount, 
            '转发', 
            () async {
              await ShareUtils.shareDynamic(post.id, post.description ?? '');
            }
          ),
        ),
        Expanded(
          child: _buildStat(
            context,
            Icons.chat_bubble_outline_rounded,
            post.commentCount,
            '评论',
            () {
              DynamicDetailRoute(id: post.id).push(context);
            },
          ),
        ),
        Expanded(
          child: _buildStat(
            context,
            post.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
            post.likeCount,
            '点赞',
            () {
              if (onLike != null) {
                onLike!(post);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('点赞功能开发中')),
                );
              }
            },
            color: post.isLiked ? const Color(0xFFFB7299) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildStat(
    BuildContext context,
    IconData icon,
    int count,
    String defaultText,
    VoidCallback onTap, {
    Color? color,
  }) {
    final contentColor = color ?? const Color(0xFF9499A0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: contentColor,
            ),
            const SizedBox(width: 6),
            Text(
              count > 0 ? _formatCount(count) : defaultText,
              style: TextStyle(
                fontSize: 13,
                color: contentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count > 10000) {
      return '${(count / 10000).toStringAsFixed(1)}万';
    }
    return count.toString();
  }
}
