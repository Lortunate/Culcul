import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod/misc.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:culcul/i18n/strings.g.dart';

class AppBootstrap {
  const AppBootstrap._();

  static Future<List<Override>> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final prefsFuture = SharedPreferences.getInstance();

    LocaleSettings.useDeviceLocale();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final prefs = await prefsFuture;

    return [sharedPreferencesProvider.overrideWithValue(prefs)];
  }
}
