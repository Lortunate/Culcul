import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_room_detail_model.freezed.dart';
part 'live_room_detail_model.g.dart';

@freezed
sealed class LiveRoomDetailModel with _$LiveRoomDetailModel {
  const factory LiveRoomDetailModel({
    required int uid,
    @JsonKey(name: 'room_id') required int roomId,
    @JsonKey(name: 'short_id') required int shortId,
    required int attention,
    required int online,
    @JsonKey(name: 'is_portrait') required bool isPortrait,
    required String description,
    @JsonKey(name: 'live_status') required int liveStatus,
    @JsonKey(name: 'area_id') required int areaId,
    @JsonKey(name: 'parent_area_id') required int parentAreaId,
    @JsonKey(name: 'parent_area_name') required String parentAreaName,
    @JsonKey(name: 'old_area_id') required int oldAreaId,
    required String background,
    required String title,
    @JsonKey(name: 'user_cover') required String userCover,
    required String keyframe,
    @JsonKey(name: 'is_strict_room') required bool isStrictRoom,
    @JsonKey(name: 'live_time') required String liveTime,
    required String tags,
    @JsonKey(name: 'is_anchor') required int isAnchor,
    @JsonKey(name: 'room_silent_type') required String roomSilentType,
    @JsonKey(name: 'room_silent_level') required int roomSilentLevel,
    @JsonKey(name: 'room_silent_second') required int roomSilentSecond,
    @JsonKey(name: 'area_name') required String areaName,
    required String pendants,
    @JsonKey(name: 'area_pendants') required String areaPendants,
    @JsonKey(name: 'hot_words') required List<String> hotWords,
    @JsonKey(name: 'hot_words_status') required int hotWordsStatus,
    required String verify,
    @JsonKey(name: 'new_pendants') required Map<String, dynamic> newPendants,
    @JsonKey(name: 'up_session') required String upSession,
    @JsonKey(name: 'pk_status') required int pkStatus,
    @JsonKey(name: 'pk_id') required int pkId,
    @JsonKey(name: 'battle_id') required int battleId,
    @JsonKey(name: 'allow_change_area_time') required int allowChangeAreaTime,
    @JsonKey(name: 'allow_upload_cover_time') required int allowUploadCoverTime,
    @JsonKey(name: 'studio_info') required Map<String, dynamic> studioInfo,
  }) = _LiveRoomDetailModel;

  factory LiveRoomDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LiveRoomDetailModelFromJson(json);
}
