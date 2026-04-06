import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path_provider/path_provider.dart';

import 'package:culcul/app/bootstrap/app_dependencies.dart';
import 'package:culcul/i18n/strings.g.dart';

class AppBootstrap {
  const AppBootstrap._();

  static Future<AppDependencies> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();
    await Hive.initFlutter();

    final sessionStorageBox = await Hive.openBox('culcul_session_box');
    final settingsStorageBox = await Hive.openBox('culcul_settings_box');
    final searchStorageBox = await Hive.openBox('culcul_search_box');

    final cacheDirectory = await _resolveCacheDirectory();
    final documentDirectory = await getApplicationDocumentsDirectory();

    LocaleSettings.useDeviceLocale();
    SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle);

    return AppDependencies(
      cookieJar: PersistCookieJar(
        storage: FileStorage('${documentDirectory.path}/.cookies/'),
      ),
      cacheStore: FileCacheStore('${cacheDirectory.path}/http_cache'),
      sessionStorageBox: sessionStorageBox,
      settingsStorageBox: settingsStorageBox,
      searchStorageBox: searchStorageBox,
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
