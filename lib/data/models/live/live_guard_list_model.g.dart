// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_guard_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveGuardListModel _$LiveGuardListModelFromJson(Map<String, dynamic> json) =>
    _LiveGuardListModel(
      info: LiveGuardInfo.fromJson(json['info'] as Map<String, dynamic>),
      top3:
          (json['top3'] as List<dynamic>?)
              ?.map((e) => LiveGuardItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => LiveGuardItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LiveGuardListModelToJson(_LiveGuardListModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'top3': instance.top3,
      'list': instance.list,
    };

_LiveGuardInfo _$LiveGuardInfoFromJson(Map<String, dynamic> json) =>
    _LiveGuardInfo(
      num: (json['num'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      now: (json['now'] as num).toInt(),
    );

Map<String, dynamic> _$LiveGuardInfoToJson(_LiveGuardInfo instance) =>
    <String, dynamic>{
      'num': instance.num,
      'page': instance.page,
      'now': instance.now,
    };

_LiveGuardItem _$LiveGuardItemFromJson(Map<String, dynamic> json) =>
    _LiveGuardItem(
      ruid: (json['ruid'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      userInfo: LiveGuardUserInfo.fromJson(
        json['uinfo'] as Map<String, dynamic>,
      ),
      guardLevel: (json['guard_level'] as num).toInt(),
    );

Map<String, dynamic> _$LiveGuardItemToJson(_LiveGuardItem instance) =>
    <String, dynamic>{
      'ruid': instance.ruid,
      'rank': instance.rank,
      'uinfo': instance.userInfo,
      'guard_level': instance.guardLevel,
    };

_LiveGuardUserInfo _$LiveGuardUserInfoFromJson(Map<String, dynamic> json) =>
    _LiveGuardUserInfo(
      uid: (json['uid'] as num).toInt(),
      base: LiveGuardUserBase.fromJson(json['base'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveGuardUserInfoToJson(_LiveGuardUserInfo instance) =>
    <String, dynamic>{'uid': instance.uid, 'base': instance.base};

_LiveGuardUserBase _$LiveGuardUserBaseFromJson(Map<String, dynamic> json) =>
    _LiveGuardUserBase(
      name: json['name'] as String,
      face: json['face'] as String,
    );

Map<String, dynamic> _$LiveGuardUserBaseToJson(_LiveGuardUserBase instance) =>
    <String, dynamic>{'name': instance.name, 'face': instance.face};
