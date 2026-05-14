import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/features/auth/application/auth_session_adapter.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentUserProvider = Provider<UserSession?>((ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) return null;
  return AuthSessionAdapter(authState);
});
