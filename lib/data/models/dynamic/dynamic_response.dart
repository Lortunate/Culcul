import 'package:json_annotation/json_annotation.dart';

part 'dynamic_response.g.dart';

@JsonSerializable()
class DynamicResponse {
  final int code;
  final String message;
  final int ttl;
  final DynamicData? data;

  DynamicResponse({
    required this.code,
    required this.message,
    required this.ttl,
    this.data,
  });

  factory DynamicResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicResponseToJson(this);
}

@JsonSerializable()
class DynamicDetailResponse {
  final int code;
  final String message;
  final int ttl;
  final DynamicDetailData? data;

  DynamicDetailResponse({
    required this.code,
    required this.message,
    required this.ttl,
    this.data,
  });

  factory DynamicDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicDetailResponseToJson(this);
}

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

  ModuleDynamic({this.desc, this.major, this.topic});

  factory ModuleDynamic.fromJson(Map<String, dynamic> json) =>
      _$ModuleDynamicFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleDynamicToJson(this);
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
}

@JsonSerializable()
class StatLike {
  final int count;
  final bool status;

  StatLike({required this.count, required this.status});

  factory StatLike.fromJson(Map<String, dynamic> json) =>
      _$StatLikeFromJson(json);
  Map<String, dynamic> toJson() => _$StatLikeToJson(this);
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

  MajorOpus({
    this.title,
    this.summary,
    this.pics,
    this.jumpUrl,
  });

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

  OpusPic({
    this.url,
    this.width,
    this.height,
    this.size,
  });

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
class DynamicPublishResponse {
  final int code;
  final String message;
  final int ttl;
  final DynamicPublishData? data;

  DynamicPublishResponse({
    required this.code,
    required this.message,
    required this.ttl,
    this.data,
  });

  factory DynamicPublishResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicPublishResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicPublishResponseToJson(this);
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
class DynamicUploadImageResponse {
  final int code;
  final String message;
  final int ttl;
  final DynamicUploadImageData? data;

  DynamicUploadImageResponse({
    required this.code,
    required this.message,
    required this.ttl,
    this.data,
  });

  factory DynamicUploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicUploadImageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicUploadImageResponseToJson(this);
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
