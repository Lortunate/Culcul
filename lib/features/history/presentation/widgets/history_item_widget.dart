import 'package:flutter/material.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:culcul/ui/assemblies/feed_cards/feed_cards.dart';

class HistoryItemWidget extends StatelessWidget {
  final HistoryEntry item;
  final VoidCallback? onTap;

  const HistoryItemWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progressColor = colorScheme.primary;

    return DefaultTextStyle.merge(
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      child: VideoListCard(
        onTap: onTap,
        coverUrl: item.coverUrl,
        title: item.title,
        // Hide default duration badge if showing progress bar
        duration: (item.progress > 0) ? 0 : item.duration,
        thumbnailWidth: 160,
        aspectRatio: 16 / 9,
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        overlay: (item.progress > 0 && item.duration > 0)
            ? Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: item.progress / item.duration,
                  minHeight: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              )
            : null,
        middleContent: Text(
          item.authorName,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        stats: [
          if (item.badge.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.primary, width: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                item.badge,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 10,
                ),
              ),
            ),
          IconText(
            icon: Icons.access_time_rounded,
            text: FormatUtils.formatTimeAgo(item.viewedAt),
            iconSize: 14,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
