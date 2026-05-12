import 'dart:convert';

import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/storage/storage_keys.dart';
import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_info_cache_repository.g.dart';

class UserInfoCacheRepository {
  final SharedPreferences _prefs;

  UserInfoCacheRepository(this._prefs);

  Future<ProfileUser?> getUser(String uid) async {
    final jsonString = _prefs.getString('${StorageKeys.userCachePrefix}$uid');
    if (jsonString == null) return null;
    try {
      final jsonMap = await jsonDecodeCompute(jsonString);
      if (jsonMap is! Map) return null;
      return ProfileUser.fromJson(jsonMap.cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUser(ProfileUser user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs.setString('${StorageKeys.userCachePrefix}${user.id}', jsonString);
  }
}

@Riverpod(keepAlive: true)
UserInfoCacheRepository userInfoCacheRepository(Ref ref) {
  return UserInfoCacheRepository(ref.watch(sharedPreferencesProvider));
}
