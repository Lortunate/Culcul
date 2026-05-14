import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract interface class SessionCookieRefresher {
  Future<void> refreshCookies();
}

final sessionCookieRefresherProvider = Provider<SessionCookieRefresher>((ref) {
  throw StateError(
    'sessionCookieRefresherProvider not initialized',
  );
});
