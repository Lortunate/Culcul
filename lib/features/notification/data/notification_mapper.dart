import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';

extension UnreadCountMapper on UnreadCountModel {
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
      system: sysMsg,
      up: up,
    );
  }
}

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
      atDetails: atDetails.map((item) => item.toDomain()).toList(),
      hideReplyButton: hideReplyButton,
      hideLikeButton: hideLikeButton,
      likeState: likeState,
      message: message,
    );
  }
}

extension ReplyItemMapper on ReplyItem {
  NotificationEntry toDomain() {
    final actors = <NotificationActor>[
      if (user != null) user!.toDomain(),
      ...?users?.map((item) => item.toDomain()),
    ];

    return NotificationEntry(
      id: id,
      actors: actors,
      detail: item.toDomain(),
      counts: counts,
      isMulti: isMulti,
      replyTime: replyTime,
      likeTime: likeTime,
    );
  }
}

extension SystemNotificationMapper on SystemNotificationItem {
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

extension PrivateMessageEmojiMapper on PrivateMessageEmojiInfo {
  PrivateMessageEmoji toDomain() {
    return PrivateMessageEmoji(text: text, url: url, size: size, gifUrl: gifUrl);
  }
}

extension PrivateMessageDetailMapper on PrivateMessageDetail {
  PrivateMessage toDomain() {
    return PrivateMessage(
      senderUid: senderUid,
      receiverType: receiverType,
      receiverId: receiverId,
      msgType: msgType,
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

extension PrivateMessageAccountInfoMapper on PrivateMessageAccountInfo {
  PrivateSessionAccountInfo toDomain() {
    return PrivateSessionAccountInfo(name: name, picUrl: picUrl);
  }
}

extension PrivateMessageSessionMapper on PrivateMessageSession {
  PrivateSession toDomain() {
    return PrivateSession(
      talkerId: talkerId,
      sessionType: sessionType,
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

extension PrivateMessageListResponseMapper on PrivateMessageListResponse {
  PrivateMessagePage toDomain() {
    return PrivateMessagePage(
      messages: (messages ?? const []).map((item) => item.toDomain()).toList(),
      hasMore: hasMore == 1,
      minSeqno: minSeqno,
      maxSeqno: maxSeqno,
      emojiInfos: (emojiInfos ?? const []).map((item) => item.toDomain()).toList(),
    );
  }
}

extension PrivateMessageSessionResponseMapper on PrivateMessageSessionResponse {
  PrivateSessionPage toDomain() {
    return PrivateSessionPage(
      sessions: (sessionList ?? const []).map((item) => item.toDomain()).toList(),
      hasMore: hasMore == 1,
      systemMessages: systemMsg,
    );
  }
}
