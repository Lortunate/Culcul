import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/app_card_container.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
import 'package:culcul/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

class VideoListCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final int? duration;
  final int? viewCount;
  final int? danmakuCount;
  final Widget? author;
  final Widget? badge; // E.g. Rank badge on image or Tag below title
  final List<Widget>? stats;
  final VoidCallback? onTap;
  final double thumbnailWidth;
  final double aspectRatio;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget? overlay; // Overlay on thumbnail (e.g. Rank)
  final Widget? middleContent; // Between title and footer
  final Widget?
  leading; // Custom leading widget (overrides coverUrl/VideoThumbnail)
  final Widget? trailing; // Custom trailing widget
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
    final theme = Theme.of(context);
    final overlayWidget = overlay;
    final statsWidgets = <Widget>[
      if (stats != null)
        ...stats!
      else if (showDefaultStats) ...[
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
      ],
    ];

    final content = Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null)
              leading!
            else
              SizedBox(
                width: thumbnailWidth,
                child: Stack(
                  children: [
                    VideoThumbnail(
                      url: coverUrl,
                      duration: duration ?? 0,
                      // Don't show stats on thumbnail in list view to avoid duplication
                      viewCount: null,
                      danmakuCount: null,
                      borderRadius: 8,
                      aspectRatio: aspectRatio,
                      width: thumbnailWidth,
                      height: thumbnailWidth / aspectRatio,
                    ),
                    if (overlayWidget != null) overlayWidget,
                  ],
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
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
                  if (middleContent != null) ...[
                    const SizedBox(height: 4),
                    middleContent!,
                  ],
                  const Spacer(),
                  if (author != null) ...[
                    author!,
                    if (statsWidgets.isNotEmpty) const SizedBox(height: 2),
                  ],
                  if (statsWidgets.isNotEmpty)
                    Row(
                      children: [
                        for (int i = 0; i < statsWidgets.length; i++) ...[
                          if (i > 0) const SizedBox(width: 12),
                          statsWidgets[i],
                        ],
                      ],
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          ],
        ),
      ),
    );

    if (flat) {
      return AppClickable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: content,
      );
    }

    return AppCardContainer(
      onTap: onTap,
      onLongPress: onLongPress,
      child: content,
    );
  }
}

