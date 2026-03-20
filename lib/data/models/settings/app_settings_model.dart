import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings_model.freezed.dart';
part 'app_settings_model.g.dart';

@freezed
sealed class AppSettings with _$AppSettings {
  const factory AppSettings({
    String? language,
    String? theme,
    required bool notificationsEnabled,
    required bool autoPlayEnabled,
    required bool highQualityVideoEnabled,
    required bool darkModeEnabled,
    required bool showExplicitContent,
    DateTime? updatedAt,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
