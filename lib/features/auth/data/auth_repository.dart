import 'dart:convert';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/auth_api.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/user/user_model.dart' as data_user;
import 'package:culcul/domain/entities/country_code.dart';
import 'package:culcul/domain/entities/user_entity.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(authApiProvider), ref.watch(storageBoxProvider));
}

class AuthRepository extends BaseRepository {
  final AuthApi _api;
  final Box _box;
  static const String _userCacheKey = 'auth_user_cache';

  AuthRepository(this._api, this._box);

  Future<void> checkAndRefreshCookie() async {
    // Basic implementation or placeholder for cookie refresh logic
    // This method is required by TokenInterceptor
  }

  UserEntity _toDomainUser(data_user.User user) {
    return UserEntity(
      id: user.id,
      username: user.username,
      avatarUrl: user.avatarUrl,
      email: user.email,
      createdAt: user.createdAt,
      level: user.level,
      currentExp: user.currentExp,
      nextExp: user.nextExp,
    );
  }

  data_user.User _toDataUser(UserEntity user) {
    return data_user.User(
      id: user.id,
      username: user.username,
      avatarUrl: user.avatarUrl,
      email: user.email,
      createdAt: user.createdAt,
      level: user.level,
      currentExp: user.currentExp,
      nextExp: user.nextExp,
    );
  }

  UserEntity? getCachedUser() {
    final jsonStr = _box.get(_userCacheKey);
    if (jsonStr == null) return null;
    try {
      return _toDomainUser(
        data_user.User.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>),
      );
    } catch (e) {
      _box.delete(_userCacheKey);
      return null;
    }
  }

  Future<void> _cacheUser(UserEntity user) async {
    await _box.put(_userCacheKey, jsonEncode(_toDataUser(user).toJson()));
  }

  Future<void> clearCache() async {
    await _box.delete(_userCacheKey);
  }

  // Password Login Flow
  Future<UserEntity> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  }) async {
    return request(() async {
      // 1. Get Key
      final keyResponse = await _api.getKey();
      if (keyResponse.code != 0) {
        throw AuthException(
          'Failed to get encryption key: ${keyResponse.message}',
          code: keyResponse.code,
        );
      }
      final keyData = keyResponse.data as Map<String, dynamic>;
      final hash = keyData['hash'] as String;
      final pubKeyPem = keyData['key'] as String;

      // 2. Encrypt Password
      final parser = RSAKeyParser();
      final publicKey = parser.parse(pubKeyPem) as RSAPublicKey;
      final encrypter = Encrypter(RSA(publicKey: publicKey));
      final encrypted = encrypter.encrypt(hash + password);
      final encryptedPassword = encrypted.base64;

      // 3. Login
      final loginResponse = await _api.loginWithPassword(
        username,
        encryptedPassword,
        0, // keep
        token,
        challenge,
        validate,
        seccode,
        'main_web',
      );

      if (loginResponse.code == 0) {
        final data = loginResponse.data as Map<String, dynamic>?;
        if (data != null && data['status'] == 0) {
          return getCurrentUser();
        } else {
          throw AuthException(
            data?['message'] ?? loginResponse.message,
            code: data?['status'],
          );
        }
      }
      throw AuthException(loginResponse.message, code: loginResponse.code);
    });
  }

  // SMS Login Flow
  Future<List<CountryCode>> getCountryList() async {
    return request(() async {
      final response = await _api.getCountryList();
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null) {
          final common =
              (data['common'] as List<dynamic>?)
                  ?.map((e) => CountryCode.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
          final others =
              (data['others'] as List<dynamic>?)
                  ?.map((e) => CountryCode.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
          return [...common, ...others];
        }
        return <CountryCode>[];
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  Future<Map<String, dynamic>> getCaptcha() async {
    return requestApi(() async {
      final response = await _api.getCaptcha();
      return ApiResponse(
        code: response.code,
        message: response.message,
        data: response.data as Map<String, dynamic>?,
      );
    });
  }

  Future<String> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    return request(() async {
      final response = await _api.sendSms(
        cid,
        phone,
        'main_web',
        token,
        challenge,
        validate,
        seccode,
      );
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null && data.containsKey('captcha_key')) {
          return data['captcha_key'] as String;
        }
        return '';
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  Future<UserEntity> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  ) async {
    return request(() async {
      final response = await _api.loginWithSms(cid, phone, code, 'main_web', captchaKey);

      if (response.code == 0) {
        return getCurrentUser();
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  // QR Login Flow
  Future<Map<String, dynamic>> getQrCode() async {
    return requestApi(() async {
      final response = await _api.getQrCode();
      return ApiResponse(
        code: response.code,
        message: response.message,
        data: response.data as Map<String, dynamic>?,
      );
    });
  }

  Future<Map<String, dynamic>> pollQrCode(String authCode) async {
    // pollQrCode returns data even on non-zero code sometimes (e.g. pending),
    // but BaseRepository.safeApiCall treats non-zero as error.
    // However, original code returned Success even if code != 0.
    // "Return data even if code is not 0, as it contains status"
    // So we should use safeCall and handle manually.
    return request(() async {
      final response = await _api.pollQrCode(authCode);
      // We return the data regardless of code, assuming caller handles 'status'
      return response.data as Map<String, dynamic>? ?? {};
    });
  }

  Future<void> logout() async {
    return request(() async {
      await clearCache();
      final response = await _api.logout();
      if (response.code != 0) {
        throw AuthException(response.message, code: response.code);
      }
    });
  }

  // User Info
  Future<UserEntity> getCurrentUser() async {
    return request(() async {
      final response = await _api.getCurrentUser();
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null && data['isLogin'] == true) {
          final levelInfo = data['level_info'] as Map<String, dynamic>?;
          final userModel = data_user.User(
            id: data['mid'].toString(),
            username: data['uname'],
            avatarUrl: data['face'],
            email: data['email'],
            createdAt: DateTime.now(),
            level: levelInfo?['current_level'] as int?,
            currentExp: levelInfo?['current_exp'] as int?,
            nextExp: levelInfo?['next_exp'] as int?,
          );
          final user = _toDomainUser(userModel);
          await _cacheUser(user);
          return user;
        } else {
          await clearCache();
          throw const AuthException('Not logged in');
        }
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  Future<bool> isLoggedIn() async {
    try {
      await getCurrentUser();
      return true;
    } catch (_) {
      return false;
    }
  }
}
