part of 'auth_repository_impl.dart';

mixin _AuthRepositorySessionMixin on _AuthRepositoryHelpersMixin
    implements domain.AuthRepository {
  abstract final RequestExecutor _executor;

  @override
  Future<Result<void, AppError>> checkAndRefreshCookie() async {
    return const Success(null);
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
}
