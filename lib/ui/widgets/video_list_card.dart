import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/video_card.dart';
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
  final Widget? leading; // Custom leading widget (overrides coverUrl/VideoThumbnail)
  final Widget? trailing; // Custom trailing widget

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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VideoCardContainer(
      onTap: onTap,
      child: Padding(
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
                        viewCount: viewCount,
                        danmakuCount: danmakuCount,
                        borderRadius: 8,
                        aspectRatio: aspectRatio,
                        width: thumbnailWidth,
                        height: thumbnailWidth / aspectRatio,
                      ),
                      if (overlay != null) overlay!,
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
                      if (stats != null && stats!.isNotEmpty)
                        const SizedBox(height: 2),
                    ],
                    if (stats != null && stats!.isNotEmpty)
                      Row(
                        children: [
                          for (int i = 0; i < stats!.length; i++) ...[
                            if (i > 0) const SizedBox(width: 12),
                            stats![i],
                          ],
                        ],
                      ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
