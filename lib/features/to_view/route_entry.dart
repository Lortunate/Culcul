import 'package:culcul/features/to_view/presentation/pages/to_view_page.dart';
import 'package:flutter/widgets.dart';

Widget buildToViewRoutePage({
  required VoidCallback onLogin,
  required ValueChanged<String> onOpenVideo,
}) {
  return ToViewPage(onLogin: onLogin, onOpenVideo: onOpenVideo);
}
