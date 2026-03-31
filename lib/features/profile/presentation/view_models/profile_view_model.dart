import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/application/profile_query_workflows.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@riverpod
Future<ProfileUser> myProfile(Ref ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) {
    throw AppError.auth('Not logged in');
  }
  final result = await ref
      .watch(profileQueryWorkflowsProvider)
      .getProfile(authState.user!.id);
  return result.when(success: (value) => value, failure: (error) => throw error);
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<ProfileUser> build(String userId) async {
    final cachedResult = await ref
        .read(profileQueryWorkflowsProvider)
        .getCachedProfile(userId);
    final cachedUser = cachedResult.dataOrNull;

    if (cachedUser != null) {
      _refreshInBackground(userId);
      return cachedUser;
    }

    return _loadFresh(userId);
  }

  Future<void> _refreshInBackground(String userId) async {
    try {
      await Future.delayed(Duration.zero);
      final user = await _loadFresh(userId);
      state = AsyncData(user);
    } catch (e) {
      // Ignore errors in background refresh
    }
  }

  Future<ProfileUser> _loadFresh(String userId) async {
    final result = await ref.read(profileQueryWorkflowsProvider).refreshProfile(userId);
    return result.when(success: (value) => value, failure: (error) => throw error);
  }
}
