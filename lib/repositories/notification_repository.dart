import 'dart:io';

import 'package:culcul/data/api/notification_api.dart';
import 'package:culcul/data/models/notification/image_upload_response.dart';
import 'package:culcul/data/models/notification/like_model.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:culcul/data/models/notification/system_notification_model.dart';
import 'package:culcul/data/models/notification/unread_count_model.dart';
import 'package:uuid/uuid.dart';

class NotificationRepository {
  final NotificationApi _api;

  NotificationRepository(this._api);

  Future<UnreadCountModel> getUnreadCount() async {
    final response = await _api.getUnreadCount();
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  Future<ReplyResponse> getReplyList({int? id, int? replyTime}) async {
    final response = await _api.getReplyList(id: id, replyTime: replyTime);
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  Future<ReplyResponse> getAtList({int? id, int? atTime}) async {
    final response = await _api.getAtList(id: id, atTime: atTime);
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  Future<ReplyResponse> getLikeList({int? id, int? likeTime}) async {
    final response = await _api.getLikeList(id: id, likeTime: likeTime);
    if (response.isSuccess && response.data != null) {
      final likeResponse = response.data!;
      return ReplyResponse(
        cursor: likeResponse.total.cursor,
        items: likeResponse.total.items,
        lastViewAt: likeResponse.latest.lastViewAt,
      );
    }
    throw Exception(response.message);
  }

  Future<PrivateMessageSessionResponse> getPrivateSessions({
    int sessionType = 1,
    int size = 20,
    int? endTs,
  }) async {
    final response = await _api.getPrivateSessions(
      sessionType: sessionType,
      size: size,
      endTs: endTs,
    );
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  Future<PrivateMessageListResponse> getPrivateMessages({
    required int talkerId,
    int sessionType = 1,
    int size = 20,
    int? beginSeqno,
    int? endSeqno,
  }) async {
    final response = await _api.getPrivateMessages(
      talkerId: talkerId,
      sessionType: sessionType,
      size: size,
      beginSeqno: beginSeqno,
      endSeqno: endSeqno,
    );
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  Future<List<SystemNotificationItem>> fetchSystemNotifications() async {
    // 1. Get sessions (type 7 for system messages)
    final sessionRes = await getPrivateSessions(sessionType: 7);

    // 2. Find system notification session (type 5)
    final systemMsgMap = sessionRes.systemMsg;
    // Usually "5" is for system notifications
    if (systemMsgMap == null || !systemMsgMap.containsKey('5')) {
      return [];
    }

    final talkerId = systemMsgMap['5']!;

    // 3. Fetch messages for this talkerId
    final msgsRes = await getPrivateMessages(talkerId: talkerId);

    // 4. Map messages to SystemNotificationItem
    return msgsRes.messages?.map((msg) {
          final contentMap = msg.contentMap;
          return SystemNotificationItem(
            id: msg.msgSeqno,
            title: contentMap?['title'] as String?,
            text: contentMap?['content'] as String? ??
                contentMap?['text'] as String?,
            time: msg.timestamp,
            uri: contentMap?['url'] as String? ??
                contentMap?['uri'] as String? ??
                contentMap?['jump_uri'] as String?,
            jumpText: contentMap?['jump_text'] as String?,
          );
        }).toList() ??
        [];
  }

  Future<ImageUploadResponse> uploadImage(File file) async {
    final response = await _api.uploadImage(file: file);
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  Future<SendMessageResponse> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required String content,
  }) async {
    final devId = const Uuid().v4().toUpperCase();
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final response = await _api.sendPrivateMessage(
      wSenderUid: senderUid,
      wReceiverId: receiverId,
      wDevId: devId,
      senderUid: senderUid,
      receiverId: receiverId,
      receiverType: receiverType,
      msgType: msgType,
      devId: devId,
      timestamp: timestamp,
      content: content,
    );

    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw Exception(response.message);
  }
}
