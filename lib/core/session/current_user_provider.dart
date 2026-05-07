import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides the current user session. Returns null if not logged in.
/// Backed by auth's state at bootstrap time via ProviderScope override.
final currentUserProvider = Provider<UserSession?>((ref) {
  throw UnimplementedError('currentUserProvider must be overridden at bootstrap');
});
