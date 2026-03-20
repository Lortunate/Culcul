// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrivateMessageSessionResponse _$PrivateMessageSessionResponseFromJson(
  Map<String, dynamic> json,
) => _PrivateMessageSessionResponse(
  sessionList: (json['session_list'] as List<dynamic>?)
      ?.map((e) => PrivateMessageSession.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasMore: (json['has_more'] as num?)?.toInt() ?? 0,
  systemMsg: (json['system_msg'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
);

Map<String, dynamic> _$PrivateMessageSessionResponseToJson(
  _PrivateMessageSessionResponse instance,
) => <String, dynamic>{
  'session_list': instance.sessionList,
  'has_more': instance.hasMore,
  'system_msg': instance.systemMsg,
};

_PrivateMessageSession _$PrivateMessageSessionFromJson(
  Map<String, dynamic> json,
) => _PrivateMessageSession(
  talkerId: (json['talker_id'] as num).toInt(),
  sessionType: (json['session_type'] as num).toInt(),
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  lastMsg: json['last_msg'] == null
      ? null
      : PrivateMessageDetail.fromJson(json['last_msg'] as Map<String, dynamic>),
  groupName: json['group_name'] as String?,
  groupCover: json['group_cover'] as String?,
  isFollow: (json['is_follow'] as num?)?.toInt() ?? 0,
  sessionTs: (json['session_ts'] as num).toInt(),
  accountInfo: json['account_info'] == null
      ? null
      : PrivateMessageAccountInfo.fromJson(
          json['account_info'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PrivateMessageSessionToJson(
  _PrivateMessageSession instance,
) => <String, dynamic>{
  'talker_id': instance.talkerId,
  'session_type': instance.sessionType,
  'unread_count': instance.unreadCount,
  'last_msg': instance.lastMsg,
  'group_name': instance.groupName,
  'group_cover': instance.groupCover,
  'is_follow': instance.isFollow,
  'session_ts': instance.sessionTs,
  'account_info': instance.accountInfo,
};

_PrivateMessageDetail _$PrivateMessageDetailFromJson(
  Map<String, dynamic> json,
) => _PrivateMessageDetail(
  senderUid: (json['sender_uid'] as num).toInt(),
  receiverType: (json['receiver_type'] as num).toInt(),
  receiverId: (json['receiver_id'] as num).toInt(),
  msgType: (json['msg_type'] as num).toInt(),
  content: json['content'],
  msgSeqno: (json['msg_seqno'] as num).toInt(),
  timestamp: (json['timestamp'] as num).toInt(),
  atUids: (json['at_uids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  msgKey: (json['msg_key'] as num?)?.toInt(),
  msgStatus: (json['msg_status'] as num?)?.toInt(),
  notifyCode: json['notify_code'] as String?,
  newFaceVersion: (json['new_face_version'] as num?)?.toInt(),
  msgSource: (json['msg_source'] as num?)?.toInt(),
);

Map<String, dynamic> _$PrivateMessageDetailToJson(
  _PrivateMessageDetail instance,
) => <String, dynamic>{
  'sender_uid': instance.senderUid,
  'receiver_type': instance.receiverType,
  'receiver_id': instance.receiverId,
  'msg_type': instance.msgType,
  'content': instance.content,
  'msg_seqno': instance.msgSeqno,
  'timestamp': instance.timestamp,
  'at_uids': instance.atUids,
  'msg_key': instance.msgKey,
  'msg_status': instance.msgStatus,
  'notify_code': instance.notifyCode,
  'new_face_version': instance.newFaceVersion,
  'msg_source': instance.msgSource,
};

_PrivateMessageListResponse _$PrivateMessageListResponseFromJson(
  Map<String, dynamic> json,
) => _PrivateMessageListResponse(
  messages: (json['messages'] as List<dynamic>?)
      ?.map((e) => PrivateMessageDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasMore: (json['has_more'] as num?)?.toInt() ?? 0,
  minSeqno: (json['min_seqno'] as num?)?.toInt(),
  maxSeqno: (json['max_seqno'] as num?)?.toInt(),
  emojiInfos: (json['e_infos'] as List<dynamic>?)
      ?.map((e) => PrivateMessageEmojiInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrivateMessageListResponseToJson(
  _PrivateMessageListResponse instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'has_more': instance.hasMore,
  'min_seqno': instance.minSeqno,
  'max_seqno': instance.maxSeqno,
  'e_infos': instance.emojiInfos,
};

_PrivateMessageEmojiInfo _$PrivateMessageEmojiInfoFromJson(
  Map<String, dynamic> json,
) => _PrivateMessageEmojiInfo(
  text: json['text'] as String,
  url: json['url'] as String,
  size: (json['size'] as num?)?.toInt() ?? 1,
  gifUrl: json['gif_url'] as String?,
);

Map<String, dynamic> _$PrivateMessageEmojiInfoToJson(
  _PrivateMessageEmojiInfo instance,
) => <String, dynamic>{
  'text': instance.text,
  'url': instance.url,
  'size': instance.size,
  'gif_url': instance.gifUrl,
};

_SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) =>
    _SendMessageResponse(
      msgKey: (json['msg_key'] as num).toInt(),
      msgContent: json['msg_content'] as String?,
      keyHitInfos: json['key_hit_infos'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SendMessageResponseToJson(
  _SendMessageResponse instance,
) => <String, dynamic>{
  'msg_key': instance.msgKey,
  'msg_content': instance.msgContent,
  'key_hit_infos': instance.keyHitInfos,
};

_PrivateMessageAccountInfo _$PrivateMessageAccountInfoFromJson(
  Map<String, dynamic> json,
) => _PrivateMessageAccountInfo(
  name: json['name'] as String,
  picUrl: json['pic_url'] as String,
);

Map<String, dynamic> _$PrivateMessageAccountInfoToJson(
  _PrivateMessageAccountInfo instance,
) => <String, dynamic>{'name': instance.name, 'pic_url': instance.picUrl};
