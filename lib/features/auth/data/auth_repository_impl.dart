import 'dart:convert';

import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/data/auth_api.dart';
import 'package:culcul/features/auth/data/dtos/auth_dtos.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
import 'package:culcul/features/auth/domain/repositories/auth_repository.dart' as domain;
import 'package:encrypt/encrypt.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
domain.AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    AuthApi(ref.watch(dioClientProvider)),
    ref.watch(sessionStorageBoxProvider),
  );
}

class AuthRepositoryImpl implements domain.AuthRepository {
  final AuthApi _api;
  final Box<dynamic> _box;
  final RequestExecutor _executor;

  AuthRepositoryImpl(this._api, this._box) : _executor = const RequestExecutor();

  @override
  Future<void> checkAndRefreshCookie() async {
    // Basic implementation or placeholder for cookie refresh logic
    // This method is required by TokenInterceptor
  }

  @override
  UserEntity? getCachedUser() {
    final jsonStr = _box.get(StorageKeys.authUserCache);
    if (jsonStr == null) return null;
    try {
      return AuthUserDto.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>).toDomain();
    } catch (e) {
      _box.delete(StorageKeys.authUserCache);
      return null;
    }
  }

  Future<void> _cacheUser(UserEntity user) async {
    await _box.put(
      StorageKeys.authUserCache,
      jsonEncode(AuthUserDto.fromDomain(user).toJson()),
    );
  }

  Future<void> clearCache() async {
    await _box.delete(StorageKeys.authUserCache);
  }

  @override
  Future<Result<UserEntity, AppError>> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  }) async {
    return _executor.run(() async {
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
          return _loadCurrentUser();
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

  @override
  Future<Result<List<CountryCode>, AppError>> getCountryList() async {
    return _executor.run(() async {
      final response = await _api.getCountryList();
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null) {
          final common =
              (data['common'] as List<dynamic>?)
                  ?.map(
                    (e) => CountryCodeDto.fromJson(e as Map<String, dynamic>).toDomain(),
                  )
                  .toList() ??
              [];
          final others =
              (data['others'] as List<dynamic>?)
                  ?.map(
                    (e) => CountryCodeDto.fromJson(e as Map<String, dynamic>).toDomain(),
                  )
                  .toList() ??
              [];
          return [...common, ...others];
        }
        return <CountryCode>[];
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  @override
  Future<Result<AuthCaptchaChallenge, AppError>> getCaptchaChallenge() async {
    final result = await _executor.runApi(
      () async {
        final response = await _api.getCaptcha();
        return ApiResponse<Map<String, dynamic>?>(
          code: response.code,
          message: response.message,
          data: response.data as Map<String, dynamic>?,
        );
      },
      transform: (data) {
        final geetest = data['geetest'] is Map<String, dynamic>
            ? data['geetest'] as Map<String, dynamic>
            : data;
        final token = data['token'] as String?;
        final gt = geetest['gt'] as String?;
        final challenge = geetest['challenge'] as String?;
        if (token == null || gt == null || challenge == null) {
          throw const DataException('Invalid captcha payload');
        }
        return AuthCaptchaChallenge(token: token, gt: gt, challenge: challenge);
      },
    );
    return result;
  }

  @override
  Future<Result<String, AppError>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    return _executor.run(() async {
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

  @override
  Future<Result<UserEntity, AppError>> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  ) async {
    return _executor.run(() async {
      final response = await _api.loginWithSms(cid, phone, code, 'main_web', captchaKey);

      if (response.code == 0) {
        return _loadCurrentUser();
      }
      throw AuthException(response.message, code: response.code);
    });
  }

  @override
  Future<Result<AuthQrCode, AppError>> getQrCode() async {
    return _executor.runApi(
      () async {
        final response = await _api.getQrCode();
        return ApiResponse<Map<String, dynamic>?>(
          code: response.code,
          message: response.message,
          data: response.data as Map<String, dynamic>?,
        );
      },
      transform: (data) {
        final url = data['url'] as String?;
        final key = data['qrcode_key'] as String?;
        if (url == null || key == null) {
          throw const DataException('Invalid QR code payload');
        }
        return AuthQrCode(url: url, key: key);
      },
    );
  }

  @override
  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode) async {
    return _executor.run(() async {
      final response = await _api.pollQrCode(authCode);
      final data = response.data as Map<String, dynamic>? ?? const {};
      final code = (data['code'] as num?)?.toInt() ?? response.code;
      return AuthQrPollResult(
        code: code,
        message: data['message'] as String? ?? response.message,
      );
    });
  }

  @override
  Future<Result<void, AppError>> logout() async {
    return _executor.run(() async {
      await clearCache();
      final response = await _api.logout();
      if (response.code != 0) {
        throw AuthException(response.message, code: response.code);
      }
    });
  }

  @override
  Future<Result<UserEntity, AppError>> getCurrentUser() async {
    return _executor.run(() async {
      return _loadCurrentUser();
    });
  }

  Future<bool> isLoggedIn() async {
    final result = await getCurrentUser();
    return result.isSuccess;
  }

  Future<UserEntity> _loadCurrentUser() async {
    final response = await _api.getCurrentUser();
    if (response.code == 0) {
      final data = response.data as Map<String, dynamic>?;
      if (data != null && data['isLogin'] == true) {
        final levelInfo = data['level_info'] as Map<String, dynamic>?;
        final userDto = AuthUserDto(
          id: data['mid'].toString(),
          username: data['uname'],
          avatarUrl: data['face'],
          email: data['email'],
          createdAt: DateTime.now(),
          level: levelInfo?['current_level'] as int?,
          currentExp: levelInfo?['current_exp'] as int?,
          nextExp: levelInfo?['next_exp'] as int?,
        );
        final user = userDto.toDomain();
        await _cacheUser(user);
        return user;
      }
      await clearCache();
      throw const AuthException('Not logged in');
    }
    throw AuthException(response.message, code: response.code);
  }
}
