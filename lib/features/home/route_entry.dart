import 'package:culcul/features/home/presentation/pages/home_page.dart';
import 'package:culcul/features/home/presentation/pages/weekly_screen.dart';
import 'package:flutter/widgets.dart';

Widget buildHomePage({
  required VoidCallback onOpenSearch,
  required VoidCallback onOpenProfile,
  required VoidCallback onOpenNotification,
  required ValueChanged<int> onOpenLiveRoom,
  required ValueChanged<String> onOpenVideo,
}) {
  return HomePage(
    onOpenSearch: onOpenSearch,
    onOpenProfile: onOpenProfile,
    onOpenNotification: onOpenNotification,
    onOpenLiveRoom: onOpenLiveRoom,
    onOpenVideo: onOpenVideo,
  );
}

Widget buildWeeklyScreenPage({required ValueChanged<String> onOpenVideo}) {
  return WeeklyScreen(onOpenVideo: onOpenVideo);
}
