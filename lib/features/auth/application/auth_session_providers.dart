import 'package:culcul/core/models/user_session_contract.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/auth/application/auth_controller.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_providers.g.dart';

@riverpod
UserSession? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) return null;
  return _CurrentUserSession(authState);
}

SessionCookieRefresher createAuthSessionCookieRefresher(Ref ref) {
  return _AuthSessionCookieRefresher(ref);
}

final class _AuthSessionCookieRefresher implements SessionCookieRefresher {
  _AuthSessionCookieRefresher(this._ref);

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

class _CurrentUserSession implements UserSession {
  final AuthState _authState;

  const _CurrentUserSession(this._authState);

  @override
  String get uid => _authState.user?.id ?? '';

  @override
  bool get isLoggedIn => _authState.isLoggedIn;

  @override
  String? get avatarUrl => _authState.user?.avatarUrl;

  @override
  String? get nickname => _authState.user?.username;
}
