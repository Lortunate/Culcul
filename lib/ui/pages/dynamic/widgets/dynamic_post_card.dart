import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/data/models/dynamic/dynamic_view_models.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_content_widget.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class DynamicPostCard extends StatelessWidget {
  final DynamicItem post;
  final Function(DynamicItem)? onLike;

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
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 4,
          ),
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
                    color:
                        post.authorName == '哔哩哔哩番剧' ||
                            post.authorName == '哔哩哔哩漫画'
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  post.timeText,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
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
            t.moments.actions.forward,
            () async {
              await ShareUtils.shareDynamic(post.id, post.description ?? '');
            },
          ),
        ),
        Expanded(
          child: _buildStat(
            context,
            Icons.chat_bubble_outline_rounded,
            post.commentCount,
            t.moments.actions.comment,
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
            t.moments.actions.like,
            () {
              if (onLike != null) {
                onLike!(post);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(t.moments.like_coming_soon)));
              }
            },
            color: post.isLiked ? Theme.of(context).colorScheme.primary : null,
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
    final contentColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: contentColor),
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
    return FormatUtils.formatNumber(count);
  }
}
