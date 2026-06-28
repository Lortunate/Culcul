import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/features/auth/models/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/models/country_code.dart';
import 'package:culcul/features/auth/models/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

class AuthState {
  const AuthState({
    this.isLoggedIn = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  final bool isLoggedIn;
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  AuthState copyWith({
    bool? isLoggedIn,
    Object? user = _undefined,
    bool? isLoading,
    Object? error = _undefined,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user == _undefined ? this.user : user as UserEntity?,
      isLoading: isLoading ?? this.isLoading,
      error: error == _undefined ? this.error : error as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthState &&
            other.isLoggedIn == isLoggedIn &&
            other.user == user &&
            other.isLoading == isLoading &&
            other.error == error;
  }

  @override
  int get hashCode => Object.hash(isLoggedIn, user, isLoading, error);

  @override
  String toString() {
    return 'AuthState(isLoggedIn: $isLoggedIn, user: $user, '
        'isLoading: $isLoading, error: $error)';
  }
}

const Object _undefined = Object();

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
    state = AuthState(isLoggedIn: user != null, user: user);
  }

  Future<List<CountryCode>> getCountryList() async {
    final result = await ref.read(authRepositoryProvider).getCountryList();
    return result.when(
      success: (value) => value,
      failure: (error) {
        _storeFailure(error);
        return const <CountryCode>[];
      },
    );
  }

  Future<AuthCaptchaChallenge?> getCaptcha() async {
    final result = await ref.read(authRepositoryProvider).getCaptchaChallenge();
    return result.when(
      success: (value) => value,
      failure: (error) {
        _storeFailure(error);
        return null;
      },
    );
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
    return result.when(
      success: (value) => value,
      failure: (error) {
        _storeFailure(error);
        return null;
      },
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
    await result.when(
      success: (_) async {
        await ref.read(sessionLogoutCleanerProvider).clearAfterLogout();
        state = state.copyWith(isLoggedIn: false, user: null, error: null);
      },
      failure: (error) async => _storeFailure(error),
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
