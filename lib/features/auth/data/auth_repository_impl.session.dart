part of 'auth_repository_impl.dart';

mixin _AuthRepositorySessionMixin on _AuthRepositoryHelpersMixin {
  abstract final RequestExecutor _executor;

  Future<Result<void, AppError>> checkAndRefreshCookie() async {
    return const Success(null);
  }

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
