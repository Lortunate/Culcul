// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_danmu_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveDanmuInfoModel _$LiveDanmuInfoModelFromJson(Map<String, dynamic> json) =>
    _LiveDanmuInfoModel(
      token: json['token'] as String,
      hostList: (json['host_list'] as List<dynamic>)
          .map((e) => LiveDanmuHost.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LiveDanmuInfoModelToJson(_LiveDanmuInfoModel instance) =>
    <String, dynamic>{'token': instance.token, 'host_list': instance.hostList};

_LiveDanmuHost _$LiveDanmuHostFromJson(Map<String, dynamic> json) =>
    _LiveDanmuHost(
      host: json['host'] as String,
      wssPort: (json['wss_port'] as num).toInt(),
      wsPort: (json['ws_port'] as num).toInt(),
    );

Map<String, dynamic> _$LiveDanmuHostToJson(_LiveDanmuHost instance) =>
    <String, dynamic>{
      'host': instance.host,
      'wss_port': instance.wssPort,
      'ws_port': instance.wsPort,
    };
