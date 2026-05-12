import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_captcha_challenge.freezed.dart';

@freezed
sealed class AuthCaptchaChallenge with _$AuthCaptchaChallenge {
  const factory AuthCaptchaChallenge({
    required String token,
    required String gt,
    required String challenge,
  }) = _AuthCaptchaChallenge;
}
