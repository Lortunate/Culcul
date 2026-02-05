class AppSettings {
  final String? language;
  final String? theme;
  final bool notificationsEnabled;
  final bool autoPlayEnabled;
  final bool highQualityVideoEnabled;
  final bool darkModeEnabled;
  final bool showExplicitContent;
  final DateTime? updatedAt;

  AppSettings({
    this.language,
    this.theme,
    required this.notificationsEnabled,
    required this.autoPlayEnabled,
    required this.highQualityVideoEnabled,
    required this.darkModeEnabled,
    required this.showExplicitContent,
    this.updatedAt,
  });

  AppSettings copyWith({
    String? language,
    String? theme,
    bool? notificationsEnabled,
    bool? autoPlayEnabled,
    bool? highQualityVideoEnabled,
    bool? darkModeEnabled,
    bool? showExplicitContent,
    DateTime? updatedAt,
  }) {
    return AppSettings(
      language: language ?? this.language,
      theme: theme ?? this.theme,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoPlayEnabled: autoPlayEnabled ?? this.autoPlayEnabled,
      highQualityVideoEnabled:
          highQualityVideoEnabled ?? this.highQualityVideoEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      showExplicitContent: showExplicitContent ?? this.showExplicitContent,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          theme == other.theme &&
          notificationsEnabled == other.notificationsEnabled &&
          autoPlayEnabled == other.autoPlayEnabled &&
          highQualityVideoEnabled == other.highQualityVideoEnabled &&
          darkModeEnabled == other.darkModeEnabled &&
          showExplicitContent == other.showExplicitContent &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      language.hashCode ^
      theme.hashCode ^
      notificationsEnabled.hashCode ^
      autoPlayEnabled.hashCode ^
      highQualityVideoEnabled.hashCode ^
      darkModeEnabled.hashCode ^
      showExplicitContent.hashCode ^
      updatedAt.hashCode;
}
