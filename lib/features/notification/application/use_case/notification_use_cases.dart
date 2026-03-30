import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/notification/image_upload_response.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:culcul/data/models/notification/system_notification_model.dart';
import 'package:culcul/data/models/notification/unread_count_model.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_use_cases.g.dart';

@riverpod
NotificationUseCases notificationUseCases(Ref ref) {
  return NotificationUseCases(ref.read(notificationRepositoryProvider));
}

class NotificationUseCases {
  final NotificationRepository _repository;

  const NotificationUseCases(this._repository);

  Future<Result<UnreadCountModel, AppError>> getUnreadCount() async {
    try {
      return Success(await _repository.getUnreadCount());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ReplyResponse, AppError>> getReplyList({int? id, int? replyTime}) async {
    try {
      return Success(await _repository.getReplyList(id: id, replyTime: replyTime));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ReplyResponse, AppError>> getAtList({int? id, int? atTime}) async {
    try {
      return Success(await _repository.getAtList(id: id, atTime: atTime));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ReplyResponse, AppError>> getLikeList({int? id, int? likeTime}) async {
    try {
      return Success(await _repository.getLikeList(id: id, likeTime: likeTime));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<SystemNotificationItem>, AppError>> getSystemNotifications() async {
    try {
      return Success(await _repository.fetchSystemNotifications());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<PrivateMessageListResponse, AppError>> getPrivateMessages({
    required int talkerId,
    required int sessionType,
    int? endSeqno,
  }) async {
    try {
      return Success(
        await _repository.getPrivateMessages(
          talkerId: talkerId,
          sessionType: sessionType,
          endSeqno: endSeqno,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ImageUploadResponse, AppError>> uploadImage(File file) async {
    try {
      return Success(await _repository.uploadImage(file));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<SendMessageResponse, AppError>> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required String content,
  }) async {
    try {
      return Success(
        await _repository.sendPrivateMessage(
          senderUid: senderUid,
          receiverId: receiverId,
          receiverType: receiverType,
          msgType: msgType,
          content: content,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
