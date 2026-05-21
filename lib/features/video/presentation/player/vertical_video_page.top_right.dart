part of 'vertical_video_page.dart';

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = context.t;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: context.pop,
            child: Icon(Icons.arrow_back_ios_new, color: colorScheme.onPrimary, size: 20),
          ),
          const SizedBox(width: 8),
          Text(
            t.video.watching_count(count: '12'),
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Icon(Icons.search, color: colorScheme.onPrimary, size: 24),
          const SizedBox(width: 16),
          Icon(Icons.more_vert, color: colorScheme.onPrimary, size: 24),
        ],
      ),
    );
  }
}

class _RightBar extends StatelessWidget {
  const _RightBar({required this.videoDetail});

  final VideoDetailViewData videoDetail;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final actions = <_VideoAction>[
      (icon: Icons.thumb_up_rounded, count: videoDetail.stat.like, label: t.actions.like),
      (
        icon: Icons.comment_rounded,
        count: videoDetail.stat.reply,
        label: t.actions.reply,
      ),
      (icon: Icons.thumb_down_alt_rounded, count: 438, label: t.actions.unlike),
      (
        icon: Icons.star_rounded,
        count: videoDetail.stat.favorite,
        label: t.video.actions.favorite,
      ),
      (icon: Icons.share_rounded, count: videoDetail.stat.share, label: t.actions.share),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < actions.length; index++) ...[
          _RightActionItem(action: actions[index]),
          if (index != actions.length - 1) const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _RightActionItem extends StatelessWidget {
  const _RightActionItem({required this.action});

  final _VideoAction action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(action.icon, color: colorScheme.onPrimary, size: 32),
        const SizedBox(height: 4),
        Text(
          FormatUtils.formatNumber(action.count),
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
