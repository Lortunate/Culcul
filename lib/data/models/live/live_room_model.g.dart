// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveRoomModel _$LiveRoomModelFromJson(Map<String, dynamic> json) =>
    _LiveRoomModel(
      roomId: (json['roomid'] as num).toInt(),
      uid: (json['uid'] as num).toInt(),
      title: json['title'] as String,
      uname: json['uname'] as String,
      cover: json['cover'] as String,
      face: json['face'] as String,
      online: (json['online'] as num).toInt(),
      areaName: json['area_v2_name'] as String,
      parentAreaName: json['area_v2_parent_name'] as String,
      link: json['link'] as String,
      keyframe: json['keyframe'] as String?,
      watchedShow: json['watched_show'] == null
          ? null
          : WatchedShow.fromJson(json['watched_show'] as Map<String, dynamic>),
      isAutoPlay: (json['is_auto_play'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LiveRoomModelToJson(_LiveRoomModel instance) =>
    <String, dynamic>{
      'roomid': instance.roomId,
      'uid': instance.uid,
      'title': instance.title,
      'uname': instance.uname,
      'cover': instance.cover,
      'face': instance.face,
      'online': instance.online,
      'area_v2_name': instance.areaName,
      'area_v2_parent_name': instance.parentAreaName,
      'link': instance.link,
      'keyframe': instance.keyframe,
      'watched_show': instance.watchedShow,
      'is_auto_play': instance.isAutoPlay,
    };

_WatchedShow _$WatchedShowFromJson(Map<String, dynamic> json) => _WatchedShow(
  switchStatus: json['switch'] as bool,
  num: (json['num'] as num).toInt(),
  textSmall: json['text_small'] as String,
  textLarge: json['text_large'] as String,
  icon: json['icon'] as String,
  iconWeb: json['icon_web'] as String,
);

Map<String, dynamic> _$WatchedShowToJson(_WatchedShow instance) =>
    <String, dynamic>{
      'switch': instance.switchStatus,
      'num': instance.num,
      'text_small': instance.textSmall,
      'text_large': instance.textLarge,
      'icon': instance.icon,
      'icon_web': instance.iconWeb,
    };
