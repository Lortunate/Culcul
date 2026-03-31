import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_room_model.freezed.dart';

@freezed
sealed class LiveRoomModel with _$LiveRoomModel {
  const factory LiveRoomModel({
    required int roomId,
    required int uid,
    required String title,
    required String uname,
    required String cover,
    required String face,
    required int online,
    required String areaName,
    required String parentAreaName,
    required String link,
    String? keyframe,
    WatchedShow? watchedShow,
    int? isAutoPlay,
  }) = _LiveRoomModel;
}

@freezed
sealed class WatchedShow with _$WatchedShow {
  const factory WatchedShow({
    required bool switchStatus,
    required int num,
    required String textSmall,
    required String textLarge,
    required String icon,
    required String iconWeb,
  }) = _WatchedShow;
}
