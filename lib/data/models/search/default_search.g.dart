// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DefaultSearch _$DefaultSearchFromJson(Map<String, dynamic> json) =>
    _DefaultSearch(
      showName: json['show_name'] as String,
      name: json['name'] as String,
      type: (json['type'] as num).toInt(),
      searchType: json['search_type'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$DefaultSearchToJson(_DefaultSearch instance) =>
    <String, dynamic>{
      'show_name': instance.showName,
      'name': instance.name,
      'type': instance.type,
      'search_type': instance.searchType,
      'id': instance.id,
    };

_DefaultSearchData _$DefaultSearchDataFromJson(Map<String, dynamic> json) =>
    _DefaultSearchData(
      showName: json['show_name'] as String,
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      url: json['url'] as String? ?? '',
      seid: json['seid'] as String? ?? '',
      type: (json['type'] as num?)?.toInt() ?? 0,
      gotoType: (json['goto_type'] as num?)?.toInt() ?? 0,
      gotoValue: json['goto_value'] as String? ?? '',
    );

Map<String, dynamic> _$DefaultSearchDataToJson(_DefaultSearchData instance) =>
    <String, dynamic>{
      'show_name': instance.showName,
      'name': instance.name,
      'id': instance.id,
      'url': instance.url,
      'seid': instance.seid,
      'type': instance.type,
      'goto_type': instance.gotoType,
      'goto_value': instance.gotoValue,
    };
