import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('sharedPreferences must be overridden');
}

class StorageKeys {
  static const String authUserCache = 'session_auth_user_cache';
  static const String themeMode = 'settings_theme_mode';
  static const String searchHistory = 'search_history';
  static const String userCachePrefix = 'user_cache_';
}
