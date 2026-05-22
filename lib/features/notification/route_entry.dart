import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/presentation/pages/chat_page.dart';
import 'package:culcul/features/notification/presentation/pages/notification_list_page.dart';
import 'package:culcul/features/notification/presentation/pages/notification_page.dart';
import 'package:culcul/features/notification/presentation/pages/system_notification_page.dart';
import 'package:flutter/widgets.dart';

export 'package:culcul/features/notification/application/notification_navigation.dart'
    show
        NotificationNavigationTarget,
        NotificationTargetOpener,
        openNotificationNavigationTarget;

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

Widget buildNotificationRoutePage({
  required VoidCallback onLogin,
  required VoidCallback onOpenReply,
  required VoidCallback onOpenAt,
  required VoidCallback onOpenLike,
  required VoidCallback onOpenSystem,
  required void Function(
    PrivateSession session, {
    required String name,
    required String avatarUrl,
  })
  onOpenChat,
}) {
  return NotificationPage(
    onLogin: onLogin,
    onOpenReply: onOpenReply,
    onOpenAt: onOpenAt,
    onOpenLike: onOpenLike,
    onOpenSystem: onOpenSystem,
    onOpenChat: onOpenChat,
  );
}

Widget buildReplyNotificationRoutePage({
  required NotificationTargetOpener onOpenTarget,
  required ValueChanged<int> onOpenUser,
}) {
  return NotificationListPage(
    type: NotificationFeedType.reply,
    onOpenTarget: onOpenTarget,
    onOpenUser: onOpenUser,
  );
}

Widget buildAtNotificationRoutePage({
  required NotificationTargetOpener onOpenTarget,
  required ValueChanged<int> onOpenUser,
}) {
  return NotificationListPage(
    type: NotificationFeedType.at,
    onOpenTarget: onOpenTarget,
    onOpenUser: onOpenUser,
  );
}

Widget buildLikeNotificationRoutePage({
  required NotificationTargetOpener onOpenTarget,
  required ValueChanged<int> onOpenUser,
}) {
  return NotificationListPage(
    type: NotificationFeedType.like,
    onOpenTarget: onOpenTarget,
    onOpenUser: onOpenUser,
  );
}

Widget buildSystemNotificationRoutePage({
  required NotificationTargetOpener onOpenTarget,
}) {
  return SystemNotificationPage(onOpenTarget: onOpenTarget);
}

Widget buildChatRoutePage({required int talkerId, required ChatRouteInput input}) {
  return ChatPage(
    talkerId: talkerId,
    name: input.name,
    sessionType: input.sessionType,
    avatarUrl: input.avatarUrl,
  );
}
