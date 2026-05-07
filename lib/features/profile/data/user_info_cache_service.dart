import 'dart:convert';

import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_cache_service.g.dart';

class UserInfoCacheService {
  static const String boxName = 'user_info_cache';
  final Box<String> box;

  UserInfoCacheService(this.box);

  Future<UserProfile?> getUser(String uid) async {
    final jsonString = box.get(uid);
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
    await box.put(user.id, jsonString);
  }
}

@Riverpod(keepAlive: true)
Future<UserInfoCacheService> userInfoCacheService(Ref ref) async {
  final box = await Hive.openBox<String>(UserInfoCacheService.boxName);
  return UserInfoCacheService(box);
}
