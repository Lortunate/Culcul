// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserCardModel _$UserCardModelFromJson(Map<String, dynamic> json) =>
    _UserCardModel(
      mid: json['mid'] as String,
      name: json['name'] as String,
      face: json['face'] as String,
      isFollowed: json['isFollowed'] as bool? ?? false,
    );

Map<String, dynamic> _$UserCardModelToJson(_UserCardModel instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'name': instance.name,
      'face': instance.face,
      'isFollowed': instance.isFollowed,
    };
