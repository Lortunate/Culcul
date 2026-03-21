import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

    final result = await ref.read(authRepositoryProvider).getCurrentUser();

    switch (result) {
      case Success(value: final user):
        state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
      case Failure():
        final stillCached = ref.read(authRepositoryProvider).getCachedUser();
        if (stillCached != null) {
          state = state.copyWith(isLoading: false);
        } else {
          state = state.copyWith(isLoggedIn: false, user: null, isLoading: false);
        }
    }
  }

  Future<Map<String, dynamic>> getCaptcha() async {
    final result = await ref.read(authRepositoryProvider).getCaptcha();
    return switch (result) {
      Success(value: final data) => data,
      Failure(exception: final e) => throw e,
    };
  }

  Future<String> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    final result = await ref
        .read(authRepositoryProvider)
        .sendSms(cid, phone, token, challenge, validate, seccode);
    return switch (result) {
      Success(value: final key) => key,
      Failure(exception: final e) => throw e,
    };
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
    final result = await ref
        .read(authRepositoryProvider)
        .loginWithPassword(
          username: username,
          password: password,
          token: token,
          challenge: challenge,
          validate: validate,
          seccode: seccode,
        );

    switch (result) {
      case Success(value: final user):
        state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
      case Failure(exception: final e):
        state = state.copyWith(isLoading: false, error: e.toString());
        throw e;
    }
  }

  Future<void> loginWithSms(int cid, String phone, String code, String captchaKey) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref
        .read(authRepositoryProvider)
        .loginWithSms(cid, phone, code, captchaKey);

    switch (result) {
      case Success(value: final user):
        state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
      case Failure(exception: final e):
        state = state.copyWith(isLoading: false, error: e.toString());
        throw e;
    }
  }

  Future<Map<String, dynamic>> getQrCode() async {
    final result = await ref.read(authRepositoryProvider).getQrCode();
    return switch (result) {
      Success(value: final data) => data,
      Failure(exception: final e) => throw e,
    };
  }

  Future<Map<String, dynamic>> pollQrCode(String authCode) async {
    final result = await ref.read(authRepositoryProvider).pollQrCode(authCode);
    return switch (result) {
      Success(value: final data) => data,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = state.copyWith(isLoggedIn: false, user: null);
  }

  Future<void> refreshUser() async {
    final result = await ref.read(authRepositoryProvider).getCurrentUser();

    switch (result) {
      case Success(value: final user):
        state = state.copyWith(isLoggedIn: true, user: user);
      case Failure():
        break;
    }
  }
}
