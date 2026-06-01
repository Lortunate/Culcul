import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_thumbnail.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';

class VideoListCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final int? duration;
  final int? viewCount;
  final int? danmakuCount;
  final Widget? author;
  final Widget? badge;
  final List<Widget>? stats;
  final VoidCallback? onTap;
  final double thumbnailWidth;
  final double aspectRatio;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget? overlay;
  final Widget? middleContent;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onLongPress;
  final bool showDefaultStats;
  final bool flat;

  const VideoListCard({
    super.key,
    required this.coverUrl,
    required this.title,
    this.duration,
    this.viewCount,
    this.danmakuCount,
    this.author,
    this.badge,
    this.stats,
    this.onTap,
    this.thumbnailWidth = 160,
    this.aspectRatio = 16 / 10,
    this.height = 100,
    this.padding = const EdgeInsets.all(12),
    this.overlay,
    this.middleContent,
    this.leading,
    this.trailing,
    this.onLongPress,
    this.showDefaultStats = false,
    this.flat = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = _VideoListCardBody(
      coverUrl: coverUrl,
      title: title,
      duration: duration,
      viewCount: viewCount,
      danmakuCount: danmakuCount,
      author: author,
      badge: badge,
      stats: stats,
      thumbnailWidth: thumbnailWidth,
      aspectRatio: aspectRatio,
      height: height,
      padding: padding,
      overlay: overlay,
      middleContent: middleContent,
      leading: leading,
      trailing: trailing,
      showDefaultStats: showDefaultStats,
    );

    if (flat) {
      return AppClickable(onTap: onTap, onLongPress: onLongPress, child: content);
    }

    return AppCardContainer(onTap: onTap, onLongPress: onLongPress, child: content);
  }
}

class _VideoListCardBody extends StatelessWidget {
  final String coverUrl;
  final String title;
  final int? duration;
  final int? viewCount;
  final int? danmakuCount;
  final Widget? author;
  final Widget? badge;
  final List<Widget>? stats;
  final double thumbnailWidth;
  final double aspectRatio;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget? overlay;
  final Widget? middleContent;
  final Widget? leading;
  final Widget? trailing;
  final bool showDefaultStats;

  const _VideoListCardBody({
    required this.coverUrl,
    required this.title,
    required this.duration,
    required this.viewCount,
    required this.danmakuCount,
    required this.author,
    required this.badge,
    required this.stats,
    required this.thumbnailWidth,
    required this.aspectRatio,
    required this.height,
    required this.padding,
    required this.overlay,
    required this.middleContent,
    required this.leading,
    required this.trailing,
    required this.showDefaultStats,
  });

  List<Widget> get _resolvedStats {
    if (stats != null) {
      return stats!;
    }
    if (!showDefaultStats) {
      return const [];
    }

    return [
      if (viewCount != null)
        IconText(
          icon: Icons.play_circle_outline_rounded,
          text: FormatUtils.formatNumber(viewCount!),
        ),
      if (danmakuCount != null)
        IconText(
          icon: Icons.list_alt_rounded,
          text: FormatUtils.formatNumber(danmakuCount!),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _VideoListCardMedia(
              leading: leading,
              coverUrl: coverUrl,
              duration: duration,
              overlay: overlay,
              thumbnailWidth: thumbnailWidth,
              aspectRatio: aspectRatio,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _VideoListCardContent(
                title: title,
                badge: badge,
                middleContent: middleContent,
                author: author,
                stats: _resolvedStats,
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          ],
        ),
      ),
    );
  }
}

class _VideoListCardMedia extends StatelessWidget {
  final Widget? leading;
  final String coverUrl;
  final int? duration;
  final Widget? overlay;
  final double thumbnailWidth;
  final double aspectRatio;

  const _VideoListCardMedia({
    required this.leading,
    required this.coverUrl,
    required this.duration,
    required this.overlay,
    required this.thumbnailWidth,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    if (leading != null) {
      return leading!;
    }

    return SizedBox(
      width: thumbnailWidth,
      child: Stack(
        children: [
          VideoThumbnail(
            url: coverUrl,
            duration: duration ?? 0,
            aspectRatio: aspectRatio,
            width: thumbnailWidth,
            height: thumbnailWidth / aspectRatio,
          ),
          ?overlay,
        ],
      ),
    );
  }
}

class _VideoListCardContent extends StatelessWidget {
  final String title;
  final Widget? badge;
  final Widget? middleContent;
  final Widget? author;
  final List<Widget> stats;

  const _VideoListCardContent({
    required this.title,
    required this.badge,
    required this.middleContent,
    required this.author,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            height: 1.3,
          ),
        ),
        if (badge != null) ...[const SizedBox(height: 4), badge!],
        if (middleContent != null) ...[const SizedBox(height: 4), middleContent!],
        const Spacer(),
        if (author != null) ...[author!, if (stats.isNotEmpty) const SizedBox(height: 2)],
        if (stats.isNotEmpty) _VideoListCardStatsRow(stats: stats),
      ],
    );
  }
}

class _VideoListCardStatsRow extends StatelessWidget {
  final List<Widget> stats;

  const _VideoListCardStatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int index = 0; index < stats.length; index++) ...[
          if (index > 0) const SizedBox(width: 12),
          stats[index],
        ],
      ],
    );
  }
}
