import 'package:culcul/features/notification/presentation/chat_page.dart';
import 'package:culcul/features/notification/presentation/notification_list_page.dart';
import 'package:culcul/features/notification/presentation/notification_page.dart';
import 'package:culcul/features/notification/presentation/system_notification_page.dart';
import 'package:flutter/widgets.dart';

Widget buildNotificationRoutePage() => const NotificationPage();

Widget buildReplyNotificationRoutePage() {
  return const NotificationListPage(type: NotificationType.reply);
}

Widget buildAtNotificationRoutePage() {
  return const NotificationListPage(type: NotificationType.at);
}

Widget buildLikeNotificationRoutePage() {
  return const NotificationListPage(type: NotificationType.like);
}

Widget buildSystemNotificationRoutePage() => const SystemNotificationPage();

Widget buildChatRoutePage({
  required int talkerId,
  String? name,
  int sessionType = 1,
  String? avatarUrl,
}) {
  return ChatPage(
    talkerId: talkerId,
    name: name,
    sessionType: sessionType,
    avatarUrl: avatarUrl,
  );
}
