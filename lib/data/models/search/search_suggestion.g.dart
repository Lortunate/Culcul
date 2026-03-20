// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchSuggestionResponse _$SearchSuggestionResponseFromJson(
  Map<String, dynamic> json,
) => _SearchSuggestionResponse(
  code: (json['code'] as num?)?.toInt(),
  expStr: json['exp_str'] as String?,
  result: const SearchSuggestionResultConverter().fromJson(json['result']),
);

Map<String, dynamic> _$SearchSuggestionResponseToJson(
  _SearchSuggestionResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'exp_str': instance.expStr,
  'result': const SearchSuggestionResultConverter().toJson(instance.result),
};

_SearchSuggestionResult _$SearchSuggestionResultFromJson(
  Map<String, dynamic> json,
) => _SearchSuggestionResult(
  tags: (json['tag'] as List<dynamic>?)
      ?.map((e) => SearchSuggestionTag.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SearchSuggestionResultToJson(
  _SearchSuggestionResult instance,
) => <String, dynamic>{'tag': instance.tags};

_SearchSuggestionTag _$SearchSuggestionTagFromJson(Map<String, dynamic> json) =>
    _SearchSuggestionTag(
      value: json['value'] as String?,
      term: json['term'] as String?,
      ref: json['ref'],
      name: json['name'] as String?,
      spid: json['spid'],
      type: json['type'] as String?,
    );

Map<String, dynamic> _$SearchSuggestionTagToJson(
  _SearchSuggestionTag instance,
) => <String, dynamic>{
  'value': instance.value,
  'term': instance.term,
  'ref': instance.ref,
  'name': instance.name,
  'spid': instance.spid,
  'type': instance.type,
};
