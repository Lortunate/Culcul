import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_page_commands.g.dart';

enum LiveRoomFollowCommandResult { toggled, requiresLogin }

typedef LiveRoomToggleFollow = Future<void> Function(int roomId);

@riverpod
LiveRoomPageCommands liveRoomPageCommands(Ref ref) {
  return LiveRoomPageCommands(
    isLoggedIn: () {
      final session = ref.read(currentUserProvider);
      return session?.isLoggedIn ?? false;
    },
    toggleFollow: (roomId) =>
        ref.read(liveRoomControllerProvider(roomId).notifier).toggleFollow(),
  );
}

class LiveRoomPageCommands {
  final bool Function() _isLoggedIn;
  final LiveRoomToggleFollow _toggleFollow;

  const LiveRoomPageCommands({
    required bool Function() isLoggedIn,
    required LiveRoomToggleFollow toggleFollow,
  }) : _isLoggedIn = isLoggedIn,
       _toggleFollow = toggleFollow;

  Future<LiveRoomFollowCommandResult> handleFollowTap(int roomId) async {
    if (!_isLoggedIn()) {
      return LiveRoomFollowCommandResult.requiresLogin;
    }

    await _toggleFollow(roomId);
    return LiveRoomFollowCommandResult.toggled;
  }
}
