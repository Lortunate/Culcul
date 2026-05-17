part of 'article_detail_parser.dart';

List<ArticleBlock> _parseOpusBlocks(Map<String, dynamic>? moduleContent) {
  if (moduleContent == null) return const [];
  final paragraphs =
      (moduleContent['paragraphs'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
  final blocks = <ArticleBlock>[];

  for (final paragraph in paragraphs) {
    final paraType = _int(paragraph['para_type']) ?? 0;
    switch (paraType) {
      case 1:
        final nodes = (paragraph['text'] as Map?)?.cast<String, dynamic>() ?? const {};
        final inline = _parseOpusInlineNodes(
          (nodes['nodes'] as List?)?.cast<Map<String, dynamic>>() ?? const [],
        );
        if (inline.isNotEmpty) {
          blocks.add(
            ArticleBlock.paragraph(
              nodes: inline,
              align: _parseTextAlign(_asMap(paragraph['format'])['align']?.toString()),
            ),
          );
        }
      case 2:
        final pic = _asMap(paragraph['pic']);
        final pics = (pic['pics'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
        final urls = pics
            .map((e) => _normalizeUrl(_string(e['url']) ?? ''))
            .where((e) => e.isNotEmpty)
            .toList();
        if (urls.isNotEmpty) {
          blocks.add(ArticleBlock.image(imageUrls: urls));
        }
      case 7:
        final card = _asMap(paragraph['link_card'])['card'];
        final cardMap = _asMap(card);
        final bizId = _string(cardMap['biz_id']) ?? '';
        final linkType = _int(cardMap['link_type']);
        blocks.add(
          ArticleBlock.linkCard(
            title: bizId.isNotEmpty ? '链接卡片 #$bizId' : '链接卡片',
            subtitle: linkType != null ? 'link_type $linkType' : null,
          ),
        );
      default:
    }
  }

  return blocks;
}

List<ArticleInlineNode> _parseOpusInlineNodes(List<Map<String, dynamic>> nodes) {
  final spans = <ArticleInlineNode>[];
  for (final node in nodes) {
    final type = _int(node['node_type']) ?? _int(node['type']) ?? 0;
    switch (type) {
      case 1:
        final word = _asMap(node['word']);
        final text = _string(word['words']) ?? '';
        if (text.isEmpty) continue;
        spans.add(
          ArticleInlineNode(
            text: text,
            fontSize: _double(word['font_size']),
            color: _string(word['color']),
          ),
        );
      case 4:
        final link = _asMap(node['link']);
        final text = _string(link['show_text']) ?? '';
        final href = _normalizeUrl(_string(link['link']) ?? '');
        if (text.isEmpty) continue;
        spans.add(ArticleInlineNode(text: text, linkUrl: href, color: '#1E80FF'));
      default:
        final text = _string(node['text']) ?? _string(node['show_text']) ?? '';
        if (text.isEmpty) continue;
        spans.add(ArticleInlineNode(text: text));
    }
  }
  return spans;
}

String? _extractImageUrl(html_dom.Element figure) {
  final img = figure.querySelector('img');
  final src = _string(img?.attributes['src']);
  if (src == null || src.isEmpty) return null;
  return _normalizeUrl(src);
}

String? _extractFigureCaption(html_dom.Element figure) {
  final caption = figure.querySelector('figcaption');
  final text = caption?.text.trim();
  if (text == null || text.isEmpty) return null;
  return text;
}

ArticleTextAlign? _parseTextAlign(String? styleValue) {
  if (styleValue == null) return null;
  final lower = styleValue.toLowerCase();
  if (lower.contains('text-align: center')) return ArticleTextAlign.center;
  if (lower.contains('text-align: right')) return ArticleTextAlign.end;
  if (lower.contains('text-align: left')) return ArticleTextAlign.start;
  return null;
}

String? _extractHtmlColor(html_dom.Element node) {
  final style = node.attributes['style'];
  if (style != null) {
    final match = _colorStyleRegex.firstMatch(style);
    if (match != null) return match.group(1)?.trim();
  }

  final classes = node.attributes['class']?.split(_whitespaceRegex) ?? const [];
  for (final cls in classes) {
    if (cls == 'color-pink-03') return '#FB7299';
    if (cls == 'color-default') return null;
  }
  return null;
}

double? _extractFontSize(html_dom.Element node) {
  final style = node.attributes['style'];
  if (style != null) {
    final match = _fontSizeStyleRegex.firstMatch(style);
    if (match != null) return double.tryParse(match.group(1)!);
  }

  final classes = node.attributes['class']?.split(_whitespaceRegex) ?? const [];
  for (final cls in classes) {
    if (cls.startsWith('font-size-')) {
      final value = cls.substring('font-size-'.length);
      return double.tryParse(value);
    }
  }
  return null;
}
