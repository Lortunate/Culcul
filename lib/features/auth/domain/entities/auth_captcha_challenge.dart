final class AuthCaptchaChallenge {
  final String token;
  final String gt;
  final String challenge;

  const AuthCaptchaChallenge({
    required this.token,
    required this.gt,
    required this.challenge,
  });
}
