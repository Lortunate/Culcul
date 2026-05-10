import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';

extension ReplyUserMapper on ReplyUser {
  NotificationActor toDomain() {
    return NotificationActor(
      mid: mid,
      fans: fans,
      nickname: nickname,
      avatar: avatar,
      midLink: midLink,
      follow: follow,
    );
  }
}

extension ReplyItemDetailMapper on ReplyItemDetail {
  NotificationEntryDetail toDomain() {
    return NotificationEntryDetail(
      subjectId: subjectId,
      rootId: rootId,
      sourceId: sourceId,
      targetId: targetId,
      type: type,
      businessId: businessId,
      business: business,
      title: title,
      desc: desc,
      image: image,
      uri: uri,
      nativeUri: nativeUri,
      rootReplyContent: rootReplyContent,
      sourceContent: sourceContent,
      targetReplyContent: targetReplyContent,
      atDetails: atDetails.map((item) => item.toDomain()).toList(growable: false),
      hideReplyButton: hideReplyButton,
      hideLikeButton: hideLikeButton,
      likeState: likeState,
      message: message,
    );
  }
}

extension ReplyItemMapper on ReplyItem {
  NotificationEntry toDomain() {
    final primaryActor = user == null ? null : <NotificationActor>[user!.toDomain()];
    final actors = <NotificationActor>[
      ...?primaryActor,
      ...?users?.map((item) => item.toDomain()),
    ];

    return NotificationEntry(
      id: id,
      actors: actors,
      detail: item.toDomain(),
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
      accountInfo: accountInfo?.toDomain(),
    );
  }
}

extension PrivateMessageAccountInfoMapper on PrivateMessageAccountInfo {
  PrivateSessionAccountInfo toDomain() {
    return PrivateSessionAccountInfo(name: name, picUrl: picUrl);
  }
}

extension PrivateMessageEmojiInfoMapper on PrivateMessageEmojiInfo {
  PrivateMessageEmoji toDomain() {
    return PrivateMessageEmoji(text: text, url: url, size: size, gifUrl: gifUrl);
  }
}

extension UnreadCountModelMapper on UnreadCountModel {
  NotificationSummary toDomain() {
    return NotificationSummary(
      at: at,
      chat: chat,
      coin: coin,
      danmu: danmu,
      favorite: favorite,
      like: like,
      recvLike: recvLike,
      recvReply: recvReply,
      reply: reply,
      system: system,
      up: up,
    );
  }
}

extension SendMessageResponseMapper on SendMessageResponse {
  SendMessageResult toDomain() {
    return SendMessageResult(
      msgKey: msgKey,
      msgContent: msgContent,
      keyHitInfos: keyHitInfos,
    );
  }
}

extension ImageUploadResponseMapper on ImageUploadResponse {
  ImageUploadResult toDomain() {
    return ImageUploadResult(
      imageUrl: imageUrl,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
    );
  }
}

extension SystemNotificationItemMapper on SystemNotificationItem {
  SystemNotice toDomain() {
    return SystemNotice(
      id: id,
      title: title,
      text: text,
      time: time,
      uri: uri,
      jumpText: jumpText,
    );
  }
}
