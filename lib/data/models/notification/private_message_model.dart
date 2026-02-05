import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'private_message_model.freezed.dart';
part 'private_message_model.g.dart';

@freezed
abstract class PrivateMessageSessionResponse
    with _$PrivateMessageSessionResponse {
  const factory PrivateMessageSessionResponse({
    @JsonKey(name: 'session_list') List<PrivateMessageSession>? sessionList,
    @JsonKey(name: 'has_more') @Default(0) int hasMore,
    @JsonKey(name: 'system_msg') Map<String, int>? systemMsg,
  }) = _PrivateMessageSessionResponse;

  factory PrivateMessageSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageSessionResponseFromJson(json);
}

@freezed
abstract class PrivateMessageSession with _$PrivateMessageSession {
  const PrivateMessageSession._();
  const factory PrivateMessageSession({
    @JsonKey(name: 'talker_id') required int talkerId,
    @JsonKey(name: 'session_type') required int sessionType,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'last_msg') PrivateMessageDetail? lastMsg,
    @JsonKey(name: 'group_name') String? groupName,
    @JsonKey(name: 'group_cover') String? groupCover,
    @JsonKey(name: 'is_follow') @Default(0) int isFollow,
    @JsonKey(name: 'session_ts') required int sessionTs,
    @JsonKey(name: 'account_info') PrivateMessageAccountInfo? accountInfo,
  }) = _PrivateMessageSession;

  factory PrivateMessageSession.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageSessionFromJson(json);
}

@freezed
abstract class PrivateMessageDetail with _$PrivateMessageDetail {
  const PrivateMessageDetail._();
  const factory PrivateMessageDetail({
    @JsonKey(name: 'sender_uid') required int senderUid,
    @JsonKey(name: 'receiver_type') required int receiverType,
    @JsonKey(name: 'receiver_id') required int receiverId,
    @JsonKey(name: 'msg_type') required int msgType,
    required dynamic
    content, // Can be String (json) or Map depending on context, usually String in last_msg
    @JsonKey(name: 'msg_seqno') required int msgSeqno,
    required int timestamp,
    @JsonKey(name: 'at_uids') List<int>? atUids,
    @JsonKey(name: 'msg_key') int? msgKey,
    @JsonKey(name: 'msg_status') int? msgStatus,
    @JsonKey(name: 'notify_code') String? notifyCode,
    @JsonKey(name: 'new_face_version') int? newFaceVersion,
    @JsonKey(name: 'msg_source') int? msgSource,
  }) = _PrivateMessageDetail;

  factory PrivateMessageDetail.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageDetailFromJson(json);

  Map<String, dynamic>? get contentMap {
    if (content is Map) return content as Map<String, dynamic>;
    if (content is String) {
      try {
        return jsonDecode(content as String) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  bool isMe(int currentUid) => senderUid == currentUid;

  String get textContent {
    if (msgType == 1) {
      return contentMap?['content'] as String? ?? '';
    }
    return '';
  }

  String? get imageUrl {
    if (msgType == 2 || msgType == 6) {
      return contentMap?['url'] as String?;
    }
    return null;
  }

  List<Map<String, dynamic>>? get systemTipContent {
    if (msgType == 18) {
      try {
        final innerContentStr = contentMap?['content'] as String?;
        if (innerContentStr != null) {
          final List<dynamic> list = jsonDecode(innerContentStr);
          return list.map((e) => e as Map<String, dynamic>).toList();
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  bool get isWithdrawn => msgStatus == 1;

  String get summary {
    if (msgStatus == 1) {
      return '[撤回了一条消息]';
    }

    final contentMap = this.contentMap;

    switch (msgType) {
      case 1: // Text
        return contentMap?['content']?.toString() ?? '[文本消息]';
      case 2: // Picture
      case 6: // Emoji
        return '[图片]';
      case 5: // Withdraw
        return '[撤回了一条消息]';
      case 10: // Notice
        return contentMap?['title']?.toString() ??
            contentMap?['text']?.toString() ??
            '[系统通知]';
      case 11: // Video Push
        return '[视频] ${contentMap?['title']?.toString() ?? ''}';
      case 12: // Article Push
        return '[专栏] ${contentMap?['title']?.toString() ?? ''}';
      case 13: // Picture Card
        return '[卡片] ${contentMap?['title']?.toString() ?? ''}';
      case 14: // Share (Live etc)
        return '[分享] ${contentMap?['title']?.toString() ?? ''}';
      default:
        // Try to guess from content
        if (contentMap != null) {
          if (contentMap.containsKey('content')) {
            return contentMap['content'].toString();
          }
          if (contentMap.containsKey('title')) {
            return contentMap['title'].toString();
          }
        }
        return '[未知消息]';
    }
  }
}

@freezed
abstract class PrivateMessageListResponse with _$PrivateMessageListResponse {
  const factory PrivateMessageListResponse({
    List<PrivateMessageDetail>? messages,
    @JsonKey(name: 'has_more') @Default(0) int hasMore,
    @JsonKey(name: 'min_seqno') int? minSeqno,
    @JsonKey(name: 'max_seqno') int? maxSeqno,
    @JsonKey(name: 'e_infos') List<PrivateMessageEmojiInfo>? emojiInfos,
  }) = _PrivateMessageListResponse;

  factory PrivateMessageListResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageListResponseFromJson(json);
}

@freezed
abstract class PrivateMessageEmojiInfo with _$PrivateMessageEmojiInfo {
  const factory PrivateMessageEmojiInfo({
    required String text,
    required String url,
    @Default(1) int size,
    @JsonKey(name: 'gif_url') String? gifUrl,
  }) = _PrivateMessageEmojiInfo;

  factory PrivateMessageEmojiInfo.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageEmojiInfoFromJson(json);
}

@freezed
abstract class SendMessageResponse with _$SendMessageResponse {
  const factory SendMessageResponse({
    @JsonKey(name: 'msg_key') required int msgKey,
    @JsonKey(name: 'msg_content') String? msgContent,
    @JsonKey(name: 'key_hit_infos') Map<String, dynamic>? keyHitInfos,
  }) = _SendMessageResponse;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseFromJson(json);
}

@freezed
abstract class PrivateMessageAccountInfo with _$PrivateMessageAccountInfo {
  const factory PrivateMessageAccountInfo({
    required String name,
    @JsonKey(name: 'pic_url') required String picUrl,
  }) = _PrivateMessageAccountInfo;

  factory PrivateMessageAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageAccountInfoFromJson(json);
}
