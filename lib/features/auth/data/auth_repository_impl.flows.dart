part of 'auth_repository_impl.dart';

mixin _AuthRepositoryFlowsMixin on _AuthRepositoryHelpersMixin
    implements domain.AuthRepository {
  abstract final RequestExecutor _executor;

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

      final publicKey = _parsePublicKeyFromPem(pubKeyPem);
      final encryptedPassword = _rsaEncrypt(publicKey, hash + password);

      final loginResponse = await _api.loginWithPassword(
        username,
        encryptedPassword,
        0,
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
        }
        throw AuthException(
          (data?['message'] as String?) ?? loginResponse.message,
          code: data?['status'] as int?,
        );
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
    return _executor.runApi(
      () async {
        final response = await _api.getCaptcha();
        return ApiResponse<Map<String, dynamic>>(
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
        return ApiResponse<Map<String, dynamic>>(
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
  Future<Result<UserEntity, AppError>> getCurrentUser() async {
    return _executor.run(() async => _loadCurrentUser());
  }
}
