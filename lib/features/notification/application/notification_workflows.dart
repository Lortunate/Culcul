import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/entities/notification_transport_entities.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_workflows.g.dart';

@riverpod
NotificationWorkflows notificationWorkflows(Ref ref) {
  return NotificationWorkflows(ref.read(notificationRepositoryProvider));
}

class NotificationWorkflows {
  final NotificationRepository _repository;

  const NotificationWorkflows(this._repository);

  Future<Result<NotificationSummary, AppError>> getUnreadCount() async {
    return runResult(() => _repository.getUnreadCount());
  }

  Future<Result<List<NotificationEntry>, AppError>> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    return runResult(() => _repository.getReplyList(id: id, replyTime: replyTime));
  }

  Future<Result<List<NotificationEntry>, AppError>> getAtList({
    int? id,
    int? atTime,
  }) async {
    return runResult(() => _repository.getAtList(id: id, atTime: atTime));
  }

  Future<Result<List<NotificationEntry>, AppError>> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    return runResult(() => _repository.getLikeList(id: id, likeTime: likeTime));
  }

  Future<Result<List<SystemNotice>, AppError>> getSystemNotifications() async {
    return runResult(() => _repository.getSystemNotifications());
  }

  Future<Result<PrivateMessagePage, AppError>> getPrivateMessages({
    required int talkerId,
    required int sessionType,
    int? endSeqno,
  }) async {
    return runResult(
      () => _repository.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType,
        endSeqno: endSeqno,
      ),
    );
  }

  Future<Result<PrivateSessionPage, AppError>> getPrivateSessions({
    int? endTs,
  }) async {
    return runResult(() => _repository.getPrivateSessions(endTs: endTs));
  }

  Future<Result<ImageUploadResponse, AppError>> uploadImage(File file) async {
    return runResult(() => _repository.uploadImage(file));
  }

  Future<Result<SendMessageResponse, AppError>> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required PrivateMessageContent content,
  }) async {
    return runResult(
      () => _repository.sendPrivateMessage(
        senderUid: senderUid,
        receiverId: receiverId,
        receiverType: receiverType,
        msgType: msgType,
        content: content,
      ),
    );
  }
}
