import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/application/auth_controller.dart';
import 'package:culcul/features/auth/data/auth_api.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('country list failure stores error and returns empty list', () async {
    final repository = await _FailingAuthRepository.create(
      countryListError: const AppError.auth('country list failed'),
    );
    final container = _authContainer(repository);
    addTearDown(container.dispose);

    final result = await container.read(authProvider.notifier).getCountryList();

    expect(result, isEmpty);
    expect(container.read(authProvider).error, 'country list failed');
  });

  test('captcha failure stores error and returns null', () async {
    final repository = await _FailingAuthRepository.create(
      captchaError: const AppError.auth('captcha failed'),
    );
    final container = _authContainer(repository);
    addTearDown(container.dispose);

    final result = await container.read(authProvider.notifier).getCaptcha();

    expect(result, isNull);
    expect(container.read(authProvider).error, 'captcha failed');
  });

  test('sms failure stores error and returns null', () async {
    final repository = await _FailingAuthRepository.create(
      smsError: const AppError.auth('sms failed'),
    );
    final container = _authContainer(repository);
    addTearDown(container.dispose);

    final result = await container
        .read(authProvider.notifier)
        .sendSms(86, '13800138000', 'token', 'challenge', 'validate', 'seccode');

    expect(result, isNull);
    expect(container.read(authProvider).error, 'sms failed');
  });
}

ProviderContainer _authContainer(_FailingAuthRepository repository) {
  return ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(repository)],
  );
}

class _FailingAuthRepository extends AuthRepositoryImpl {
  _FailingAuthRepository._(
    super.api,
    super.prefs, {
    this.countryListError,
    this.captchaError,
    this.smsError,
  });

  final AppError? countryListError;
  final AppError? captchaError;
  final AppError? smsError;

  static Future<_FailingAuthRepository> create({
    AppError? countryListError,
    AppError? captchaError,
    AppError? smsError,
  }) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return _FailingAuthRepository._(
      _UnsupportedAuthApi(),
      prefs,
      countryListError: countryListError,
      captchaError: captchaError,
      smsError: smsError,
    );
  }

  @override
  UserEntity? getCachedUser() => null;

  @override
  Future<Result<UserEntity, AppError>> getCurrentUser() async {
    return const Failure(AppError.auth('not logged in'));
  }

  @override
  Future<Result<List<CountryCode>, AppError>> getCountryList() async {
    final error = countryListError;
    if (error != null) {
      return Failure(error);
    }
    return const Success(<CountryCode>[]);
  }

  @override
  Future<Result<AuthCaptchaChallenge, AppError>> getCaptchaChallenge() async {
    final error = captchaError;
    if (error != null) {
      return Failure(error);
    }
    return const Success(
      AuthCaptchaChallenge(token: 'token', gt: 'gt', challenge: 'challenge'),
    );
  }

  @override
  Future<Result<String, AppError>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    final error = smsError;
    if (error != null) {
      return Failure(error);
    }
    return const Success('captcha-key');
  }
}

class _UnsupportedAuthApi implements AuthApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
