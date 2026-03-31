import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_room_detail_model.freezed.dart';

@freezed
sealed class LiveRoomDetailModel with _$LiveRoomDetailModel {
  const factory LiveRoomDetailModel({
    required int uid,
    required int roomId,
    required int shortId,
    required int attention,
    required int online,
    required bool isPortrait,
    required String description,
    required int liveStatus,
    required int areaId,
    required int parentAreaId,
    required String parentAreaName,
    required int oldAreaId,
    required String background,
    required String title,
    required String userCover,
    required String keyframe,
    required bool isStrictRoom,
    required String liveTime,
    required String tags,
    required int isAnchor,
    required String roomSilentType,
    required int roomSilentLevel,
    required int roomSilentSecond,
    required String areaName,
    required String pendants,
    required String areaPendants,
    required List<String> hotWords,
    required int hotWordsStatus,
    required String verify,
    required Map<String, dynamic> newPendants,
    required String upSession,
    required int pkStatus,
    required int pkId,
    required int battleId,
    required int allowChangeAreaTime,
    required int allowUploadCoverTime,
    required Map<String, dynamic> studioInfo,
  }) = _LiveRoomDetailModel;
}
