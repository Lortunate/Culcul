import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class SessionCookieRefresher {
  Future<void> refreshCookies();
}

final sessionCookieRefresherProvider = Provider<SessionCookieRefresher>((ref) {
  throw UnimplementedError(
    'sessionCookieRefresherProvider must be overridden at app bootstrap',
  );
});
