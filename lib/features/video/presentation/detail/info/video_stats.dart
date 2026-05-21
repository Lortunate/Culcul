import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';

class VideoStatsRow extends StatelessWidget {
  final VideoDetailViewData detail;
  final bool showBvid;

  const VideoStatsRow({super.key, required this.detail, this.showBvid = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = theme.textTheme.labelSmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final d = DateTime.fromMillisecondsSinceEpoch(detail.pubDate * 1000);
    final date = d.toIsoDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconText(
              icon: Icons.play_circle_outline_rounded,
              text: detail.stat.view.formatNumber,
            ),
            IconText(
              icon: Icons.subtitles_outlined,
              text: detail.stat.danmaku.formatNumber,
            ),
            Text(date, style: style),
          ],
        ),
        if (showBvid) ...[
          const SizedBox(height: 6),
          Text('BV${detail.bvid}', style: style),
        ],
      ],
    );
  }
}
