part of '../video_list_card.dart';

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
