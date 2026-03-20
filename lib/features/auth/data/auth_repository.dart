import 'dart:convert';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/auth_api.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/user_model.dart';
import 'package:culcul/domain/entities/country_code.dart';
import 'package:culcul/domain/entities/user.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/asymmetric/api.dart';

class AuthRepository extends BaseRepository {
  final AuthApi _api;
  final Box _box;
  static const String _userCacheKey = 'auth_user_cache';

  AuthRepository(this._api, this._box);

  Future<void> checkAndRefreshCookie() async {
    // Basic implementation or placeholder for cookie refresh logic
    // This method is required by TokenInterceptor
  }

  User? getCachedUser() {
    final jsonStr = _box.get(_userCacheKey);
    if (jsonStr == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(jsonStr)).toEntity();
    } catch (e) {
      _box.delete(_userCacheKey);
      return null;
    }
  }

  Future<void> _cacheUser(User user) async {
    await _box.put(
      _userCacheKey,
      jsonEncode(UserModel.fromEntity(user).toJson()),
    );
  }

  Future<void> clearCache() async {
    await _box.delete(_userCacheKey);
  }

  // Password Login Flow
  Future<Result<User, AppException>> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  }) async {
    return safeCall(() async {
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
          final userResult = await getCurrentUser();
          return switch (userResult) {
            Success(value: final user) => user,
            Failure(exception: final e) => throw e,
          };
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
  Future<Result<List<CountryCode>, AppException>> getCountryList() async {
    return safeCall(() async {
      final response = await _api.getCountryList();
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null) {
          final common = (data['common'] as List<dynamic>?)
                  ?.map((e) => CountryCode.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
          final others = (data['others'] as List<dynamic>?)
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

  Future<Result<Map<String, dynamic>, AppException>> getCaptcha() async {
    return safeApiCall(() async {
      final response = await _api.getCaptcha();
      return ApiResponse(
        code: response.code,
        message: response.message,
        data: response.data as Map<String, dynamic>?,
      );
    });
  }

  Future<Result<String, AppException>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    return safeCall(() async {
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

  Future<Result<User, AppException>> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  ) async {
    return safeCall(() async {
      final response = await _api.loginWithSms(
        cid,
        phone,
        code,
        'main_web',
        captchaKey,
      );

      if (response.code == 0) {
        final userResult = await getCurrentUser();
        return switch (userResult) {
          Success(value: final user) => user,
          Failure(exception: final e) => throw e,
        };
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  // QR Login Flow
  Future<Result<Map<String, dynamic>, AppException>> getQrCode() async {
    return safeApiCall(() async {
      final response = await _api.getQrCode();
      return ApiResponse(
        code: response.code,
        message: response.message,
        data: response.data as Map<String, dynamic>?,
      );
    });
  }

  Future<Result<Map<String, dynamic>, AppException>> pollQrCode(
    String authCode,
  ) async {
    // pollQrCode returns data even on non-zero code sometimes (e.g. pending),
    // but BaseRepository.safeApiCall treats non-zero as error.
    // However, original code returned Success even if code != 0.
    // "Return data even if code is not 0, as it contains status"
    // So we should use safeCall and handle manually.
    return safeCall(() async {
      final response = await _api.pollQrCode(authCode);
      // We return the data regardless of code, assuming caller handles 'status'
      return response.data as Map<String, dynamic>? ?? {};
    });
  }

  Future<Result<void, AppException>> logout() async {
    return safeCall(() async {
      await clearCache();
      final response = await _api.logout();
      if (response.code != 0) {
        throw AuthException(response.message, code: response.code);
      }
    });
  }

  // User Info
  Future<Result<User, AppException>> getCurrentUser() async {
    return safeCall(() async {
      final response = await _api.getCurrentUser();
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null && data['isLogin'] == true) {
          final levelInfo = data['level_info'] as Map<String, dynamic>?;
          final userModel = UserModel(
            id: data['mid'].toString(),
            username: data['uname'],
            avatarUrl: data['face'],
            email: data['email'],
            createdAt: DateTime.now(),
            level: levelInfo?['current_level'] as int?,
            currentExp: levelInfo?['current_exp'] as int?,
            nextExp: levelInfo?['next_exp'] as int?,
          );
          await _cacheUser(userModel.toEntity());
          return userModel.toEntity();
        } else {
          await clearCache();
          throw const AuthException('Not logged in');
        }
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  Future<bool> isLoggedIn() async {
    final result = await getCurrentUser();
    return result is Success;
  }
}
