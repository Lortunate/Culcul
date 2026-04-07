import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';

extension ReplyItemMapper on ReplyItem {
  NotificationEntry toDomain() {
    final primaryActor = user == null ? null : <NotificationActor>[user!];
    final actors = <NotificationActor>[...?primaryActor, ...?users];

    return NotificationEntry(
      id: id,
      actors: actors,
      detail: item,
      replyTime: replyTime,
      likeTime: likeTime,
    );
  }
}

extension PrivateMessageDetailMapper on PrivateMessageDetail {
  PrivateMessage toDomain() {
    return PrivateMessage(
      senderUid: senderUid,
      receiverType: PrivateMessageReceiverType.fromValue(receiverType),
      receiverId: receiverId,
      type: PrivateMessageType.fromValue(msgType),
      content: PrivateMessageContent.fromRaw(content),
      msgSeqno: msgSeqno,
      timestamp: timestamp,
      atUids: atUids,
      msgKey: msgKey,
      msgStatus: msgStatus,
      notifyCode: notifyCode,
      newFaceVersion: newFaceVersion,
      msgSource: msgSource,
    );
  }
}

extension PrivateMessageSessionMapper on PrivateMessageSession {
  PrivateSession toDomain() {
    return PrivateSession(
      talkerId: talkerId,
      sessionType: PrivateSessionType.fromValue(sessionType),
      unreadCount: unreadCount,
      lastMessage: lastMsg?.toDomain(),
      groupName: groupName,
      groupCover: groupCover,
      isFollow: isFollow,
      sessionTs: sessionTs,
      accountInfo: accountInfo,
    );
  }
}
