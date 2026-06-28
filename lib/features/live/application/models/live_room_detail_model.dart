import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show listEquals, mapEquals;

final class LiveRoomDetailModel {
  LiveRoomDetailModel({
    required this.uid,
    required this.roomId,
    required this.shortId,
    required this.attention,
    required this.online,
    required this.isPortrait,
    required this.description,
    required this.liveStatus,
    required this.areaId,
    required this.parentAreaId,
    required this.parentAreaName,
    required this.oldAreaId,
    required this.background,
    required this.title,
    required this.userCover,
    required this.keyframe,
    required this.isStrictRoom,
    required this.liveTime,
    required this.tags,
    required this.isAnchor,
    required this.roomSilentType,
    required this.roomSilentLevel,
    required this.roomSilentSecond,
    required this.areaName,
    required this.pendants,
    required this.areaPendants,
    required List<String> hotWords,
    required this.hotWordsStatus,
    required this.verify,
    required Map<String, dynamic> newPendants,
    required this.upSession,
    required this.pkStatus,
    required this.pkId,
    required this.battleId,
    required this.allowChangeAreaTime,
    required this.allowUploadCoverTime,
    required Map<String, dynamic> studioInfo,
  }) : hotWords = List<String>.unmodifiable(hotWords),
       newPendants = Map<String, dynamic>.unmodifiable(newPendants),
       studioInfo = Map<String, dynamic>.unmodifiable(studioInfo);

  factory LiveRoomDetailModel.fromJson(Map<String, dynamic> json) {
    return LiveRoomDetailModel(
      uid: (json['uid'] as num).toInt(),
      roomId: (json['room_id'] as num).toInt(),
      shortId: (json['short_id'] as num).toInt(),
      attention: (json['attention'] as num).toInt(),
      online: (json['online'] as num).toInt(),
      isPortrait: json['is_portrait'] as bool,
      description: json['description'] as String,
      liveStatus: (json['live_status'] as num).toInt(),
      areaId: (json['area_id'] as num).toInt(),
      parentAreaId: (json['parent_area_id'] as num).toInt(),
      parentAreaName: json['parent_area_name'] as String,
      oldAreaId: (json['old_area_id'] as num).toInt(),
      background: json['background'] as String,
      title: json['title'] as String,
      userCover: json['user_cover'] as String,
      keyframe: json['keyframe'] as String,
      isStrictRoom: json['is_strict_room'] as bool,
      liveTime: json['live_time'] as String,
      tags: json['tags'] as String,
      isAnchor: (json['is_anchor'] as num).toInt(),
      roomSilentType: json['room_silent_type'] as String,
      roomSilentLevel: (json['room_silent_level'] as num).toInt(),
      roomSilentSecond: (json['room_silent_second'] as num).toInt(),
      areaName: json['area_name'] as String,
      pendants: json['pendants'] as String,
      areaPendants: json['area_pendants'] as String,
      hotWords: (json['hot_words'] as List<dynamic>)
          .map((e) => e as String)
          .toList(growable: false),
      hotWordsStatus: (json['hot_words_status'] as num).toInt(),
      verify: json['verify'] as String,
      newPendants: json['new_pendants'] as Map<String, dynamic>,
      upSession: json['up_session'] as String,
      pkStatus: (json['pk_status'] as num).toInt(),
      pkId: (json['pk_id'] as num).toInt(),
      battleId: (json['battle_id'] as num).toInt(),
      allowChangeAreaTime: (json['allow_change_area_time'] as num).toInt(),
      allowUploadCoverTime: (json['allow_upload_cover_time'] as num).toInt(),
      studioInfo: json['studio_info'] as Map<String, dynamic>,
    );
  }

  final int uid;
  final int roomId;
  final int shortId;
  final int attention;
  final int online;
  final bool isPortrait;
  final String description;
  final int liveStatus;
  final int areaId;
  final int parentAreaId;
  final String parentAreaName;
  final int oldAreaId;
  final String background;
  final String title;
  final String userCover;
  final String keyframe;
  final bool isStrictRoom;
  final String liveTime;
  final String tags;
  final int isAnchor;
  final String roomSilentType;
  final int roomSilentLevel;
  final int roomSilentSecond;
  final String areaName;
  final String pendants;
  final String areaPendants;
  final List<String> hotWords;
  final int hotWordsStatus;
  final String verify;
  final Map<String, dynamic> newPendants;
  final String upSession;
  final int pkStatus;
  final int pkId;
  final int battleId;
  final int allowChangeAreaTime;
  final int allowUploadCoverTime;
  final Map<String, dynamic> studioInfo;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveRoomDetailModel &&
            runtimeType == other.runtimeType &&
            uid == other.uid &&
            roomId == other.roomId &&
            shortId == other.shortId &&
            attention == other.attention &&
            online == other.online &&
            isPortrait == other.isPortrait &&
            description == other.description &&
            liveStatus == other.liveStatus &&
            areaId == other.areaId &&
            parentAreaId == other.parentAreaId &&
            parentAreaName == other.parentAreaName &&
            oldAreaId == other.oldAreaId &&
            background == other.background &&
            title == other.title &&
            userCover == other.userCover &&
            keyframe == other.keyframe &&
            isStrictRoom == other.isStrictRoom &&
            liveTime == other.liveTime &&
            tags == other.tags &&
            isAnchor == other.isAnchor &&
            roomSilentType == other.roomSilentType &&
            roomSilentLevel == other.roomSilentLevel &&
            roomSilentSecond == other.roomSilentSecond &&
            areaName == other.areaName &&
            pendants == other.pendants &&
            areaPendants == other.areaPendants &&
            listEquals(hotWords, other.hotWords) &&
            hotWordsStatus == other.hotWordsStatus &&
            verify == other.verify &&
            mapEquals(newPendants, other.newPendants) &&
            upSession == other.upSession &&
            pkStatus == other.pkStatus &&
            pkId == other.pkId &&
            battleId == other.battleId &&
            allowChangeAreaTime == other.allowChangeAreaTime &&
            allowUploadCoverTime == other.allowUploadCoverTime &&
            mapEquals(studioInfo, other.studioInfo);
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      uid,
      roomId,
      shortId,
      attention,
      online,
      isPortrait,
      description,
      liveStatus,
      areaId,
      parentAreaId,
      parentAreaName,
      oldAreaId,
      background,
      title,
      userCover,
      keyframe,
      isStrictRoom,
      liveTime,
      tags,
      isAnchor,
      roomSilentType,
      roomSilentLevel,
      roomSilentSecond,
      areaName,
      pendants,
      areaPendants,
      Object.hashAll(hotWords),
      hotWordsStatus,
      verify,
      const MapEquality<String, dynamic>().hash(newPendants),
      upSession,
      pkStatus,
      pkId,
      battleId,
      allowChangeAreaTime,
      allowUploadCoverTime,
      const MapEquality<String, dynamic>().hash(studioInfo),
    ]);
  }

  @override
  String toString() {
    return 'LiveRoomDetailModel('
        'uid: $uid, '
        'roomId: $roomId, '
        'shortId: $shortId, '
        'attention: $attention, '
        'online: $online, '
        'isPortrait: $isPortrait, '
        'description: $description, '
        'liveStatus: $liveStatus, '
        'areaId: $areaId, '
        'parentAreaId: $parentAreaId, '
        'parentAreaName: $parentAreaName, '
        'oldAreaId: $oldAreaId, '
        'background: $background, '
        'title: $title, '
        'userCover: $userCover, '
        'keyframe: $keyframe, '
        'isStrictRoom: $isStrictRoom, '
        'liveTime: $liveTime, '
        'tags: $tags, '
        'isAnchor: $isAnchor, '
        'roomSilentType: $roomSilentType, '
        'roomSilentLevel: $roomSilentLevel, '
        'roomSilentSecond: $roomSilentSecond, '
        'areaName: $areaName, '
        'pendants: $pendants, '
        'areaPendants: $areaPendants, '
        'hotWords: $hotWords, '
        'hotWordsStatus: $hotWordsStatus, '
        'verify: $verify, '
        'newPendants: $newPendants, '
        'upSession: $upSession, '
        'pkStatus: $pkStatus, '
        'pkId: $pkId, '
        'battleId: $battleId, '
        'allowChangeAreaTime: $allowChangeAreaTime, '
        'allowUploadCoverTime: $allowUploadCoverTime, '
        'studioInfo: $studioInfo'
        ')';
  }
}
