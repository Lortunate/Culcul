import 'package:culcul/features/search/presentation/pages/search_page.dart';
import 'package:flutter/widgets.dart';

Widget buildSearchRoutePage({
  required ValueChanged<String> onOpenVideo,
  required ValueChanged<int> onOpenUser,
  required void Function(int topicId, String topicName) onOpenTopic,
}) {
  return SearchPage(
    onOpenVideo: onOpenVideo,
    onOpenUser: onOpenUser,
    onOpenTopic: onOpenTopic,
  );
}
