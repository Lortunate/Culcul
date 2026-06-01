import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/ui/widgets/buttons/app_tag.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:flutter/material.dart';

class PopularVideoCard extends StatelessWidget {
  final VideoModel video;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double cardHeight;
  final double thumbnailWidth;

  const PopularVideoCard({
    super.key,
    required this.video,
    this.onTap,
    this.onLongPress,
    this.cardHeight = 100,
    this.thumbnailWidth = 160,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final rcmdReason = video.rcmdReason;
    final isMillion = rcmdReason.contains('M');

    return RepaintBoundary(
      child: VideoListCard(
        onTap: onTap,
        padding: const EdgeInsets.all(10),
        onLongPress: onLongPress,
        height: cardHeight,
        thumbnailWidth: thumbnailWidth,
        coverUrl: video.pic,
        title: video.title,
        duration: video.duration,
        viewCount: video.stat.view,
        danmakuCount: video.stat.danmaku,
        badge: rcmdReason.isNotEmpty
            ? AppTag(
                text: rcmdReason,
                color: isMillion
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                textColor: isMillion ? colorScheme.primary : colorScheme.onSurfaceVariant,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                borderRadius: 6,
              )
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
        showDefaultStats: true,
      ),
    );
  }
}
