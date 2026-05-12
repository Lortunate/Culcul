import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRuntime {
  final PersistCookieJar cookieJar;
  final FileCacheStore cacheStore;
  final SharedPreferences prefs;

  const AppRuntime({
    required this.cookieJar,
    required this.cacheStore,
    required this.prefs,
  });
}
