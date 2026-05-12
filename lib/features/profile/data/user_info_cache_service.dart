import 'dart:convert';

import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_info_cache_service.g.dart';

class UserInfoCacheService {
  final SharedPreferences _prefs;

  UserInfoCacheService(this._prefs);

  Future<UserProfile?> getUser(String uid) async {
    final jsonString = _prefs.getString('${StorageKeys.userCachePrefix}$uid');
    if (jsonString == null) return null;
    try {
      final jsonMap = await jsonDecodeCompute(jsonString);
      if (jsonMap is! Map) return null;
      return UserProfile.fromJson(jsonMap.cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUser(UserProfile user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs.setString('${StorageKeys.userCachePrefix}${user.id}', jsonString);
  }
}

@Riverpod(keepAlive: true)
UserInfoCacheService userInfoCacheService(Ref ref) {
  return UserInfoCacheService(ref.watch(sharedPreferencesProvider));
}
