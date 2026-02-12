import 'package:json_annotation/json_annotation.dart';

part 'dynamic_response.g.dart';

@JsonSerializable()
class DynamicDetailData {
  final DynamicItem item;

  DynamicDetailData({required this.item});

  factory DynamicDetailData.fromJson(Map<String, dynamic> json) =>
      _$DynamicDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicDetailDataToJson(this);
}

@JsonSerializable()
class DynamicData {
  @JsonKey(name: 'has_more')
  final bool hasMore;
  final List<DynamicItem> items;
  final String offset;
  @JsonKey(name: 'update_baseline')
  final String updateBaseline;
  @JsonKey(name: 'update_num')
  final int updateNum;

  DynamicData({
    required this.hasMore,
    required this.items,
    required this.offset,
    required this.updateBaseline,
    required this.updateNum,
  });

  factory DynamicData.fromJson(Map<String, dynamic> json) =>
      _$DynamicDataFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicDataToJson(this);
}

@JsonSerializable()
class DynamicItem {
  @JsonKey(name: 'id_str')
  final String idStr;
  final String type;
  final bool visible;
  final DynamicModules modules;
  final DynamicItem? orig;
  final DynamicBasic? basic;

  DynamicItem({
    required this.idStr,
    required this.type,
    required this.visible,
    required this.modules,
    this.orig,
    this.basic,
  });

  factory DynamicItem.fromJson(Map<String, dynamic> json) =>
      _$DynamicItemFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicItemToJson(this);

  DynamicItem copyWith({
    String? idStr,
    String? type,
    bool? visible,
    DynamicModules? modules,
    DynamicItem? orig,
    DynamicBasic? basic,
  }) {
    return DynamicItem(
      idStr: idStr ?? this.idStr,
      type: type ?? this.type,
      visible: visible ?? this.visible,
      modules: modules ?? this.modules,
      orig: orig ?? this.orig,
      basic: basic ?? this.basic,
    );
  }
}

@JsonSerializable()
class DynamicBasic {
  @JsonKey(name: 'comment_id_str')
  final String commentIdStr;
  @JsonKey(name: 'comment_type')
  final int commentType;
  @JsonKey(name: 'rid_str')
  final String ridStr;

  DynamicBasic({
    required this.commentIdStr,
    required this.commentType,
    required this.ridStr,
  });

  factory DynamicBasic.fromJson(Map<String, dynamic> json) =>
      _$DynamicBasicFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicBasicToJson(this);
}

@JsonSerializable()
class DynamicModules {
  @JsonKey(name: 'module_author')
  final ModuleAuthor moduleAuthor;
  @JsonKey(name: 'module_dynamic')
  final ModuleDynamic moduleDynamic;
  @JsonKey(name: 'module_stat')
  final ModuleStat? moduleStat;

  DynamicModules({
    required this.moduleAuthor,
    required this.moduleDynamic,
    this.moduleStat,
  });

  factory DynamicModules.fromJson(Map<String, dynamic> json) =>
      _$DynamicModulesFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicModulesToJson(this);

  DynamicModules copyWith({
    ModuleAuthor? moduleAuthor,
    ModuleDynamic? moduleDynamic,
    ModuleStat? moduleStat,
  }) {
    return DynamicModules(
      moduleAuthor: moduleAuthor ?? this.moduleAuthor,
      moduleDynamic: moduleDynamic ?? this.moduleDynamic,
      moduleStat: moduleStat ?? this.moduleStat,
    );
  }
}

@JsonSerializable()
class ModuleAuthor {
  final int mid;
  final String name;
  @JsonKey(name: 'face')
  final String avatar;
  @JsonKey(name: 'pub_time')
  final String pubTime;
  @JsonKey(name: 'pub_action')
  final String pubAction;

  ModuleAuthor({
    required this.mid,
    required this.name,
    required this.avatar,
    required this.pubTime,
    required this.pubAction,
  });

  factory ModuleAuthor.fromJson(Map<String, dynamic> json) =>
      _$ModuleAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleAuthorToJson(this);
}

@JsonSerializable()
class ModuleDynamic {
  final ModuleDesc? desc;
  final ModuleMajor? major;
  final ModuleTopic? topic;
  final ModuleAdditional? additional;

  ModuleDynamic({this.desc, this.major, this.topic, this.additional});

  factory ModuleDynamic.fromJson(Map<String, dynamic> json) =>
      _$ModuleDynamicFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleDynamicToJson(this);
}

@JsonSerializable()
class ModuleAdditional {
  final String type;
  final AdditionalCommon? common;
  final AdditionalReserve? reserve;
  final AdditionalGoods? goods;
  final AdditionalVote? vote;
  final AdditionalUgc? ugc;

  ModuleAdditional({
    required this.type,
    this.common,
    this.reserve,
    this.goods,
    this.vote,
    this.ugc,
  });

  factory ModuleAdditional.fromJson(Map<String, dynamic> json) =>
      _$ModuleAdditionalFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleAdditionalToJson(this);
}

@JsonSerializable()
class AdditionalCommon {
  final String title;
  final String? desc1;
  final String? desc2;
  final String cover;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  @JsonKey(name: 'sub_type')
  final String subType;
  @JsonKey(name: 'head_text')
  final String? headText;

  AdditionalCommon({
    required this.title,
    this.desc1,
    this.desc2,
    required this.cover,
    required this.jumpUrl,
    required this.subType,
    this.headText,
  });

  factory AdditionalCommon.fromJson(Map<String, dynamic> json) =>
      _$AdditionalCommonFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalCommonToJson(this);
}

@JsonSerializable()
class AdditionalReserve {
  final String title;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  @JsonKey(name: 'reserve_total')
  final int reserveTotal;
  final int
  state; // 0: unreserved?, 1: reserved? - Check docs. actually status in button.
  // Docs say: state 0.
  // Docs say desc1, desc2 are objects.
  final ReserveDesc? desc1;
  final ReserveDesc? desc2;

  AdditionalReserve({
    required this.title,
    required this.jumpUrl,
    required this.reserveTotal,
    required this.state,
    this.desc1,
    this.desc2,
  });

  factory AdditionalReserve.fromJson(Map<String, dynamic> json) =>
      _$AdditionalReserveFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalReserveToJson(this);
}

@JsonSerializable()
class ReserveDesc {
  final String text;
  final int style;

  ReserveDesc({required this.text, required this.style});

  factory ReserveDesc.fromJson(Map<String, dynamic> json) =>
      _$ReserveDescFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveDescToJson(this);
}

@JsonSerializable()
class AdditionalGoods {
  @JsonKey(name: 'head_text')
  final String headText;
  final List<GoodsItem> items;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;

  AdditionalGoods({
    required this.headText,
    required this.items,
    required this.jumpUrl,
  });

  factory AdditionalGoods.fromJson(Map<String, dynamic> json) =>
      _$AdditionalGoodsFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalGoodsToJson(this);
}

@JsonSerializable()
class GoodsItem {
  final String name;
  final String price;
  final String cover;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;

  GoodsItem({
    required this.name,
    required this.price,
    required this.cover,
    required this.jumpUrl,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) =>
      _$GoodsItemFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsItemToJson(this);
}

@JsonSerializable()
class AdditionalVote {
  final String desc;
  @JsonKey(name: 'end_time')
  final int endTime;
  @JsonKey(name: 'join_num')
  final int joinNum;
  @JsonKey(name: 'vote_id')
  final int voteId;
  final int choice_cnt;
  final int status;

  AdditionalVote({
    required this.desc,
    required this.endTime,
    required this.joinNum,
    required this.voteId,
    required this.choice_cnt,
    required this.status,
  });

  factory AdditionalVote.fromJson(Map<String, dynamic> json) =>
      _$AdditionalVoteFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalVoteToJson(this);
}

@JsonSerializable()
class AdditionalUgc {
  final String title;
  final String cover;
  @JsonKey(name: 'desc_second')
  final String descSecond;
  final String duration;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;

  AdditionalUgc({
    required this.title,
    required this.cover,
    required this.descSecond,
    required this.duration,
    required this.jumpUrl,
  });

  factory AdditionalUgc.fromJson(Map<String, dynamic> json) =>
      _$AdditionalUgcFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalUgcToJson(this);
}

@JsonSerializable()
class ModuleDesc {
  final String text;
  @JsonKey(name: 'rich_text_nodes')
  final List<dynamic>? richTextNodes;

  ModuleDesc({required this.text, this.richTextNodes});

  factory ModuleDesc.fromJson(Map<String, dynamic> json) =>
      _$ModuleDescFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleDescToJson(this);
}

@JsonSerializable()
class ModuleMajor {
  final String type;
  final MajorArchive? archive;
  final MajorDraw? draw;
  final MajorArchive? ugc_season;
  final MajorArticle? article;
  final MajorCommon? common;
  final MajorPgc? pgc;
  final MajorCourses? courses;
  final MajorMusic? music;
  final MajorOpus? opus;
  final MajorLive? live;
  @JsonKey(name: 'live_rcmd')
  final MajorLiveRcmd? liveRcmd;

  ModuleMajor({
    required this.type,
    this.archive,
    this.draw,
    this.ugc_season,
    this.article,
    this.common,
    this.pgc,
    this.courses,
    this.music,
    this.opus,
    this.live,
    this.liveRcmd,
  });

  factory ModuleMajor.fromJson(Map<String, dynamic> json) =>
      _$ModuleMajorFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleMajorToJson(this);
}

@JsonSerializable()
class MajorArchive {
  final String cover;
  final String title;
  final String desc;
  @JsonKey(name: 'duration_text')
  final String durationText;
  final MajorStat stat;
  final String aid;
  final String bvid;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;

  MajorArchive({
    required this.cover,
    required this.title,
    required this.desc,
    required this.durationText,
    required this.stat,
    required this.aid,
    required this.bvid,
    required this.jumpUrl,
  });

  factory MajorArchive.fromJson(Map<String, dynamic> json) =>
      _$MajorArchiveFromJson(json);
  Map<String, dynamic> toJson() => _$MajorArchiveToJson(this);
}

@JsonSerializable()
class MajorDraw {
  final int id;
  final List<DrawItem> items;

  MajorDraw({required this.id, required this.items});

  factory MajorDraw.fromJson(Map<String, dynamic> json) =>
      _$MajorDrawFromJson(json);
  Map<String, dynamic> toJson() => _$MajorDrawToJson(this);
}

@JsonSerializable()
class DrawItem {
  final String src;
  final int width;
  final int height;
  final int size;

  DrawItem({
    required this.src,
    required this.width,
    required this.height,
    required this.size,
  });

  factory DrawItem.fromJson(Map<String, dynamic> json) =>
      _$DrawItemFromJson(json);
  Map<String, dynamic> toJson() => _$DrawItemToJson(this);
}

@JsonSerializable()
class MajorArticle {
  final int id;
  final String title;
  final String desc;
  final List<String> covers;
  final String label;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;

  MajorArticle({
    required this.id,
    required this.title,
    required this.desc,
    required this.covers,
    required this.label,
    required this.jumpUrl,
  });

  factory MajorArticle.fromJson(Map<String, dynamic> json) =>
      _$MajorArticleFromJson(json);
  Map<String, dynamic> toJson() => _$MajorArticleToJson(this);
}

@JsonSerializable()
class MajorCommon {
  final String title;
  final String desc;
  final String cover;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  final String label;

  MajorCommon({
    required this.title,
    required this.desc,
    required this.cover,
    required this.jumpUrl,
    required this.label,
  });

  factory MajorCommon.fromJson(Map<String, dynamic> json) =>
      _$MajorCommonFromJson(json);
  Map<String, dynamic> toJson() => _$MajorCommonToJson(this);
}

@JsonSerializable()
class MajorStat {
  final String play;
  final String danmaku;

  MajorStat({required this.play, required this.danmaku});

  factory MajorStat.fromJson(Map<String, dynamic> json) =>
      _$MajorStatFromJson(json);
  Map<String, dynamic> toJson() => _$MajorStatToJson(this);
}

@JsonSerializable()
class ModuleStat {
  final StatLike like;
  final StatCommon comment;
  final StatCommon forward;

  ModuleStat({
    required this.like,
    required this.comment,
    required this.forward,
  });

  factory ModuleStat.fromJson(Map<String, dynamic> json) =>
      _$ModuleStatFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleStatToJson(this);

  ModuleStat copyWith({
    StatLike? like,
    StatCommon? comment,
    StatCommon? forward,
  }) {
    return ModuleStat(
      like: like ?? this.like,
      comment: comment ?? this.comment,
      forward: forward ?? this.forward,
    );
  }
}

@JsonSerializable()
class StatLike {
  final int count;
  final bool status;

  StatLike({required this.count, required this.status});

  factory StatLike.fromJson(Map<String, dynamic> json) =>
      _$StatLikeFromJson(json);
  Map<String, dynamic> toJson() => _$StatLikeToJson(this);

  StatLike copyWith({
    int? count,
    bool? status,
  }) {
    return StatLike(
      count: count ?? this.count,
      status: status ?? this.status,
    );
  }
}

@JsonSerializable()
class StatCommon {
  final int count;

  StatCommon({required this.count});

  factory StatCommon.fromJson(Map<String, dynamic> json) =>
      _$StatCommonFromJson(json);
  Map<String, dynamic> toJson() => _$StatCommonToJson(this);
}

@JsonSerializable()
class ModuleTopic {
  final String name;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;

  ModuleTopic({required this.name, required this.jumpUrl});

  factory ModuleTopic.fromJson(Map<String, dynamic> json) =>
      _$ModuleTopicFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleTopicToJson(this);
}

@JsonSerializable()
class MajorPgc {
  final String cover;
  final String title;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  final MajorStat stat;
  @JsonKey(name: 'season_id')
  final int seasonId;
  @JsonKey(name: 'epid')
  final int epid;
  @JsonKey(name: 'sub_type')
  final int subType;
  final int type;

  MajorPgc({
    required this.cover,
    required this.title,
    required this.jumpUrl,
    required this.stat,
    required this.seasonId,
    required this.epid,
    required this.subType,
    required this.type,
  });

  factory MajorPgc.fromJson(Map<String, dynamic> json) =>
      _$MajorPgcFromJson(json);
  Map<String, dynamic> toJson() => _$MajorPgcToJson(this);
}

@JsonSerializable()
class MajorCourses {
  final String cover;
  final String title;
  @JsonKey(name: 'sub_title')
  final String subTitle;
  final String desc;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  final int id;

  MajorCourses({
    required this.cover,
    required this.title,
    required this.subTitle,
    required this.desc,
    required this.jumpUrl,
    required this.id,
  });

  factory MajorCourses.fromJson(Map<String, dynamic> json) =>
      _$MajorCoursesFromJson(json);
  Map<String, dynamic> toJson() => _$MajorCoursesToJson(this);
}

@JsonSerializable()
class MajorMusic {
  final String cover;
  final String title;
  final String label;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  final int id;

  MajorMusic({
    required this.cover,
    required this.title,
    required this.label,
    required this.jumpUrl,
    required this.id,
  });

  factory MajorMusic.fromJson(Map<String, dynamic> json) =>
      _$MajorMusicFromJson(json);
  Map<String, dynamic> toJson() => _$MajorMusicToJson(this);
}

@JsonSerializable()
class MajorOpus {
  final String? title;
  final OpusSummary? summary;
  final List<OpusPic>? pics;
  @JsonKey(name: 'jump_url')
  final String? jumpUrl;

  MajorOpus({this.title, this.summary, this.pics, this.jumpUrl});

  factory MajorOpus.fromJson(Map<String, dynamic> json) =>
      _$MajorOpusFromJson(json);
  Map<String, dynamic> toJson() => _$MajorOpusToJson(this);
}

@JsonSerializable()
class OpusSummary {
  final String? text;
  @JsonKey(name: 'rich_text_nodes')
  final List<dynamic>? richTextNodes;

  OpusSummary({this.text, this.richTextNodes});

  factory OpusSummary.fromJson(Map<String, dynamic> json) =>
      _$OpusSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$OpusSummaryToJson(this);
}

@JsonSerializable()
class OpusPic {
  final String? url;
  final int? width;
  final int? height;
  final int? size;

  OpusPic({this.url, this.width, this.height, this.size});

  factory OpusPic.fromJson(Map<String, dynamic> json) =>
      _$OpusPicFromJson(json);
  Map<String, dynamic> toJson() => _$OpusPicToJson(this);
}

@JsonSerializable()
class MajorLive {
  final String cover;
  final String title;
  @JsonKey(name: 'live_state')
  final int liveState;
  @JsonKey(name: 'jump_url')
  final String jumpUrl;
  @JsonKey(name: 'desc_first')
  final String descFirst;
  @JsonKey(name: 'desc_second')
  final String descSecond;

  MajorLive({
    required this.cover,
    required this.title,
    required this.liveState,
    required this.jumpUrl,
    required this.descFirst,
    required this.descSecond,
  });

  factory MajorLive.fromJson(Map<String, dynamic> json) =>
      _$MajorLiveFromJson(json);
  Map<String, dynamic> toJson() => _$MajorLiveToJson(this);
}

@JsonSerializable()
class MajorLiveRcmd {
  final String content;
  @JsonKey(name: 'reserve_type')
  final int reserveType;

  MajorLiveRcmd({required this.content, required this.reserveType});

  factory MajorLiveRcmd.fromJson(Map<String, dynamic> json) =>
      _$MajorLiveRcmdFromJson(json);
  Map<String, dynamic> toJson() => _$MajorLiveRcmdToJson(this);
}

@JsonSerializable()
class DynamicPublishData {
  @JsonKey(name: 'dyn_id_str')
  final String dynIdStr;

  DynamicPublishData({required this.dynIdStr});

  factory DynamicPublishData.fromJson(Map<String, dynamic> json) =>
      _$DynamicPublishDataFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicPublishDataToJson(this);
}

@JsonSerializable()
class DynamicUploadImageData {
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'image_width')
  final int width;
  @JsonKey(name: 'image_height')
  final int height;

  DynamicUploadImageData({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  factory DynamicUploadImageData.fromJson(Map<String, dynamic> json) =>
      _$DynamicUploadImageDataFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicUploadImageDataToJson(this);
}
