import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/domain/entities/country_code.dart';
import 'package:culcul/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/data/auth_repository.dart';
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
    try {
      final refreshedUser = await _repository.getCurrentUser();
      return Success(AuthInitData(cachedUser: cachedUser, refreshedUser: refreshedUser));
    } catch (error) {
      return Success(AuthInitData(cachedUser: cachedUser, refreshedUser: null));
    }
  }

  Future<Result<List<CountryCode>, AppError>> getCountryList() async {
    try {
      return Success(await _repository.getCountryList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<Map<String, dynamic>, AppError>> getCaptcha() async {
    try {
      return Success(await _repository.getCaptcha());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<String, AppError>> sendSms(SendSmsCommand command) async {
    try {
      return Success(
        await _repository.sendSms(
          command.cid,
          command.phone,
          command.token,
          command.challenge,
          command.validate,
          command.seccode,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<UserEntity, AppError>> loginWithPassword(
    PasswordLoginCommand command,
  ) async {
    try {
      return Success(
        await _repository.loginWithPassword(
          username: command.username,
          password: command.password,
          token: command.token,
          challenge: command.challenge,
          validate: command.validate,
          seccode: command.seccode,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<UserEntity, AppError>> loginWithSms(SmsLoginCommand command) async {
    try {
      return Success(
        await _repository.loginWithSms(
          command.cid,
          command.phone,
          command.code,
          command.captchaKey,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<Map<String, dynamic>, AppError>> getQrCode() async {
    try {
      return Success(await _repository.getQrCode());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<Map<String, dynamic>, AppError>> pollQrCode(String authCode) async {
    try {
      return Success(await _repository.pollQrCode(authCode));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> logout() async {
    try {
      await _repository.logout();
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<UserEntity, AppError>> refreshUser() async {
    try {
      return Success(await _repository.getCurrentUser());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
