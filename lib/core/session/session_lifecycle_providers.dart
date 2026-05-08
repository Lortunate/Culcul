import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract interface class SessionCookieRefresher {
  Future<void> refreshCookies();
}

final sessionCookieRefresherProvider = Provider<SessionCookieRefresher>((ref) {
  throw UnimplementedError(
    'sessionCookieRefresherProvider must be overridden at app bootstrap',
  );
});

typedef SessionRefreshAction = Future<void> Function();

final sessionRefreshActionProvider = Provider<SessionRefreshAction>((ref) {
  throw UnimplementedError('sessionRefreshActionProvider must be overridden');
});

typedef LogoutAction = Future<void> Function();

/// Provides the logout action. Must be overridden at bootstrap.
final logoutActionProvider = Provider<LogoutAction>((ref) {
  throw UnimplementedError('logoutActionProvider must be overridden at bootstrap');
});

typedef ShowLoginDialog = void Function(BuildContext context);

/// Provides the login dialog action. Must be overridden at bootstrap.
final showLoginDialogProvider = Provider<ShowLoginDialog>((ref) {
  throw UnimplementedError('showLoginDialogProvider must be overridden at bootstrap');
});
