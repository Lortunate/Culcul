// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyModel _$WeeklyModelFromJson(Map<String, dynamic> json) => WeeklyModel(
  list: (json['list'] as List<dynamic>)
      .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeeklyModelToJson(WeeklyModel instance) =>
    <String, dynamic>{'list': instance.list};
