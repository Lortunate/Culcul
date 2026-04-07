part of 'notification_repository_impl.dart';

class _NotificationLocalReadStore {
  const _NotificationLocalReadStore(this.repo);

  final NotificationRepositoryImpl repo;

  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) async {
    final row =
        await (repo._database.select(repo._database.notificationUnreadSummaries)
              ..where((t) => t.ownerUid.equals(ownerUid))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    final dto = UnreadCountModel.fromJson(
      jsonDecode(row.summaryJson) as Map<String, dynamic>,
    );
    return dto;
  }

  Future<List<SystemNotice>> listSystemNoticesFromLocal({required int ownerUid}) async {
    final rows =
        await (repo._database.select(repo._database.notificationFeedItems)
              ..where(
                (t) =>
                    t.ownerUid.equals(ownerUid) &
                    t.feedType.equals(NotificationFeedType.system.value),
              )
              ..orderBy([
                (t) => OrderingTerm.desc(t.eventTime),
                (t) => OrderingTerm.desc(t.eventId),
              ]))
            .get();

    return rows
        .map(
          (row) => SystemNotificationItem.fromJson(
            jsonDecode(row.itemJson) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async {
    final query = repo._database.select(repo._database.notificationSessions)
      ..where(
        (t) =>
            t.ownerUid.equals(ownerUid) &
            t.sessionType.equals(sessionType.value) &
            (endTs == null
                ? const Constant(true)
                : t.sessionTs.isSmallerThanValue(endTs)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.sessionTs)])
      ..limit(NotificationRepositoryImpl._pageSize);
    final rows = await query.get();
    return rows
        .map(
          (row) => PrivateMessageSession.fromJson(
            jsonDecode(row.sessionJson) as Map<String, dynamic>,
          ).toDomain(),
        )
        .toList();
  }

  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async {
    final query = repo._database.select(repo._database.notificationMessages)
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
      ..limit(NotificationRepositoryImpl._pageSize);
    final rows = await query.get();
    return rows.map(repo._messageSendService.rowToPrivateMessage).toList();
  }

  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final rows =
        await (repo._database.select(repo._database.notificationMessageEmojis)
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
      repo._messageSendService.putEmojiVariants(
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
    int? cursorId,
    int? cursorTime,
  }) async {
    if (type == NotificationFeedType.system) {
      return const <NotificationEntry>[];
    }

    final query = repo._database.select(repo._database.notificationFeedItems)
      ..where((t) {
        final base = t.ownerUid.equals(ownerUid) & t.feedType.equals(type.value);
        if (cursorId == null || cursorTime == null) return base;
        return base &
            (t.eventTime.isSmallerThanValue(cursorTime) |
                (t.eventTime.equals(cursorTime) &
                    t.eventId.isSmallerThanValue(cursorId)));
      })
      ..orderBy([
        (t) => OrderingTerm.desc(t.eventTime),
        (t) => OrderingTerm.desc(t.eventId),
      ])
      ..limit(NotificationRepositoryImpl._pageSize);
    final rows = await query.get();
    return rows
        .map(
          (row) => ReplyItem.fromJson(
            jsonDecode(row.itemJson) as Map<String, dynamic>,
          ).toDomain(),
        )
        .toList();
  }
}
