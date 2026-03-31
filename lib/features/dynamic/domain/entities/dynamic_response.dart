import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_response.freezed.dart';

@freezed
sealed class DynamicDetailData with _$DynamicDetailData {
  const factory DynamicDetailData({required DynamicItem item}) = _DynamicDetailData;
}

@freezed
sealed class DynamicData with _$DynamicData {
  const factory DynamicData({
    required bool hasMore,
    required List<DynamicItem> items,
    required String offset,
    required String updateBaseline,
    required int updateNum,
  }) = _DynamicData;
}

@freezed
sealed class DynamicItem with _$DynamicItem {
  const factory DynamicItem({
    required String idStr,
    required String type,
    required bool visible,
    required DynamicModules modules,
    DynamicItem? orig,
    DynamicBasic? basic,
  }) = _DynamicItem;
}

@freezed
sealed class DynamicBasic with _$DynamicBasic {
  const factory DynamicBasic({
    required String commentIdStr,
    required int commentType,
    required String ridStr,
  }) = _DynamicBasic;
}

@freezed
sealed class DynamicModules with _$DynamicModules {
  const factory DynamicModules({
    required ModuleAuthor moduleAuthor,
    required ModuleDynamic moduleDynamic,
    ModuleStat? moduleStat,
  }) = _DynamicModules;
}

@freezed
sealed class ModuleAuthor with _$ModuleAuthor {
  const factory ModuleAuthor({
    required int mid,
    required String name,
    required String avatar,
    required String pubTime,
    required String pubAction,
  }) = _ModuleAuthor;
}

@freezed
sealed class ModuleDynamic with _$ModuleDynamic {
  const factory ModuleDynamic({
    ModuleDesc? desc,
    ModuleMajor? major,
    ModuleTopic? topic,
    ModuleAdditional? additional,
  }) = _ModuleDynamic;
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
}

@freezed
sealed class AdditionalCommon with _$AdditionalCommon {
  const factory AdditionalCommon({
    required String title,
    String? desc1,
    String? desc2,
    required String cover,
    required String jumpUrl,
    required String subType,
    String? headText,
  }) = _AdditionalCommon;
}

@freezed
sealed class AdditionalReserve with _$AdditionalReserve {
  const factory AdditionalReserve({
    required String title,
    required String jumpUrl,
    required int reserveTotal,
    required int state,
    ReserveDesc? desc1,
    ReserveDesc? desc2,
  }) = _AdditionalReserve;
}

@freezed
sealed class ReserveDesc with _$ReserveDesc {
  const factory ReserveDesc({
    required String text,
    required int style,
  }) = _ReserveDesc;
}

@freezed
sealed class AdditionalGoods with _$AdditionalGoods {
  const factory AdditionalGoods({
    required String headText,
    required List<GoodsItem> items,
    required String jumpUrl,
  }) = _AdditionalGoods;
}

@freezed
sealed class GoodsItem with _$GoodsItem {
  const factory GoodsItem({
    required String name,
    required String price,
    required String cover,
    required String jumpUrl,
  }) = _GoodsItem;
}

@freezed
sealed class AdditionalVote with _$AdditionalVote {
  const factory AdditionalVote({
    required String desc,
    required int endTime,
    required int joinNum,
    required int voteId,
    required int choiceCnt,
    required int status,
  }) = _AdditionalVote;
}

@freezed
sealed class AdditionalUgc with _$AdditionalUgc {
  const factory AdditionalUgc({
    required String title,
    required String cover,
    required String descSecond,
    required String duration,
    required String jumpUrl,
  }) = _AdditionalUgc;
}

@freezed
sealed class ModuleDesc with _$ModuleDesc {
  const factory ModuleDesc({
    required String text,
    List<dynamic>? richTextNodes,
  }) = _ModuleDesc;
}

@freezed
sealed class ModuleMajor with _$ModuleMajor {
  const factory ModuleMajor({
    required String type,
    MajorArchive? archive,
    MajorDraw? draw,
    MajorArchive? ugcSeason,
    MajorArticle? article,
    MajorCommon? common,
    MajorPgc? pgc,
    MajorCourses? courses,
    MajorMusic? music,
    MajorOpus? opus,
    MajorLive? live,
    MajorLiveRcmd? liveRcmd,
  }) = _ModuleMajor;
}

@freezed
sealed class MajorArchive with _$MajorArchive {
  const factory MajorArchive({
    required String cover,
    required String title,
    required String desc,
    required String durationText,
    required MajorStat stat,
    required String aid,
    required String bvid,
    required String jumpUrl,
  }) = _MajorArchive;
}

@freezed
sealed class MajorDraw with _$MajorDraw {
  const factory MajorDraw({required int id, required List<DrawItem> items}) = _MajorDraw;
}

@freezed
sealed class DrawItem with _$DrawItem {
  const factory DrawItem({
    required String src,
    required int width,
    required int height,
    required int size,
  }) = _DrawItem;
}

@freezed
sealed class MajorArticle with _$MajorArticle {
  const factory MajorArticle({
    required int id,
    required String title,
    required String desc,
    required List<String> covers,
    required String label,
    required String jumpUrl,
  }) = _MajorArticle;
}

@freezed
sealed class MajorCommon with _$MajorCommon {
  const factory MajorCommon({
    required String title,
    required String desc,
    required String cover,
    required String jumpUrl,
    required String label,
  }) = _MajorCommon;
}

@freezed
sealed class MajorStat with _$MajorStat {
  const factory MajorStat({
    required String play,
    required String danmaku,
  }) = _MajorStat;
}

@freezed
sealed class ModuleStat with _$ModuleStat {
  const factory ModuleStat({
    required StatLike like,
    required StatCommon comment,
    required StatCommon forward,
  }) = _ModuleStat;
}

@freezed
sealed class StatLike with _$StatLike {
  const factory StatLike({required int count, required bool status}) = _StatLike;
}

@freezed
sealed class StatCommon with _$StatCommon {
  const factory StatCommon({required int count}) = _StatCommon;
}

@freezed
sealed class ModuleTopic with _$ModuleTopic {
  const factory ModuleTopic({
    required String name,
    required String jumpUrl,
  }) = _ModuleTopic;
}

@freezed
sealed class MajorPgc with _$MajorPgc {
  const factory MajorPgc({
    required String cover,
    required String title,
    required String jumpUrl,
    required MajorStat stat,
    required int seasonId,
    required int epid,
    required int subType,
    required int type,
  }) = _MajorPgc;
}

@freezed
sealed class MajorCourses with _$MajorCourses {
  const factory MajorCourses({
    required String cover,
    required String title,
    required String subTitle,
    required String desc,
    required String jumpUrl,
    required int id,
  }) = _MajorCourses;
}

@freezed
sealed class MajorMusic with _$MajorMusic {
  const factory MajorMusic({
    required String cover,
    required String title,
    required String label,
    required String jumpUrl,
    required int id,
  }) = _MajorMusic;
}

@freezed
sealed class MajorOpus with _$MajorOpus {
  const factory MajorOpus({
    String? title,
    OpusSummary? summary,
    List<OpusPic>? pics,
    String? jumpUrl,
  }) = _MajorOpus;
}

@freezed
sealed class OpusSummary with _$OpusSummary {
  const factory OpusSummary({
    String? text,
    List<dynamic>? richTextNodes,
  }) = _OpusSummary;
}

@freezed
sealed class OpusPic with _$OpusPic {
  const factory OpusPic({String? url, int? width, int? height, int? size}) = _OpusPic;
}

@freezed
sealed class MajorLive with _$MajorLive {
  const factory MajorLive({
    required String cover,
    required String title,
    required int liveState,
    required String jumpUrl,
    required String descFirst,
    required String descSecond,
  }) = _MajorLive;
}

@freezed
sealed class MajorLiveRcmd with _$MajorLiveRcmd {
  const factory MajorLiveRcmd({
    required String content,
    required int reserveType,
  }) = _MajorLiveRcmd;
}

@freezed
sealed class DynamicPublishData with _$DynamicPublishData {
  const factory DynamicPublishData({
    required String dynIdStr,
  }) = _DynamicPublishData;
}

@freezed
sealed class DynamicUploadImageData with _$DynamicUploadImageData {
  const factory DynamicUploadImageData({
    required String imageUrl,
    required int width,
    required int height,
  }) = _DynamicUploadImageData;
}
