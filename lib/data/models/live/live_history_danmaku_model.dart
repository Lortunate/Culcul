import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_history_danmaku_model.freezed.dart';
part 'live_history_danmaku_model.g.dart';

@freezed
abstract class LiveHistoryDanmakuModel with _$LiveHistoryDanmakuModel {
  const factory LiveHistoryDanmakuModel({
    required List<LiveDanmakuItem> admin,
    required List<LiveDanmakuItem> room,
  }) = _LiveHistoryDanmakuModel;

  factory LiveHistoryDanmakuModel.fromJson(Map<String, dynamic> json) =>
      _$LiveHistoryDanmakuModelFromJson(json);
}

@freezed
abstract class LiveDanmakuItem with _$LiveDanmakuItem {
  const factory LiveDanmakuItem({
    required String text,
    required String nickname,
    required int uid,
    @Default('') @JsonKey(name: 'timeline') String timeline,
    @Default(0) @JsonKey(name: 'dm_type') int dmType,
    @Default(0) int isadmin,
    @Default(0) int vip,
    @Default(0) int svip,
    @Default([]) List<dynamic> medal,
    @Default([]) List<dynamic> title,
    @Default([]) @JsonKey(name: 'user_level') List<dynamic> userLevel,
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
