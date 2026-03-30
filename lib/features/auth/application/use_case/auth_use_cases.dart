import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/domain/entities/country_code.dart';
import 'package:culcul/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/data/auth_repository.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_use_cases.g.dart';

class PasswordLoginCommand {
  final String username;
  final String password;
  final String token;
  final String challenge;
  final String validate;
  final String seccode;

  const PasswordLoginCommand({
    required this.username,
    required this.password,
    required this.token,
    required this.challenge,
    required this.validate,
    required this.seccode,
  });
}

class SmsLoginCommand {
  final int cid;
  final String phone;
  final String code;
  final String captchaKey;

  const SmsLoginCommand({
    required this.cid,
    required this.phone,
    required this.code,
    required this.captchaKey,
  });
}

class SendSmsCommand {
  final int cid;
  final String phone;
  final String token;
  final String challenge;
  final String validate;
  final String seccode;

  const SendSmsCommand({
    required this.cid,
    required this.phone,
    required this.token,
    required this.challenge,
    required this.validate,
    required this.seccode,
  });
}

class AuthInitData {
  final UserEntity? cachedUser;
  final UserEntity? refreshedUser;

  const AuthInitData({required this.cachedUser, required this.refreshedUser});
}

@riverpod
AuthUseCases authUseCases(Ref ref) {
  return AuthUseCases(ref.read(authRepositoryProvider));
}

class AuthUseCases {
  final AuthRepository _repository;

  const AuthUseCases(this._repository);

  Future<Result<AuthInitData, AppError>> initialize() async {
    final cachedUser = _repository.getCachedUser();
    final refreshedResult = await _repository.getCurrentUser();
    return Success(
      AuthInitData(cachedUser: cachedUser, refreshedUser: refreshedResult.dataOrNull),
    );
  }

  Future<Result<List<CountryCode>, AppError>> getCountryList() async {
    return _repository.getCountryList().then(_mapRepositoryResult);
  }

  Future<Result<AuthCaptchaChallenge, AppError>> getCaptcha() async {
    return _repository.getCaptchaChallenge().then(_mapRepositoryResult);
  }

  Future<Result<String, AppError>> sendSms(SendSmsCommand command) async {
    return _repository
        .sendSms(
          command.cid,
          command.phone,
          command.token,
          command.challenge,
          command.validate,
          command.seccode,
        )
        .then(_mapRepositoryResult);
  }

  Future<Result<UserEntity, AppError>> loginWithPassword(
    PasswordLoginCommand command,
  ) async {
    return _repository
        .loginWithPassword(
          username: command.username,
          password: command.password,
          token: command.token,
          challenge: command.challenge,
          validate: command.validate,
          seccode: command.seccode,
        )
        .then(_mapRepositoryResult);
  }

  Future<Result<UserEntity, AppError>> loginWithSms(SmsLoginCommand command) async {
    return _repository
        .loginWithSms(command.cid, command.phone, command.code, command.captchaKey)
        .then(_mapRepositoryResult);
  }

  Future<Result<AuthQrCode, AppError>> getQrCode() async {
    return _repository.getQrCode().then(_mapRepositoryResult);
  }

  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode) async {
    return _repository.pollQrCode(authCode).then(_mapRepositoryResult);
  }

  Future<Result<void, AppError>> logout() async {
    return _repository.logout().then(_mapRepositoryResult);
  }

  Future<Result<UserEntity, AppError>> refreshUser() async {
    return _repository.getCurrentUser().then(_mapRepositoryResult);
  }
}

Result<T, AppError> _mapRepositoryResult<T>(Result<T, dynamic> result) {
  return result.when(
    success: Success.new,
    failure: (error) =>
        Failure(error is AppError ? error : AppError.fromObject(error as Object)),
  );
}
