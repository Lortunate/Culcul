// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RelationResponseData _$RelationResponseDataFromJson(
  Map<String, dynamic> json,
) => _RelationResponseData(
  list:
      (json['list'] as List<dynamic>?)
          ?.map((e) => RelationUser.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RelationResponseDataToJson(
  _RelationResponseData instance,
) => <String, dynamic>{'list': instance.list, 'total': instance.total};

_RelationUser _$RelationUserFromJson(Map<String, dynamic> json) =>
    _RelationUser(
      mid: (json['mid'] as num).toInt(),
      uname: json['uname'] as String,
      face: json['face'] as String,
      sign: json['sign'] as String? ?? '',
      attribute: (json['attribute'] as num?)?.toInt() ?? 0,
      officialVerify: json['official_verify'] == null
          ? null
          : OfficialVerify.fromJson(
              json['official_verify'] as Map<String, dynamic>,
            ),
      vip: json['vip'] == null
          ? null
          : VipInfo.fromJson(json['vip'] as Map<String, dynamic>),
      mtime: (json['mtime'] as num?)?.toInt() ?? 0,
      special: (json['special'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RelationUserToJson(_RelationUser instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'uname': instance.uname,
      'face': instance.face,
      'sign': instance.sign,
      'attribute': instance.attribute,
      'official_verify': instance.officialVerify,
      'vip': instance.vip,
      'mtime': instance.mtime,
      'special': instance.special,
    };

_OfficialVerify _$OfficialVerifyFromJson(Map<String, dynamic> json) =>
    _OfficialVerify(
      type: (json['type'] as num?)?.toInt() ?? -1,
      desc: json['desc'] as String? ?? '',
    );

Map<String, dynamic> _$OfficialVerifyToJson(_OfficialVerify instance) =>
    <String, dynamic>{'type': instance.type, 'desc': instance.desc};

_VipInfo _$VipInfoFromJson(Map<String, dynamic> json) => _VipInfo(
  vipType: (json['vipType'] as num?)?.toInt() ?? 0,
  vipStatus: (json['vipStatus'] as num?)?.toInt() ?? 0,
  nicknameColor: json['nicknameColor'] as String? ?? '',
);

Map<String, dynamic> _$VipInfoToJson(_VipInfo instance) => <String, dynamic>{
  'vipType': instance.vipType,
  'vipStatus': instance.vipStatus,
  'nicknameColor': instance.nicknameColor,
};
