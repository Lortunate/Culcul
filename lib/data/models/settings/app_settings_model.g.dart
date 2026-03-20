// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  language: json['language'] as String?,
  theme: json['theme'] as String?,
  notificationsEnabled: json['notificationsEnabled'] as bool,
  autoPlayEnabled: json['autoPlayEnabled'] as bool,
  highQualityVideoEnabled: json['highQualityVideoEnabled'] as bool,
  darkModeEnabled: json['darkModeEnabled'] as bool,
  showExplicitContent: json['showExplicitContent'] as bool,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'language': instance.language,
      'theme': instance.theme,
      'notificationsEnabled': instance.notificationsEnabled,
      'autoPlayEnabled': instance.autoPlayEnabled,
      'highQualityVideoEnabled': instance.highQualityVideoEnabled,
      'darkModeEnabled': instance.darkModeEnabled,
      'showExplicitContent': instance.showExplicitContent,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
