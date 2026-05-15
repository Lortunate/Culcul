import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_actions.g.dart';

@riverpod
AuthSessionActions authSessionActions(Ref ref) {
  return AuthSessionActions(ref);
}

class AuthSessionActions {
  const AuthSessionActions(this._ref);

  final Ref _ref;

  Future<void> logout() {
    return _ref.read(authProvider.notifier).logout();
  }
}
