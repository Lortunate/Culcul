import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/auth/application/auth_session_adapter.dart';
import 'package:culcul/features/auth/application/auth_session_cookie_refresher.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_providers.g.dart';

final class AuthSessionState {
  const AuthSessionState({
    this.isLoggedIn = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  final bool isLoggedIn;
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  AuthSessionState copyWith({
    bool? isLoggedIn,
    Object? user = _sentinel,
    bool? isLoading,
    Object? error = _sentinel,
  }) {
    return AuthSessionState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: identical(user, _sentinel) ? this.user : user as UserEntity?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
    );
  }
}

const Object _sentinel = Object();

@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  AuthSessionState build() {
    Future<void>.microtask(_init);
    return const AuthSessionState(isLoading: true);
  }

  Future<void> _init() async {
    final repository = ref.read(authRepositoryProvider);
    final cachedUser = repository.getCachedUser();
    final refreshedResult = await repository.getCurrentUser();
    final user = refreshedResult.dataOrNull ?? cachedUser;
    state = AuthSessionState(isLoggedIn: user != null, user: user);
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

  Future<bool> logout() async {
    final result = await ref.read(authRepositoryProvider).logout();
    return result.when(
      success: (_) async {
        state = state.copyWith(isLoggedIn: false, user: null, error: null);
        return true;
      },
      failure: (error) async {
        _storeFailure(error);
        return false;
      },
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

@riverpod
UserSession? currentUser(Ref ref) {
  final authSession = ref.watch(authSessionProvider);
  final user = authSession.user;
  if (!authSession.isLoggedIn || user == null) return null;
  return AuthSessionAdapter(user);
}

SessionCookieRefresher createAuthSessionCookieRefresher(Ref ref) {
  return AuthSessionCookieRefresher(ref);
}
