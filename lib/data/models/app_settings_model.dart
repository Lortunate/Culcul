import 'package:culcul/domain/entities/app_settings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_settings_model.g.dart';

@JsonSerializable()
class AppSettingsModel extends AppSettings {
  AppSettingsModel({
    super.language,
    super.theme,
    required super.notificationsEnabled,
    required super.autoPlayEnabled,
    required super.highQualityVideoEnabled,
    required super.darkModeEnabled,
    required super.showExplicitContent,
    super.updatedAt,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsModelToJson(this);

  factory AppSettingsModel.fromEntity(AppSettings settings) {
    return AppSettingsModel(
      language: settings.language,
      theme: settings.theme,
      notificationsEnabled: settings.notificationsEnabled,
      autoPlayEnabled: settings.autoPlayEnabled,
      highQualityVideoEnabled: settings.highQualityVideoEnabled,
      darkModeEnabled: settings.darkModeEnabled,
      showExplicitContent: settings.showExplicitContent,
      updatedAt: settings.updatedAt,
    );
  }

  AppSettings toEntity() {
    return AppSettings(
      language: language,
      theme: theme,
      notificationsEnabled: notificationsEnabled,
      autoPlayEnabled: autoPlayEnabled,
      highQualityVideoEnabled: highQualityVideoEnabled,
      darkModeEnabled: darkModeEnabled,
      showExplicitContent: showExplicitContent,
      updatedAt: updatedAt,
    );
  }
}
