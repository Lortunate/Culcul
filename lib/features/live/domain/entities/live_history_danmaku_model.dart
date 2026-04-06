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
    LiveDanmakuMedal? medal,
    LiveDanmakuTitle? title,
    LiveDanmakuUserLevel? userLevel,
    @Default(0) int rank,
    @Default(0) int teamid,
    @Default('') String rnd,
    @Default('') String userTitle,
    @Default(0) int guardLevel,
    @Default(0) int bubble,
    @Default({}) Map<String, dynamic> checkInfo,
  }) = _LiveDanmakuItem;
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
