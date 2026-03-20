// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_danmaku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveDanmakuConfigModel _$LiveDanmakuConfigModelFromJson(
  Map<String, dynamic> json,
) => _LiveDanmakuConfigModel(
  group: (json['group'] as List<dynamic>)
      .map((e) => LiveDanmakuGroup.fromJson(e as Map<String, dynamic>))
      .toList(),
  mode: (json['mode'] as List<dynamic>)
      .map((e) => LiveDanmakuMode.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LiveDanmakuConfigModelToJson(
  _LiveDanmakuConfigModel instance,
) => <String, dynamic>{'group': instance.group, 'mode': instance.mode};

_LiveDanmakuGroup _$LiveDanmakuGroupFromJson(Map<String, dynamic> json) =>
    _LiveDanmakuGroup(
      name: json['name'] as String,
      sort: (json['sort'] as num).toInt(),
      color: (json['color'] as List<dynamic>)
          .map((e) => LiveDanmakuColor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LiveDanmakuGroupToJson(_LiveDanmakuGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sort': instance.sort,
      'color': instance.color,
    };

_LiveDanmakuColor _$LiveDanmakuColorFromJson(Map<String, dynamic> json) =>
    _LiveDanmakuColor(
      name: json['name'] as String,
      color: json['color'] as String,
      colorHex: json['color_hex'] as String,
      status: (json['status'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      colorId: (json['color_id'] as num).toInt(),
      origin: (json['origin'] as num).toInt(),
    );

Map<String, dynamic> _$LiveDanmakuColorToJson(_LiveDanmakuColor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'color_hex': instance.colorHex,
      'status': instance.status,
      'weight': instance.weight,
      'color_id': instance.colorId,
      'origin': instance.origin,
    };

_LiveDanmakuMode _$LiveDanmakuModeFromJson(Map<String, dynamic> json) =>
    _LiveDanmakuMode(
      name: json['name'] as String,
      mode: (json['mode'] as num).toInt(),
      type: json['type'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$LiveDanmakuModeToJson(_LiveDanmakuMode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mode': instance.mode,
      'type': instance.type,
      'status': instance.status,
    };
