import 'dart:convert';
import 'dart:io';

import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'notification_repository_impl.g.dart';

@riverpod
domain.NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(NotificationApi(ref.watch(dioClientProvider)));
}

class NotificationRepositoryImpl
    with RequestExecutorBinding
    implements domain.NotificationRepository {
  final NotificationApi _api;
  final RequestExecutor _requestExecutor;

  NotificationRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<UnreadCountModel> getUnreadCountModel() async {
    return requestApi(() => _api.getUnreadCount());
  }

  Future<ReplyResponse> getReplyListModel({int? id, int? replyTime}) async {
    return requestApi(() => _api.getReplyList(id: id, replyTime: replyTime));
  }

  Future<ReplyResponse> getAtListModel({int? id, int? atTime}) async {
    return requestApi(() => _api.getAtList(id: id, atTime: atTime));
  }

  Future<ReplyResponse> getLikeListModel({int? id, int? likeTime}) async {
    final likeResponse = await requestApi(
      () => _api.getLikeList(id: id, likeTime: likeTime),
    );
    return ReplyResponse(
      cursor: likeResponse.total.cursor,
      items: likeResponse.total.items,
      lastViewAt: likeResponse.latest.lastViewAt,
    );
  }

  Future<PrivateMessageSessionResponse> getPrivateSessionsModel({
    PrivateSessionType sessionType = PrivateSessionType.user,
    int size = 20,
    int? endTs,
  }) async {
    return requestApi(
      () => _api.getPrivateSessions(
        sessionType: sessionType.value,
        size: size,
        endTs: endTs,
      ),
    );
  }

  Future<PrivateMessageListResponse> getPrivateMessagesModel({
    required int talkerId,
    PrivateSessionType sessionType = PrivateSessionType.user,
    int size = 20,
    int? beginSeqno,
    int? endSeqno,
  }) async {
    return requestApi(
      () => _api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType.value,
        size: size,
        beginSeqno: beginSeqno,
        endSeqno: endSeqno,
      ),
    );
  }

  Future<List<SystemNotificationItem>> fetchSystemNotifications() async {
    final sessionRes = await getPrivateSessionsModel(
      sessionType: PrivateSessionType.system,
    );
    final systemMsgMap = sessionRes.systemMsg;

    if (systemMsgMap == null || !systemMsgMap.containsKey('5')) {
      return [];
    }

    final talkerId = systemMsgMap['5']!;
    final msgsRes = await getPrivateMessagesModel(talkerId: talkerId);
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

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(File file) async {
    return requestResult(() async {
      final response = await requestApi(() => _api.uploadImage(file: file));
      return response.toDomain();
    });
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final devId = const Uuid().v4().toUpperCase();
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return requestResult(() async {
      final response = await requestApi(
        () => _api.sendPrivateMessage(
          wSenderUid: senderUid,
          wReceiverId: receiverId,
          wDevId: devId,
          senderUid: senderUid,
          receiverId: receiverId,
          receiverType: receiverType.value,
          msgType: messageType.value,
          devId: devId,
          timestamp: timestamp,
          content: jsonEncode(content.toRawMap()),
        ),
      );
      return response.toDomain();
    });
  }

  @override
  Future<Result<NotificationSummary, AppError>> getUnreadCount() async {
    return requestResult(() async => (await getUnreadCountModel()).toDomain());
  }

  @override
  Future<Result<List<NotificationEntry>, AppError>> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    return requestResult(() async {
      final response = await getReplyListModel(id: id, replyTime: replyTime);
      return response.items.map((item) => item.toDomain()).toList();
    });
  }

  @override
  Future<Result<List<NotificationEntry>, AppError>> getAtList({
    int? id,
    int? atTime,
  }) async {
    return requestResult(() async {
      final response = await getAtListModel(id: id, atTime: atTime);
      return response.items.map((item) => item.toDomain()).toList();
    });
  }

  @override
  Future<Result<List<NotificationEntry>, AppError>> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    return requestResult(() async {
      final response = await getLikeListModel(id: id, likeTime: likeTime);
      return response.items.map((item) => item.toDomain()).toList();
    });
  }

  @override
  Future<Result<List<SystemNotice>, AppError>> getSystemNotifications() async {
    return requestResult(
      () async =>
          (await fetchSystemNotifications()).map((item) => item.toDomain()).toList(),
    );
  }

  @override
  Future<Result<PrivateMessagePage, AppError>> getPrivateMessages({
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async {
    return requestResult(() async {
      final response = await getPrivateMessagesModel(
        talkerId: talkerId,
        sessionType: sessionType,
        endSeqno: endSeqno,
      );
      return response.toDomain();
    });
  }

  @override
  Future<Result<PrivateSessionPage, AppError>> getPrivateSessions({int? endTs}) async {
    return requestResult(() async {
      final response = await getPrivateSessionsModel(
        sessionType: PrivateSessionType.user,
        size: 20,
        endTs: endTs,
      );
      return response.toDomain();
    });
  }
}
