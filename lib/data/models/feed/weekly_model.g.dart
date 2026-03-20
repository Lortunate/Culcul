// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyModel _$WeeklyModelFromJson(Map<String, dynamic> json) => _WeeklyModel(
  list: (json['list'] as List<dynamic>)
      .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeeklyModelToJson(_WeeklyModel instance) =>
    <String, dynamic>{'list': instance.list};
