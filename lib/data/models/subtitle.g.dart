// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoSubtitle _$VideoSubtitleFromJson(Map<String, dynamic> json) =>
    _VideoSubtitle(
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => SubtitleInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$VideoSubtitleToJson(_VideoSubtitle instance) =>
    <String, dynamic>{'list': instance.list};

_SubtitleInfo _$SubtitleInfoFromJson(Map<String, dynamic> json) =>
    _SubtitleInfo(
      id: (json['id'] as num).toInt(),
      lan: json['lan'] as String,
      lanDoc: json['lan_doc'] as String,
      subtitleUrl: json['subtitle_url'] as String,
      isLock: json['is_lock'] as bool? ?? false,
      idStr: json['id_str'] as String?,
      type: (json['type'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SubtitleInfoToJson(_SubtitleInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lan': instance.lan,
      'lan_doc': instance.lanDoc,
      'subtitle_url': instance.subtitleUrl,
      'is_lock': instance.isLock,
      'id_str': instance.idStr,
      'type': instance.type,
    };

_SubtitleContent _$SubtitleContentFromJson(Map<String, dynamic> json) =>
    _SubtitleContent(
      fontSize: (json['font_size'] as num?)?.toDouble(),
      fontColor: json['font_color'] as String?,
      backgroundAlpha: (json['background_alpha'] as num?)?.toDouble(),
      backgroundColor: json['background_color'] as String?,
      body:
          (json['body'] as List<dynamic>?)
              ?.map((e) => SubtitleItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SubtitleContentToJson(_SubtitleContent instance) =>
    <String, dynamic>{
      'font_size': instance.fontSize,
      'font_color': instance.fontColor,
      'background_alpha': instance.backgroundAlpha,
      'background_color': instance.backgroundColor,
      'body': instance.body,
    };

_SubtitleItem _$SubtitleItemFromJson(Map<String, dynamic> json) =>
    _SubtitleItem(
      from: (json['from'] as num).toDouble(),
      to: (json['to'] as num).toDouble(),
      location: (json['location'] as num).toInt(),
      content: json['content'] as String,
    );

Map<String, dynamic> _$SubtitleItemToJson(_SubtitleItem instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'location': instance.location,
      'content': instance.content,
    };
