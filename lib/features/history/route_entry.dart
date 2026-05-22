import 'package:culcul/features/history/presentation/pages/history_page.dart';
import 'package:flutter/widgets.dart';

Widget buildHistoryRoutePage({
  required VoidCallback onLogin,
  required ValueChanged<String> onOpenVideo,
}) {
  return HistoryPage(onLogin: onLogin, onOpenVideo: onOpenVideo);
}
