import 'dart:convert';

import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:flutter/foundation.dart';

PrivateSessionAccountInfo? _privateSessionAccountInfoFromJson(Object? raw) {
  final json = JsonUtils.asStringKeyedMap(raw);
  if (json == null) return null;
  return PrivateSessionAccountInfo(
    name: JsonUtils.parseStringWithDefault(json['name']),
    picUrl: JsonUtils.parseStringWithDefault(json['pic_url']),
  );
}

Map<String, dynamic>? _privateSessionAccountInfoToJson(PrivateSessionAccountInfo? value) {
  if (value == null) return null;
  return <String, dynamic>{'name': value.name, 'pic_url': value.picUrl};
}

final class PrivateMessageSessionResponse {
  PrivateMessageSessionResponse({
    List<PrivateMessageSession>? sessionList,
    this.hasMore = 0,
    Map<String, int>? systemMsg,
  }) : _sessionList = sessionList == null
           ? null
           : List<PrivateMessageSession>.unmodifiable(sessionList),
       _systemMsg = systemMsg == null ? null : Map<String, int>.unmodifiable(systemMsg);

  factory PrivateMessageSessionResponse.fromJson(Map<String, dynamic> json) {
    final rawSystemMsg = JsonUtils.asStringKeyedMap(json['system_msg']);
    return PrivateMessageSessionResponse(
      sessionList: (json['session_list'] as List<dynamic>?)
          ?.map((e) => PrivateMessageSession.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: (json['has_more'] as num?)?.toInt() ?? 0,
      systemMsg: rawSystemMsg?.map((key, value) => MapEntry(key, (value as num).toInt())),
    );
  }

  final List<PrivateMessageSession>? _sessionList;
  final int hasMore;
  final Map<String, int>? _systemMsg;

  List<PrivateMessageSession>? get sessionList => _sessionList;
  Map<String, int>? get systemMsg => _systemMsg;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateMessageSessionResponse &&
            runtimeType == other.runtimeType &&
            listEquals(_sessionList, other._sessionList) &&
            hasMore == other.hasMore &&
            mapEquals(_systemMsg, other._systemMsg);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      Object.hashAll(_sessionList ?? const <PrivateMessageSession>[]),
      hasMore,
      Object.hashAllUnordered(
        _systemMsg?.entries.map((entry) => Object.hash(entry.key, entry.value)) ??
            const <int>[],
      ),
    );
  }

  @override
  String toString() {
    return 'PrivateMessageSessionResponse('
        'sessionList: $_sessionList, '
        'hasMore: $hasMore, '
        'systemMsg: $_systemMsg'
        ')';
  }
}

final class PrivateMessageSession {
  const PrivateMessageSession({
    required this.talkerId,
    required this.sessionType,
    this.unreadCount = 0,
    this.lastMsg,
    this.groupName,
    this.groupCover,
    this.isFollow = 0,
    required this.sessionTs,
    this.accountInfo,
  });

  factory PrivateMessageSession.fromJson(Map<String, dynamic> json) {
    return PrivateMessageSession(
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
      accountInfo: _privateSessionAccountInfoFromJson(json['account_info']),
    );
  }

  final int talkerId;
  final int sessionType;
  final int unreadCount;
  final PrivateMessageDetail? lastMsg;
  final String? groupName;
  final String? groupCover;
  final int isFollow;
  final int sessionTs;
  final PrivateSessionAccountInfo? accountInfo;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'talker_id': talkerId,
      'session_type': sessionType,
      'unread_count': unreadCount,
      'last_msg': lastMsg?.toJson(),
      'group_name': groupName,
      'group_cover': groupCover,
      'is_follow': isFollow,
      'session_ts': sessionTs,
      'account_info': _privateSessionAccountInfoToJson(accountInfo),
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateMessageSession &&
            runtimeType == other.runtimeType &&
            talkerId == other.talkerId &&
            sessionType == other.sessionType &&
            unreadCount == other.unreadCount &&
            lastMsg == other.lastMsg &&
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
      lastMsg,
      groupName,
      groupCover,
      isFollow,
      sessionTs,
      accountInfo,
    );
  }

  @override
  String toString() {
    return 'PrivateMessageSession('
        'talkerId: $talkerId, '
        'sessionType: $sessionType, '
        'unreadCount: $unreadCount, '
        'lastMsg: $lastMsg, '
        'groupName: $groupName, '
        'groupCover: $groupCover, '
        'isFollow: $isFollow, '
        'sessionTs: $sessionTs, '
        'accountInfo: $accountInfo'
        ')';
  }
}

final class PrivateMessageDetail {
  PrivateMessageDetail({
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.msgType,
    required this.content,
    required this.msgSeqno,
    required this.timestamp,
    List<int>? atUids,
    this.msgKey,
    this.msgStatus,
    this.notifyCode,
    this.newFaceVersion,
    this.msgSource,
  }) : _atUids = atUids == null ? null : List<int>.unmodifiable(atUids);

  factory PrivateMessageDetail.fromJson(Map<String, dynamic> json) {
    return PrivateMessageDetail(
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
  }

  final int senderUid;
  final int receiverType;
  final int receiverId;
  final int msgType;
  final dynamic content;
  final int msgSeqno;
  final int timestamp;
  final List<int>? _atUids;
  final int? msgKey;
  final int? msgStatus;
  final String? notifyCode;
  final int? newFaceVersion;
  final int? msgSource;

  List<int>? get atUids => _atUids;

  Map<String, dynamic>? get contentMap {
    if (content is Map) return Map<String, dynamic>.from(content as Map);
    if (content is String) {
      try {
        // Intentionally synchronous: message content payloads are small
        // (<1KB). Making this async would require API-breaking changes
        // to all callers (UI widgets, summary getters).
        return jsonDecode(content as String) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender_uid': senderUid,
      'receiver_type': receiverType,
      'receiver_id': receiverId,
      'msg_type': msgType,
      'content': content,
      'msg_seqno': msgSeqno,
      'timestamp': timestamp,
      'at_uids': _atUids,
      'msg_key': msgKey,
      'msg_status': msgStatus,
      'notify_code': notifyCode,
      'new_face_version': newFaceVersion,
      'msg_source': msgSource,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateMessageDetail &&
            runtimeType == other.runtimeType &&
            senderUid == other.senderUid &&
            receiverType == other.receiverType &&
            receiverId == other.receiverId &&
            msgType == other.msgType &&
            _contentEquals(content, other.content) &&
            msgSeqno == other.msgSeqno &&
            timestamp == other.timestamp &&
            listEquals(_atUids, other._atUids) &&
            msgKey == other.msgKey &&
            msgStatus == other.msgStatus &&
            notifyCode == other.notifyCode &&
            newFaceVersion == other.newFaceVersion &&
            msgSource == other.msgSource;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      senderUid,
      receiverType,
      receiverId,
      msgType,
      _contentHash(content),
      msgSeqno,
      timestamp,
      Object.hashAll(_atUids ?? const <int>[]),
      msgKey,
      msgStatus,
      notifyCode,
      newFaceVersion,
      msgSource,
    );
  }

  @override
  String toString() {
    return 'PrivateMessageDetail('
        'senderUid: $senderUid, '
        'receiverType: $receiverType, '
        'receiverId: $receiverId, '
        'msgType: $msgType, '
        'content: $content, '
        'msgSeqno: $msgSeqno, '
        'timestamp: $timestamp, '
        'atUids: $_atUids, '
        'msgKey: $msgKey, '
        'msgStatus: $msgStatus, '
        'notifyCode: $notifyCode, '
        'newFaceVersion: $newFaceVersion, '
        'msgSource: $msgSource'
        ')';
  }
}

final class PrivateMessageListResponse {
  PrivateMessageListResponse({
    List<PrivateMessageDetail>? messages,
    this.hasMore = 0,
    this.minSeqno,
    this.maxSeqno,
    List<PrivateMessageEmoji>? emojiInfos,
  }) : _messages = messages == null
           ? null
           : List<PrivateMessageDetail>.unmodifiable(messages),
       _emojiInfos = emojiInfos == null
           ? null
           : List<PrivateMessageEmoji>.unmodifiable(emojiInfos);

  factory PrivateMessageListResponse.fromJson(Map<String, dynamic> json) {
    return PrivateMessageListResponse(
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => PrivateMessageDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: (json['has_more'] as num?)?.toInt() ?? 0,
      minSeqno: (json['min_seqno'] as num?)?.toInt(),
      maxSeqno: (json['max_seqno'] as num?)?.toInt(),
      emojiInfos: (json['e_infos'] as List<dynamic>?)
          ?.map((e) => PrivateMessageEmoji.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<PrivateMessageDetail>? _messages;
  final int hasMore;
  final int? minSeqno;
  final int? maxSeqno;
  final List<PrivateMessageEmoji>? _emojiInfos;

  List<PrivateMessageDetail>? get messages => _messages;
  List<PrivateMessageEmoji>? get emojiInfos => _emojiInfos;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateMessageListResponse &&
            runtimeType == other.runtimeType &&
            listEquals(_messages, other._messages) &&
            hasMore == other.hasMore &&
            minSeqno == other.minSeqno &&
            maxSeqno == other.maxSeqno &&
            listEquals(_emojiInfos, other._emojiInfos);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      Object.hashAll(_messages ?? const <PrivateMessageDetail>[]),
      hasMore,
      minSeqno,
      maxSeqno,
      Object.hashAll(_emojiInfos ?? const <PrivateMessageEmoji>[]),
    );
  }

  @override
  String toString() {
    return 'PrivateMessageListResponse('
        'messages: $_messages, '
        'hasMore: $hasMore, '
        'minSeqno: $minSeqno, '
        'maxSeqno: $maxSeqno, '
        'emojiInfos: $_emojiInfos'
        ')';
  }
}

bool _contentEquals(Object? left, Object? right) {
  if (identical(left, right)) return true;
  if (left is Map && right is Map) {
    if (left.length != right.length) return false;
    for (final entry in left.entries) {
      if (!right.containsKey(entry.key)) return false;
      if (!_contentEquals(entry.value, right[entry.key])) return false;
    }
    return true;
  }
  if (left is List && right is List) {
    if (left.length != right.length) return false;
    for (var i = 0; i < left.length; i += 1) {
      if (!_contentEquals(left[i], right[i])) return false;
    }
    return true;
  }
  return left == right;
}

int _contentHash(Object? value) {
  if (value is Map) {
    return Object.hashAllUnordered(
      value.entries.map(
        (entry) => Object.hash(_contentHash(entry.key), _contentHash(entry.value)),
      ),
    );
  }
  if (value is List) {
    return Object.hashAll(value.map(_contentHash));
  }
  return value.hashCode;
}
