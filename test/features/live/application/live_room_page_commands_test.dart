import 'package:culcul/features/live/application/live_room_page_commands.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LiveRoomPageCommands', () {
    test('returns requiresLogin without toggling when user is not logged in', () async {
      var toggledRoomId = -1;
      final commands = LiveRoomPageCommands(
        isLoggedIn: () => false,
        toggleFollow: (roomId) async {
          toggledRoomId = roomId;
        },
      );

      final result = await commands.handleFollowTap(42);

      expect(result, LiveRoomFollowCommandResult.requiresLogin);
      expect(toggledRoomId, -1);
    });

    test('toggles follow when user is logged in', () async {
      var toggledRoomId = -1;
      final commands = LiveRoomPageCommands(
        isLoggedIn: () => true,
        toggleFollow: (roomId) async {
          toggledRoomId = roomId;
        },
      );

      final result = await commands.handleFollowTap(7);

      expect(result, LiveRoomFollowCommandResult.toggled);
      expect(toggledRoomId, 7);
    });

    test('does not toggle follow when user is not logged in', () async {
      var toggledRoomId = -1;
      final commands = LiveRoomPageCommands(
        isLoggedIn: () => false,
        toggleFollow: (roomId) async {
          toggledRoomId = roomId;
        },
      );

      final result = await commands.handleFollowTap(9);

      expect(result, LiveRoomFollowCommandResult.requiresLogin);
      expect(toggledRoomId, -1);
    });
  });
}
