/// Minimal user session state needed by features outside auth.
/// Features should depend on this contract, not on auth's internal view models.
abstract interface class UserSession {
  String get uid;
  bool get isLoggedIn;
  String? get avatarUrl;
  String? get nickname;
}
