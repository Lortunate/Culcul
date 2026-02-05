import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/index.dart';

import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class PopularVideoCard extends StatelessWidget {
  final VideoModel video;
  final VoidCallback? onTap;

  const PopularVideoCard({super.key, required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return VideoListCard(
      onTap: onTap,
      height: 100,
      thumbnailWidth: 160,
      coverUrl: video.pic,
      title: video.title,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      badge: video.rcmd_reason.isNotEmpty
          ? _PopularTag(text: video.rcmd_reason)
          : null,
      author: Row(
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 14,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              video.owner.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      stats: [
        IconText(
          icon: Icons.play_circle_outline_rounded,
          text: FormatUtils.formatNumber(video.stat.view),
        ),
        IconText(
          icon: Icons.list_alt_rounded,
          text: FormatUtils.formatNumber(video.stat.danmaku),
        ),
      ],
    );
  }
}

class _PopularTag extends StatelessWidget {
  final String text;

  const _PopularTag({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMillion = text.contains('百万');

    return AppTag(
      text: text,
      color: isMillion
          ? colorScheme.primary.withValues(alpha: 0.1)
          : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      textColor: isMillion ? colorScheme.primary : colorScheme.onSurfaceVariant,
      fontSize: 10,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      borderRadius: 6,
    );
  }
}
