import 'dart:async';

import 'package:culcul/domain/entities/country_code.dart';
import 'package:culcul/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/application/use_case/auth_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

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
    unawaited(_init());
    return AuthState.initial();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(authUseCasesProvider).initialize();
    final data = result.dataOrNull;
    if (data == null) {
      state = state.copyWith(isLoggedIn: false, user: null, isLoading: false);
      return;
    }

    if (data.cachedUser != null) {
      state = state.copyWith(isLoggedIn: true, user: data.cachedUser);
    }
    final refreshedUser = data.refreshedUser;
    if (refreshedUser != null) {
      state = state.copyWith(isLoggedIn: true, user: refreshedUser, isLoading: false);
      return;
    }

    if (data.cachedUser != null) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoggedIn: false, user: null, isLoading: false);
  }

  Future<List<CountryCode>> getCountryList() async {
    final result = await ref.read(authUseCasesProvider).getCountryList();
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
  }

  Future<Map<String, dynamic>> getCaptcha() async {
    final result = await ref.read(authUseCasesProvider).getCaptcha();
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
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
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
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
    result.when(
      success: (user) {
        state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.message);
        throw Exception(error.message);
      },
    );
  }

  Future<void> loginWithSms(int cid, String phone, String code, String captchaKey) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref
        .read(authUseCasesProvider)
        .loginWithSms(
          SmsLoginCommand(cid: cid, phone: phone, code: code, captchaKey: captchaKey),
        );
    result.when(
      success: (user) {
        state = state.copyWith(isLoggedIn: true, user: user, isLoading: false);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.message);
        throw Exception(error.message);
      },
    );
  }

  Future<Map<String, dynamic>> getQrCode() async {
    final result = await ref.read(authUseCasesProvider).getQrCode();
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
  }

  Future<Map<String, dynamic>> pollQrCode(String authCode) async {
    final result = await ref.read(authUseCasesProvider).pollQrCode(authCode);
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
  }

  Future<void> logout() async {
    final result = await ref.read(authUseCasesProvider).logout();
    result.when(
      success: (_) => state = state.copyWith(isLoggedIn: false, user: null),
      failure: (error) {
        state = state.copyWith(error: error.message);
      },
    );
  }

  Future<void> refreshUser() async {
    final result = await ref.read(authUseCasesProvider).refreshUser();
    result.when(
      success: (user) => state = state.copyWith(isLoggedIn: true, user: user),
      failure: (_) {},
    );
  }
}
