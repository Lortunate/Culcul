// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  email: json['email'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  level: (json['level'] as num?)?.toInt(),
  currentExp: (json['currentExp'] as num?)?.toInt(),
  nextExp: (json['nextExp'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'avatarUrl': instance.avatarUrl,
  'email': instance.email,
  'createdAt': instance.createdAt.toIso8601String(),
  'level': instance.level,
  'currentExp': instance.currentExp,
  'nextExp': instance.nextExp,
};
