import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/cards/video_list_card.dart';
import 'package:culcul/ui/widgets/cards/video_list_card_dimensions.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';

class RankingItemCard extends StatelessWidget {
  final VideoModel video;
  final int rank;
  final ValueChanged<String> onOpenVideo;

  const RankingItemCard({
    required this.video,
    required this.rank,
    required this.onOpenVideo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const rankBadgeBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    );
    final rankBadgeTopColor = switch (rank) {
      1 => colorScheme.error,
      2 => colorScheme.tertiary,
      3 => colorScheme.primary,
      _ => null,
    };
    final rankBadgeSize = rankBadgeTopColor == null ? 20.0 : 24.0;
    final rankBadgeDecoration = rankBadgeTopColor == null
        ? BoxDecoration(
            color: colorScheme.scrim.withValues(alpha: 0.4),
            borderRadius: rankBadgeBorderRadius,
          )
        : BoxDecoration(
            gradient: LinearGradient(
              colors: [rankBadgeTopColor, rankBadgeTopColor.withValues(alpha: 0.78)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: rankBadgeBorderRadius,
            boxShadow: [
              BoxShadow(
                color: rankBadgeTopColor.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          );

    return VideoListCard(
      // Standard list item padding
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () => onOpenVideo(video.bvid),
      coverUrl: video.pic,
      title: video.title,
      duration: video.duration,
      thumbnailWidth: compactVideoListCardThumbnailWidth,
      aspectRatio: compactVideoListCardThumbnailAspectRatio,
      height: compactVideoListCardThumbnailHeight,
      // Rank Badge on top-left of the thumbnail
      overlay: Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: rankBadgeSize,
          height: rankBadgeSize,
          alignment: Alignment.center,
          decoration: rankBadgeDecoration,
          child: Text(
            '$rank',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: rankBadgeTopColor == null ? 12.0 : 14.0,
              fontStyle: FontStyle.italic,
              height: 1,
            ),
          ),
        ),
      ),
      // Use author slot for UP name
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
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      // Stats: Play count and Danmaku count
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
