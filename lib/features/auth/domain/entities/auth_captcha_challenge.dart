class AuthCaptchaChallenge {
  const AuthCaptchaChallenge({
    required this.token,
    required this.gt,
    required this.challenge,
  });

  final String token;
  final String gt;
  final String challenge;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthCaptchaChallenge &&
            other.token == token &&
            other.gt == gt &&
            other.challenge == challenge;
  }

  @override
  int get hashCode => Object.hash(token, gt, challenge);

  @override
  String toString() {
    return 'AuthCaptchaChallenge(token: $token, gt: $gt, challenge: $challenge)';
  }
}
