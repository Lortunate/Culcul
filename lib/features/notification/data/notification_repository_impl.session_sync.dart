import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_message_persistence.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:drift/drift.dart';

class NotificationSessionSync {
  const NotificationSessionSync({
    required this.database,
    required this.api,
    required this.requestExecutor,
    required this.cleanupPolicy,
    required this.persistence,
    required this.nowSeconds,
  });

  final NotificationLocalDatabase database;
  final NotificationApi api;
  final RequestExecutor requestExecutor;
  final NotificationCleanupPolicy cleanupPolicy;
  final NotificationMessagePersistence persistence;
  final int Function() nowSeconds;

  Future<Result<T, AppError>> _requestApiResult<T>(
    Future<ApiResponse<T>> Function() apiCall,
  ) {
    return requestExecutor.runApiDirect(apiCall);
  }

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) async {
    if (!await cleanupPolicy.shouldSync(
      ownerUid: ownerUid,
      scope: 'unread',
      force: force,
    )) {
      return const Success(null);
    }
    return (await _requestApiResult(api.getUnreadCount)).when(
      success: (response) async {
        final now = nowSeconds();

        await database
            .into(database.notificationUnreadSummaries)
            .insertOnConflictUpdate(
              NotificationUnreadSummariesCompanion.insert(
                ownerUid: Value(ownerUid),
                summaryJson: jsonEncode(response),
                updatedAt: now,
              ),
            );
        await cleanupPolicy.touchCursor(
          ownerUid: ownerUid,
          scope: 'unread',
          cursorJson: null,
          hasMore: true,
        );
        await cleanupPolicy.maybeCleanup(ownerUid);
        return const Success(null);
      },
      failure: (error) async => Failure(error),
    );
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
    if (!await cleanupPolicy.shouldSync(
      ownerUid: ownerUid,
      scope: scope,
      force: force,
    )) {
      return const Success(null);
    }

    return (await _requestApiResult(
      () => api.getPrivateSessions(sessionType: sessionType.value, endTs: endTs),
    )).when(
      success: (response) async {
        final now = nowSeconds();
        final sessions = response.sessionList ?? const <PrivateMessageSession>[];

        await database.transaction(() async {
          for (final session in sessions) {
            await database
                .into(database.notificationSessions)
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
              await persistence.upsertMessageDetail(
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
        await cleanupPolicy.touchCursor(
          ownerUid: ownerUid,
          scope: scope,
          cursorJson: nextCursor == null ? null : jsonEncode({'endTs': nextCursor}),
          hasMore: response.hasMore == 1,
        );
        await cleanupPolicy.maybeCleanup(ownerUid);
        return const Success(null);
      },
      failure: (error) async => Failure(error),
    );
  }
}
