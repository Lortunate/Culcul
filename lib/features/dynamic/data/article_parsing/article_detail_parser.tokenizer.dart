part of 'article_detail_parser.dart';

List<ArticleBlock> _parseHtmlContent(String htmlContent) {
  if (htmlContent.trim().isEmpty) return const [];

  final root = html_parser.parseFragment(htmlContent);
  final blocks = <ArticleBlock>[];
  for (final node in root.nodes) {
    blocks.addAll(_parseHtmlNode(node));
  }
  return blocks;
}

List<ArticleBlock> _parseHtmlNode(html_dom.Node node) {
  if (node is html_dom.Text) {
    final text = node.text.trim();
    if (text.isEmpty) return const [];
    return [
      ArticleBlock.paragraph(nodes: [ArticleInlineNode(text: text)]),
    ];
  }

  if (node is! html_dom.Element) return const [];
  final tag = node.localName?.toLowerCase() ?? '';

  switch (tag) {
    case 'p':
      final nodes = _parseHtmlInlineNodes(node.nodes);
      if (nodes.isEmpty) return const [];
      return [
        ArticleBlock.paragraph(
          nodes: nodes,
          align: _parseTextAlign(node.attributes['style']),
        ),
      ];
    case 'h1':
    case 'h2':
    case 'h3':
    case 'h4':
    case 'h5':
    case 'h6':
      final nodes = _parseHtmlInlineNodes(node.nodes, forceBold: true);
      final level = int.tryParse(tag.substring(1)) ?? 1;
      return [
        ArticleBlock.paragraph(
          nodes: nodes,
          fontSize: switch (level) {
            1 => 22,
            2 => 20,
            3 => 18,
            _ => 17,
          },
          bold: true,
        ),
      ];
    case 'figure':
      final imageUrl = _extractImageUrl(node);
      if (imageUrl != null) {
        return [
          ArticleBlock.image(imageUrls: [imageUrl], caption: _extractFigureCaption(node)),
        ];
      }
      return _parseHtmlChildren(node);
    case 'img':
      final imageUrl = _string(node.attributes['src']);
      if (imageUrl == null || imageUrl.isEmpty) return const [];
      return [
        ArticleBlock.image(imageUrls: [_normalizeUrl(imageUrl)]),
      ];
    case 'blockquote':
      final nodes = _parseHtmlInlineNodes(node.nodes);
      if (nodes.isEmpty) return const [];
      return [ArticleBlock.quote(nodes: nodes)];
    case 'hr':
      return [const ArticleBlock.divider()];
    case 'ul':
    case 'ol':
      final listBlocks = <ArticleBlock>[];
      for (final child in node.children.where((e) => e.localName == 'li')) {
        final nodes = _parseHtmlInlineNodes(child.nodes);
        if (nodes.isEmpty) continue;
        final bulletPrefix = tag == 'ol' ? '${listBlocks.length + 1}. ' : '• ';
        listBlocks.add(
          ArticleBlock.paragraph(
            nodes: [
              ArticleInlineNode(text: bulletPrefix),
              ...nodes,
            ],
          ),
        );
      }
      return listBlocks;
    default:
      return _parseHtmlChildren(node);
  }
}

List<ArticleBlock> _parseHtmlChildren(html_dom.Element node) {
  final blocks = <ArticleBlock>[];
  for (final child in node.nodes) {
    blocks.addAll(_parseHtmlNode(child));
  }
  return blocks;
}

List<ArticleInlineNode> _parseHtmlInlineNodes(
  List<html_dom.Node> nodes, {
  bool forceBold = false,
}) {
  final spans = <ArticleInlineNode>[];
  for (final node in nodes) {
    spans.addAll(_parseHtmlInlineNode(node, forceBold: forceBold));
  }
  return spans;
}

List<ArticleInlineNode> _parseHtmlInlineNode(
  html_dom.Node node, {
  bool forceBold = false,
}) {
  if (node is html_dom.Text) {
    final text = node.text;
    if (text.isEmpty) return const [];
    return [ArticleInlineNode(text: text)];
  }

  if (node is! html_dom.Element) return const [];
  final tag = node.localName?.toLowerCase() ?? '';

  if (tag == 'br') {
    return [const ArticleInlineNode(text: '\n')];
  }

  final baseChildren = node.nodes.isNotEmpty
      ? _parseHtmlInlineNodes(node.nodes, forceBold: forceBold)
      : [ArticleInlineNode(text: node.text)];

  switch (tag) {
    case 'a':
      final href = _normalizeUrl(node.attributes['href'] ?? '');
      return baseChildren
          .map((e) => e.copyWith(linkUrl: href, color: e.color ?? '#1E80FF'))
          .toList();
    case 'strong':
    case 'b':
      return baseChildren.map((e) => e.copyWith(bold: true)).toList();
    case 'em':
    case 'i':
      return baseChildren.map((e) => e.copyWith(italic: true)).toList();
    case 'span':
      return baseChildren
          .map(
            (e) => e.copyWith(
              color: _extractHtmlColor(node) ?? e.color,
              fontSize: _extractFontSize(node) ?? e.fontSize,
              bold: forceBold || e.bold,
            ),
          )
          .toList();
    default:
      return baseChildren
          .map(
            (e) => e.copyWith(
              color: _extractHtmlColor(node) ?? e.color,
              fontSize: _extractFontSize(node) ?? e.fontSize,
              bold: forceBold || e.bold,
            ),
          )
          .toList();
  }
}
