part of 'article_detail_page.dart';

class _ParagraphBlockView extends StatefulWidget {
  final ArticleBlockParagraph block;

  const _ParagraphBlockView({required this.block});

  @override
  State<_ParagraphBlockView> createState() => _ParagraphBlockViewState();
}

class _ParagraphBlockViewState extends State<_ParagraphBlockView> {
  final Map<int, TapGestureRecognizer> _recognizers = <int, TapGestureRecognizer>{};

  @override
  void initState() {
    super.initState();
    _syncRecognizers();
  }

  @override
  void didUpdateWidget(covariant _ParagraphBlockView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncRecognizers();
  }

  @override
  void dispose() {
    for (final recognizer in _recognizers.values) {
      recognizer.dispose();
    }
    super.dispose();
  }

  void _syncRecognizers() {
    final activeIndexes = <int>{};

    for (var index = 0; index < widget.block.nodes.length; index++) {
      final node = widget.block.nodes[index];
      final linkUrl = node.linkUrl;
      if (linkUrl == null || linkUrl.isEmpty) {
        continue;
      }

      activeIndexes.add(index);
      final recognizer = _recognizers[index] ??= TapGestureRecognizer(debugOwner: this);
      recognizer.onTap = () => DynamicNavigation.open(context, url: linkUrl);
    }

    final removedIndexes = _recognizers.keys
        .where((index) => !activeIndexes.contains(index))
        .toList();
    for (final index in removedIndexes) {
      _recognizers.remove(index)?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spans = widget.block.nodes.indexed.map((entry) {
      final (index, node) = entry;
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

      final recognizer = _recognizers[index];
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
