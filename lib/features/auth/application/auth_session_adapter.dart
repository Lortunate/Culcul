import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';

/// Bridges core's UserSession contract with auth's AuthState.
class AuthSessionAdapter implements UserSession {
  final AuthState _authState;
  AuthSessionAdapter(this._authState);

  @override
  String get uid => _authState.user?.id ?? '';

  @override
  bool get isLoggedIn => _authState.isLoggedIn;

  @override
  String? get avatarUrl => _authState.user?.avatarUrl;

  @override
  String? get nickname => _authState.user?.username;
}
