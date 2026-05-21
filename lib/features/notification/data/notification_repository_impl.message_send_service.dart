import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_message_persistence.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;

typedef SyncMessagesHeadFn =
    Future<void> Function({
      required int ownerUid,
      required int talkerId,
      required PrivateSessionType sessionType,
    });

class NotificationMessageSendService {
  NotificationMessageSendService({
    required this.database,
    required this.api,
    required this.dio,
    required this.requestExecutor,
    required this.persistence,
    required this.messageSupport,
    required this.nowSeconds,
    required this.syncMessagesHead,
  });

  final NotificationLocalDatabase database;
  final NotificationApi api;
  final Dio dio;
  final RequestExecutor requestExecutor;
  final NotificationMessagePersistence persistence;
  final NotificationMessageSupport messageSupport;
  final int Function() nowSeconds;
  final SyncMessagesHeadFn syncMessagesHead;

  PrivateSessionType _sessionTypeFromReceiver(PrivateMessageReceiverType type) {
    return type == PrivateMessageReceiverType.group
        ? PrivateSessionType.group
        : PrivateSessionType.user;
  }

  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) async {
    final result = await requestExecutor.runApiDirect(() async {
      final formData = FormData.fromMap({
        'file_up': MultipartFile.fromBytes(bytes, filename: filename),
        'biz': 'draw',
        'category': 'daily',
        'build': '0',
        'mobi_app': 'web',
      });
      final response = await dio.post<Map<String, dynamic>>(
        'https://api.vc.bilibili.com/api/v1/drawImage/upload',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data!,
        (json) => Map<String, dynamic>.from(json as Map),
      );
    });
    return result.map(imageUploadResultFromJson);
  }

  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final now = nowSeconds();
    final localMsgSeqno = -DateTime.now().microsecondsSinceEpoch;
    final contentMap = content.toRawMap();
    final contentRawJson = jsonEncode(contentMap);
    final devId = _generateUuidV4();

    await database.transaction(() async {
      await database
          .into(database.notificationMessages)
          .insertOnConflictUpdate(
            NotificationMessagesCompanion.insert(
              ownerUid: ownerUid,
              sessionType: _sessionTypeFromReceiver(receiverType).value,
              talkerId: receiverId,
              msgSeqno: localMsgSeqno,
              senderUid: ownerUid,
              receiverType: receiverType.value,
              receiverId: receiverId,
              msgType: messageType.value,
              contentJson: contentRawJson,
              timestamp: now,
              atUidsJson: const Value(null),
              msgKey: const Value(null),
              msgStatus: const Value(0),
              notifyCode: const Value(null),
              newFaceVersion: const Value(null),
              msgSource: const Value(null),
              syncStatus: const Value('pending'),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await database
          .into(database.notificationOutbox)
          .insert(
            NotificationOutboxCompanion.insert(
              ownerUid: ownerUid,
              sessionType: _sessionTypeFromReceiver(receiverType).value,
              talkerId: receiverId,
              localMsgSeqno: localMsgSeqno,
              senderUid: ownerUid,
              receiverType: receiverType.value,
              receiverId: receiverId,
              msgType: messageType.value,
              contentJson: contentRawJson,
              timestamp: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
    });

    final responseResult = await requestExecutor.runApiDirect(
      () => api.sendPrivateMessage(
        wSenderUid: ownerUid,
        wReceiverId: receiverId,
        wDevId: devId,
        senderUid: ownerUid,
        receiverId: receiverId,
        receiverType: receiverType.value,
        msgType: messageType.value,
        devId: devId,
        timestamp: now,
        content: contentRawJson,
      ),
    );

    await responseResult.when(
      success: (responseJson) async {
        final response = sendMessageResultFromJson(responseJson as Map<String, dynamic>);
        await persistence.markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'sent',
          now: nowSeconds(),
          msgKey: response.msgKey,
        );
        await syncMessagesHead(
          ownerUid: ownerUid,
          talkerId: receiverId,
          sessionType: _sessionTypeFromReceiver(receiverType),
        );
      },
      failure: (error) async {
        await persistence.markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'failed',
          now: nowSeconds(),
          error: error.message,
        );
      },
    );

    return responseResult.map(
      (json) => sendMessageResultFromJson(json as Map<String, dynamic>),
    );
  }

  Future<Result<ReplyResponse, AppError>> fetchReplyLikeAtResponse({
    required NotificationFeedType type,
    int? id,
    int? time,
  }) {
    return messageSupport.fetchReplyLikeAtResponse(type: type, id: id, time: time);
  }

  Future<Result<List<SystemNotice>, AppError>> fetchSystemNotifications() {
    return messageSupport.fetchSystemNotifications();
  }
}

String _generateUuidV4() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));

  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  String hex(int byte) => byte.toRadixString(16).padLeft(2, '0');

  final buffer = StringBuffer()
    ..write(hex(bytes[0]))
    ..write(hex(bytes[1]))
    ..write(hex(bytes[2]))
    ..write(hex(bytes[3]))
    ..write('-')
    ..write(hex(bytes[4]))
    ..write(hex(bytes[5]))
    ..write('-')
    ..write(hex(bytes[6]))
    ..write(hex(bytes[7]))
    ..write('-')
    ..write(hex(bytes[8]))
    ..write(hex(bytes[9]))
    ..write('-')
    ..write(hex(bytes[10]))
    ..write(hex(bytes[11]))
    ..write(hex(bytes[12]))
    ..write(hex(bytes[13]))
    ..write(hex(bytes[14]))
    ..write(hex(bytes[15]));

  return buffer.toString().toUpperCase();
}
