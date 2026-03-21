import 'package:culcul/core/utils/json_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_response.freezed.dart';
part 'dynamic_response.g.dart';

@freezed
sealed class DynamicDetailData with _$DynamicDetailData {
  const factory DynamicDetailData({required DynamicItem item}) = _DynamicDetailData;

  factory DynamicDetailData.fromJson(Map<String, dynamic> json) =>
      _$DynamicDetailDataFromJson(json);
}

@freezed
sealed class DynamicData with _$DynamicData {
  const factory DynamicData({
    @JsonKey(name: 'has_more') required bool hasMore,
    required List<DynamicItem> items,
    required String offset,
    @JsonKey(name: 'update_baseline') required String updateBaseline,
    @JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault)
    required int updateNum,
  }) = _DynamicData;

  factory DynamicData.fromJson(Map<String, dynamic> json) => _$DynamicDataFromJson(json);
}

@freezed
sealed class DynamicItem with _$DynamicItem {
  const factory DynamicItem({
    @JsonKey(name: 'id_str') required String idStr,
    required String type,
    required bool visible,
    required DynamicModules modules,
    DynamicItem? orig,
    DynamicBasic? basic,
  }) = _DynamicItem;

  factory DynamicItem.fromJson(Map<String, dynamic> json) => _$DynamicItemFromJson(json);
}

@freezed
sealed class DynamicBasic with _$DynamicBasic {
  const factory DynamicBasic({
    @JsonKey(name: 'comment_id_str') required String commentIdStr,
    @JsonKey(name: 'comment_type') required int commentType,
    @JsonKey(name: 'rid_str') required String ridStr,
  }) = _DynamicBasic;

  factory DynamicBasic.fromJson(Map<String, dynamic> json) =>
      _$DynamicBasicFromJson(json);
}

@freezed
sealed class DynamicModules with _$DynamicModules {
  const factory DynamicModules({
    @JsonKey(name: 'module_author') required ModuleAuthor moduleAuthor,
    @JsonKey(name: 'module_dynamic') required ModuleDynamic moduleDynamic,
    @JsonKey(name: 'module_stat') ModuleStat? moduleStat,
  }) = _DynamicModules;

  factory DynamicModules.fromJson(Map<String, dynamic> json) =>
      _$DynamicModulesFromJson(json);
}

@freezed
sealed class ModuleAuthor with _$ModuleAuthor {
  const factory ModuleAuthor({
    required int mid,
    required String name,
    @JsonKey(name: 'face') required String avatar,
    @JsonKey(name: 'pub_time') required String pubTime,
    @JsonKey(name: 'pub_action') required String pubAction,
  }) = _ModuleAuthor;

  factory ModuleAuthor.fromJson(Map<String, dynamic> json) =>
      _$ModuleAuthorFromJson(json);
}

@freezed
sealed class ModuleDynamic with _$ModuleDynamic {
  const factory ModuleDynamic({
    ModuleDesc? desc,
    ModuleMajor? major,
    ModuleTopic? topic,
    ModuleAdditional? additional,
  }) = _ModuleDynamic;

  factory ModuleDynamic.fromJson(Map<String, dynamic> json) =>
      _$ModuleDynamicFromJson(json);
}

@freezed
sealed class ModuleAdditional with _$ModuleAdditional {
  const factory ModuleAdditional({
    required String type,
    AdditionalCommon? common,
    AdditionalReserve? reserve,
    AdditionalGoods? goods,
    AdditionalVote? vote,
    AdditionalUgc? ugc,
  }) = _ModuleAdditional;

  factory ModuleAdditional.fromJson(Map<String, dynamic> json) =>
      _$ModuleAdditionalFromJson(json);
}

@freezed
sealed class AdditionalCommon with _$AdditionalCommon {
  const factory AdditionalCommon({
    required String title,
    String? desc1,
    String? desc2,
    required String cover,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    @JsonKey(name: 'sub_type') required String subType,
    @JsonKey(name: 'head_text') String? headText,
  }) = _AdditionalCommon;

  factory AdditionalCommon.fromJson(Map<String, dynamic> json) =>
      _$AdditionalCommonFromJson(json);
}

@freezed
sealed class AdditionalReserve with _$AdditionalReserve {
  const factory AdditionalReserve({
    required String title,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    @JsonKey(name: 'reserve_total') required int reserveTotal,
    required int state,
    ReserveDesc? desc1,
    ReserveDesc? desc2,
  }) = _AdditionalReserve;

  factory AdditionalReserve.fromJson(Map<String, dynamic> json) =>
      _$AdditionalReserveFromJson(json);
}

@freezed
sealed class ReserveDesc with _$ReserveDesc {
  const factory ReserveDesc({required String text, required int style}) = _ReserveDesc;

  factory ReserveDesc.fromJson(Map<String, dynamic> json) => _$ReserveDescFromJson(json);
}

@freezed
sealed class AdditionalGoods with _$AdditionalGoods {
  const factory AdditionalGoods({
    @JsonKey(name: 'head_text') required String headText,
    required List<GoodsItem> items,
    @JsonKey(name: 'jump_url') required String jumpUrl,
  }) = _AdditionalGoods;

  factory AdditionalGoods.fromJson(Map<String, dynamic> json) =>
      _$AdditionalGoodsFromJson(json);
}

@freezed
sealed class GoodsItem with _$GoodsItem {
  const factory GoodsItem({
    required String name,
    required String price,
    required String cover,
    @JsonKey(name: 'jump_url') required String jumpUrl,
  }) = _GoodsItem;

  factory GoodsItem.fromJson(Map<String, dynamic> json) => _$GoodsItemFromJson(json);
}

@freezed
sealed class AdditionalVote with _$AdditionalVote {
  const factory AdditionalVote({
    required String desc,
    @JsonKey(name: 'end_time') required int endTime,
    @JsonKey(name: 'join_num') required int joinNum,
    @JsonKey(name: 'vote_id') required int voteId,
    @JsonKey(name: 'choice_cnt') required int choiceCnt,
    required int status,
  }) = _AdditionalVote;

  factory AdditionalVote.fromJson(Map<String, dynamic> json) =>
      _$AdditionalVoteFromJson(json);
}

@freezed
sealed class AdditionalUgc with _$AdditionalUgc {
  const factory AdditionalUgc({
    required String title,
    required String cover,
    @JsonKey(name: 'desc_second') required String descSecond,
    required String duration,
    @JsonKey(name: 'jump_url') required String jumpUrl,
  }) = _AdditionalUgc;

  factory AdditionalUgc.fromJson(Map<String, dynamic> json) =>
      _$AdditionalUgcFromJson(json);
}

@freezed
sealed class ModuleDesc with _$ModuleDesc {
  const factory ModuleDesc({
    required String text,
    @JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes,
  }) = _ModuleDesc;

  factory ModuleDesc.fromJson(Map<String, dynamic> json) => _$ModuleDescFromJson(json);
}

@freezed
sealed class ModuleMajor with _$ModuleMajor {
  const factory ModuleMajor({
    required String type,
    MajorArchive? archive,
    MajorDraw? draw,
    @JsonKey(name: 'ugc_season') MajorArchive? ugcSeason,
    MajorArticle? article,
    MajorCommon? common,
    MajorPgc? pgc,
    MajorCourses? courses,
    MajorMusic? music,
    MajorOpus? opus,
    MajorLive? live,
    @JsonKey(name: 'live_rcmd') MajorLiveRcmd? liveRcmd,
  }) = _ModuleMajor;

  factory ModuleMajor.fromJson(Map<String, dynamic> json) => _$ModuleMajorFromJson(json);
}

@freezed
sealed class MajorArchive with _$MajorArchive {
  const factory MajorArchive({
    required String cover,
    required String title,
    required String desc,
    @JsonKey(name: 'duration_text') required String durationText,
    required MajorStat stat,
    required String aid,
    required String bvid,
    @JsonKey(name: 'jump_url') required String jumpUrl,
  }) = _MajorArchive;

  factory MajorArchive.fromJson(Map<String, dynamic> json) =>
      _$MajorArchiveFromJson(json);
}

@freezed
sealed class MajorDraw with _$MajorDraw {
  const factory MajorDraw({required int id, required List<DrawItem> items}) = _MajorDraw;

  factory MajorDraw.fromJson(Map<String, dynamic> json) => _$MajorDrawFromJson(json);
}

@freezed
sealed class DrawItem with _$DrawItem {
  const factory DrawItem({
    required String src,
    required int width,
    required int height,
    required int size,
  }) = _DrawItem;

  factory DrawItem.fromJson(Map<String, dynamic> json) => _$DrawItemFromJson(json);
}

@freezed
sealed class MajorArticle with _$MajorArticle {
  const factory MajorArticle({
    required int id,
    required String title,
    required String desc,
    required List<String> covers,
    required String label,
    @JsonKey(name: 'jump_url') required String jumpUrl,
  }) = _MajorArticle;

  factory MajorArticle.fromJson(Map<String, dynamic> json) =>
      _$MajorArticleFromJson(json);
}

@freezed
sealed class MajorCommon with _$MajorCommon {
  const factory MajorCommon({
    required String title,
    required String desc,
    required String cover,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    required String label,
  }) = _MajorCommon;

  factory MajorCommon.fromJson(Map<String, dynamic> json) => _$MajorCommonFromJson(json);
}

@freezed
sealed class MajorStat with _$MajorStat {
  const factory MajorStat({required String play, required String danmaku}) = _MajorStat;

  factory MajorStat.fromJson(Map<String, dynamic> json) => _$MajorStatFromJson(json);
}

@freezed
sealed class ModuleStat with _$ModuleStat {
  const factory ModuleStat({
    required StatLike like,
    required StatCommon comment,
    required StatCommon forward,
  }) = _ModuleStat;

  factory ModuleStat.fromJson(Map<String, dynamic> json) => _$ModuleStatFromJson(json);
}

@freezed
sealed class StatLike with _$StatLike {
  const factory StatLike({required int count, required bool status}) = _StatLike;

  factory StatLike.fromJson(Map<String, dynamic> json) => _$StatLikeFromJson(json);
}

@freezed
sealed class StatCommon with _$StatCommon {
  const factory StatCommon({required int count}) = _StatCommon;

  factory StatCommon.fromJson(Map<String, dynamic> json) => _$StatCommonFromJson(json);
}

@freezed
sealed class ModuleTopic with _$ModuleTopic {
  const factory ModuleTopic({
    required String name,
    @JsonKey(name: 'jump_url') required String jumpUrl,
  }) = _ModuleTopic;

  factory ModuleTopic.fromJson(Map<String, dynamic> json) => _$ModuleTopicFromJson(json);
}

@freezed
sealed class MajorPgc with _$MajorPgc {
  const factory MajorPgc({
    required String cover,
    required String title,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    required MajorStat stat,
    @JsonKey(name: 'season_id') required int seasonId,
    @JsonKey(name: 'epid') required int epid,
    @JsonKey(name: 'sub_type') required int subType,
    required int type,
  }) = _MajorPgc;

  factory MajorPgc.fromJson(Map<String, dynamic> json) => _$MajorPgcFromJson(json);
}

@freezed
sealed class MajorCourses with _$MajorCourses {
  const factory MajorCourses({
    required String cover,
    required String title,
    @JsonKey(name: 'sub_title') required String subTitle,
    required String desc,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    required int id,
  }) = _MajorCourses;

  factory MajorCourses.fromJson(Map<String, dynamic> json) =>
      _$MajorCoursesFromJson(json);
}

@freezed
sealed class MajorMusic with _$MajorMusic {
  const factory MajorMusic({
    required String cover,
    required String title,
    required String label,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    required int id,
  }) = _MajorMusic;

  factory MajorMusic.fromJson(Map<String, dynamic> json) => _$MajorMusicFromJson(json);
}

@freezed
sealed class MajorOpus with _$MajorOpus {
  const factory MajorOpus({
    String? title,
    OpusSummary? summary,
    List<OpusPic>? pics,
    @JsonKey(name: 'jump_url') String? jumpUrl,
  }) = _MajorOpus;

  factory MajorOpus.fromJson(Map<String, dynamic> json) => _$MajorOpusFromJson(json);
}

@freezed
sealed class OpusSummary with _$OpusSummary {
  const factory OpusSummary({
    String? text,
    @JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes,
  }) = _OpusSummary;

  factory OpusSummary.fromJson(Map<String, dynamic> json) => _$OpusSummaryFromJson(json);
}

@freezed
sealed class OpusPic with _$OpusPic {
  const factory OpusPic({String? url, int? width, int? height, int? size}) = _OpusPic;

  factory OpusPic.fromJson(Map<String, dynamic> json) => _$OpusPicFromJson(json);
}

@freezed
sealed class MajorLive with _$MajorLive {
  const factory MajorLive({
    required String cover,
    required String title,
    @JsonKey(name: 'live_state') required int liveState,
    @JsonKey(name: 'jump_url') required String jumpUrl,
    @JsonKey(name: 'desc_first') required String descFirst,
    @JsonKey(name: 'desc_second') required String descSecond,
  }) = _MajorLive;

  factory MajorLive.fromJson(Map<String, dynamic> json) => _$MajorLiveFromJson(json);
}

@freezed
sealed class MajorLiveRcmd with _$MajorLiveRcmd {
  const factory MajorLiveRcmd({
    required String content,
    @JsonKey(name: 'reserve_type') required int reserveType,
  }) = _MajorLiveRcmd;

  factory MajorLiveRcmd.fromJson(Map<String, dynamic> json) =>
      _$MajorLiveRcmdFromJson(json);
}

@freezed
sealed class DynamicPublishData with _$DynamicPublishData {
  const factory DynamicPublishData({
    @JsonKey(name: 'dyn_id_str') required String dynIdStr,
  }) = _DynamicPublishData;

  factory DynamicPublishData.fromJson(Map<String, dynamic> json) =>
      _$DynamicPublishDataFromJson(json);
}

@freezed
sealed class DynamicUploadImageData with _$DynamicUploadImageData {
  const factory DynamicUploadImageData({
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'image_width') required int width,
    @JsonKey(name: 'image_height') required int height,
  }) = _DynamicUploadImageData;

  factory DynamicUploadImageData.fromJson(Map<String, dynamic> json) =>
      _$DynamicUploadImageDataFromJson(json);
}
