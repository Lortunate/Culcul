import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/pages/chat_page.dart';
import 'package:culcul/features/notification/presentation/pages/notification_list_page.dart';
import 'package:culcul/features/notification/presentation/pages/notification_page.dart';
import 'package:culcul/features/notification/presentation/pages/system_notification_page.dart';
import 'package:flutter/widgets.dart';

class ChatRouteInput {
  final String? name;
  final PrivateSessionType sessionType;
  final String? avatarUrl;

  const ChatRouteInput({
    this.name,
    this.sessionType = PrivateSessionType.user,
    this.avatarUrl,
  });
}

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

Widget buildChatRoutePage({required int talkerId, required ChatRouteInput input}) {
  return ChatPage(
    talkerId: talkerId,
    name: input.name,
    sessionType: input.sessionType,
    avatarUrl: input.avatarUrl,
  );
}
