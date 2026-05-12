import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/notification/data/dtos/system_notification_model.dart';
import 'package:culcul/features/notification/data/dtos/unread_count_model.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
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
        .asyncMap((row) async {
          if (row == null) return NotificationRepositoryImpl.emptySummary;
          try {
            final decoded = await jsonDecodeCompute(row.summaryJson);
            final dto = UnreadCountModel.fromJson(decoded as Map<String, dynamic>);
            return dto.toDomain();
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
