import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.freezed.dart';
part 'auth_view_model.g.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoggedIn,
    UserEntity? user,
    @Default(false) bool isLoading,
    String? error,
  }) = _AuthState;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    Future<void>.microtask(_init);
    return const AuthState(isLoading: true);
  }

  Future<void> _init() async {
    final repository = ref.read(authRepositoryProvider);
    final cachedUser = repository.getCachedUser();
    final refreshedResult = await repository.getCurrentUser();
    final user = refreshedResult.dataOrNull ?? cachedUser;
    state = AuthState(isLoggedIn: user != null, user: user, isLoading: false);
  }

  Future<List<CountryCode>> getCountryList() async {
    final result = await ref.read(authRepositoryProvider).getCountryList();
    return _unwrapOrDefault(result, const <CountryCode>[]);
  }

  Future<AuthCaptchaChallenge?> getCaptcha() async {
    final result = await ref.read(authRepositoryProvider).getCaptchaChallenge();
    return _unwrapOrNull(result);
  }

  Future<String?> sendSms(
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
    return _unwrapOrNull(result);
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
    _handleUserResult(result);
  }

  Future<void> loginWithSms(int cid, String phone, String code, String captchaKey) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref
        .read(authRepositoryProvider)
        .loginWithSms(cid, phone, code, captchaKey);
    _handleUserResult(result);
  }

  Future<void> logout() async {
    final result = await ref.read(authRepositoryProvider).logout();
    result.when(
      success: (_) {
        state = state.copyWith(isLoggedIn: false, user: null, error: null);
      },
      failure: _storeFailure,
    );
  }

  Future<void> refreshUser() async {
    final result = await ref.read(authRepositoryProvider).getCurrentUser();
    result.when(
      success: (user) {
        state = state.copyWith(isLoggedIn: true, user: user, error: null);
      },
      failure: _storeFailure,
    );
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  T _unwrapOrDefault<T>(Result<T, AppError> result, T fallback) {
    return result.when(
      success: (value) => value,
      failure: (error) {
        _storeFailure(error);
        return fallback;
      },
    );
  }

  T? _unwrapOrNull<T>(Result<T, AppError> result) {
    return result.when(
      success: (value) => value,
      failure: (error) {
        _storeFailure(error);
        return null;
      },
    );
  }

  void _handleUserResult(Result<UserEntity, AppError> result) {
    result.when(
      success: (user) {
        state = state.copyWith(
          isLoggedIn: true,
          user: user,
          isLoading: false,
          error: null,
        );
      },
      failure: (error) {
        _storeFailure(error);
        state = state.copyWith(isLoading: false);
      },
    );
  }

  void _storeFailure(AppError error) {
    state = state.copyWith(error: error.message, isLoading: false);
  }
}
