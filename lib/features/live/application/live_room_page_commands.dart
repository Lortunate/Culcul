import 'package:culcul/features/auth/domain/repositories/auth_repository.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LiveRoomFollowCommandResult { toggled, requiresLogin }

typedef LiveRoomToggleFollow = Future<void> Function(int roomId);

final liveRoomPageCommandsProvider = Provider<LiveRoomPageCommands>((ref) {
  return LiveRoomPageCommands(
    authRepository: ref.read(authRepositoryProvider),
    toggleFollow: (roomId) =>
        ref.read(liveRoomControllerProvider(roomId).notifier).toggleFollow(),
  );
});

class LiveRoomPageCommands {
  final AuthRepository _authRepository;
  final LiveRoomToggleFollow _toggleFollow;

  const LiveRoomPageCommands({
    required AuthRepository authRepository,
    required LiveRoomToggleFollow toggleFollow,
  }) : _authRepository = authRepository,
       _toggleFollow = toggleFollow;

  Future<LiveRoomFollowCommandResult> handleFollowTap(int roomId) async {
    if (!await _isLoggedIn()) {
      return LiveRoomFollowCommandResult.requiresLogin;
    }

    await _toggleFollow(roomId);
    return LiveRoomFollowCommandResult.toggled;
  }

  Future<bool> _isLoggedIn() async {
    if (_authRepository.getCachedUser() != null) {
      return true;
    }

    return (await _authRepository.getCurrentUser()).isSuccess;
  }
}
