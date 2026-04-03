import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';

abstract class NotificationRepository {
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid});

  Future<List<SystemNotice>> listSystemNoticesFromLocal({required int ownerUid});

  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  });

  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  });

  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    int? cursorId,
    int? cursorTime,
  });

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid});

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid});

  Future<void> syncUnreadCount({required int ownerUid, bool force = false});

  Future<void> syncSessions({required int ownerUid, bool force = false});

  Future<void> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  });

  Future<void> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  });

  Future<void> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  });

  Future<void> syncFeedHead({required int ownerUid, required NotificationFeedType type});

  Future<void> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required int cursorId,
    required int cursorTime,
  });

  Future<Result<ImageUploadResult, AppError>> uploadImage(File file);

  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  });
}
