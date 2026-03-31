import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/application/use_case/auth_use_cases.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
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
    unawaited(_init());
    return const AuthState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await ref.read(authUseCasesProvider).initialize();
    final data = result.dataOrNull;
    if (data == null) {
      state = state.copyWith(isLoggedIn: false, user: null, isLoading: false);
      return;
    }

    final user = data.refreshedUser ?? data.cachedUser;
    state = state.copyWith(isLoggedIn: user != null, user: user, isLoading: false);
  }

  Future<List<CountryCode>> getCountryList() async {
    final result = await ref.read(authUseCasesProvider).getCountryList();
    return _unwrapOrDefault(result, const <CountryCode>[]);
  }

  Future<AuthCaptchaChallenge?> getCaptcha() async {
    final result = await ref.read(authUseCasesProvider).getCaptcha();
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
        .read(authUseCasesProvider)
        .sendSms(
          SendSmsCommand(
            cid: cid,
            phone: phone,
            token: token,
            challenge: challenge,
            validate: validate,
            seccode: seccode,
          ),
        );
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
        .read(authUseCasesProvider)
        .loginWithPassword(
          PasswordLoginCommand(
            username: username,
            password: password,
            token: token,
            challenge: challenge,
            validate: validate,
            seccode: seccode,
          ),
        );
    _handleUserResult(result);
  }

  Future<void> loginWithSms(int cid, String phone, String code, String captchaKey) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref
        .read(authUseCasesProvider)
        .loginWithSms(
          SmsLoginCommand(cid: cid, phone: phone, code: code, captchaKey: captchaKey),
        );
    _handleUserResult(result);
  }

  Future<AuthQrCode?> getQrCode() async {
    final result = await ref.read(authUseCasesProvider).getQrCode();
    return _unwrapOrNull(result);
  }

  Future<AuthQrPollResult?> pollQrCode(String authCode) async {
    final result = await ref.read(authUseCasesProvider).pollQrCode(authCode);
    return _unwrapOrNull(result);
  }

  Future<void> logout() async {
    final result = await ref.read(authUseCasesProvider).logout();
    result.when(
      success: (_) {
        state = state.copyWith(isLoggedIn: false, user: null, error: null);
      },
      failure: _storeFailure,
    );
  }

  Future<void> refreshUser() async {
    final result = await ref.read(authUseCasesProvider).refreshUser();
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
