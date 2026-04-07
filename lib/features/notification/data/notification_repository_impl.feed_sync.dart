part of 'notification_repository_impl.dart';

class _NotificationFeedSync {
  const _NotificationFeedSync(this.repo);

  final NotificationRepositoryImpl repo;

  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    return _syncFeedRemote(ownerUid: ownerUid, type: type, force: true);
  }

  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required int cursorId,
    required int cursorTime,
  }) {
    return _syncFeedRemote(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursorId,
      cursorTime: cursorTime,
      force: true,
    );
  }

  Future<Result<void, AppError>> _syncFeedRemote({
    required int ownerUid,
    required NotificationFeedType type,
    int? cursorId,
    int? cursorTime,
    bool force = false,
  }) async {
    final scope = 'feed:${type.value}:${cursorId == null ? "head" : "older"}';
    if (!await repo._cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    final now = repo._nowSeconds();
    if (type == NotificationFeedType.system) {
      final itemsResult = await repo._messageSendService.fetchSystemNotifications();
      if (itemsResult.errorOrNull case final error?) {
        return Failure(error);
      }
      final items = itemsResult.dataOrNull!;
      await repo._database.transaction(() async {
        for (final item in items) {
          await repo._database
              .into(repo._database.notificationFeedItems)
              .insertOnConflictUpdate(
                NotificationFeedItemsCompanion.insert(
                  ownerUid: ownerUid,
                  feedType: type.value,
                  eventId: item.id,
                  eventTime: item.time,
                  itemJson: jsonEncode(item.toJson()),
                  updatedAt: now,
                ),
              );
        }
      });
      await repo._cleanupPolicy.touchCursor(
        ownerUid: ownerUid,
        scope: scope,
        cursorJson: null,
        hasMore: false,
      );
      await repo._cleanupPolicy.maybeCleanup(ownerUid);
      return const Success(null);
    }

    final responseResult = await repo._messageSendService.fetchReplyLikeAtResponse(
      type: type,
      id: cursorId,
      time: cursorTime,
    );
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;

    await repo._database.transaction(() async {
      for (final item in response.items) {
        await repo._database
            .into(repo._database.notificationFeedItems)
            .insertOnConflictUpdate(
              NotificationFeedItemsCompanion.insert(
                ownerUid: ownerUid,
                feedType: type.value,
                eventId: item.id,
                eventTime: item.replyTime ?? item.likeTime ?? 0,
                itemJson: jsonEncode(item.toJson()),
                updatedAt: now,
              ),
            );
      }
    });

    final next = response.items.isEmpty
        ? null
        : {
            'id': response.items.last.id,
            'time': response.items.last.replyTime ?? response.items.last.likeTime ?? 0,
          };
    await repo._cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: next == null ? null : jsonEncode(next),
      hasMore: !response.cursor.isEnd,
    );
    await repo._cleanupPolicy.maybeCleanup(ownerUid);
    return const Success(null);
  }
}
