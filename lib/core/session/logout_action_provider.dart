import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef LogoutAction = Future<void> Function();

/// Provides the logout action. Must be overridden at bootstrap.
final logoutActionProvider = Provider<LogoutAction>((ref) {
  throw UnimplementedError('logoutActionProvider must be overridden at bootstrap');
});
