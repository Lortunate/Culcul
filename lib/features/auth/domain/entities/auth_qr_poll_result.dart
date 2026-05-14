import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_qr_poll_result.freezed.dart';

@freezed
sealed class AuthQrPollResult with _$AuthQrPollResult {
  const factory AuthQrPollResult({required int code, String? message}) =
      _AuthQrPollResult;
}
