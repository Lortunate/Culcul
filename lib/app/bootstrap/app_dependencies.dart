import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:culcul/core/services/audio_handler.dart';

class AppDependencies {
  final PersistCookieJar cookieJar;
  final FileCacheStore cacheStore;
  final Box<dynamic> sessionStorageBox;
  final Box<dynamic> settingsStorageBox;
  final Box<dynamic> searchStorageBox;
  final CilixiliAudioHandler audioHandler;

  const AppDependencies({
    required this.cookieJar,
    required this.cacheStore,
    required this.sessionStorageBox,
    required this.settingsStorageBox,
    required this.searchStorageBox,
    required this.audioHandler,
  });
}
