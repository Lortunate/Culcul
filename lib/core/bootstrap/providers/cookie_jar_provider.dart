import 'package:cookie_jar/cookie_jar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cookie_jar_provider.g.dart';

CookieJar? _cookieJarInstance;

void initializeCookieJar(CookieJar cookieJar) {
  _cookieJarInstance = cookieJar;
}

@Riverpod(keepAlive: true)
CookieJar cookieJar(Ref ref) {
  final cookieJar = _cookieJarInstance;
  if (cookieJar == null) {
    throw StateError('cookieJarProvider not initialized');
  }
  return cookieJar;
}
