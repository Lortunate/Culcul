import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/ranking/data/models/ranking_video.dart';
import 'package:culcul/features/ranking/presentation/widgets/rank_badge.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class RankingItemCard extends StatelessWidget {
  final RankingVideo video;
  final int rank;

  const RankingItemCard({required this.video, required this.rank, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return VideoListCard(
      // Standard list item padding
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
      coverUrl: video.coverUrl,
      title: video.title,
      duration: video.duration,
      thumbnailWidth: 140,
      aspectRatio: 140 / 88,
      height: 88,
      // Rank Badge on top-left of the thumbnail
      overlay: Positioned(top: 0, left: 0, child: RankBadge(rank: rank)),
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
              video.ownerName,
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
          text: FormatUtils.formatNumber(video.viewCount),
        ),
        IconText(
          icon: Icons.list_alt_rounded,
          text: FormatUtils.formatNumber(video.danmakuCount),
        ),
      ],
    );
  }
}
