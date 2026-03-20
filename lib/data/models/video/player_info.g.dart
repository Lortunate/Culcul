// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => _PlayerInfo(
  dmMask: json['dm_mask'] == null
      ? null
      : DmMask.fromJson(json['dm_mask'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlayerInfoToJson(_PlayerInfo instance) =>
    <String, dynamic>{'dm_mask': instance.dmMask};

_DmMask _$DmMaskFromJson(Map<String, dynamic> json) => _DmMask(
  maskUrl: json['mask_url'] as String,
  fps: (json['fps'] as num).toInt(),
);

Map<String, dynamic> _$DmMaskToJson(_DmMask instance) => <String, dynamic>{
  'mask_url': instance.maskUrl,
  'fps': instance.fps,
};
