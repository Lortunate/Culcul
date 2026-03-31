import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_history_danmaku_model.freezed.dart';

@freezed
sealed class LiveHistoryDanmakuModel with _$LiveHistoryDanmakuModel {
  const factory LiveHistoryDanmakuModel({
    required List<LiveDanmakuItem> admin,
    required List<LiveDanmakuItem> room,
  }) = _LiveHistoryDanmakuModel;
}

@freezed
sealed class LiveDanmakuItem with _$LiveDanmakuItem {
  const factory LiveDanmakuItem({
    required String text,
    required String nickname,
    required int uid,
    @Default('') String timeline,
    @Default(0) int dmType,
    @Default(0) int isadmin,
    @Default(0) int vip,
    @Default(0) int svip,
    @Default([]) List<dynamic> medal,
    @Default([]) List<dynamic> title,
    @Default([]) List<dynamic> userLevel,
    @Default(0) int rank,
    @Default(0) int teamid,
    @Default('') String rnd,
    @Default('') String userTitle,
    @Default(0) int guardLevel,
    @Default(0) int bubble,
    @Default({}) Map<String, dynamic> checkInfo,
  }) = _LiveDanmakuItem;
}
