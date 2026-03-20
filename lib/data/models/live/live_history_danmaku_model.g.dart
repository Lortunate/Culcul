// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_history_danmaku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveHistoryDanmakuModel _$LiveHistoryDanmakuModelFromJson(
  Map<String, dynamic> json,
) => _LiveHistoryDanmakuModel(
  admin: (json['admin'] as List<dynamic>)
      .map((e) => LiveDanmakuItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  room: (json['room'] as List<dynamic>)
      .map((e) => LiveDanmakuItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LiveHistoryDanmakuModelToJson(
  _LiveHistoryDanmakuModel instance,
) => <String, dynamic>{'admin': instance.admin, 'room': instance.room};

_LiveDanmakuItem _$LiveDanmakuItemFromJson(Map<String, dynamic> json) =>
    _LiveDanmakuItem(
      text: json['text'] as String,
      nickname: json['nickname'] as String,
      uid: (json['uid'] as num).toInt(),
      timeline: json['timeline'] as String? ?? '',
      dmType: (json['dm_type'] as num?)?.toInt() ?? 0,
      isadmin: (json['isadmin'] as num?)?.toInt() ?? 0,
      vip: (json['vip'] as num?)?.toInt() ?? 0,
      svip: (json['svip'] as num?)?.toInt() ?? 0,
      medal: json['medal'] as List<dynamic>? ?? const [],
      title: json['title'] as List<dynamic>? ?? const [],
      userLevel: json['user_level'] as List<dynamic>? ?? const [],
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      teamid: (json['teamid'] as num?)?.toInt() ?? 0,
      rnd: json['rnd'] as String? ?? '',
      userTitle: json['user_title'] as String? ?? '',
      guardLevel: (json['guard_level'] as num?)?.toInt() ?? 0,
      bubble: (json['bubble'] as num?)?.toInt() ?? 0,
      checkInfo: json['check_info'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$LiveDanmakuItemToJson(_LiveDanmakuItem instance) =>
    <String, dynamic>{
      'text': instance.text,
      'nickname': instance.nickname,
      'uid': instance.uid,
      'timeline': instance.timeline,
      'dm_type': instance.dmType,
      'isadmin': instance.isadmin,
      'vip': instance.vip,
      'svip': instance.svip,
      'medal': instance.medal,
      'title': instance.title,
      'user_level': instance.userLevel,
      'rank': instance.rank,
      'teamid': instance.teamid,
      'rnd': instance.rnd,
      'user_title': instance.userTitle,
      'guard_level': instance.guardLevel,
      'bubble': instance.bubble,
      'check_info': instance.checkInfo,
    };
