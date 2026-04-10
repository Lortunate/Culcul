import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';

abstract class AuthRepository {
  UserEntity? getCachedUser();

  Future<Result<void, AppError>> checkAndRefreshCookie();

  Future<Result<List<CountryCode>, AppError>> getCountryList();

  Future<Result<AuthCaptchaChallenge, AppError>> getCaptchaChallenge();

  Future<Result<String, AppError>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  );

  Future<Result<UserEntity, AppError>> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  });

  Future<Result<UserEntity, AppError>> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  );

  Future<Result<AuthQrCode, AppError>> getQrCode();

  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode);

  Future<Result<void, AppError>> logout();

  Future<Result<UserEntity, AppError>> getCurrentUser();
}
