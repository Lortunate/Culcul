import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/core/session/user_providers.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/features/auth/application/auth_session_adapter.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:riverpod/misc.dart' show Override;

export 'data/auth_repository_impl.dart' show authRepositoryProvider;

class AuthFeatureScope {
  const AuthFeatureScope._();

  static List<Override> overrides() {
    return [
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
        return AuthSessionAdapter(authState);
      }),
      logoutActionProvider.overrideWith((ref) {
        return () => ref.read(authProvider.notifier).logout();
      }),
    ];
  }
}
