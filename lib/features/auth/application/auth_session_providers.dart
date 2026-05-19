import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/auth/application/auth_session_cookie_refresher.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_providers.g.dart';

@riverpod
UserSession? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) return null;
  return _CurrentUserSession(authState);
}

SessionCookieRefresher createAuthSessionCookieRefresher(Ref ref) {
  return AuthSessionCookieRefresher(ref);
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
