import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';

/// Auth QR login application boundary.
abstract interface class AuthQrLoginPort {
  Future<Result<AuthQrCode, AppError>> getQrCode();

  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode);
}
