import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';

abstract class NotificationRepository {
  Future<Result<NotificationSummary, AppError>> getUnreadCount();

  Future<Result<List<NotificationEntry>, AppError>> getReplyList({
    int? id,
    int? replyTime,
  });

  Future<Result<List<NotificationEntry>, AppError>> getAtList({int? id, int? atTime});

  Future<Result<List<NotificationEntry>, AppError>> getLikeList({int? id, int? likeTime});

  Future<Result<List<SystemNotice>, AppError>> getSystemNotifications();

  Future<Result<PrivateMessagePage, AppError>> getPrivateMessages({
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  });

  Future<Result<PrivateSessionPage, AppError>> getPrivateSessions({int? endTs});

  Future<Result<ImageUploadResult, AppError>> uploadImage(File file);

  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  });
}
