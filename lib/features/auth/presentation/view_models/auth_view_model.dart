import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.freezed.dart';
part 'auth_view_model.g.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({@Default(false) bool isLoading, String? error}) = _AuthState;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    final session = ref.watch(authSessionProvider);
    return AuthState(isLoading: session.isLoading, error: session.error);
  }

  Future<List<CountryCode>> getCountryList() async {
    return ref.read(authSessionProvider.notifier).getCountryList();
  }

  Future<AuthCaptchaChallenge?> getCaptcha() async {
    return ref.read(authSessionProvider.notifier).getCaptcha();
  }

  Future<String?> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    return ref
        .read(authSessionProvider.notifier)
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
    await ref
        .read(authSessionProvider.notifier)
        .loginWithPassword(username, password, token, challenge, validate, seccode);
  }

  Future<void> loginWithSms(int cid, String phone, String code, String captchaKey) async {
    await ref
        .read(authSessionProvider.notifier)
        .loginWithSms(cid, phone, code, captchaKey);
  }

  Future<void> logout() async {
    await ref.read(authSessionProvider.notifier).logout();
  }

  Future<void> refreshUser() async {
    await ref.read(authSessionProvider.notifier).refreshUser();
  }

  void clearError() {
    ref.read(authSessionProvider.notifier).clearError();
  }
}
