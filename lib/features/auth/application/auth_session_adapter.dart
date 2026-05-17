import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';

/// Bridges core's UserSession contract with auth's domain user.
class AuthSessionAdapter implements UserSession {
  final UserEntity _user;
  AuthSessionAdapter(this._user);

  @override
  String get uid => _user.id;

  @override
  bool get isLoggedIn => true;

  @override
  String? get avatarUrl => _user.avatarUrl;

  @override
  String? get nickname => _user.username;
}
