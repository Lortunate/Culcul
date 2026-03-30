import 'package:culcul/features/notification/domain/entities/private_message.dart';

class PrivateSessionAccountInfo {
  final String name;
  final String picUrl;

  const PrivateSessionAccountInfo({required this.name, required this.picUrl});
}

class PrivateSession {
  final int talkerId;
  final int sessionType;
  final int unreadCount;
  final PrivateMessage? lastMessage;
  final String? groupName;
  final String? groupCover;
  final int isFollow;
  final int sessionTs;
  final PrivateSessionAccountInfo? accountInfo;

  const PrivateSession({
    required this.talkerId,
    required this.sessionType,
    required this.unreadCount,
    required this.lastMessage,
    required this.groupName,
    required this.groupCover,
    required this.isFollow,
    required this.sessionTs,
    required this.accountInfo,
  });
}

class PrivateSessionPage {
  final List<PrivateSession> sessions;
  final bool hasMore;
  final Map<String, int>? systemMessages;

  const PrivateSessionPage({
    required this.sessions,
    required this.hasMore,
    required this.systemMessages,
  });
}
