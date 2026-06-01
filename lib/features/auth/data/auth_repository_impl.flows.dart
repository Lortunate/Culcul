part of 'auth_repository_impl.dart';

abstract class _AuthRepositoryFlowsDeps {
  AuthApi get _api;

  RequestExecutor get _executor;

  Future<UserEntity> _loadCurrentUser();
}

mixin _AuthRepositoryFlowsMixin on _AuthRepositoryFlowsDeps {
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
        throw AppError.auth(
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
        throw AppError.auth(
          (data?['message'] as String?) ?? loginResponse.message,
          code: data?['status'] as int?,
        );
      }
      throw AppError.auth(loginResponse.message, code: loginResponse.code);
    });
  }

  Future<Result<List<CountryCode>, AppError>> getCountryList() async {
    return _executor.run(() async {
      final response = await _api.getCountryList();
      if (response.code == 0) {
        final data = response.data as Map<String, dynamic>?;
        if (data != null) {
          final common =
              (data['common'] as List<dynamic>?)
                  ?.map((e) => _countryCodeFromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
          final others =
              (data['others'] as List<dynamic>?)
                  ?.map((e) => _countryCodeFromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
          return [...common, ...others];
        }
        return <CountryCode>[];
      }
      throw AppError.auth(response.message, code: response.code);
    });
  }

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
          throw const AppError.data('Invalid captcha payload');
        }
        return AuthCaptchaChallenge(token: token, gt: gt, challenge: challenge);
      },
    );
  }

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
      throw AppError.auth(response.message, code: response.code);
    });
  }

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
      throw AppError.auth(response.message, code: response.code);
    });
  }

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
          throw const AppError.data('Invalid QR code payload');
        }
        return AuthQrCode(url: url, key: key);
      },
    );
  }

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

  Future<Result<UserEntity, AppError>> getCurrentUser() async {
    return _executor.run(() async => _loadCurrentUser());
  }
}

RSAPublicKey _parsePublicKeyFromPem(String pem) {
  final lines = pem.split('\n').where((line) => !line.startsWith('-----')).join();
  final bytes = base64Decode(lines);

  // X.509 SubjectPublicKeyInfo DER: SEQUENCE { SEQUENCE { OID, NULL }, BIT STRING { SEQUENCE { INTEGER modulus, INTEGER exponent } } }
  int offset = 0;

  int readTagAndLength(Uint8List data, int pos) {
    pos++; // skip tag
    int length = data[pos++];
    if (length & 0x80 != 0) {
      final numBytes = length & 0x7f;
      length = 0;
      for (int i = 0; i < numBytes; i++) {
        length = (length << 8) | data[pos++];
      }
    }
    return pos;
  }

  BigInt readInteger(Uint8List data, int pos) {
    pos++; // skip 0x02 tag
    int length = data[pos++];
    if (length & 0x80 != 0) {
      final numBytes = length & 0x7f;
      length = 0;
      for (int i = 0; i < numBytes; i++) {
        length = (length << 8) | data[pos++];
      }
    }
    final intBytes = data.sublist(pos, pos + length);
    return _bytesToBigInt(intBytes);
  }

  final derBytes = Uint8List.fromList(bytes);

  // Skip outer SEQUENCE
  offset = readTagAndLength(derBytes, offset);
  // Skip algorithm SEQUENCE
  offset++; // tag
  int algLen = derBytes[offset++];
  if (algLen & 0x80 != 0) {
    final n = algLen & 0x7f;
    algLen = 0;
    for (int i = 0; i < n; i++) {
      algLen = (algLen << 8) | derBytes[offset++];
    }
  }
  offset += algLen;

  // BIT STRING
  offset++; // tag 0x03
  int bsLen = derBytes[offset++];
  if (bsLen & 0x80 != 0) {
    final n = bsLen & 0x7f;
    bsLen = 0;
    for (int i = 0; i < n; i++) {
      bsLen = (bsLen << 8) | derBytes[offset++];
    }
  }
  offset++; // skip unused bits byte

  // Inner SEQUENCE containing modulus and exponent
  offset = readTagAndLength(derBytes, offset);

  final modulus = readInteger(derBytes, offset);
  // Advance past modulus
  offset++; // tag
  int modLen = derBytes[offset++];
  if (modLen & 0x80 != 0) {
    final n = modLen & 0x7f;
    modLen = 0;
    for (int i = 0; i < n; i++) {
      modLen = (modLen << 8) | derBytes[offset++];
    }
  }
  offset += modLen;

  final exponent = readInteger(derBytes, offset);

  return RSAPublicKey(modulus, exponent);
}

BigInt _bytesToBigInt(List<int> bytes) {
  var result = BigInt.zero;
  for (final byte in bytes) {
    result = (result << 8) | BigInt.from(byte);
  }
  if (bytes.isNotEmpty && bytes[0] & 0x80 != 0) {
    result -= BigInt.one << (bytes.length * 8);
  }
  return result;
}

String _rsaEncrypt(RSAPublicKey publicKey, String plainText) {
  final cipher = PKCS1Encoding(RSAEngine())
    ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
  final input = Uint8List.fromList(utf8.encode(plainText));
  final output = cipher.process(input);
  return base64Encode(output);
}

CountryCode _countryCodeFromJson(Map<String, dynamic> json) {
  return CountryCode(
    id: json['id'] as int? ?? 0,
    name: json['cname'] as String? ?? '',
    code: '+${json['country_id']?.toString() ?? ''}',
  );
}
