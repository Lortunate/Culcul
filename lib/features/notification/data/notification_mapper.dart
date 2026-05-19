import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
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

NotificationSummary notificationSummaryFromJson(Map<String, dynamic> json) {
  return NotificationSummary(
    at: _readInt(json['at']),
    chat: _readInt(json['chat']),
    coin: _readInt(json['coin']),
    danmu: _readInt(json['danmu']),
    favorite: _readInt(json['favorite']),
    like: _readInt(json['like']),
    recvLike: _readInt(json['recv_like']),
    recvReply: _readInt(json['recv_reply']),
    reply: _readInt(json['reply']),
    system: _readInt(json['sys_msg']),
    up: _readInt(json['up']),
  );
}

Map<String, dynamic> notificationSummaryToJson(NotificationSummary summary) {
  return <String, dynamic>{
    'at': summary.at,
    'chat': summary.chat,
    'coin': summary.coin,
    'danmu': summary.danmu,
    'favorite': summary.favorite,
    'like': summary.like,
    'recv_like': summary.recvLike,
    'recv_reply': summary.recvReply,
    'reply': summary.reply,
    'sys_msg': summary.system,
    'up': summary.up,
  };
}

SendMessageResult sendMessageResultFromJson(Map<String, dynamic> json) {
  return SendMessageResult(
    msgKey: _readInt(json['msg_key']),
    msgContent: _readNullableString(json['msg_content']),
    keyHitInfos: _readMapOrNull(json['key_hit_infos']),
  );
}

ImageUploadResult imageUploadResultFromJson(Map<String, dynamic> json) {
  return ImageUploadResult(
    imageUrl: _readString(json['image_url']),
    imageWidth: _readInt(json['image_width']),
    imageHeight: _readInt(json['image_height']),
  );
}

int _readInt(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String _readString(Object? value) {
  return value?.toString() ?? '';
}

String? _readNullableString(Object? value) {
  if (value == null) {
    return null;
  }
  final stringValue = value.toString();
  return stringValue.isEmpty ? null : stringValue;
}

Map<String, dynamic>? _readMapOrNull(Object? value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return null;
}
