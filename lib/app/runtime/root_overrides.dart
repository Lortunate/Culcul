import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/auth/application/auth_session_cookie_refresher.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/misc.dart' show Override;

List<Override> createRootOverrides() {
  return [
    // Auth / session lifecycle
    sessionCookieRefresherProvider.overrideWith(AuthSessionCookieRefresher.new),
  ];
}

void verifyRootOverrides(List<Override> overrides) {
  final container = ProviderContainer(overrides: overrides);
  try {
    container.read(sessionCookieRefresherProvider);
  } finally {
    container.dispose();
  }
}
