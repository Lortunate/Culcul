import 'package:culcul/app/bootstrap/app_dependencies.dart';
import 'package:culcul/core/contracts/follow_list_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/contracts/search_query_contract.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/contracts/search_service_contract.dart';
import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/contracts/watch_later_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/session/current_user_provider.dart';
import 'package:culcul/core/session/follow_list_provider.dart';
import 'package:culcul/core/session/logout_action_provider.dart';
import 'package:culcul/core/session/modify_relation_provider.dart';
import 'package:culcul/core/session/search_service_provider.dart';
import 'package:culcul/core/session/session_refresh_provider.dart';
import 'package:culcul/core/session/show_login_dialog_provider.dart';
import 'package:culcul/core/session/user_card_provider.dart';
import 'package:culcul/core/session/user_profile_lookup_provider.dart';
import 'package:culcul/core/session/watch_later_provider.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:culcul/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:culcul/features/auth/presentation/widgets/login_dialog.dart';
import 'package:culcul/features/search/feature_scope.dart';
import 'package:culcul/features/to_view/presentation/view_models/to_view_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    followListServiceProvider.overrideWith((ref) {
      return _FollowListAdapter(ref);
    }),
    searchServiceProvider.overrideWith((ref) {
      return _SearchServiceAdapter(ref);
    }),
    watchLaterActionsProvider.overrideWith((ref) {
      return _WatchLaterAdapter(ref);
    }),
    userProfileLookupProvider.overrideWith((ref) {
      return _UserProfileLookupAdapter(ref);
    }),
  ];
}

class _FollowListAdapter implements FollowListService {
  final Ref _ref;
  _FollowListAdapter(this._ref);

  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
  }) {
    return _ref.read(relationRepositoryProvider).getFollowings(vmid, page: page);
  }
}

class _SearchServiceAdapter implements SearchService {
  final Ref _ref;
  _SearchServiceAdapter(this._ref);

  @override
  Future<Result<SearchResultPage, AppError>> search({required SearchQuery query}) {
    return _ref.read(searchRepositoryProvider).search(query: query);
  }
}

class _WatchLaterAdapter implements WatchLaterActions {
  final Ref _ref;
  _WatchLaterAdapter(this._ref);

  @override
  Future<void> addToWatchLater(int aid) async {
    await _ref.read(toViewListProvider.notifier).add(aid);
  }

  @override
  Future<void> removeFromWatchLater(int aid) async {
    // Not yet implemented in to_view feature
    throw UnimplementedError('removeFromWatchLater not yet supported');
  }
}

class _UserProfileLookupAdapter implements UserProfileLookup {
  final Ref _ref;
  _UserProfileLookupAdapter(this._ref);

  @override
  Future<Result<UserProfileInfo, AppError>> getUserProfile(String mid) async {
    try {
      final profile = await _ref.read(userProfileProvider(mid).future);
      return Success(UserProfileInfo(
        mid: profile.id,
        name: profile.username,
        avatarUrl: profile.avatarUrl ?? '',
      ));
    } catch (e) {
      return Failure(ServerAppError('Failed to fetch user profile: $e'));
    }
  }
}
