import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/presentation/utils/dynamic_navigation.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          bottom: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
        ),
      ),
      child: InkWell(
        onTap: () {
          DynamicDetailRoute(id: post.id).push(context);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              DynamicContentWidget(post: post),
              const SizedBox(height: 12),
              Divider(
                height: 1,
                thickness: 0.5,
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
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
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          AppAvatar(url: post.authorAvatar, size: 40),
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
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  post.timeText,
                  style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_horiz_rounded,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () => _showMoreActions(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
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
            t.actions.forward,
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
            t.actions.comment,
            () {
              DynamicDetailRoute(id: post.id).push(context);
            },
          ),
        ),
        Expanded(
          child: _buildStat(
            context,
            post.isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
            post.likeCount,
            t.actions.like,
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
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: contentColor),
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

  Future<void> _showMoreActions(BuildContext context) async {
    final link = 'https://t.bilibili.com/${post.id}';
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('分享动态'),
              onTap: () => Navigator.pop(context, 'share'),
            ),
            ListTile(
              leading: const Icon(Icons.copy_all_rounded),
              title: const Text('复制链接'),
              onTap: () => Navigator.pop(context, 'copy'),
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser_rounded),
              title: const Text('浏览器打开'),
              onTap: () => Navigator.pop(context, 'open'),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted) return;

    switch (action) {
      case 'share':
        await ShareUtils.shareDynamic(post.id, post.contentText ?? '');
        break;
      case 'copy':
        await Clipboard.setData(ClipboardData(text: link));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('已复制动态链接')));
        }
        break;
      case 'open':
        await DynamicNavigation.open(context, url: link);
        break;
      default:
        break;
    }
  }
}
