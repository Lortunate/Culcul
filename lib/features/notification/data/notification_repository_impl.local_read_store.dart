import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/data/dtos/unread_count_model.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:drift/drift.dart';

class NotificationLocalReadStore {
  const NotificationLocalReadStore(this.repo);

  final NotificationRepositoryImpl repo;

  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) async {
    final row =
        await (repo.database.select(repo.database.notificationUnreadSummaries)
              ..where((t) => t.ownerUid.equals(ownerUid))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    final decoded = await jsonDecodeCompute(row.summaryJson);
    final dto = UnreadCountModel.fromJson(decoded as Map<String, dynamic>);
    return dto.toDomain();
  }

  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async {
    final query = repo.database.select(repo.database.notificationSessions)
      ..where(
        (t) =>
            t.ownerUid.equals(ownerUid) &
            t.sessionType.equals(sessionType.value) &
            (endTs == null
                ? const Constant(true)
                : t.sessionTs.isSmallerThanValue(endTs)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.sessionTs)])
      ..limit(NotificationRepositoryImpl.pageSize);
    final rows = await query.get();
    final sessions = <PrivateSession>[];
    for (final row in rows) {
      final decoded = await jsonDecodeCompute(row.sessionJson);
      sessions.add(
        PrivateMessageSession.fromJson(decoded as Map<String, dynamic>).toDomain(),
      );
    }
    return sessions;
  }

  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async {
    final query = repo.database.select(repo.database.notificationMessages)
      ..where((t) {
        final base =
            t.ownerUid.equals(ownerUid) &
            t.sessionType.equals(sessionType.value) &
            t.talkerId.equals(talkerId);
        if (endSeqno == null) return base;
        return base & t.msgSeqno.isSmallerThanValue(endSeqno);
      })
      ..orderBy([
        (t) => OrderingTerm.desc(t.timestamp),
        (t) => OrderingTerm.desc(t.msgSeqno),
      ])
      ..limit(NotificationRepositoryImpl.pageSize);
    final rows = await query.get();
    return rows.map(repo.messageSendService.rowToPrivateMessage).toList();
  }

  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final rows =
        await (repo.database.select(repo.database.notificationMessageEmojis)
              ..where(
                (t) =>
                    t.ownerUid.equals(ownerUid) &
                    t.sessionType.equals(sessionType.value) &
                    t.talkerId.equals(talkerId),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    final map = <String, String>{};
    for (final row in rows) {
      repo.messageSendService.putEmojiVariants(
        map: map,
        rawKey: row.emojiText,
        url: row.emojiUrl,
        overwrite: false,
      );
    }
    return map;
  }

  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async {
    if (type == NotificationFeedType.system) {
      return const <NotificationEntry>[];
    }

    final query = repo.database.select(repo.database.notificationFeedItems)
      ..where((t) {
        final base = t.ownerUid.equals(ownerUid) & t.feedType.equals(type.value);
        if (cursor == null) return base;
        return base &
            (t.eventTime.isSmallerThanValue(cursor.time) |
                (t.eventTime.equals(cursor.time) &
                    t.eventId.isSmallerThanValue(cursor.id)));
      })
      ..orderBy([
        (t) => OrderingTerm.desc(t.eventTime),
        (t) => OrderingTerm.desc(t.eventId),
      ])
      ..limit(NotificationRepositoryImpl.pageSize);
    final rows = await query.get();
    final items = <NotificationEntry>[];
    for (final row in rows) {
      final decoded = await jsonDecodeCompute(row.itemJson);
      items.add(ReplyItem.fromJson(decoded as Map<String, dynamic>).toDomain());
    }
    return items;
  }
}
