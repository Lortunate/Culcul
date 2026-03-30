import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/notification/image_upload_response.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/features/notification/data/mappers/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
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
      return Success((await _repository.getUnreadCount()).toDomain());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<NotificationEntry>, AppError>> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    try {
      final response = await _repository.getReplyList(id: id, replyTime: replyTime);
      return Success(response.items.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<NotificationEntry>, AppError>> getAtList({
    int? id,
    int? atTime,
  }) async {
    try {
      final response = await _repository.getAtList(id: id, atTime: atTime);
      return Success(response.items.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<NotificationEntry>, AppError>> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    try {
      final response = await _repository.getLikeList(id: id, likeTime: likeTime);
      return Success(response.items.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<SystemNotice>, AppError>> getSystemNotifications() async {
    try {
      return Success(
        (await _repository.fetchSystemNotifications())
            .map((item) => item.toDomain())
            .toList(),
      );
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
      final response = await _repository.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType,
        endSeqno: endSeqno,
      );
      return Success(response.toDomain());
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
      final response = await _repository.getPrivateSessions(
        sessionType: sessionType,
        size: size,
        endTs: endTs,
      );
      return Success(response.toDomain());
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
