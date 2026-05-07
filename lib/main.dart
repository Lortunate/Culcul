import 'package:culcul/app/app.dart';
import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/app/bootstrap/deferred_app_init.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/session/current_user_provider.dart';
import 'package:culcul/core/session/session_refresh_provider.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/core/perf/startup_perf_logger.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
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

void main() async {
  final bootstrapStopwatch = Stopwatch()..start();
  StartupPerfLogger.log(StartupPerfEvent.bootstrapStart);
  final dependencies = await AppBootstrap.initialize();
  StartupPerfLogger.log(
    StartupPerfEvent.bootstrapReady,
    fields: {'bootstrap_ms': bootstrapStopwatch.elapsedMilliseconds},
  );
  FrameTimingSampler.start();
  StartupPerfLogger.log(StartupPerfEvent.runApp);

  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          cookieJarProvider.overrideWithValue(dependencies.cookieJar),
          cacheStoreProvider.overrideWithValue(dependencies.cacheStore),
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
          sessionStorageBoxProvider.overrideWithValue(dependencies.sessionStorageBox),
          settingsStorageBoxProvider.overrideWithValue(dependencies.settingsStorageBox),
          searchStorageBoxProvider.overrideWithValue(dependencies.searchStorageBox),
        ],
        child: const CulculApp(),
      ),
    ),
  );

  DeferredAppInitController.instance.scheduleAfterFirstFrame();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    StartupPerfLogger.log(StartupPerfEvent.firstFrame);
  });
}
