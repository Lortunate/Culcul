enum AppThemePreference {
  system,
  light,
  dark;

  String get storageValue => 'ThemeMode.$name';

  static AppThemePreference fromStorage(String? value) {
    return switch (value) {
      'ThemeMode.light' || 'light' => AppThemePreference.light,
      'ThemeMode.dark' || 'dark' => AppThemePreference.dark,
      _ => AppThemePreference.system,
    };
  }
}
