import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/contracts/relation_port.dart';
import 'package:culcul/core/contracts/search_port.dart';
import 'package:culcul/core/session/feature_action_providers.dart';
import 'package:culcul/core/session/relation_providers.dart';
import 'package:culcul/core/session/search_providers.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/core/session/user_providers.dart';
import 'package:culcul/features/auth/application/auth_session_adapter.dart';
import 'package:culcul/features/auth/application/auth_session_cookie_refresher.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/application/profile_lookup_adapter.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/data/relation_repository_impl.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/to_view/application/watch_later_adapter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/misc.dart' show Override;

List<Override> createRootOverrides(AppRuntime runtime) {
  return [
    // Infrastructure
    cookieJarProvider.overrideWithValue(runtime.cookieJar),
    cacheStoreProvider.overrideWithValue(runtime.cacheStore),
    sharedPreferencesProvider.overrideWithValue(runtime.prefs),

    // Auth / session lifecycle
    sessionCookieRefresherProvider.overrideWith((ref) => AuthSessionCookieRefresher(ref)),
    sessionRefreshActionProvider.overrideWith((ref) {
      final authRepo = ref.watch(authRepositoryProvider);
      return () async {
        final result = await authRepo.checkAndRefreshCookie();
        final error = result.errorOrNull;
        if (error != null) {
          throw StateError('Cookie refresh failed: ${error.message}');
        }
      };
    }),
    currentUserProvider.overrideWith((ref) {
      final authState = ref.watch(authProvider);
      if (!authState.isLoggedIn || authState.user == null) return null;
      return AuthSessionAdapter(authState);
    }),
    logoutActionProvider.overrideWith((ref) {
      return () => ref.read(authProvider.notifier).logout();
    }),

    // Profile / relation
    userCardProvider.overrideWith((ref) {
      return (mid) => ref.read(profileRepositoryProvider).getUserCard(mid);
    }),
    userProfileLookupProvider.overrideWith((ref) => ProfileLookupAdapter(ref)),
    relationPortProvider.overrideWith((ref) {
      return ref.read(relationRepositoryProvider) as RelationPort;
    }),
    modifyRelationProvider.overrideWith((ref) {
      return ({required mid, required isFollow}) =>
          ref.read(profileRepositoryProvider).modifyRelation(mid: mid, isFollow: isFollow);
    }),

    // Search
    searchPortProvider.overrideWith((ref) {
      return ref.read(searchRepositoryProvider) as SearchPort;
    }),

    // Watch later
    watchLaterPortProvider.overrideWith((ref) => WatchLaterAdapter(ref)),
  ];
}

void verifyRootOverrides(List<Override> overrides) {
  final container = ProviderContainer(overrides: overrides);
  try {
    container.read(cookieJarProvider);
    container.read(cacheStoreProvider);
    container.read(sharedPreferencesProvider);
    container.read(sessionCookieRefresherProvider);
    container.read(sessionRefreshActionProvider);
    container.read(logoutActionProvider);
    container.read(currentUserProvider);
    container.read(userCardProvider);
    container.read(userProfileLookupProvider);
    container.read(relationPortProvider);
    container.read(modifyRelationProvider);
    container.read(searchPortProvider);
    container.read(watchLaterPortProvider);
  } finally {
    container.dispose();
  }
}
