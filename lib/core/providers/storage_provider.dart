import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
Box storageBox(Ref ref) {
  throw UnimplementedError('storageBox must be overridden');
}

class StorageKeys {
  static const String user = 'auth_user';
  static const String settings = 'app_settings';
  static const String searchHistory = 'search_history';
}
