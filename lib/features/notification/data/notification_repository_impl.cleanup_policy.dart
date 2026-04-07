part of 'notification_repository_impl.dart';

class _NotificationCleanupPolicy {
  const _NotificationCleanupPolicy(this.repo);

  final NotificationRepositoryImpl repo;

  Future<bool> shouldSync({
    required int ownerUid,
    required String scope,
    required bool force,
  }) async {
    if (force) return true;
    final now = repo._nowSeconds();
    final existing =
        await (repo._database.select(repo._database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(scope))
              ..limit(1))
            .getSingleOrNull();
    if (existing == null) return true;
    return now - existing.lastSyncedAt >= NotificationRepositoryImpl._syncThrottleSeconds;
  }

  Future<void> touchCursor({
    required int ownerUid,
    required String scope,
    required String? cursorJson,
    required bool hasMore,
  }) async {
    final now = repo._nowSeconds();
    await repo._database
        .into(repo._database.notificationSyncCursors)
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
    final now = repo._nowSeconds();
    final cleanupCursor =
        await (repo._database.select(repo._database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(NotificationRepositoryImpl._cleanupScope))
              ..limit(1))
            .getSingleOrNull();

    if (cleanupCursor != null && now - cleanupCursor.lastSyncedAt < 24 * 60 * 60) {
      return;
    }

    final cutoff = now - (NotificationRepositoryImpl._retentionDays * 24 * 60 * 60);

    await repo._database.transaction(() async {
      await (repo._database.delete(repo._database.notificationMessages)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.timestamp.isSmallerThanValue(cutoff),
          ))
          .go();

      await (repo._database.delete(repo._database.notificationMessageEmojis)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.updatedAt.isSmallerThanValue(cutoff),
          ))
          .go();

      await (repo._database.delete(repo._database.notificationFeedItems)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.eventTime.isSmallerThanValue(cutoff),
          ))
          .go();

      await (repo._database.delete(repo._database.notificationSessions)..where(
            (t) =>
                t.ownerUid.equals(ownerUid) &
                t.sessionTs.isSmallerThanValue(cutoff) &
                t.unreadCount.equals(0),
          ))
          .go();

      await touchCursor(
        ownerUid: ownerUid,
        scope: NotificationRepositoryImpl._cleanupScope,
        cursorJson: null,
        hasMore: false,
      );
    });
  }
}
