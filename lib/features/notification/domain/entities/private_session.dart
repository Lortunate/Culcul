import 'package:culcul/features/notification/domain/entities/private_message.dart';

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

final class PrivateSessionAccountInfo {
  const PrivateSessionAccountInfo({required this.name, required this.picUrl});

  final String name;
  final String picUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateSessionAccountInfo &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            picUrl == other.picUrl;
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, picUrl);

  @override
  String toString() => 'PrivateSessionAccountInfo(name: $name, picUrl: $picUrl)';
}

final class PrivateSession {
  const PrivateSession({
    required this.talkerId,
    required this.sessionType,
    required this.unreadCount,
    this.lastMessage,
    this.groupName,
    this.groupCover,
    required this.isFollow,
    required this.sessionTs,
    this.accountInfo,
  });

  final int talkerId;
  final PrivateSessionType sessionType;
  final int unreadCount;
  final PrivateMessage? lastMessage;
  final String? groupName;
  final String? groupCover;
  final int isFollow;
  final int sessionTs;
  final PrivateSessionAccountInfo? accountInfo;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateSession &&
            runtimeType == other.runtimeType &&
            talkerId == other.talkerId &&
            sessionType == other.sessionType &&
            unreadCount == other.unreadCount &&
            lastMessage == other.lastMessage &&
            groupName == other.groupName &&
            groupCover == other.groupCover &&
            isFollow == other.isFollow &&
            sessionTs == other.sessionTs &&
            accountInfo == other.accountInfo;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      talkerId,
      sessionType,
      unreadCount,
      lastMessage,
      groupName,
      groupCover,
      isFollow,
      sessionTs,
      accountInfo,
    );
  }

  @override
  String toString() {
    return 'PrivateSession('
        'talkerId: $talkerId, '
        'sessionType: $sessionType, '
        'unreadCount: $unreadCount, '
        'lastMessage: $lastMessage, '
        'groupName: $groupName, '
        'groupCover: $groupCover, '
        'isFollow: $isFollow, '
        'sessionTs: $sessionTs, '
        'accountInfo: $accountInfo'
        ')';
  }
}
