import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_detail_data.freezed.dart';

enum ArticleTextAlign { start, center, end }

@freezed
sealed class ArticleDetailData with _$ArticleDetailData {
  const factory ArticleDetailData({
    required String url,
    required String commentOid,
    required int commentType,
    required String title,
    required String summary,
    String? bannerUrl,
    required String authorName,
    required int authorMid,
    required String authorAvatar,
    required int publishTime,
    required ArticleStats stats,
    required List<ArticleBlock> blocks,
  }) = _ArticleDetailData;
}

@freezed
sealed class ArticleStats with _$ArticleStats {
  const factory ArticleStats({
    required int view,
    required int favorite,
    required int like,
    required int dislike,
    required int reply,
    required int share,
    required int coin,
    required int dynamicCount,
  }) = _ArticleStats;
}

sealed class ArticleBlock {
  const ArticleBlock();

  factory ArticleBlock.paragraph({
    required List<ArticleInlineNode> nodes,
    ArticleTextAlign? align,
    double? fontSize,
    bool bold = false,
  }) {
    return ArticleBlockParagraph(
      nodes: nodes,
      align: align,
      fontSize: fontSize,
      bold: bold,
    );
  }

  factory ArticleBlock.image({required List<String> imageUrls, String? caption}) =
      ArticleBlockImage;

  factory ArticleBlock.linkCard({
    required String title,
    String? subtitle,
    String? linkUrl,
  }) = ArticleBlockLinkCard;

  factory ArticleBlock.quote({required List<ArticleInlineNode> nodes}) =
      ArticleBlockQuote;

  const factory ArticleBlock.divider() = ArticleBlockDivider;
}

final class ArticleBlockParagraph extends ArticleBlock {
  ArticleBlockParagraph({
    required List<ArticleInlineNode> nodes,
    this.align,
    this.fontSize,
    this.bold = false,
  }) : nodes = List<ArticleInlineNode>.unmodifiable(nodes);

  final List<ArticleInlineNode> nodes;
  final ArticleTextAlign? align;
  final double? fontSize;
  final bool bold;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleBlockParagraph &&
            const DeepCollectionEquality().equals(other.nodes, nodes) &&
            other.align == align &&
            other.fontSize == fontSize &&
            other.bold == bold;
  }

  @override
  int get hashCode {
    return Object.hash(const DeepCollectionEquality().hash(nodes), align, fontSize, bold);
  }

  @override
  String toString() {
    return 'ArticleBlock.paragraph('
        'nodes: $nodes, '
        'align: $align, '
        'fontSize: $fontSize, '
        'bold: $bold'
        ')';
  }
}

final class ArticleBlockImage extends ArticleBlock {
  ArticleBlockImage({required List<String> imageUrls, this.caption})
    : imageUrls = List<String>.unmodifiable(imageUrls);

  final List<String> imageUrls;
  final String? caption;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleBlockImage &&
            const DeepCollectionEquality().equals(other.imageUrls, imageUrls) &&
            other.caption == caption;
  }

  @override
  int get hashCode =>
      Object.hash(const DeepCollectionEquality().hash(imageUrls), caption);

  @override
  String toString() {
    return 'ArticleBlock.image(imageUrls: $imageUrls, caption: $caption)';
  }
}

final class ArticleBlockLinkCard extends ArticleBlock {
  const ArticleBlockLinkCard({required this.title, this.subtitle, this.linkUrl});

  final String title;
  final String? subtitle;
  final String? linkUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleBlockLinkCard &&
            other.title == title &&
            other.subtitle == subtitle &&
            other.linkUrl == linkUrl;
  }

  @override
  int get hashCode => Object.hash(title, subtitle, linkUrl);

  @override
  String toString() {
    return 'ArticleBlock.linkCard('
        'title: $title, '
        'subtitle: $subtitle, '
        'linkUrl: $linkUrl'
        ')';
  }
}

final class ArticleBlockQuote extends ArticleBlock {
  ArticleBlockQuote({required List<ArticleInlineNode> nodes})
    : nodes = List<ArticleInlineNode>.unmodifiable(nodes);

  final List<ArticleInlineNode> nodes;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleBlockQuote &&
            const DeepCollectionEquality().equals(other.nodes, nodes);
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(nodes);

  @override
  String toString() => 'ArticleBlock.quote(nodes: $nodes)';
}

final class ArticleBlockDivider extends ArticleBlock {
  const ArticleBlockDivider();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ArticleBlockDivider;
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'ArticleBlock.divider()';
}

final class ArticleInlineNode {
  static const Object _nullableSentinel = Object();

  const ArticleInlineNode({
    required this.text,
    this.linkUrl,
    this.color,
    this.fontSize,
    this.bold = false,
    this.italic = false,
  });

  final String text;
  final String? linkUrl;
  final String? color;
  final double? fontSize;
  final bool bold;
  final bool italic;

  ArticleInlineNode copyWith({
    String? text,
    Object? linkUrl = _nullableSentinel,
    Object? color = _nullableSentinel,
    Object? fontSize = _nullableSentinel,
    bool? bold,
    bool? italic,
  }) {
    return ArticleInlineNode(
      text: text ?? this.text,
      linkUrl: identical(linkUrl, _nullableSentinel) ? this.linkUrl : linkUrl as String?,
      color: identical(color, _nullableSentinel) ? this.color : color as String?,
      fontSize: identical(fontSize, _nullableSentinel)
          ? this.fontSize
          : fontSize as double?,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleInlineNode &&
            other.text == text &&
            other.linkUrl == linkUrl &&
            other.color == color &&
            other.fontSize == fontSize &&
            other.bold == bold &&
            other.italic == italic;
  }

  @override
  int get hashCode => Object.hash(text, linkUrl, color, fontSize, bold, italic);

  @override
  String toString() {
    return 'ArticleInlineNode('
        'text: $text, '
        'linkUrl: $linkUrl, '
        'color: $color, '
        'fontSize: $fontSize, '
        'bold: $bold, '
        'italic: $italic'
        ')';
  }
}
