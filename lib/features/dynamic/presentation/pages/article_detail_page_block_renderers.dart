part of 'article_detail_page.dart';

class _ParagraphBlockView extends StatefulWidget {
  final ArticleBlock block;

  const _ParagraphBlockView({required this.block});

  @override
  State<_ParagraphBlockView> createState() => _ParagraphBlockViewState();
}

class _ParagraphBlockViewState extends State<_ParagraphBlockView> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    final spans = widget.block.nodes.map((node) {
      final style =
          theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            fontSize: node.fontSize ?? widget.block.fontSize ?? 16,
            fontWeight: node.bold || widget.block.bold
                ? FontWeight.w600
                : FontWeight.w400,
            fontStyle: node.italic ? FontStyle.italic : FontStyle.normal,
            color: _parseColor(node.color) ?? colorScheme.onSurface,
            decoration: node.linkUrl != null
                ? TextDecoration.underline
                : TextDecoration.none,
          ) ??
          TextStyle(
            height: 1.6,
            fontSize: node.fontSize ?? widget.block.fontSize ?? 16,
            fontWeight: node.bold || widget.block.bold
                ? FontWeight.w600
                : FontWeight.w400,
            fontStyle: node.italic ? FontStyle.italic : FontStyle.normal,
            color: _parseColor(node.color) ?? colorScheme.onSurface,
            decoration: node.linkUrl != null
                ? TextDecoration.underline
                : TextDecoration.none,
          );

      final normalizedText = _normalizeBlockText(node.text);
      if (node.linkUrl == null || node.linkUrl!.isEmpty) {
        return TextSpan(text: normalizedText, style: style);
      }

      final recognizer = TapGestureRecognizer()
        ..onTap = () => DynamicNavigation.open(context, url: node.linkUrl!);
      _recognizers.add(recognizer);
      return TextSpan(text: normalizedText, style: style, recognizer: recognizer);
    }).toList();

    return Align(
      alignment: _alignToAlignment(widget.block.align),
      child: Text.rich(
        TextSpan(children: spans),
        textAlign: _toTextAlign(widget.block.align),
      ),
    );
  }

  Alignment _alignToAlignment(ArticleTextAlign? align) {
    switch (align) {
      case ArticleTextAlign.center:
        return Alignment.center;
      case ArticleTextAlign.end:
        return Alignment.centerRight;
      case ArticleTextAlign.start:
      case null:
        return Alignment.centerLeft;
    }
  }

  TextAlign _toTextAlign(ArticleTextAlign? align) {
    return switch (align) {
      ArticleTextAlign.center => TextAlign.center,
      ArticleTextAlign.end => TextAlign.end,
      ArticleTextAlign.start || null => TextAlign.start,
    };
  }
}

class _ImageBlockView extends StatelessWidget {
  final ArticleBlock block;
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
          GestureDetector(
            onTap: () => onTap(i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AppNetworkImage(url: urls[i], fit: BoxFit.cover, borderRadius: 14),
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
  final ArticleBlock block;
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
                      block.title ?? '链接卡片',
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
  final ArticleBlock block;

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

bool _hasVisibleText(String value) {
  return value.replaceAll(RegExp(r'\s+'), '').isNotEmpty;
}

String _normalizeBlockText(String value) {
  return value.replaceAll(RegExp(r'\n{3,}'), '\n\n');
}

Color? _parseColor(String? color) {
  if (color == null || color.isEmpty) return null;
  if (color.startsWith('#')) {
    final hex = color.substring(1);
    try {
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      }
      if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    } on FormatException {
      return null;
    }
  }
  return null;
}

