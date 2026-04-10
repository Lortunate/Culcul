import 'dart:convert';

import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:drift/drift.dart';

class NotificationStreamWatchers {
  const NotificationStreamWatchers(this.repo);

  final NotificationRepositoryImpl repo;

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return (repo.database.select(repo.database.notificationUnreadSummaries)
          ..where((t) => t.ownerUid.equals(ownerUid))
          ..limit(1))
        .watchSingleOrNull()
        .map((row) {
          if (row == null) return NotificationRepositoryImpl.emptySummary;
          try {
            final dto = UnreadCountModel.fromJson(
              jsonDecode(row.summaryJson) as Map<String, dynamic>,
            );
            return dto;
          } catch (_) {
            return NotificationRepositoryImpl.emptySummary;
          }
        });
  }

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return (repo.database.select(repo.database.notificationFeedItems)
          ..where(
            (t) =>
                t.ownerUid.equals(ownerUid) &
                t.feedType.equals(NotificationFeedType.system.value),
          )
          ..orderBy([
            (t) => OrderingTerm.desc(t.eventTime),
            (t) => OrderingTerm.desc(t.eventId),
          ]))
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => SystemNotificationItem.fromJson(
                  jsonDecode(row.itemJson) as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
