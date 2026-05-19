import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_lifecycle_providers.g.dart';

abstract interface class SessionCookieRefresher {
  Future<void> refreshCookies();
}

@Riverpod(keepAlive: true)
SessionCookieRefresher sessionCookieRefresher(Ref ref) {
  throw StateError('sessionCookieRefresherProvider not initialized');
}
