class DynamicVideoContent {
  final String cover;
  final String title;
  final String playCount;
  final String danmakuCount;
  final String duration;
  final String? aid;
  final String? bvid;

  DynamicVideoContent({
    required this.cover,
    required this.title,
    required this.playCount,
    required this.danmakuCount,
    required this.duration,
    this.aid,
    this.bvid,
  });
}

class DynamicLinkCard {
  final String title;
  final String cover;
  final String? desc;
  final String url;

  DynamicLinkCard({
    required this.title,
    required this.cover,
    this.desc,
    required this.url,
  });
}

class DynamicAdditional {
  final String type;
  final String? title;
  final String? cover;
  final String? desc1;
  final String? desc2;
  final String? jumpUrl;

  // Vote specific
  final int? voteId;
  final int? voteJoinNum;
  final int? voteChoiceCnt;
  final int? voteStatus;

  // Reserve specific
  final int? reserveTotal;
  final int? state;

  // Goods specific
  final String? headText;
  final List<DynamicGoodsItem>? goodsItems;

  DynamicAdditional({
    required this.type,
    this.title,
    this.cover,
    this.desc1,
    this.desc2,
    this.jumpUrl,
    this.voteId,
    this.voteJoinNum,
    this.voteChoiceCnt,
    this.voteStatus,
    this.reserveTotal,
    this.state,
    this.headText,
    this.goodsItems,
  });
}

class DynamicGoodsItem {
  final String name;
  final String price;
  final String cover;
  final String jumpUrl;

  DynamicGoodsItem({
    required this.name,
    required this.price,
    required this.cover,
    required this.jumpUrl,
  });
}

