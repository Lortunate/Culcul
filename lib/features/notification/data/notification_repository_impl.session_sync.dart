part of 'notification_repository_impl.dart';

class _NotificationSessionSync {
  const _NotificationSessionSync(this.repo);

  final NotificationRepositoryImpl repo;

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) async {
    if (!await repo._cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: 'unread', force: force)) {
      return const Success(null);
    }
    final responseResult = await repo.requestApiResult(() => repo._api.getUnreadCount());
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;
    final now = repo._nowSeconds();

    await repo._database
        .into(repo._database.notificationUnreadSummaries)
        .insertOnConflictUpdate(
          NotificationUnreadSummariesCompanion.insert(
            ownerUid: Value(ownerUid),
            summaryJson: jsonEncode(response.toJson()),
            updatedAt: now,
          ),
        );
    await repo._cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: 'unread',
      cursorJson: null,
      hasMore: true,
    );
    await repo._cleanupPolicy.maybeCleanup(ownerUid);
    return const Success(null);
  }

  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _syncSessionsRemote(
      ownerUid: ownerUid,
      sessionType: PrivateSessionType.user,
      force: force,
    );
  }

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return _syncSessionsRemote(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
      force: true,
    );
  }

  Future<Result<void, AppError>> _syncSessionsRemote({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
    bool force = false,
  }) async {
    final scope = 'sessions:${sessionType.value}:${endTs == null ? "head" : "older"}';
    if (!await repo._cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    final responseResult = await repo.requestApiResult(
      () => repo._api.getPrivateSessions(
        sessionType: sessionType.value,
        size: NotificationRepositoryImpl._pageSize,
        endTs: endTs,
      ),
    );
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;
    final now = repo._nowSeconds();
    final sessions = response.sessionList ?? const <PrivateMessageSession>[];

    await repo._database.transaction(() async {
      for (final session in sessions) {
        await repo._database
            .into(repo._database.notificationSessions)
            .insertOnConflictUpdate(
              NotificationSessionsCompanion.insert(
                ownerUid: ownerUid,
                sessionType: session.sessionType,
                talkerId: session.talkerId,
                unreadCount: Value(session.unreadCount),
                sessionTs: session.sessionTs,
                sessionJson: jsonEncode(session.toJson()),
                updatedAt: now,
              ),
            );

        if (session.lastMsg != null) {
          await repo._messageSendService.upsertMessageDetail(
            ownerUid: ownerUid,
            sessionType: PrivateSessionType.fromValue(session.sessionType),
            talkerId: session.talkerId,
            message: session.lastMsg!,
            now: now,
            syncStatus: 'synced',
          );
        }
      }
    });

    final nextCursor = sessions.isEmpty ? null : sessions.last.sessionTs;
    await repo._cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: nextCursor == null ? null : jsonEncode({'endTs': nextCursor}),
      hasMore: response.hasMore == 1,
    );
    await repo._cleanupPolicy.maybeCleanup(ownerUid);
    return const Success(null);
  }
}
