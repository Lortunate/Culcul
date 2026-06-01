part of 'dynamic_response.dart';

final class ModuleAdditional {
  const ModuleAdditional({
    required this.type,
    this.common,
    this.reserve,
    this.goods,
    this.vote,
    this.ugc,
  });

  factory ModuleAdditional.fromJson(Map<String, dynamic> json) {
    return ModuleAdditional(
      type: JsonUtils.parseStringWithDefault(json['type']),
      common: json['common'] == null
          ? null
          : AdditionalCommon.fromJson(json['common'] as Map<String, dynamic>),
      reserve: json['reserve'] == null
          ? null
          : AdditionalReserve.fromJson(json['reserve'] as Map<String, dynamic>),
      goods: json['goods'] == null
          ? null
          : AdditionalGoods.fromJson(json['goods'] as Map<String, dynamic>),
      vote: json['vote'] == null
          ? null
          : AdditionalVote.fromJson(json['vote'] as Map<String, dynamic>),
      ugc: json['ugc'] == null
          ? null
          : AdditionalUgc.fromJson(json['ugc'] as Map<String, dynamic>),
    );
  }

  final String type;
  final AdditionalCommon? common;
  final AdditionalReserve? reserve;
  final AdditionalGoods? goods;
  final AdditionalVote? vote;
  final AdditionalUgc? ugc;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleAdditional &&
            other.type == type &&
            other.common == common &&
            other.reserve == reserve &&
            other.goods == goods &&
            other.vote == vote &&
            other.ugc == ugc;
  }

  @override
  int get hashCode => Object.hash(type, common, reserve, goods, vote, ugc);

  @override
  String toString() {
    return 'ModuleAdditional('
        'type: $type, '
        'common: $common, '
        'reserve: $reserve, '
        'goods: $goods, '
        'vote: $vote, '
        'ugc: $ugc'
        ')';
  }
}

final class AdditionalCommon {
  const AdditionalCommon({
    required this.title,
    this.desc1,
    this.desc2,
    required this.cover,
    required this.jumpUrl,
    required this.subType,
    this.headText,
  });

  factory AdditionalCommon.fromJson(Map<String, dynamic> json) {
    return AdditionalCommon(
      title: JsonUtils.parseStringWithDefault(json['title']),
      desc1: json['desc1'] as String?,
      desc2: json['desc2'] as String?,
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      subType: JsonUtils.parseStringWithDefault(json['sub_type']),
      headText: json['head_text'] as String?,
    );
  }

  final String title;
  final String? desc1;
  final String? desc2;
  final String cover;
  final String jumpUrl;
  final String subType;
  final String? headText;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AdditionalCommon &&
            other.title == title &&
            other.desc1 == desc1 &&
            other.desc2 == desc2 &&
            other.cover == cover &&
            other.jumpUrl == jumpUrl &&
            other.subType == subType &&
            other.headText == headText;
  }

  @override
  int get hashCode => Object.hash(title, desc1, desc2, cover, jumpUrl, subType, headText);

  @override
  String toString() {
    return 'AdditionalCommon('
        'title: $title, '
        'desc1: $desc1, '
        'desc2: $desc2, '
        'cover: $cover, '
        'jumpUrl: $jumpUrl, '
        'subType: $subType, '
        'headText: $headText'
        ')';
  }
}

final class AdditionalReserve {
  const AdditionalReserve({
    required this.title,
    required this.jumpUrl,
    required this.reserveTotal,
    required this.state,
    this.desc1,
    this.desc2,
  });

  factory AdditionalReserve.fromJson(Map<String, dynamic> json) {
    return AdditionalReserve(
      title: JsonUtils.parseStringWithDefault(json['title']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      reserveTotal: (json['reserve_total'] as num).toInt(),
      state: (json['state'] as num).toInt(),
      desc1: json['desc1'] == null
          ? null
          : ReserveDesc.fromJson(json['desc1'] as Map<String, dynamic>),
      desc2: json['desc2'] == null
          ? null
          : ReserveDesc.fromJson(json['desc2'] as Map<String, dynamic>),
    );
  }

  final String title;
  final String jumpUrl;
  final int reserveTotal;
  final int state;
  final ReserveDesc? desc1;
  final ReserveDesc? desc2;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AdditionalReserve &&
            other.title == title &&
            other.jumpUrl == jumpUrl &&
            other.reserveTotal == reserveTotal &&
            other.state == state &&
            other.desc1 == desc1 &&
            other.desc2 == desc2;
  }

  @override
  int get hashCode => Object.hash(title, jumpUrl, reserveTotal, state, desc1, desc2);

  @override
  String toString() {
    return 'AdditionalReserve('
        'title: $title, '
        'jumpUrl: $jumpUrl, '
        'reserveTotal: $reserveTotal, '
        'state: $state, '
        'desc1: $desc1, '
        'desc2: $desc2'
        ')';
  }
}

final class ReserveDesc {
  const ReserveDesc({required this.text, required this.style});

  factory ReserveDesc.fromJson(Map<String, dynamic> json) {
    return ReserveDesc(
      text: JsonUtils.parseStringWithDefault(json['text']),
      style: (json['style'] as num).toInt(),
    );
  }

  final String text;
  final int style;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReserveDesc && other.text == text && other.style == style;
  }

  @override
  int get hashCode => Object.hash(text, style);

  @override
  String toString() => 'ReserveDesc(text: $text, style: $style)';
}

final class AdditionalGoods {
  AdditionalGoods({
    required this.headText,
    required List<GoodsItem> items,
    required this.jumpUrl,
  }) : items = List.unmodifiable(items);

  factory AdditionalGoods.fromJson(Map<String, dynamic> json) {
    return AdditionalGoods(
      headText: JsonUtils.parseStringWithDefault(json['head_text']),
      items: (json['items'] as List<dynamic>)
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
    );
  }

  final String headText;
  final List<GoodsItem> items;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AdditionalGoods &&
            other.headText == headText &&
            listEquals(other.items, items) &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode => Object.hash(headText, Object.hashAll(items), jumpUrl);

  @override
  String toString() {
    return 'AdditionalGoods(headText: $headText, items: $items, jumpUrl: $jumpUrl)';
  }
}

final class GoodsItem {
  const GoodsItem({
    required this.name,
    required this.price,
    required this.cover,
    required this.jumpUrl,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      name: JsonUtils.parseStringWithDefault(json['name']),
      price: JsonUtils.parseStringWithDefault(json['price']),
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
    );
  }

  final String name;
  final String price;
  final String cover;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GoodsItem &&
            other.name == name &&
            other.price == price &&
            other.cover == cover &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode => Object.hash(name, price, cover, jumpUrl);

  @override
  String toString() {
    return 'GoodsItem(name: $name, price: $price, cover: $cover, jumpUrl: $jumpUrl)';
  }
}

final class AdditionalVote {
  const AdditionalVote({
    required this.desc,
    required this.endTime,
    required this.joinNum,
    required this.voteId,
    required this.choiceCnt,
    required this.status,
  });

  factory AdditionalVote.fromJson(Map<String, dynamic> json) {
    return AdditionalVote(
      desc: JsonUtils.parseStringWithDefault(json['desc']),
      endTime: (json['end_time'] as num).toInt(),
      joinNum: (json['join_num'] as num).toInt(),
      voteId: (json['vote_id'] as num).toInt(),
      choiceCnt: (json['choice_cnt'] as num).toInt(),
      status: (json['status'] as num).toInt(),
    );
  }

  final String desc;
  final int endTime;
  final int joinNum;
  final int voteId;
  final int choiceCnt;
  final int status;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AdditionalVote &&
            other.desc == desc &&
            other.endTime == endTime &&
            other.joinNum == joinNum &&
            other.voteId == voteId &&
            other.choiceCnt == choiceCnt &&
            other.status == status;
  }

  @override
  int get hashCode => Object.hash(desc, endTime, joinNum, voteId, choiceCnt, status);

  @override
  String toString() {
    return 'AdditionalVote('
        'desc: $desc, '
        'endTime: $endTime, '
        'joinNum: $joinNum, '
        'voteId: $voteId, '
        'choiceCnt: $choiceCnt, '
        'status: $status'
        ')';
  }
}

final class AdditionalUgc {
  const AdditionalUgc({
    required this.title,
    required this.cover,
    required this.descSecond,
    required this.duration,
    required this.jumpUrl,
  });

  factory AdditionalUgc.fromJson(Map<String, dynamic> json) {
    return AdditionalUgc(
      title: JsonUtils.parseStringWithDefault(json['title']),
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      descSecond: JsonUtils.parseStringWithDefault(json['desc_second']),
      duration: JsonUtils.parseStringWithDefault(json['duration']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
    );
  }

  final String title;
  final String cover;
  final String descSecond;
  final String duration;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AdditionalUgc &&
            other.title == title &&
            other.cover == cover &&
            other.descSecond == descSecond &&
            other.duration == duration &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode => Object.hash(title, cover, descSecond, duration, jumpUrl);

  @override
  String toString() {
    return 'AdditionalUgc('
        'title: $title, '
        'cover: $cover, '
        'descSecond: $descSecond, '
        'duration: $duration, '
        'jumpUrl: $jumpUrl'
        ')';
  }
}
