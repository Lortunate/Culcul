import 'dart:convert';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:drift/drift.dart';

class NotificationSessionSync {
  const NotificationSessionSync(this.repo);

  final NotificationRepositoryImpl repo;

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) async {
    if (!await repo.cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: 'unread', force: force)) {
      return const Success(null);
    }
    final responseResult = await repo.requestApiResult(() => repo.api.getUnreadCount());
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;
    final now = repo.nowSeconds();

    await repo.database
        .into(repo.database.notificationUnreadSummaries)
        .insertOnConflictUpdate(
          NotificationUnreadSummariesCompanion.insert(
            ownerUid: Value(ownerUid),
            summaryJson: jsonEncode(response.toJson()),
            updatedAt: now,
          ),
        );
    await repo.cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: 'unread',
      cursorJson: null,
      hasMore: true,
    );
    await repo.cleanupPolicy.maybeCleanup(ownerUid);
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
    if (!await repo.cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    final responseResult = await repo.requestApiResult(
      () => repo.api.getPrivateSessions(
        sessionType: sessionType.value,
        size: NotificationRepositoryImpl.pageSize,
        endTs: endTs,
      ),
    );
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;
    final now = repo.nowSeconds();
    final sessions = response.sessionList ?? const <PrivateMessageSession>[];

    await repo.database.transaction(() async {
      for (final session in sessions) {
        await repo.database
            .into(repo.database.notificationSessions)
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
          await repo.messageSendService.upsertMessageDetail(
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
    await repo.cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: nextCursor == null ? null : jsonEncode({'endTs': nextCursor}),
      hasMore: response.hasMore == 1,
    );
    await repo.cleanupPolicy.maybeCleanup(ownerUid);
    return const Success(null);
  }
}
