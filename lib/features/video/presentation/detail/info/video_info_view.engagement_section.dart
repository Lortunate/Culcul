part of 'video_info_view.dart';

class _VideoInfoEngagementSection extends StatelessWidget {
  final VideoDetailViewData detail;
  final int currentCid;
  final bool hasRecommendations;
  final VoidCallback onLike;
  final VoidCallback onCoin;
  final ValueChanged<int> onPartChanged;

  const _VideoInfoEngagementSection({
    required this.detail,
    required this.currentCid,
    required this.hasRecommendations,
    required this.onLike,
    required this.onCoin,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        VideoActionsRow(detail: detail, onLike: onLike, onCoin: onCoin),
        const SizedBox(height: 8),
        if (detail.pages.length > 1) ...[
          VideoPartsSection(
            pages: detail.pages,
            currentCid: currentCid,
            onPartChanged: onPartChanged,
          ),
          const SizedBox(height: 10),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: VideoCollectionSummary(
            label: t.video.parts,
            title: detail.title,
            pageCount: detail.pages.length,
          ),
        ),
        const SizedBox(height: 14),
        Divider(
          height: 1,
          thickness: 0.5,
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
        if (hasRecommendations)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Text(
              t.video.recommend,
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}
