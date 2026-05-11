import 'dart:io';

import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:culcul/i18n/strings.g.dart';

class AppBootstrap {
  const AppBootstrap._();

  static Future<AppRuntime> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    final results = await Future.wait<dynamic>([
      Hive.openBox('culcul_session_box'),
      Hive.openBox('culcul_settings_box'),
      Hive.openBox('culcul_search_box'),
      _resolveCacheDirectory(),
      getApplicationDocumentsDirectory(),
    ]);

    final sessionStorageBox = results[0] as Box<dynamic>;
    final settingsStorageBox = results[1] as Box<dynamic>;
    final searchStorageBox = results[2] as Box<dynamic>;
    final cacheDirectory = results[3] as Directory;
    final documentDirectory = results[4] as Directory;

    LocaleSettings.useDeviceLocale();
    SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle);

    return AppRuntime(
      cookieJar: PersistCookieJar(
        storage: FileStorage('${documentDirectory.path}/.cookies/'),
      ),
      cacheStore: FileCacheStore('${cacheDirectory.path}/http_cache'),
      sessionBox: sessionStorageBox,
      settingsBox: settingsStorageBox,
      searchHistoryBox: searchStorageBox,
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
