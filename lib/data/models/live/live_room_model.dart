import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_room_model.freezed.dart';
part 'live_room_model.g.dart';

@freezed
sealed class LiveRoomModel with _$LiveRoomModel {
  const factory LiveRoomModel({
    @JsonKey(name: 'roomid') required int roomId,
    @JsonKey(name: 'uid') required int uid,
    required String title,
    required String uname,
    required String cover,
    required String face,
    @JsonKey(name: 'online') required int online,
    @JsonKey(name: 'area_v2_name') required String areaName,
    @JsonKey(name: 'area_v2_parent_name') required String parentAreaName,
    @JsonKey(name: 'link') required String link,
    @JsonKey(name: 'keyframe') String? keyframe,
    @JsonKey(name: 'watched_show') WatchedShow? watchedShow,
    @JsonKey(name: 'is_auto_play') int? isAutoPlay,
  }) = _LiveRoomModel;

  factory LiveRoomModel.fromJson(Map<String, dynamic> json) =>
      _$LiveRoomModelFromJson(json);
}

@freezed
sealed class WatchedShow with _$WatchedShow {
  const factory WatchedShow({
    @JsonKey(name: 'switch') required bool switchStatus,
    required int num,
    @JsonKey(name: 'text_small') required String textSmall,
    @JsonKey(name: 'text_large') required String textLarge,
    required String icon,
    @JsonKey(name: 'icon_web') required String iconWeb,
  }) = _WatchedShow;

  factory WatchedShow.fromJson(Map<String, dynamic> json) => _$WatchedShowFromJson(json);
}

