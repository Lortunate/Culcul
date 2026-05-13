part of 'auth_repository_impl.dart';

RSAPublicKey _parsePublicKeyFromPem(String pem) {
  final lines = pem
      .split('\n')
      .where((line) => !line.startsWith('-----'))
      .join();
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

mixin _AuthRepositoryHelpersMixin on Object {
  abstract final SharedPreferences _prefs;
  abstract final AuthApi _api;

  UserEntity? getCachedUser() {
    final jsonStr = _prefs.getString(StorageKeys.authUserCache);
    if (jsonStr == null) return null;
    try {
      return AuthUserDto.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>).toDomain();
    } catch (_) {
      _prefs.remove(StorageKeys.authUserCache);
      return null;
    }
  }

  Future<void> _cacheUser(UserEntity user) async {
    await _prefs.setString(
      StorageKeys.authUserCache,
      jsonEncode(AuthUserDto.fromDomain(user).toJson()),
    );
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

  Future<UserEntity> _loadCurrentUser() async {
    final response = await _api.getCurrentUser();
    if (response.code == 0) {
      final data = response.data as Map<String, dynamic>?;
      if (data != null && data['isLogin'] == true) {
        final levelInfo = data['level_info'] as Map<String, dynamic>?;
        final userDto = AuthUserDto(
          id: (data['mid'] as Object).toString(),
          username: data['uname'] as String,
          avatarUrl: data['face'] as String,
          email: data['email'] as String?,
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
      throw const AppError.auth('Not logged in');
    }
    throw AppError.auth(response.message, code: response.code);
  }
}
