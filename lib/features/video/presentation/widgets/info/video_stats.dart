import 'package:culcul/data/models/video/video_detail.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
import 'package:flutter/material.dart';

class VideoStatsRow extends StatelessWidget {
  final VideoDetail detail;

  const VideoStatsRow({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = theme.textTheme.labelSmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final d = DateTime.fromMillisecondsSinceEpoch(detail.pubDate * 1000);
    final date = d.toIsoDate();

    return Wrap(
      spacing: 10,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconText(
          icon: Icons.play_circle_outline_rounded,
          text: detail.stat.view.formatNumber,
        ),
        IconText(icon: Icons.list_alt_outlined, text: detail.stat.danmaku.formatNumber),
        Text(date, style: style),
        Text('BV${detail.bvid}', style: style),
      ],
    );
  }
}
