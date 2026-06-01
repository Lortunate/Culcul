import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card_dimensions.dart';
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
      overlay: Positioned(top: 0, left: 0, child: _RankBadge(rank: rank)),
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

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  static const _shadowOffset = Offset(0, 2);
  static const _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = _RankBadgeStyle.resolve(rank, colorScheme);

    return Container(
      width: style.size,
      height: style.size,
      alignment: Alignment.center,
      decoration: style.decoration,
      child: Text(
        '$rank',
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: style.fontSize,
          fontStyle: FontStyle.italic,
          height: 1,
        ),
      ),
    );
  }
}

class _RankBadgeStyle {
  const _RankBadgeStyle({
    required this.size,
    required this.fontSize,
    required this.decoration,
  });

  final double size;
  final double fontSize;
  final BoxDecoration decoration;

  static _RankBadgeStyle resolve(int rank, ColorScheme colorScheme) {
    return switch (rank) {
      1 => _buildTopStyle(colorScheme.error),
      2 => _buildTopStyle(colorScheme.tertiary),
      3 => _buildTopStyle(colorScheme.primary),
      _ => _RankBadgeStyle(
        size: 20,
        fontSize: 12,
        decoration: BoxDecoration(
          color: colorScheme.scrim.withValues(alpha: 0.4),
          borderRadius: _RankBadge._borderRadius,
        ),
      ),
    };
  }

  static _RankBadgeStyle _buildTopStyle(Color baseColor) {
    return _RankBadgeStyle(
      size: 24,
      fontSize: 14,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [baseColor, baseColor.withValues(alpha: 0.78)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: _RankBadge._borderRadius,
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: _RankBadge._shadowOffset,
          ),
        ],
      ),
    );
  }
}
