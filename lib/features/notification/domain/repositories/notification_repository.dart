import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
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

  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  });

  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  });

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid});

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid});

  Future<Result<void, AppError>> syncUnreadCount({required int ownerUid, bool force = false});

  Future<Result<void, AppError>> syncSessions({required int ownerUid, bool force = false});

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  });

  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  });

  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  });

  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  });

  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
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
