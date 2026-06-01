import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
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
      detail: NotificationEntryDetail(
        subjectId: item.subjectId,
        rootId: item.rootId,
        sourceId: item.sourceId,
        targetId: item.targetId,
        type: item.type,
        businessId: item.businessId,
        business: item.business,
        title: item.title,
        desc: item.desc,
        image: item.image,
        uri: item.uri,
        nativeUri: item.nativeUri,
        rootReplyContent: item.rootReplyContent,
        sourceContent: item.sourceContent,
        targetReplyContent: item.targetReplyContent,
        atDetails: item.atDetails,
        hideReplyButton: item.hideReplyButton,
        hideLikeButton: item.hideLikeButton,
        likeState: item.likeState,
        message: item.message,
      ),
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
