import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:drift/drift.dart';

class NotificationCleanupPolicy {
  const NotificationCleanupPolicy({
    required this.database,
    required this.syncThrottleSeconds,
    required this.retentionDays,
    required this.cleanupScope,
    required this.nowSeconds,
  });

  final NotificationLocalDatabase database;
  final int syncThrottleSeconds;
  final int retentionDays;
  final String cleanupScope;
  final int Function() nowSeconds;

  Future<bool> shouldSync({
    required int ownerUid,
    required String scope,
    required bool force,
  }) async {
    if (force) return true;
    final now = nowSeconds();
    final existing =
        await (database.select(database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(scope))
              ..limit(1))
            .getSingleOrNull();
    if (existing == null) return true;
    return now - existing.lastSyncedAt >= syncThrottleSeconds;
  }

  Future<void> touchCursor({
    required int ownerUid,
    required String scope,
    required String? cursorJson,
    required bool hasMore,
  }) async {
    final now = nowSeconds();
    await database
        .into(database.notificationSyncCursors)
        .insertOnConflictUpdate(
          NotificationSyncCursorsCompanion.insert(
            ownerUid: ownerUid,
            scope: scope,
            cursorJson: Value(cursorJson),
            hasMore: Value(hasMore),
            lastSyncedAt: Value(now),
          ),
        );
  }

  Future<void> maybeCleanup(int ownerUid) async {
    final now = nowSeconds();
    final cleanupCursor =
        await (database.select(database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(cleanupScope))
              ..limit(1))
            .getSingleOrNull();

    if (cleanupCursor != null && now - cleanupCursor.lastSyncedAt < 24 * 60 * 60) {
      return;
    }

    final cutoff = now - (retentionDays * 24 * 60 * 60);

    await database.transaction(() async {
      await (database.delete(database.notificationMessages)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.timestamp.isSmallerThanValue(cutoff),
          ))
          .go();

      await (database.delete(database.notificationMessageEmojis)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.updatedAt.isSmallerThanValue(cutoff),
          ))
          .go();

      await (database.delete(database.notificationFeedItems)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.eventTime.isSmallerThanValue(cutoff),
          ))
          .go();

      await (database.delete(database.notificationSessions)..where(
            (t) =>
                t.ownerUid.equals(ownerUid) &
                t.sessionTs.isSmallerThanValue(cutoff) &
                t.unreadCount.equals(0),
          ))
          .go();

      await touchCursor(
        ownerUid: ownerUid,
        scope: cleanupScope,
        cursorJson: null,
        hasMore: false,
      );
    });
  }
}
