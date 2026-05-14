import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/notification/data/dtos/system_notification_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/data/dtos/system_notice.dart';
import 'package:drift/drift.dart';

class NotificationStreamWatchers {
  const NotificationStreamWatchers({
    required this.database,
    required this.emptySummary,
  });

  final NotificationLocalDatabase database;
  final NotificationSummary emptySummary;

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return (database.select(database.notificationUnreadSummaries)
          ..where((t) => t.ownerUid.equals(ownerUid))
          ..limit(1))
        .watchSingleOrNull()
        .asyncMap((row) async {
          if (row == null) return emptySummary;
          try {
            final decoded = await jsonDecodeCompute(row.summaryJson);
            return notificationSummaryFromJson(decoded as Map<String, dynamic>);
          } catch (_) {
            return emptySummary;
          }
        });
  }

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return (database.select(database.notificationFeedItems)
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
        .asyncMap((rows) async {
          final notices = <SystemNotice>[];
          for (final row in rows) {
            notices.add(
              SystemNotificationItem.fromJson(
                (await jsonDecodeCompute(row.itemJson)) as Map<String, dynamic>,
              ).toDomain(),
            );
          }
          return notices;
        });
  }
}
