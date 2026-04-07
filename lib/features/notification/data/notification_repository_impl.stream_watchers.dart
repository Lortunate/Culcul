part of 'notification_repository_impl.dart';

class _NotificationStreamWatchers {
  const _NotificationStreamWatchers(this.repo);

  final NotificationRepositoryImpl repo;

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return (repo._database.select(repo._database.notificationUnreadSummaries)
          ..where((t) => t.ownerUid.equals(ownerUid))
          ..limit(1))
        .watchSingleOrNull()
        .map((row) {
          if (row == null) return NotificationRepositoryImpl._emptySummary;
          try {
            final dto = UnreadCountModel.fromJson(
              jsonDecode(row.summaryJson) as Map<String, dynamic>,
            );
            return dto;
          } catch (_) {
            return NotificationRepositoryImpl._emptySummary;
          }
        });
  }

  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return (repo._database.select(repo._database.notificationFeedItems)
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
