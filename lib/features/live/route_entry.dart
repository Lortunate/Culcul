import 'package:culcul/features/live/presentation/pages/live_room_page.dart';
import 'package:flutter/widgets.dart';

Widget buildLiveRoomRoutePage({required int roomId, required VoidCallback onLogin}) {
  return LiveRoomPage(roomId: roomId, onLogin: onLogin);
}
