import 'dart:io';

import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/notification_api.dart';
import 'package:culcul/data/models/notification/image_upload_response.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:culcul/data/models/notification/system_notification_model.dart';
import 'package:culcul/data/models/notification/unread_count_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'notification_repository.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(ref.watch(notificationApiProvider));
}

class NotificationRepository extends BaseRepository {
  final NotificationApi _api;

  NotificationRepository(this._api);

  Future<UnreadCountModel> getUnreadCount() async {
    return requestApi(() => _api.getUnreadCount());
  }

  Future<ReplyResponse> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    return requestApi(() => _api.getReplyList(id: id, replyTime: replyTime));
  }

  Future<ReplyResponse> getAtList({int? id, int? atTime}) async {
    return requestApi(() => _api.getAtList(id: id, atTime: atTime));
  }

  Future<ReplyResponse> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    final likeResponse = await requestApi(() => _api.getLikeList(id: id, likeTime: likeTime));
    return ReplyResponse(
      cursor: likeResponse.total.cursor,
      items: likeResponse.total.items,
      lastViewAt: likeResponse.latest.lastViewAt,
    );
  }

  Future<PrivateMessageSessionResponse> getPrivateSessions({
    int sessionType = 1,
    int size = 20,
    int? endTs,
  }) async {
    return requestApi(
      () => _api.getPrivateSessions(sessionType: sessionType, size: size, endTs: endTs),
    );
  }

  Future<PrivateMessageListResponse> getPrivateMessages({
    required int talkerId,
    int sessionType = 1,
    int size = 20,
    int? beginSeqno,
    int? endSeqno,
  }) async {
    return requestApi(
      () => _api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType,
        size: size,
        beginSeqno: beginSeqno,
        endSeqno: endSeqno,
      ),
    );
  }

  Future<List<SystemNotificationItem>> fetchSystemNotifications() async {
    final sessionRes = await getPrivateSessions(sessionType: 7);
    final systemMsgMap = sessionRes.systemMsg;

    if (systemMsgMap == null || !systemMsgMap.containsKey('5')) {
      return [];
    }

    final talkerId = systemMsgMap['5']!;
    final msgsRes = await getPrivateMessages(talkerId: talkerId);
    return msgsRes.messages?.map((msg) {
          final contentMap = msg.contentMap;
          return SystemNotificationItem(
            id: msg.msgSeqno,
            title: contentMap?['title'] as String?,
            text: contentMap?['content'] as String? ?? contentMap?['text'] as String?,
            time: msg.timestamp,
            uri:
                contentMap?['url'] as String? ??
                contentMap?['uri'] as String? ??
                contentMap?['jump_uri'] as String?,
            jumpText: contentMap?['jump_text'] as String?,
          );
        }).toList() ??
        [];
  }

  Future<ImageUploadResponse> uploadImage(File file) async {
    return requestApi(() => _api.uploadImage(file: file));
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

    return requestApi(
      () => _api.sendPrivateMessage(
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
      ),
    );
  }
}

