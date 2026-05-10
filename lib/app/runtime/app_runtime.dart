import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/app/runtime/stores/search_history_store.dart';
import 'package:culcul/app/runtime/stores/session_store.dart';
import 'package:culcul/app/runtime/stores/settings_store.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';

class AppRuntime {
  final PersistCookieJar cookieJar;
  final FileCacheStore cacheStore;
  final SessionStore sessionStore;
  final SettingsStore settingsStore;
  final SearchHistoryStore searchHistoryStore;

  const AppRuntime({
    required this.cookieJar,
    required this.cacheStore,
    required this.sessionStore,
    required this.settingsStore,
    required this.searchHistoryStore,
  });
}
