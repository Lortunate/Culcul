part of '../video_list_card.dart';

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

