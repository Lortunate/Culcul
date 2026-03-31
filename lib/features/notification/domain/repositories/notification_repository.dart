import 'dart:io';

import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/entities/notification_transport_entities.dart';

abstract class NotificationRepository {
  Future<NotificationSummary> getUnreadCount();

  Future<List<NotificationEntry>> getReplyList({int? id, int? replyTime});

  Future<List<NotificationEntry>> getAtList({int? id, int? atTime});

  Future<List<NotificationEntry>> getLikeList({int? id, int? likeTime});

  Future<List<SystemNotice>> getSystemNotifications();

  Future<PrivateMessagePage> getPrivateMessages({
    required int talkerId,
    required int sessionType,
    int? endSeqno,
  });

  Future<PrivateSessionPage> getPrivateSessions({
    int? endTs,
  });

  Future<ImageUploadResponse> uploadImage(File file);

  Future<SendMessageResponse> sendPrivateMessage({
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required PrivateMessageContent content,
  });
}
