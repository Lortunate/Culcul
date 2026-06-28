import 'dart:convert';
import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/storage/storage_keys.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/auth/data/auth_api.dart';
import 'package:culcul/features/auth/models/country_code.dart';
import 'package:culcul/features/auth/models/user_entity.dart';
import 'package:culcul/features/auth/models/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/models/auth_qr_code.dart';
import 'package:culcul/features/auth/models/auth_qr_poll_result.dart';
import 'package:pointycastle/export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository_impl.g.dart';
part 'auth_repository_impl.flows.dart';

@riverpod
AuthRepositoryImpl authRepository(Ref ref) {
  return AuthRepositoryImpl(
    AuthApi(ref.watch(dioClientProvider)),
    ref.watch(sharedPreferencesProvider),
  );
}

class AuthRepositoryImpl extends _AuthRepositoryFlowsDeps with _AuthRepositoryFlowsMixin {
  @override
  final AuthApi _api;
  final SharedPreferences _prefs;
  @override
  final RequestExecutor _executor;

  AuthRepositoryImpl(this._api, this._prefs) : _executor = const RequestExecutor();

  Future<Result<void, AppError>> checkAndRefreshCookie() async {
    return const Success(null);
  }

  Future<Result<void, AppError>> logout() async {
    return _executor.run(() async {
      await clearCache();
      final response = await _api.logout();
      if (response.code != 0) {
        throw AppError.auth(response.message, code: response.code);
      }
    });
  }

  UserEntity? getCachedUser() {
    final jsonStr = _prefs.getString(StorageKeys.authUserCache);
    if (jsonStr == null) return null;
    try {
      return _userEntityFromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
    } catch (_) {
      _prefs.remove(StorageKeys.authUserCache);
      return null;
    }
  }

  Future<void> clearCache() async {
    await _prefs.remove(StorageKeys.authUserCache);
  }

  Future<bool> isLoggedIn() async {
    try {
      await _loadCurrentUser();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<UserEntity> _loadCurrentUser() async {
    final response = await _api.getCurrentUser();
    if (response.code == 0) {
      final data = response.data as Map<String, dynamic>?;
      if (data != null && data['isLogin'] == true) {
        final user = _userEntityFromJson(<String, dynamic>{
          ...data,
          'created_at': data['created_at'] ?? DateTime.now().toIso8601String(),
        });
        await _prefs.setString(
          StorageKeys.authUserCache,
          jsonEncode(<String, dynamic>{
            'mid': user.id,
            'uname': user.username,
            'face': user.avatarUrl,
            'email': user.email,
            'created_at': user.createdAt.toIso8601String(),
            'level_info': <String, dynamic>{
              'current_level': user.level,
              'current_exp': user.currentExp,
              'next_exp': user.nextExp,
            },
          }),
        );
        return user;
      }
      await clearCache();
      throw const AppError.auth('Not logged in');
    }
    throw AppError.auth(response.message, code: response.code);
  }
}

UserEntity _userEntityFromJson(Map<String, dynamic> json) {
  final levelInfo = JsonUtils.asStringKeyedMap(json['level_info']);
  final createdAtRaw = json['created_at'];
  final createdAt = createdAtRaw is String
      ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
      : DateTime.now();

  return UserEntity(
    id: json['mid']?.toString() ?? '',
    username: json['uname'] as String? ?? '',
    avatarUrl: json['face'] as String?,
    email: json['email'] as String?,
    createdAt: createdAt,
    level: JsonUtils.parseInt(levelInfo?['current_level']),
    currentExp: JsonUtils.parseInt(levelInfo?['current_exp']),
    nextExp: JsonUtils.parseInt(levelInfo?['next_exp']),
  );
}
