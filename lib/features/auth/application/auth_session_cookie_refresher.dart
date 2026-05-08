import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class AuthSessionCookieRefresher implements SessionCookieRefresher {
  AuthSessionCookieRefresher(this._ref);

  final Ref _ref;

  @override
  Future<void> refreshCookies() async {
    final authRepository = _ref.read(authRepositoryProvider);
    final result = await authRepository.checkAndRefreshCookie();
    final error = result.errorOrNull;
    if (error != null) {
      throw StateError('Cookie refresh failed: ${error.message}');
    }
  }
}
