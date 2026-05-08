import 'package:culcul/app/bootstrap/app_dependencies.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:culcul/features/search/feature_scope.dart';
import 'package:culcul/features/to_view/feature_scope.dart';
import 'package:riverpod/misc.dart' show Override;

List<Override> createProviderOverrides(AppDependencies deps) {
  return [
    // Storage
    cookieJarProvider.overrideWithValue(deps.cookieJar),
    cacheStoreProvider.overrideWithValue(deps.cacheStore),
    sessionStorageBoxProvider.overrideWithValue(deps.sessionStorageBox),
    settingsStorageBoxProvider.overrideWithValue(deps.settingsStorageBox),
    searchStorageBoxProvider.overrideWithValue(deps.searchStorageBox),

    ...AuthFeatureScope.overrides(),
    ...ProfileFeatureScope.overrides(),
    ...SearchFeatureScope.overrides(),
    ...ToViewFeatureScope.overrides(),
  ];
}
