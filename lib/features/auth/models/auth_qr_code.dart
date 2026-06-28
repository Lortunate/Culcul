final class AuthQrCode {
  const AuthQrCode({required this.url, required this.key});

  final String url;
  final String key;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is AuthQrCode &&
            other.url == url &&
            other.key == key;
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, key);

  @override
  String toString() => 'AuthQrCode(url: $url, key: $key)';
}
