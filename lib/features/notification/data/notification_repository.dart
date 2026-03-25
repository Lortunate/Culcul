import 'dart:io';

import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
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

  Future<Result<UnreadCountModel, AppException>> getUnreadCount() async {
    return safeApiCall(() => _api.getUnreadCount());
  }

  Future<Result<ReplyResponse, AppException>> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    return safeApiCall(() => _api.getReplyList(id: id, replyTime: replyTime));
  }

  Future<Result<ReplyResponse, AppException>> getAtList({int? id, int? atTime}) async {
    return safeApiCall(() => _api.getAtList(id: id, atTime: atTime));
  }

  Future<Result<ReplyResponse, AppException>> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    final result = await safeApiCall(() => _api.getLikeList(id: id, likeTime: likeTime));

    return switch (result) {
      Success(value: final likeResponse) => Success(
        ReplyResponse(
          cursor: likeResponse.total.cursor,
          items: likeResponse.total.items,
          lastViewAt: likeResponse.latest.lastViewAt,
        ),
      ),
      Failure(exception: final e) => Failure(e),
    };
  }

  Future<Result<PrivateMessageSessionResponse, AppException>> getPrivateSessions({
    int sessionType = 1,
    int size = 20,
    int? endTs,
  }) async {
    return safeApiCall(
      () => _api.getPrivateSessions(sessionType: sessionType, size: size, endTs: endTs),
    );
  }

  Future<Result<PrivateMessageListResponse, AppException>> getPrivateMessages({
    required int talkerId,
    int sessionType = 1,
    int size = 20,
    int? beginSeqno,
    int? endSeqno,
  }) async {
    return safeApiCall(
      () => _api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType,
        size: size,
        beginSeqno: beginSeqno,
        endSeqno: endSeqno,
      ),
    );
  }

  Future<Result<List<SystemNotificationItem>, AppException>>
  fetchSystemNotifications() async {
    final sessionResult = await getPrivateSessions(sessionType: 7);

    if (sessionResult case Failure(exception: final e)) {
      return Failure(e);
    }

    final sessionRes =
        (sessionResult as Success<PrivateMessageSessionResponse, AppException>).value;
    final systemMsgMap = sessionRes.systemMsg;

    if (systemMsgMap == null || !systemMsgMap.containsKey('5')) {
      return const Success([]);
    }

    final talkerId = systemMsgMap['5']!;
    final msgsResult = await getPrivateMessages(talkerId: talkerId);

    return switch (msgsResult) {
      Success(value: final msgsRes) => Success(
        msgsRes.messages?.map((msg) {
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
            [],
      ),
      Failure(exception: final e) => Failure(e),
    };
  }

  Future<Result<ImageUploadResponse, AppException>> uploadImage(File file) async {
    return safeApiCall(() => _api.uploadImage(file: file));
  }

  Future<Result<SendMessageResponse, AppException>> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required String content,
  }) async {
    final devId = const Uuid().v4().toUpperCase();
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return safeApiCall(
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

