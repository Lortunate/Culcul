import 'dart:convert';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/auth_api.dart';
import 'package:culcul/data/models/user_model.dart';
import 'package:culcul/domain/entities/user.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/asymmetric/api.dart';

class AuthRepository {
  final AuthApi _api;
  final Box _box;
  static const String _userCacheKey = 'auth_user_cache';

  AuthRepository(this._api, this._box);

  User? getCachedUser() {
    final jsonStr = _box.get(_userCacheKey);
    if (jsonStr == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(jsonStr));
    } catch (e) {
      _box.delete(_userCacheKey);
      return null;
    }
  }

  Future<void> _cacheUser(User user) async {
    if (user is UserModel) {
      await _box.put(_userCacheKey, jsonEncode(user.toJson()));
    } else {
      await _box.put(
        _userCacheKey,
        jsonEncode(UserModel.fromEntity(user).toJson()),
      );
    }
  }

  Future<void> clearCache() async {
    await _box.delete(_userCacheKey);
  }

  // Password Login Flow
  Future<Result<User, Exception>> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  }) async {
    try {
      // 1. Get Key
      final keyResponse = await _api.getKey();
      if (keyResponse.code != 0) {
        return Failure(
          Exception('Failed to get encryption key: ${keyResponse.message}'),
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
        // status 0: success
        // status 2: risk warning, but possibly logged in or needs verification?
        // Docs say: 0: success.
        if (data != null && data['status'] == 0) {
          return await getCurrentUser();
        } else {
          return Failure(Exception(data?['message'] ?? loginResponse.message));
        }
      }
      return Failure(Exception(loginResponse.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  // SMS Login Flow
  Future<Result<Map<String, dynamic>, Exception>> getCaptcha() async {
    try {
      final response = await _api.getCaptcha();
      if (response.code == 0) {
        return Success(response.data as Map<String, dynamic>? ?? {});
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<Result<String, Exception>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    try {
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
          return Success(data['captcha_key'] as String);
        }
        return const Success('');
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<Result<User, Exception>> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  ) async {
    try {
      final response = await _api.loginWithSms(
        cid,
        phone,
        code,
        'main_web',
        captchaKey,
      );

      if (response.code == 0) {
        // Login successful, now fetch user info to return a proper User
        return await getCurrentUser();
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  // QR Login Flow
  Future<Result<Map<String, dynamic>, Exception>> getQrCode() async {
    try {
      final response = await _api.getQrCode();
      if (response.code == 0) {
        return Success(response.data as Map<String, dynamic>? ?? {});
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<Result<Map<String, dynamic>, Exception>> pollQrCode(
    String authCode,
  ) async {
    try {
      final response = await _api.pollQrCode(authCode);
      if (response.code == 0) {
        return Success(response.data as Map<String, dynamic>? ?? {});
      }
      // Return data even if code is not 0, as it contains status
      return Success(response.data as Map<String, dynamic>? ?? {});
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<Result<void, Exception>> logout() async {
    try {
      await clearCache();
      final response = await _api.logout();
      if (response.code == 0) {
        return const Success(null);
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  // User Info
  Future<Result<User, Exception>> getCurrentUser() async {
    try {
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
          await _cacheUser(userModel);
          return Success(userModel.toEntity());
        } else {
          await clearCache();
          return Failure(Exception('Not logged in'));
        }
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<bool> isLoggedIn() async {
    final result = await getCurrentUser();
    return result is Success;
  }
}
