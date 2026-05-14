import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_provider.g.dart';

SharedPreferences? _sharedPreferencesInstance;

void initializeSharedPreferences(SharedPreferences sharedPreferences) {
  _sharedPreferencesInstance = sharedPreferences;
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  final sharedPreferences = _sharedPreferencesInstance;
  if (sharedPreferences == null) {
    throw StateError('sharedPreferencesProvider not initialized');
  }
  return sharedPreferences;
}
