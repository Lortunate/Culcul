import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_actions.g.dart';

@riverpod
AuthSessionActions authSessionActions(Ref ref) {
  return AuthSessionActions(ref);
}

class AuthSessionActions {
  const AuthSessionActions(this._ref);

  final Ref _ref;

  Future<bool> logout() {
    return _ref.read(authSessionProvider.notifier).logout();
  }
}
