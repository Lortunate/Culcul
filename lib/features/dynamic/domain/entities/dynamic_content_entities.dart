import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_content_entities.freezed.dart';

@freezed
sealed class DynamicVideoContent with _$DynamicVideoContent {
  const factory DynamicVideoContent({
    required String cover,
    required String title,
    required String playCount,
    required String danmakuCount,
    required String duration,
    String? aid,
    String? bvid,
  }) = _DynamicVideoContent;
}

@freezed
sealed class DynamicLinkCard with _$DynamicLinkCard {
  const factory DynamicLinkCard({
    required String title,
    required String cover,
    String? desc,
    required String url,
  }) = _DynamicLinkCard;
}

@freezed
sealed class DynamicAdditional with _$DynamicAdditional {
  const factory DynamicAdditional({
    required String type,
    String? title,
    String? cover,
    String? desc1,
    String? desc2,
    String? jumpUrl,
    // Vote specific
    int? voteId,
    int? voteJoinNum,
    int? voteChoiceCnt,
    int? voteStatus,
    // Reserve specific
    int? reserveTotal,
    int? state,
    // Goods specific
    String? headText,
    List<DynamicGoodsItem>? goodsItems,
  }) = _DynamicAdditional;
}

@freezed
sealed class DynamicGoodsItem with _$DynamicGoodsItem {
  const factory DynamicGoodsItem({
    required String name,
    required String price,
    required String cover,
    required String jumpUrl,
  }) = _DynamicGoodsItem;
}
