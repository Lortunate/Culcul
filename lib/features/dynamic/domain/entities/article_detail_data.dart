import 'package:html/dom.dart' as html_dom;
import 'package:html/parser.dart' as html_parser;

enum ArticleBlockType { paragraph, image, linkCard, quote, divider }

enum ArticleTextAlign { start, center, end }

class ArticleDetailData {
  final String url;
  final String commentOid;
  final int commentType;
  final String title;
  final String summary;
  final String? bannerUrl;
  final String authorName;
  final int authorMid;
  final String authorAvatar;
  final int publishTime;
  final ArticleStats stats;
  final List<ArticleBlock> blocks;

  const ArticleDetailData({
    required this.url,
    required this.commentOid,
    required this.commentType,
    required this.title,
    required this.summary,
    required this.bannerUrl,
    required this.authorName,
    required this.authorMid,
    required this.authorAvatar,
    required this.publishTime,
    required this.stats,
    required this.blocks,
  });

  factory ArticleDetailData.fromArticleView({
    required Uri sourceUri,
    required Map<String, dynamic> data,
  }) {
    final author = _asMap(data['author']);
    final stats = _asMap(data['stats']);
    final content = (data['content'] ?? '').toString();
    final articleId = _extractArticleId(sourceUri);

    return ArticleDetailData(
      url: sourceUri.toString(),
      commentOid: articleId?.toString() ?? '',
      commentType: 12,
      title: _string(data['title']) ?? '',
      summary: _string(data['summary']) ?? '',
      bannerUrl: _string(data['banner_url']),
      authorName: _string(author['name']) ?? _string(data['author_name']) ?? '',
      authorMid: _int(author['mid']) ?? _int(data['mid']) ?? 0,
      authorAvatar: _string(author['face']) ?? '',
      publishTime: _int(data['publish_time']) ?? 0,
      stats: ArticleStats(
        view: _int(stats['view']) ?? 0,
        favorite: _int(stats['favorite']) ?? 0,
        like: _int(stats['like']) ?? 0,
        dislike: _int(stats['dislike']) ?? 0,
        reply: _int(stats['reply']) ?? 0,
        share: _int(stats['share']) ?? 0,
        coin: _int(stats['coin']) ?? 0,
        dynamicCount: _int(stats['dynamic']) ?? 0,
      ),
      blocks: _parseHtmlContent(content),
    );
  }

  factory ArticleDetailData.fromOpusState({
    required Uri sourceUri,
    required Map<String, dynamic> state,
  }) {
    final detail = _asMap(state['detail']);
    final basic = _asMap(detail['basic']);
    final modules =
        (detail['modules'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

    final title = _firstNonEmptyString([
      _string(basic['title']),
      _string(_findModule(modules, 'MODULE_TYPE_TITLE')['module_title']?['text']),
      _string(detail['title']),
    ]);

    final authorModule = _findModule(modules, 'MODULE_TYPE_AUTHOR');
    final authorData = _asMap(authorModule['module_author']);
    final topModule = _findModule(modules, 'MODULE_TYPE_TOP');
    final contentModule = _findModule(modules, 'MODULE_TYPE_CONTENT');
    final statModule = _findModule(modules, 'MODULE_TYPE_STAT');

    final topDisplay = _asMap(_asMap(topModule['module_top'])['display']);
    final album = _asMap(topDisplay['album']);
    final pics = (album['pics'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final articleId = _extractArticleId(sourceUri);

    return ArticleDetailData(
      url: sourceUri.toString(),
      commentOid: articleId?.toString() ?? '',
      commentType: 12,
      title: title,
      summary: _string(detail['summary']) ?? _string(basic['summary']) ?? '',
      bannerUrl: _firstNonEmptyString([
        pics.isNotEmpty ? _string(pics.first['url']) : null,
      ]),
      authorName: _firstNonEmptyString([
        _string(authorData['name']),
        _string(basic['author_name']),
      ]),
      authorMid: _int(authorData['mid']) ?? _int(basic['uid']) ?? 0,
      authorAvatar: _firstNonEmptyString([
        _string(authorData['face']),
        _string(_asMap(authorData['avatar'])['face']),
      ]),
      publishTime:
          _int(authorData['pub_ts']) ?? _int(_asMap(detail['pub_info'])['pub_time']) ?? 0,
      stats: ArticleStats(
        view: _int(_asMap(_asMap(statModule['module_stat'])['view'])['count']) ?? 0,
        favorite:
            _int(_asMap(_asMap(statModule['module_stat'])['favorite'])['count']) ?? 0,
        like: _int(_asMap(_asMap(statModule['module_stat'])['like'])['count']) ?? 0,
        dislike: _int(_asMap(_asMap(statModule['module_stat'])['dislike'])['count']) ?? 0,
        reply: _int(_asMap(_asMap(statModule['module_stat'])['comment'])['count']) ?? 0,
        share: _int(_asMap(_asMap(statModule['module_stat'])['forward'])['count']) ?? 0,
        coin: _int(_asMap(_asMap(statModule['module_stat'])['coin'])['count']) ?? 0,
        dynamicCount: 0,
      ),
      blocks: _parseOpusBlocks(
        (contentModule['module_content'] as Map?)?.cast<String, dynamic>(),
      ),
    );
  }

  static Map<String, dynamic> _findModule(
    List<Map<String, dynamic>> modules,
    String type,
  ) {
    for (final module in modules) {
      if (module['module_type'] == type) {
        return module;
      }
    }
    return const {};
  }

  static List<ArticleBlock> _parseHtmlContent(String htmlContent) {
    if (htmlContent.trim().isEmpty) return const [];

    final root = html_parser.parseFragment(htmlContent);
    final blocks = <ArticleBlock>[];
    for (final node in root.nodes) {
      blocks.addAll(_parseHtmlNode(node));
    }
    return blocks;
  }

  static List<ArticleBlock> _parseHtmlNode(html_dom.Node node) {
    if (node is html_dom.Text) {
      final text = node.text.trim();
      if (text.isEmpty) return const [];
      return [
        ArticleBlock.paragraph(nodes: [ArticleInlineNode.text(text)]),
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
            ArticleBlock.image(
              imageUrls: [imageUrl],
              caption: _extractFigureCaption(node),
            ),
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
              nodes: [ArticleInlineNode.text(bulletPrefix), ...nodes],
            ),
          );
        }
        return listBlocks;
      default:
        return _parseHtmlChildren(node);
    }
  }

  static List<ArticleBlock> _parseHtmlChildren(html_dom.Element node) {
    final blocks = <ArticleBlock>[];
    for (final child in node.nodes) {
      blocks.addAll(_parseHtmlNode(child));
    }
    return blocks;
  }

  static List<ArticleInlineNode> _parseHtmlInlineNodes(
    List<html_dom.Node> nodes, {
    bool forceBold = false,
  }) {
    final spans = <ArticleInlineNode>[];
    for (final node in nodes) {
      spans.addAll(_parseHtmlInlineNode(node, forceBold: forceBold));
    }
    return spans;
  }

  static List<ArticleInlineNode> _parseHtmlInlineNode(
    html_dom.Node node, {
    bool forceBold = false,
  }) {
    if (node is html_dom.Text) {
      final text = node.text;
      if (text.isEmpty) return const [];
      return [ArticleInlineNode.text(text)];
    }

    if (node is! html_dom.Element) return const [];
    final tag = node.localName?.toLowerCase() ?? '';

    if (tag == 'br') {
      return [const ArticleInlineNode.text('\n')];
    }

    final baseChildren = node.nodes.isNotEmpty
        ? _parseHtmlInlineNodes(node.nodes, forceBold: forceBold)
        : [ArticleInlineNode.text(node.text)];

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

  static List<ArticleBlock> _parseOpusBlocks(Map<String, dynamic>? moduleContent) {
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
          break;
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
          break;
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
          break;
        default:
          break;
      }
    }

    return blocks;
  }

  static List<ArticleInlineNode> _parseOpusInlineNodes(List<Map<String, dynamic>> nodes) {
    final spans = <ArticleInlineNode>[];
    for (final node in nodes) {
      final type = _int(node['node_type']) ?? _int(node['type']) ?? 0;
      switch (type) {
        case 1:
          final word = _asMap(node['word']);
          final text = _string(word['words']) ?? '';
          if (text.isEmpty) continue;
          spans.add(
            ArticleInlineNode.text(
              text,
              fontSize: _double(word['font_size']),
              color: _string(word['color']),
            ),
          );
          break;
        case 4:
          final link = _asMap(node['link']);
          final text = _string(link['show_text']) ?? '';
          final href = _normalizeUrl(_string(link['link']) ?? '');
          if (text.isEmpty) continue;
          spans.add(ArticleInlineNode.text(text, linkUrl: href, color: '#1E80FF'));
          break;
        default:
          final text = _string(node['text']) ?? _string(node['show_text']) ?? '';
          if (text.isEmpty) continue;
          spans.add(ArticleInlineNode.text(text));
          break;
      }
    }
    return spans;
  }

  static String? _extractImageUrl(html_dom.Element figure) {
    final img = figure.querySelector('img');
    final src = _string(img?.attributes['src']);
    if (src == null || src.isEmpty) return null;
    return _normalizeUrl(src);
  }

  static String? _extractFigureCaption(html_dom.Element figure) {
    final caption = figure.querySelector('figcaption');
    final text = caption?.text.trim();
    if (text == null || text.isEmpty) return null;
    return text;
  }

  static ArticleTextAlign? _parseTextAlign(String? styleValue) {
    if (styleValue == null) return null;
    final lower = styleValue.toLowerCase();
    if (lower.contains('text-align: center')) return ArticleTextAlign.center;
    if (lower.contains('text-align: right')) return ArticleTextAlign.end;
    if (lower.contains('text-align: left')) return ArticleTextAlign.start;
    return null;
  }

  static String? _extractHtmlColor(html_dom.Element node) {
    final style = node.attributes['style'];
    if (style != null) {
      final match = RegExp(r'color:\s*([^;]+)', caseSensitive: false).firstMatch(style);
      if (match != null) return match.group(1)?.trim();
    }

    final classes = node.attributes['class']?.split(RegExp(r'\s+')) ?? const [];
    for (final cls in classes) {
      if (cls == 'color-pink-03') return '#FB7299';
      if (cls == 'color-default') return null;
    }
    return null;
  }

  static double? _extractFontSize(html_dom.Element node) {
    final style = node.attributes['style'];
    if (style != null) {
      final match = RegExp(
        r'font-size:\s*(\d+(?:\.\d+)?)px',
        caseSensitive: false,
      ).firstMatch(style);
      if (match != null) return double.tryParse(match.group(1)!);
    }

    final classes = node.attributes['class']?.split(RegExp(r'\s+')) ?? const [];
    for (final cls in classes) {
      if (cls.startsWith('font-size-')) {
        final value = cls.substring('font-size-'.length);
        return double.tryParse(value);
      }
    }
    return null;
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return value.cast<String, dynamic>();
    return const {};
  }

  static int? _extractArticleId(Uri uri) {
    final path = uri.path;
    final readMatch = RegExp(r'/cv(\d+)').firstMatch(path);
    if (readMatch != null) return int.tryParse(readMatch.group(1)!);

    final opusMatch = RegExp(r'/opus/(\d+)').firstMatch(path);
    if (opusMatch != null) return int.tryParse(opusMatch.group(1)!);

    return int.tryParse(uri.queryParameters['id'] ?? '');
  }

  static String? _string(dynamic value) {
    if (value == null) return null;
    final str = value.toString();
    if (str.isEmpty || str == 'null') return null;
    return str;
  }

  static int? _int(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static double? _double(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static String _firstNonEmptyString(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) return value;
    }
    return '';
  }

  static String _normalizeUrl(String raw) {
    if (raw.isEmpty) return raw;
    if (raw.startsWith('//')) return 'https:$raw';
    if (raw.startsWith('/')) return 'https://www.bilibili.com$raw';
    return raw;
  }
}

class ArticleStats {
  final int view;
  final int favorite;
  final int like;
  final int dislike;
  final int reply;
  final int share;
  final int coin;
  final int dynamicCount;

  const ArticleStats({
    required this.view,
    required this.favorite,
    required this.like,
    required this.dislike,
    required this.reply,
    required this.share,
    required this.coin,
    required this.dynamicCount,
  });
}

class ArticleBlock {
  final ArticleBlockType type;
  final List<ArticleInlineNode> nodes;
  final List<String> imageUrls;
  final String? caption;
  final String? title;
  final String? subtitle;
  final String? linkUrl;
  final ArticleTextAlign? align;
  final double? fontSize;
  final bool bold;

  const ArticleBlock._({
    required this.type,
    this.nodes = const [],
    this.imageUrls = const [],
    this.caption,
    this.title,
    this.subtitle,
    this.linkUrl,
    this.align,
    this.fontSize,
    this.bold = false,
  });

  factory ArticleBlock.paragraph({
    required List<ArticleInlineNode> nodes,
    ArticleTextAlign? align,
    double? fontSize,
    bool bold = false,
  }) {
    return ArticleBlock._(
      type: ArticleBlockType.paragraph,
      nodes: nodes,
      align: align,
      fontSize: fontSize,
      bold: bold,
    );
  }

  factory ArticleBlock.image({required List<String> imageUrls, String? caption}) {
    return ArticleBlock._(
      type: ArticleBlockType.image,
      imageUrls: imageUrls,
      caption: caption,
    );
  }

  factory ArticleBlock.linkCard({
    required String title,
    String? subtitle,
    String? linkUrl,
  }) {
    return ArticleBlock._(
      type: ArticleBlockType.linkCard,
      title: title,
      subtitle: subtitle,
      linkUrl: linkUrl,
    );
  }

  const ArticleBlock.quote({required List<ArticleInlineNode> nodes})
    : this._(type: ArticleBlockType.quote, nodes: nodes);

  const ArticleBlock.divider() : this._(type: ArticleBlockType.divider);
}

class ArticleInlineNode {
  final String text;
  final String? linkUrl;
  final String? color;
  final double? fontSize;
  final bool bold;
  final bool italic;

  const ArticleInlineNode({
    required this.text,
    this.linkUrl,
    this.color,
    this.fontSize,
    this.bold = false,
    this.italic = false,
  });

  const ArticleInlineNode.text(
    this.text, {
    this.linkUrl,
    this.color,
    this.fontSize,
    this.bold = false,
    this.italic = false,
  });

  ArticleInlineNode copyWith({
    String? text,
    String? linkUrl,
    String? color,
    double? fontSize,
    bool? bold,
    bool? italic,
  }) {
    return ArticleInlineNode(
      text: text ?? this.text,
      linkUrl: linkUrl ?? this.linkUrl,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
    );
  }
}
