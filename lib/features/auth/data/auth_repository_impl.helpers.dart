part of 'auth_repository_impl.dart';

mixin _AuthRepositoryHelpersMixin on Object {
  abstract final Box<dynamic> _box;
  abstract final AuthApi _api;

  UserEntity? getCachedUser() {
    final jsonStr = _box.get(StorageKeys.authUserCache);
    if (jsonStr == null) return null;
    try {
      return AuthUserDto.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>).toDomain();
    } catch (_) {
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
