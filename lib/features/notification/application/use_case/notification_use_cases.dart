import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/models/notification_models.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_use_cases.g.dart';

@riverpod
NotificationUseCases notificationUseCases(Ref ref) {
  return NotificationUseCases(ref.read(notificationRepositoryProvider));
}

class NotificationUseCases {
  final NotificationRepository _repository;

  const NotificationUseCases(this._repository);

  Future<Result<NotificationSummary, AppError>> getUnreadCount() async {
    try {
      return Success(await _repository.getUnreadCount());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<NotificationEntry>, AppError>> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    try {
      return Success(await _repository.getReplyList(id: id, replyTime: replyTime));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<NotificationEntry>, AppError>> getAtList({
    int? id,
    int? atTime,
  }) async {
    try {
      return Success(await _repository.getAtList(id: id, atTime: atTime));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<NotificationEntry>, AppError>> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    try {
      return Success(await _repository.getLikeList(id: id, likeTime: likeTime));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<SystemNotice>, AppError>> getSystemNotifications() async {
    try {
      return Success(await _repository.getSystemNotifications());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<PrivateMessagePage, AppError>> getPrivateMessages({
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

  Future<Result<PrivateSessionPage, AppError>> getPrivateSessions({
    int sessionType = 1,
    int size = 20,
    int? endTs,
  }) async {
    try {
      return Success(
        await _repository.getPrivateSessions(
          sessionType: sessionType,
          size: size,
          endTs: endTs,
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
    required PrivateMessageContent content,
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
