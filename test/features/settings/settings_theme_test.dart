import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/storage/storage_keys.dart';
import 'package:culcul/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AppThemeMode reads and persists the selected theme', () async {
    SharedPreferences.setMockInitialValues({StorageKeys.themeMode: 'ThemeMode.dark'});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    expect(container.read(appThemeModeProvider), ThemeMode.dark);

    await container.read(appThemeModeProvider.notifier).setTheme(ThemeMode.light);

    expect(container.read(appThemeModeProvider), ThemeMode.light);
    expect(prefs.getString(StorageKeys.themeMode), 'ThemeMode.light');
  });
}
