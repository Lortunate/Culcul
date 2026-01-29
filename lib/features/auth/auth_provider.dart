import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

class AuthState {
  final bool isLoggedIn;
  final String? username;
  final String? avatarUrl;

  AuthState({required this.isLoggedIn, this.username, this.avatarUrl});

  factory AuthState.initial() => AuthState(isLoggedIn: false);

  AuthState copyWith({bool? isLoggedIn, String? username, String? avatarUrl}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  void login(String username) {
    state = state.copyWith(
      isLoggedIn: true,
      username: username,
      avatarUrl: 'https://picsum.photos/seed/$username/100/100',
    );
  }

  void logout() {
    state = AuthState.initial();
  }
}
