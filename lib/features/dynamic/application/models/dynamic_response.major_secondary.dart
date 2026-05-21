part of 'dynamic_response.dart';

@freezed
sealed class MajorPgc with _$MajorPgc {
  const factory MajorPgc({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
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
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(name: 'sub_title', fromJson: JsonUtils.parseStringWithDefault)
    required String subTitle,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String desc,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
    required int id,
  }) = _MajorCourses;

  factory MajorCourses.fromJson(Map<String, dynamic> json) =>
      _$MajorCoursesFromJson(json);
}

@freezed
sealed class MajorMusic with _$MajorMusic {
  const factory MajorMusic({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String label,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
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
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(name: 'live_state') required int liveState,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
    @JsonKey(name: 'desc_first', fromJson: JsonUtils.parseStringWithDefault)
    required String descFirst,
    @JsonKey(name: 'desc_second', fromJson: JsonUtils.parseStringWithDefault)
    required String descSecond,
  }) = _MajorLive;

  factory MajorLive.fromJson(Map<String, dynamic> json) => _$MajorLiveFromJson(json);
}

@freezed
sealed class MajorLiveRcmd with _$MajorLiveRcmd {
  const factory MajorLiveRcmd({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String content,
    @JsonKey(name: 'reserve_type') required int reserveType,
  }) = _MajorLiveRcmd;

  factory MajorLiveRcmd.fromJson(Map<String, dynamic> json) =>
      _$MajorLiveRcmdFromJson(json);
}
