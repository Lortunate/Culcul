import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:drift/drift.dart';

class NotificationCleanupPolicy {
  const NotificationCleanupPolicy(this.repo);

  final NotificationRepositoryImpl repo;

  Future<bool> shouldSync({
    required int ownerUid,
    required String scope,
    required bool force,
  }) async {
    if (force) return true;
    final now = repo.nowSeconds();
    final existing =
        await (repo.database.select(repo.database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(scope))
              ..limit(1))
            .getSingleOrNull();
    if (existing == null) return true;
    return now - existing.lastSyncedAt >= NotificationRepositoryImpl.syncThrottleSeconds;
  }

  Future<void> touchCursor({
    required int ownerUid,
    required String scope,
    required String? cursorJson,
    required bool hasMore,
  }) async {
    final now = repo.nowSeconds();
    await repo.database
        .into(repo.database.notificationSyncCursors)
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
    final now = repo.nowSeconds();
    final cleanupCursor =
        await (repo.database.select(repo.database.notificationSyncCursors)
              ..where(
                (t) =>
                    t.ownerUid.equals(ownerUid) &
                    t.scope.equals(NotificationRepositoryImpl.cleanupScope),
              )
              ..limit(1))
            .getSingleOrNull();

    if (cleanupCursor != null && now - cleanupCursor.lastSyncedAt < 24 * 60 * 60) {
      return;
    }

    final cutoff = now - (NotificationRepositoryImpl.retentionDays * 24 * 60 * 60);

    await repo.database.transaction(() async {
      await (repo.database.delete(repo.database.notificationMessages)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.timestamp.isSmallerThanValue(cutoff),
          ))
          .go();

      await (repo.database.delete(repo.database.notificationMessageEmojis)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.updatedAt.isSmallerThanValue(cutoff),
          ))
          .go();

      await (repo.database.delete(repo.database.notificationFeedItems)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.eventTime.isSmallerThanValue(cutoff),
          ))
          .go();

      await (repo.database.delete(repo.database.notificationSessions)..where(
            (t) =>
                t.ownerUid.equals(ownerUid) &
                t.sessionTs.isSmallerThanValue(cutoff) &
                t.unreadCount.equals(0),
          ))
          .go();

      await touchCursor(
        ownerUid: ownerUid,
        scope: NotificationRepositoryImpl.cleanupScope,
        cursorJson: null,
        hasMore: false,
      );
    });
  }
}
