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

@freezed
sealed class ArticleBlock with _$ArticleBlock {
  const factory ArticleBlock.paragraph({
    required List<ArticleInlineNode> nodes,
    ArticleTextAlign? align,
    double? fontSize,
    @Default(false) bool bold,
  }) = ArticleBlockParagraph;

  const factory ArticleBlock.image({required List<String> imageUrls, String? caption}) =
      ArticleBlockImage;

  const factory ArticleBlock.linkCard({
    required String title,
    String? subtitle,
    String? linkUrl,
  }) = ArticleBlockLinkCard;

  const factory ArticleBlock.quote({required List<ArticleInlineNode> nodes}) =
      ArticleBlockQuote;

  const factory ArticleBlock.divider() = ArticleBlockDivider;
}

@freezed
sealed class ArticleInlineNode with _$ArticleInlineNode {
  const factory ArticleInlineNode({
    required String text,
    String? linkUrl,
    String? color,
    double? fontSize,
    @Default(false) bool bold,
    @Default(false) bool italic,
  }) = _ArticleInlineNode;
}
