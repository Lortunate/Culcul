import 'dart:io';

import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:culcul/i18n/strings.g.dart';

class AppBootstrap {
  const AppBootstrap._();

  static Future<AppRuntime> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final results = await Future.wait<dynamic>([
      SharedPreferences.getInstance(),
      _resolveCacheDirectory(),
      getApplicationDocumentsDirectory(),
    ]);

    final prefs = results[0] as SharedPreferences;
    final cacheDirectory = results[1] as Directory;
    final documentDirectory = results[2] as Directory;

    LocaleSettings.useDeviceLocale();
    SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle);

    return AppRuntime(
      cookieJar: PersistCookieJar(
        storage: FileStorage('${documentDirectory.path}/.cookies/'),
      ),
      cacheStore: FileCacheStore('${cacheDirectory.path}/http_cache'),
      prefs: prefs,
    );
  }

  static Future<Directory> _resolveCacheDirectory() async {
    try {
      return await getTemporaryDirectory();
    } catch (error) {
      debugPrint('Failed to get temporary directory: $error');
      return getApplicationDocumentsDirectory();
    }
  }

  static const _systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
}
