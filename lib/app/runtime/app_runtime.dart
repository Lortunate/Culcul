import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRuntime {
  final PersistCookieJar cookieJar;
  final FileCacheStore cacheStore;
  final Box<dynamic> sessionBox;
  final Box<dynamic> settingsBox;
  final Box<dynamic> searchHistoryBox;

  const AppRuntime({
    required this.cookieJar,
    required this.cacheStore,
    required this.sessionBox,
    required this.settingsBox,
    required this.searchHistoryBox,
  });
}
