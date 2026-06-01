import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_lifecycle_providers.g.dart';

abstract interface class SessionCookieRefresher {
  Future<void> refreshCookies();
}

abstract interface class SessionLogoutCleaner {
  Future<void> clearAfterLogout();
}

final class _NoopSessionLogoutCleaner implements SessionLogoutCleaner {
  const _NoopSessionLogoutCleaner();

  @override
  Future<void> clearAfterLogout() async {}
}

@Riverpod(keepAlive: true)
SessionCookieRefresher sessionCookieRefresher(Ref ref) {
  throw StateError('sessionCookieRefresherProvider not initialized');
}

@Riverpod(keepAlive: true)
SessionLogoutCleaner sessionLogoutCleaner(Ref ref) {
  return const _NoopSessionLogoutCleaner();
}
