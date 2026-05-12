part of 'article_detail_page.dart';

class _ImageBlockView extends StatelessWidget {
  final ArticleBlockImage block;
  final void Function(int index) onTap;

  const _ImageBlockView({required this.block, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final urls = block.imageUrls.where((e) => e.isNotEmpty).toList();
    if (urls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < urls.length; i++) ...[
          RepaintBoundary(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AppNetworkImage(
                  url: urls[i],
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          if (i < urls.length - 1) const SizedBox(height: 10),
        ],
        if (block.caption != null && block.caption!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            block.caption!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _LinkCardView extends StatelessWidget {
  final ArticleBlockLinkCard block;
  final VoidCallback? onTap;

  const _LinkCardView({required this.block, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.link_rounded, color: colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      block.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (block.subtitle != null && block.subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        block.subtitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteBlockView extends StatelessWidget {
  final ArticleBlockQuote block;

  const _QuoteBlockView({required this.block});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: colorScheme.primary, width: 3)),
      ),
      child: Text.rich(
        TextSpan(
          children: block.nodes
              .map(
                (node) => TextSpan(
                  text: node.text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.55,
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
