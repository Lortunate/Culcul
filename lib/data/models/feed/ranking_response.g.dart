// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankingResponse _$RankingResponseFromJson(Map<String, dynamic> json) =>
    _RankingResponse(
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RankingResponseToJson(_RankingResponse instance) =>
    <String, dynamic>{'list': instance.list};
