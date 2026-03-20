// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_play_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LivePlayUrlModel _$LivePlayUrlModelFromJson(Map<String, dynamic> json) =>
    _LivePlayUrlModel(
      currentQuality: (json['current_quality'] as num).toInt(),
      acceptQuality: (json['accept_quality'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      currentQn: (json['current_qn'] as num).toInt(),
      qualityDescription: (json['quality_description'] as List<dynamic>)
          .map(
            (e) => LiveQualityDescription.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      durl: (json['durl'] as List<dynamic>)
          .map((e) => LiveStreamUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LivePlayUrlModelToJson(_LivePlayUrlModel instance) =>
    <String, dynamic>{
      'current_quality': instance.currentQuality,
      'accept_quality': instance.acceptQuality,
      'current_qn': instance.currentQn,
      'quality_description': instance.qualityDescription,
      'durl': instance.durl,
    };

_LiveQualityDescription _$LiveQualityDescriptionFromJson(
  Map<String, dynamic> json,
) => _LiveQualityDescription(
  qn: (json['qn'] as num).toInt(),
  desc: json['desc'] as String,
);

Map<String, dynamic> _$LiveQualityDescriptionToJson(
  _LiveQualityDescription instance,
) => <String, dynamic>{'qn': instance.qn, 'desc': instance.desc};

_LiveStreamUrl _$LiveStreamUrlFromJson(Map<String, dynamic> json) =>
    _LiveStreamUrl(
      url: json['url'] as String,
      length: (json['length'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      streamType: (json['stream_type'] as num).toInt(),
      p2pType: (json['p2p_type'] as num).toInt(),
    );

Map<String, dynamic> _$LiveStreamUrlToJson(_LiveStreamUrl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'length': instance.length,
      'order': instance.order,
      'stream_type': instance.streamType,
      'p2p_type': instance.p2pType,
    };
