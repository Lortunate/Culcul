part of 'article_detail_page.dart';

class _AuthorHeader extends StatelessWidget {
  final ArticleDetailData data;

  const _AuthorHeader({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.surfaceContainerHighest,
          backgroundImage: data.authorAvatar.isNotEmpty
              ? AppNetworkImage.providerFor(url: data.authorAvatar)
              : null,
          child: data.authorAvatar.isEmpty
              ? Icon(Icons.person_rounded, color: colorScheme.onSurfaceVariant)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.authorName.isNotEmpty ? data.authorName : 'Bilibili',
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 3),
              Text(
                data.publishTime > 0
                    ? FormatUtils.formatTimeAgo(data.publishTime)
                    : Translations.of(context).moments.detail_title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final ArticleDetailData data;

  const _StatsRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatChip(
              icon: Icons.star_border_rounded,
              label: FormatUtils.formatAnyNumber(data.stats.favorite),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: colorScheme.outlineVariant.withValues(alpha: 0.35),
          ),
          Expanded(
            child: _StatChip(
              icon: Icons.thumb_up_outlined,
              label: FormatUtils.formatAnyNumber(data.stats.like),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
