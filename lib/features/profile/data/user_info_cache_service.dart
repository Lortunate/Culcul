import 'dart:convert';

import 'package:culcul/features/profile/models/user_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_cache_service.g.dart';

class UserInfoCacheService {
  static const String boxName = 'user_info_cache';
  final Box<String> box;

  UserInfoCacheService(this.box);

  UserProfile? getUser(String uid) {
    final jsonString = box.get(uid);
    if (jsonString == null) return null;
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProfile.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUser(UserProfile user) async {
    final jsonString = jsonEncode(user.toJson());
    await box.put(user.id, jsonString);
  }
}

@Riverpod(keepAlive: true)
Future<UserInfoCacheService> userInfoCacheService(Ref ref) async {
  final box = await Hive.openBox<String>(UserInfoCacheService.boxName);
  return UserInfoCacheService(box);
}
