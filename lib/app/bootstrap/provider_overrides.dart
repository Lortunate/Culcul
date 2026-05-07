import 'package:culcul/app/bootstrap/app_dependencies.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/session/current_user_provider.dart';
import 'package:culcul/core/session/logout_action_provider.dart';
import 'package:culcul/core/session/modify_relation_provider.dart';
import 'package:culcul/core/session/session_refresh_provider.dart';
import 'package:culcul/core/session/show_login_dialog_provider.dart';
import 'package:culcul/core/session/user_card_provider.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:culcul/features/auth/presentation/widgets/login_dialog.dart';

class _AuthSessionAdapter implements UserSession {
  final AuthState _authState;
  _AuthSessionAdapter(this._authState);

  @override
  String get uid => _authState.user?.id ?? '';

  @override
  bool get isLoggedIn => _authState.isLoggedIn;

  @override
  String? get avatarUrl => _authState.user?.avatarUrl;

  @override
  String? get nickname => _authState.user?.username;
}

createProviderOverrides(AppDependencies deps) {
  return [
    cookieJarProvider.overrideWithValue(deps.cookieJar),
    cacheStoreProvider.overrideWithValue(deps.cacheStore),
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
      if (!authState.isLoggedIn || authState.user == null) {
        return null;
      }
      return _AuthSessionAdapter(authState);
    }),
    logoutActionProvider.overrideWith((ref) {
      return () => ref.read(authProvider.notifier).logout();
    }),
    showLoginDialogProvider.overrideWith((ref) {
      return (context) => LoginDialog.show(context);
    }),
    userCardProvider.overrideWith((ref) {
      return (mid) => ref.read(profileRepositoryProvider).getUserCard(mid);
    }),
    modifyRelationProvider.overrideWith((ref) {
      return ({required mid, required isFollow}) =>
          ref.read(profileRepositoryProvider).modifyRelation(mid: mid, isFollow: isFollow);
    }),
    sessionStorageBoxProvider.overrideWithValue(deps.sessionStorageBox),
    settingsStorageBoxProvider.overrideWithValue(deps.settingsStorageBox),
    searchStorageBoxProvider.overrideWithValue(deps.searchStorageBox),
  ];
}
