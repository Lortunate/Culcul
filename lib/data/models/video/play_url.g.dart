// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayUrl _$PlayUrlFromJson(Map<String, dynamic> json) => _PlayUrl(
  format: json['format'] as String,
  quality: (json['quality'] as num).toInt(),
  timeLength: (json['timelength'] as num).toInt(),
  acceptFormat: json['accept_format'] as String,
  acceptDescription: (json['accept_description'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  acceptQuality: (json['accept_quality'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  videoCodecId: (json['video_codecid'] as num).toInt(),
  durl: (json['durl'] as List<dynamic>)
      .map((e) => Durl.fromJson(e as Map<String, dynamic>))
      .toList(),
  supportFormats:
      (json['support_formats'] as List<dynamic>?)
          ?.map((e) => SupportFormat.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PlayUrlToJson(_PlayUrl instance) => <String, dynamic>{
  'format': instance.format,
  'quality': instance.quality,
  'timelength': instance.timeLength,
  'accept_format': instance.acceptFormat,
  'accept_description': instance.acceptDescription,
  'accept_quality': instance.acceptQuality,
  'video_codecid': instance.videoCodecId,
  'durl': instance.durl,
  'support_formats': instance.supportFormats,
};

_Durl _$DurlFromJson(Map<String, dynamic> json) => _Durl(
  order: (json['order'] as num).toInt(),
  length: (json['length'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  url: json['url'] as String,
  backupUrl:
      (json['backupUrl'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$DurlToJson(_Durl instance) => <String, dynamic>{
  'order': instance.order,
  'length': instance.length,
  'size': instance.size,
  'url': instance.url,
  'backupUrl': instance.backupUrl,
};

_SupportFormat _$SupportFormatFromJson(Map<String, dynamic> json) =>
    _SupportFormat(
      quality: (json['quality'] as num).toInt(),
      format: json['format'] as String,
      newDescription: json['new_description'] as String,
      displayDesc: json['display_desc'] as String,
      superscript: json['superscript'] as String,
      codecs:
          (json['codecs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SupportFormatToJson(_SupportFormat instance) =>
    <String, dynamic>{
      'quality': instance.quality,
      'format': instance.format,
      'new_description': instance.newDescription,
      'display_desc': instance.displayDesc,
      'superscript': instance.superscript,
      'codecs': instance.codecs,
    };
