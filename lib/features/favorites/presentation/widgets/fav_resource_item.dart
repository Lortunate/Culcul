import 'package:culcul/shared/utils/format_utils.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/shared/widgets/icon_text.dart';
import 'package:culcul/shared/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class FavResourceItem extends StatelessWidget {
  final FavoriteResource item;
  final VoidCallback? onTap;

  const FavResourceItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTextStyle.merge(
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      child: VideoListCard(
        onTap: onTap,
        coverUrl: item.cover,
        title: item.title,
        duration: item.duration,
        thumbnailWidth: 160,
        aspectRatio: 16 / 9,
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        middleContent: Row(
          children: [
            Expanded(
              child: Text(
                item.upper.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: More actions
              },
              child: Icon(Icons.more_vert, size: 16, color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        stats: [
          IconText(
            icon: Icons.play_circle_outline,
            text: FormatUtils.formatNumber(item.stats.play),
            iconSize: 14,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
          IconText(
            icon: Icons.comment_outlined,
            text: FormatUtils.formatNumber(item.stats.danmaku),
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
