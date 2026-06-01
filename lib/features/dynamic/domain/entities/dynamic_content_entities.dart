import 'dart:collection';
import 'package:flutter/foundation.dart' show listEquals;

class DynamicVideoContent {
  const DynamicVideoContent({
    required this.cover,
    required this.title,
    required this.playCount,
    required this.danmakuCount,
    required this.duration,
    this.aid,
    this.bvid,
  });

  final String cover;
  final String title;
  final String playCount;
  final String danmakuCount;
  final String duration;
  final String? aid;
  final String? bvid;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicVideoContent &&
            other.cover == cover &&
            other.title == title &&
            other.playCount == playCount &&
            other.danmakuCount == danmakuCount &&
            other.duration == duration &&
            other.aid == aid &&
            other.bvid == bvid;
  }

  @override
  int get hashCode =>
      Object.hash(cover, title, playCount, danmakuCount, duration, aid, bvid);

  @override
  String toString() {
    return 'DynamicVideoContent(cover: $cover, title: $title, playCount: $playCount, '
        'danmakuCount: $danmakuCount, duration: $duration, aid: $aid, bvid: $bvid)';
  }
}

class DynamicLinkCard {
  const DynamicLinkCard({
    required this.title,
    required this.cover,
    this.desc,
    required this.url,
  });

  final String title;
  final String cover;
  final String? desc;
  final String url;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicLinkCard &&
            other.title == title &&
            other.cover == cover &&
            other.desc == desc &&
            other.url == url;
  }

  @override
  int get hashCode => Object.hash(title, cover, desc, url);

  @override
  String toString() {
    return 'DynamicLinkCard(title: $title, cover: $cover, desc: $desc, url: $url)';
  }
}

class DynamicAdditional {
  const DynamicAdditional({
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
    List<DynamicGoodsItem>? goodsItems,
  }) : _goodsItems = goodsItems;

  final String type;
  final String? title;
  final String? cover;
  final String? desc1;
  final String? desc2;
  final String? jumpUrl;
  final int? voteId;
  final int? voteJoinNum;
  final int? voteChoiceCnt;
  final int? voteStatus;
  final int? reserveTotal;
  final int? state;
  final String? headText;
  final List<DynamicGoodsItem>? _goodsItems;

  List<DynamicGoodsItem>? get goodsItems {
    final items = _goodsItems;
    return items == null ? null : UnmodifiableListView<DynamicGoodsItem>(items);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicAdditional &&
            other.type == type &&
            other.title == title &&
            other.cover == cover &&
            other.desc1 == desc1 &&
            other.desc2 == desc2 &&
            other.jumpUrl == jumpUrl &&
            other.voteId == voteId &&
            other.voteJoinNum == voteJoinNum &&
            other.voteChoiceCnt == voteChoiceCnt &&
            other.voteStatus == voteStatus &&
            other.reserveTotal == reserveTotal &&
            other.state == state &&
            other.headText == headText &&
            listEquals(other.goodsItems, goodsItems);
  }

  @override
  int get hashCode => Object.hash(
    type,
    title,
    cover,
    desc1,
    desc2,
    jumpUrl,
    voteId,
    voteJoinNum,
    voteChoiceCnt,
    voteStatus,
    reserveTotal,
    state,
    headText,
    Object.hashAll(goodsItems ?? const <DynamicGoodsItem>[]),
  );

  @override
  String toString() {
    return 'DynamicAdditional(type: $type, title: $title, cover: $cover, desc1: $desc1, '
        'desc2: $desc2, jumpUrl: $jumpUrl, voteId: $voteId, voteJoinNum: $voteJoinNum, '
        'voteChoiceCnt: $voteChoiceCnt, voteStatus: $voteStatus, reserveTotal: $reserveTotal, '
        'state: $state, headText: $headText, goodsItems: $goodsItems)';
  }
}

class DynamicGoodsItem {
  const DynamicGoodsItem({
    required this.name,
    required this.price,
    required this.cover,
    required this.jumpUrl,
  });

  final String name;
  final String price;
  final String cover;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicGoodsItem &&
            other.name == name &&
            other.price == price &&
            other.cover == cover &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode => Object.hash(name, price, cover, jumpUrl);

  @override
  String toString() {
    return 'DynamicGoodsItem(name: $name, price: $price, cover: $cover, jumpUrl: $jumpUrl)';
  }
}
