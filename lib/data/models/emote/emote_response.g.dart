// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmoteResponse _$EmoteResponseFromJson(Map<String, dynamic> json) =>
    _EmoteResponse(
      packages: (json['packages'] as List<dynamic>)
          .map((e) => EmotePackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmoteResponseToJson(_EmoteResponse instance) =>
    <String, dynamic>{'packages': instance.packages};

_EmotePackage _$EmotePackageFromJson(Map<String, dynamic> json) =>
    _EmotePackage(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      url: json['url'] as String,
      emote: (json['emote'] as List<dynamic>)
          .map((e) => Emote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmotePackageToJson(_EmotePackage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'url': instance.url,
      'emote': instance.emote,
    };

_Emote _$EmoteFromJson(Map<String, dynamic> json) => _Emote(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$EmoteToJson(_Emote instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'url': instance.url,
};
