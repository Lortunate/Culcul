import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart'
    show PrivateMessageAccountInfo;

enum PrivateSessionType {
  unknown(0),
  user(1),
  group(2),
  system(7);

  const PrivateSessionType(this.value);

  final int value;

  static PrivateSessionType fromValue(int value) {
    return values.firstWhere(
      (type) => type.value == value,
      orElse: () => PrivateSessionType.unknown,
    );
  }

  PrivateMessageReceiverType get receiverType {
    return switch (this) {
      PrivateSessionType.group => PrivateMessageReceiverType.group,
      _ => PrivateMessageReceiverType.user,
    };
  }
}

typedef PrivateSessionAccountInfo = PrivateMessageAccountInfo;

class PrivateSession {
  final int talkerId;
  final PrivateSessionType sessionType;
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
