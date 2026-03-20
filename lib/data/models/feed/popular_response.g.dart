// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PopularResponse _$PopularResponseFromJson(Map<String, dynamic> json) =>
    _PopularResponse(
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      noMore: json['no_more'] as bool? ?? false,
    );

Map<String, dynamic> _$PopularResponseToJson(_PopularResponse instance) =>
    <String, dynamic>{'list': instance.list, 'no_more': instance.noMore};
