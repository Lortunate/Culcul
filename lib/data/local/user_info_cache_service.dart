import 'dart:convert';
import 'package:culcul/data/models/user_profile_model.dart';
import 'package:culcul/domain/entities/user_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      // UserProfileModel inherits from UserProfile, so we can return it directly
      // or use toEntity() if strict separation is needed.
      // Given the existing code uses UserProfileModel.fromEntity, we should verify if toEntity exists or is needed.
      // Based on previous read, UserProfileModel extends UserProfile.
      return UserProfileModel.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUser(UserProfile user) async {
    // Convert to model to access toJson
    final model = user is UserProfileModel ? user : UserProfileModel.fromEntity(user);
    final jsonString = jsonEncode(model.toJson());
    await box.put(user.id, jsonString);
  }
}

@Riverpod(keepAlive: true)
Future<UserInfoCacheService> userInfoCacheService(Ref ref) async {
  // Ensure Hive is initialized (usually in main.dart, but openBox needs to be called)
  final box = await Hive.openBox<String>(UserInfoCacheService.boxName);
  return UserInfoCacheService(box);
}
