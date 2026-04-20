import 'dart:async';

import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/domain/repositories/auth_repository.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({this.cachedUser, required this.currentUserCompleter});

  final UserEntity? cachedUser;
  final Completer<Result<UserEntity, AppError>> currentUserCompleter;

  @override
  UserEntity? getCachedUser() => cachedUser;

  @override
  Future<Result<UserEntity, AppError>> getCurrentUser() => currentUserCompleter.future;

  @override
  Future<Result<void, AppError>> checkAndRefreshCookie() async => const Success(null);

  @override
  Future<Result<AuthCaptchaChallenge, AppError>> getCaptchaChallenge() {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<CountryCode>, AppError>> getCountryList() {
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthQrCode, AppError>> getQrCode() {
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity, AppError>> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity, AppError>> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode) {
    throw UnimplementedError();
  }

  @override
  Future<Result<String, AppError>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) {
    throw UnimplementedError();
  }
}

Future<void> _flushMicrotasks() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  test('authProvider initializes without uninitialized state error', () async {
    final completer = Completer<Result<UserEntity, AppError>>();
    final cachedUser = UserEntity(
      id: '1',
      username: 'cached',
      createdAt: DateTime(2026, 1, 1),
    );
    final repository = _FakeAuthRepository(
      cachedUser: cachedUser,
      currentUserCompleter: completer,
    );

    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final initial = container.read(authProvider);
    expect(initial.isLoading, isTrue);
    expect(initial.error, isNull);

    completer.complete(Success(cachedUser));
    await _flushMicrotasks();

    final state = container.read(authProvider);
    expect(state.isLoading, isFalse);
    expect(state.isLoggedIn, isTrue);
    expect(state.user, cachedUser);
  });
}
