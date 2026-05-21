part of 'dynamic_response.dart';

@freezed
sealed class ModuleDesc with _$ModuleDesc {
  const factory ModuleDesc({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String text,
    @JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes,
  }) = _ModuleDesc;

  factory ModuleDesc.fromJson(Map<String, dynamic> json) => _$ModuleDescFromJson(json);
}

@freezed
sealed class ModuleMajor with _$ModuleMajor {
  const factory ModuleMajor({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String type,
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
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String desc,
    @JsonKey(name: 'duration_text', fromJson: JsonUtils.parseStringWithDefault)
    required String durationText,
    required MajorStat stat,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String aid,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String bvid,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
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
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String src,
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
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String desc,
    @JsonKey(fromJson: JsonUtils.parseStringListWithDefault) required List<String> covers,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String label,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
  }) = _MajorArticle;

  factory MajorArticle.fromJson(Map<String, dynamic> json) =>
      _$MajorArticleFromJson(json);
}

@freezed
sealed class MajorCommon with _$MajorCommon {
  const factory MajorCommon({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String desc,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String label,
  }) = _MajorCommon;

  factory MajorCommon.fromJson(Map<String, dynamic> json) => _$MajorCommonFromJson(json);
}

@freezed
sealed class MajorStat with _$MajorStat {
  const factory MajorStat({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String play,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String danmaku,
  }) = _MajorStat;

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
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String name,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
  }) = _ModuleTopic;

  factory ModuleTopic.fromJson(Map<String, dynamic> json) => _$ModuleTopicFromJson(json);
}
