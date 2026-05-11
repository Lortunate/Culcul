import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/session/feature_action_providers.dart';
import 'package:culcul/core/session/relation_providers.dart';
import 'package:culcul/core/session/search_providers.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/core/session/user_providers.dart';
import 'package:culcul/features/auth/application/auth_session_cookie_refresher.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/misc.dart' show Override;

List<Override> createRootOverrides(AppRuntime runtime) {
  return [
    cookieJarProvider.overrideWithValue(runtime.cookieJar),
    cacheStoreProvider.overrideWithValue(runtime.cacheStore),
    sessionStorageBoxProvider.overrideWithValue(runtime.sessionBox),
    settingsStorageBoxProvider.overrideWithValue(runtime.settingsBox),
    searchStorageBoxProvider.overrideWithValue(runtime.searchHistoryBox),
    sessionCookieRefresherProvider.overrideWith((ref) => AuthSessionCookieRefresher(ref)),
  ];
}

void verifyRootOverrides(List<Override> overrides) {
  final container = ProviderContainer(overrides: overrides);
  try {
    container.read(cookieJarProvider);
    container.read(cacheStoreProvider);
    container.read(sessionStorageBoxProvider);
    container.read(settingsStorageBoxProvider);
    container.read(searchStorageBoxProvider);
    container.read(sessionCookieRefresherProvider);
    container.read(sessionRefreshActionProvider);
    container.read(logoutActionProvider);
    container.read(relationPortProvider);
    container.read(searchPortProvider);
    container.read(watchLaterPortProvider);
    container.read(currentUserProvider);
    container.read(userCardProvider);
    container.read(userProfileLookupProvider);
    container.read(modifyRelationProvider);
    container.read(followListServiceProvider);
    container.read(searchServiceProvider);
  } finally {
    container.dispose();
  }
}
