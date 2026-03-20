// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmoteResponse _$EmoteResponseFromJson(Map<String, dynamic> json) =>
    EmoteResponse(
      packages: (json['packages'] as List<dynamic>)
          .map((e) => EmotePackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmoteResponseToJson(EmoteResponse instance) =>
    <String, dynamic>{'packages': instance.packages};

EmotePackage _$EmotePackageFromJson(Map<String, dynamic> json) => EmotePackage(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  url: json['url'] as String,
  emote: (json['emote'] as List<dynamic>)
      .map((e) => Emote.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EmotePackageToJson(EmotePackage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'url': instance.url,
      'emote': instance.emote,
    };

Emote _$EmoteFromJson(Map<String, dynamic> json) => Emote(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$EmoteToJson(Emote instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'url': instance.url,
};
