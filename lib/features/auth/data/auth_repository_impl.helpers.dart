part of 'auth_repository_impl.dart';

mixin _AuthRepositoryHelpersMixin on Object {
  abstract final SharedPreferences _prefs;
  abstract final AuthApi _api;

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

  Future<void> _cacheUser(UserEntity user) async {
    await _prefs.setString(
      StorageKeys.authUserCache,
      jsonEncode(_userEntityToJson(user)),
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
        final user = _userEntityFromJson(<String, dynamic>{
          ...data,
          'created_at': data['created_at'] ?? DateTime.now().toIso8601String(),
        });
        await _cacheUser(user);
        return user;
      }
      await clearCache();
      throw const AppError.auth('Not logged in');
    }
    throw AppError.auth(response.message, code: response.code);
  }
}

UserEntity _userEntityFromJson(Map<String, dynamic> json) {
  final levelInfo = _asMapOrNull(json['level_info']);
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
    level: _asIntOrNull(levelInfo?['current_level']),
    currentExp: _asIntOrNull(levelInfo?['current_exp']),
    nextExp: _asIntOrNull(levelInfo?['next_exp']),
  );
}

Map<String, dynamic> _userEntityToJson(UserEntity entity) {
  return <String, dynamic>{
    'mid': entity.id,
    'uname': entity.username,
    'face': entity.avatarUrl,
    'email': entity.email,
    'created_at': entity.createdAt.toIso8601String(),
    'level_info': <String, dynamic>{
      'current_level': entity.level,
      'current_exp': entity.currentExp,
      'next_exp': entity.nextExp,
    },
  };
}

Map<String, dynamic>? _asMapOrNull(Object? value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return null;
}

int? _asIntOrNull(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return null;
}
