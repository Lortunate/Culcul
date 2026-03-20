// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_anchor_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveAnchorInfoModel _$LiveAnchorInfoModelFromJson(Map<String, dynamic> json) =>
    _LiveAnchorInfoModel(
      info: LiveAnchorInfo.fromJson(json['info'] as Map<String, dynamic>),
      exp: LiveAnchorExp.fromJson(json['exp'] as Map<String, dynamic>),
      followerNum: (json['follower_num'] as num).toInt(),
      roomId: (json['room_id'] as num).toInt(),
      medalName: json['medal_name'] as String,
      gloryCount: (json['glory_count'] as num).toInt(),
      pendant: json['pendant'] as String,
    );

Map<String, dynamic> _$LiveAnchorInfoModelToJson(
  _LiveAnchorInfoModel instance,
) => <String, dynamic>{
  'info': instance.info,
  'exp': instance.exp,
  'follower_num': instance.followerNum,
  'room_id': instance.roomId,
  'medal_name': instance.medalName,
  'glory_count': instance.gloryCount,
  'pendant': instance.pendant,
};

_LiveAnchorInfo _$LiveAnchorInfoFromJson(Map<String, dynamic> json) =>
    _LiveAnchorInfo(
      uid: (json['uid'] as num).toInt(),
      uname: json['uname'] as String,
      face: json['face'] as String,
      officialVerify: LiveAnchorVerify.fromJson(
        json['official_verify'] as Map<String, dynamic>,
      ),
      gender: (json['gender'] as num).toInt(),
    );

Map<String, dynamic> _$LiveAnchorInfoToJson(_LiveAnchorInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'uname': instance.uname,
      'face': instance.face,
      'official_verify': instance.officialVerify,
      'gender': instance.gender,
    };

_LiveAnchorVerify _$LiveAnchorVerifyFromJson(Map<String, dynamic> json) =>
    _LiveAnchorVerify(
      type: (json['type'] as num).toInt(),
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$LiveAnchorVerifyToJson(_LiveAnchorVerify instance) =>
    <String, dynamic>{'type': instance.type, 'desc': instance.desc};

_LiveAnchorExp _$LiveAnchorExpFromJson(Map<String, dynamic> json) =>
    _LiveAnchorExp(
      masterLevel: LiveMasterLevel.fromJson(
        json['master_level'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$LiveAnchorExpToJson(_LiveAnchorExp instance) =>
    <String, dynamic>{'master_level': instance.masterLevel};

_LiveMasterLevel _$LiveMasterLevelFromJson(Map<String, dynamic> json) =>
    _LiveMasterLevel(
      level: (json['level'] as num).toInt(),
      color: (json['color'] as num).toInt(),
      current: (json['current'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      next: (json['next'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$LiveMasterLevelToJson(_LiveMasterLevel instance) =>
    <String, dynamic>{
      'level': instance.level,
      'color': instance.color,
      'current': instance.current,
      'next': instance.next,
    };
