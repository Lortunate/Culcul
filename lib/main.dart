import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/app/app.dart';
import 'package:culcul/core/providers/cache_store_provider.dart';
import 'package:culcul/core/providers/cookie_jar_provider.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/services/audio_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await Hive.initFlutter();

  // Initialize AudioService
  final audioHandler = await CilixiliAudioHandler.init();

  // Open the main box for the app
  final box = await Hive.openBox('cilixili_box');

  Directory? cacheDir;
  try {
    cacheDir = await getTemporaryDirectory();
  } catch (e) {
    debugPrint('Failed to get temporary directory: $e');
  }

  final appDocDir = await getApplicationDocumentsDirectory();
  final cookieJar = PersistCookieJar(storage: FileStorage("${appDocDir.path}/.cookies/"));

  final cacheStore = FileCacheStore('${cacheDir?.path ?? appDocDir.path}/http_cache');

  LocaleSettings.useDeviceLocale();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          cookieJarProvider.overrideWithValue(cookieJar),
          cacheStoreProvider.overrideWithValue(cacheStore),
          storageBoxProvider.overrideWithValue(box),
          audioHandlerProvider.overrideWithValue(audioHandler),
        ],
        child: const CulculApp(),
      ),
    ),
  );
}
