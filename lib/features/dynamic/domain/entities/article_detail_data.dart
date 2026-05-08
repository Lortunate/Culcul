import 'package:culcul/features/dynamic/domain/entities/article_detail_parser.dart';

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
    return ArticleDetailParser.fromArticleView(sourceUri: sourceUri, data: data);
  }

  factory ArticleDetailData.fromOpusState({
    required Uri sourceUri,
    required Map<String, dynamic> state,
  }) {
    return ArticleDetailParser.fromOpusState(sourceUri: sourceUri, state: state);
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
