import 'package:culcul/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/auth/data/auth_repository.dart';

part 'auth_controller.g.dart';

class AuthState {
  final bool isLoggedIn;
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  AuthState({this.isLoggedIn = false, this.user, this.isLoading = false, this.error});

  factory AuthState.initial() => AuthState();

  AuthState copyWith({
    bool? isLoggedIn,
    UserEntity? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    Future.microtask(_init);
    return AuthState.initial();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);

    final cachedUser = ref.read(authRepositoryProvider).getCachedUser();
    if (cachedUser != null) {
      state = state.copyWith(isLoggedIn: true, user: cachedUser);
    }

    try {
      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
    } catch (_) {
      final stillCached = ref.read(authRepositoryProvider).getCachedUser();
      if (stillCached != null) {
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(isLoggedIn: false, user: null, isLoading: false);
      }
    }
  }

  Future<Map<String, dynamic>> getCaptcha() async {
    return ref.read(authRepositoryProvider).getCaptcha();
  }

  Future<String> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    return ref
        .read(authRepositoryProvider)
        .sendSms(cid, phone, token, challenge, validate, seccode);
  }

  Future<void> loginWithPassword(
    String username,
    String password,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .loginWithPassword(
            username: username,
            password: password,
            token: token,
            challenge: challenge,
            validate: validate,
            seccode: seccode,
          );
      state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> loginWithSms(int cid, String phone, String code, String captchaKey) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .loginWithSms(cid, phone, code, captchaKey);
      state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getQrCode() async {
    return ref.read(authRepositoryProvider).getQrCode();
  }

  Future<Map<String, dynamic>> pollQrCode(String authCode) async {
    return ref.read(authRepositoryProvider).pollQrCode(authCode);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = state.copyWith(isLoggedIn: false, user: null);
  }

  Future<void> refreshUser() async {
    try {
      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      state = state.copyWith(isLoggedIn: true, user: user);
    } catch (_) {
      // Ignore refresh errors to preserve current UI state.
    }
  }
}
