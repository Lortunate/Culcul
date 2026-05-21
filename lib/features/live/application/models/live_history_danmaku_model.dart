import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_history_danmaku_model.freezed.dart';
part 'live_history_danmaku_model.g.dart';

@freezed
sealed class LiveHistoryDanmakuModel with _$LiveHistoryDanmakuModel {
  const factory LiveHistoryDanmakuModel({
    required List<LiveDanmakuItem> admin,
    required List<LiveDanmakuItem> room,
  }) = _LiveHistoryDanmakuModel;

  factory LiveHistoryDanmakuModel.fromJson(Map<String, dynamic> json) =>
      _$LiveHistoryDanmakuModelFromJson(json);
}

@freezed
sealed class LiveDanmakuItem with _$LiveDanmakuItem {
  const factory LiveDanmakuItem({
    required String text,
    required String nickname,
    required int uid,
    @Default('') String timeline,
    @Default(0) @JsonKey(name: 'dm_type') int dmType,
    @Default(0) int isadmin,
    @Default(0) int vip,
    @Default(0) int svip,
    @JsonKey(fromJson: _medalFromJson, toJson: _medalToJson) LiveDanmakuMedal? medal,
    @JsonKey(fromJson: _titleFromJson, toJson: _titleToJson) LiveDanmakuTitle? title,
    @JsonKey(name: 'user_level', fromJson: _userLevelFromJson, toJson: _userLevelToJson)
    LiveDanmakuUserLevel? userLevel,
    @Default(0) int rank,
    @Default(0) int teamid,
    @Default('') String rnd,
    @Default('') @JsonKey(name: 'user_title') String userTitle,
    @Default(0) @JsonKey(name: 'guard_level') int guardLevel,
    @Default(0) int bubble,
    @Default({}) @JsonKey(name: 'check_info') Map<String, dynamic> checkInfo,
  }) = _LiveDanmakuItem;

  factory LiveDanmakuItem.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmakuItemFromJson(json);
}

@freezed
sealed class LiveDanmakuMedal with _$LiveDanmakuMedal {
  const factory LiveDanmakuMedal({
    @Default(0) int level,
    @Default('') String name,
    @Default(0) int anchorRoomId,
    @Default(0) int color,
  }) = _LiveDanmakuMedal;
}

@freezed
sealed class LiveDanmakuTitle with _$LiveDanmakuTitle {
  const factory LiveDanmakuTitle({@Default('') String title, @Default('') String skin}) =
      _LiveDanmakuTitle;
}

@freezed
sealed class LiveDanmakuUserLevel with _$LiveDanmakuUserLevel {
  const factory LiveDanmakuUserLevel({@Default(0) int level, @Default(0) int rank}) =
      _LiveDanmakuUserLevel;
}

// -- JSON converters for array-encoded sub-models --

LiveDanmakuMedal? _medalFromJson(dynamic raw) {
  if (raw is! List || raw.length < 2) return null;
  return LiveDanmakuMedal(
    level: raw.first is num ? (raw.first as num).toInt() : 0,
    name: raw[1]?.toString() ?? '',
    anchorRoomId: raw.length > 3 && raw[3] is num ? (raw[3] as num).toInt() : 0,
    color: raw.length > 4 && raw[4] is num ? (raw[4] as num).toInt() : 0,
  );
}

List<dynamic>? _medalToJson(LiveDanmakuMedal? medal) {
  if (medal == null) return null;
  return [medal.level, medal.name, '', medal.anchorRoomId, medal.color];
}

LiveDanmakuTitle? _titleFromJson(dynamic raw) {
  if (raw is! List || raw.isEmpty) return null;
  return LiveDanmakuTitle(
    title: raw.first?.toString() ?? '',
    skin: raw.length > 1 ? raw[1]?.toString() ?? '' : '',
  );
}

List<dynamic>? _titleToJson(LiveDanmakuTitle? title) {
  if (title == null) return null;
  return [title.title, title.skin];
}

LiveDanmakuUserLevel? _userLevelFromJson(dynamic raw) {
  if (raw is! List || raw.isEmpty) return null;
  return LiveDanmakuUserLevel(
    level: raw.first is num ? (raw.first as num).toInt() : 0,
    rank: raw.length > 1 && raw[1] is num ? (raw[1] as num).toInt() : 0,
  );
}

List<dynamic>? _userLevelToJson(LiveDanmakuUserLevel? userLevel) {
  if (userLevel == null) return null;
  return [userLevel.level, userLevel.rank];
}
