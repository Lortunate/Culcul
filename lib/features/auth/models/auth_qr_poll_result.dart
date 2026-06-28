final class AuthQrPollResult {
  const AuthQrPollResult({required this.code, this.message});

  final int code;
  final String? message;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is AuthQrPollResult &&
            other.code == code &&
            other.message == message;
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @override
  String toString() {
    return 'AuthQrPollResult(code: $code, message: $message)';
  }
}
