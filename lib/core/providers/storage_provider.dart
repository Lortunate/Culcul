import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
Box<dynamic> sessionStorageBox(Ref ref) {
  throw UnimplementedError('sessionStorageBox must be overridden');
}

@Riverpod(keepAlive: true)
Box<dynamic> settingsStorageBox(Ref ref) {
  throw UnimplementedError('settingsStorageBox must be overridden');
}

@Riverpod(keepAlive: true)
Box<dynamic> searchStorageBox(Ref ref) {
  throw UnimplementedError('searchStorageBox must be overridden');
}

class StorageKeys {
  static const String authUserCache = 'auth_user_cache';
  static const String themeMode = 'theme_mode';
  static const String searchHistory = 'search_history';
}
