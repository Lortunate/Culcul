import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';

class NotificationFeedSync {
  const NotificationFeedSync({
    required this.database,
    required this.api,
    required this.requestExecutor,
    required this.cleanupPolicy,
    required this.messageSupport,
    required this.nowSeconds,
  });

  final NotificationLocalDatabase database;
  final NotificationApi api;
  final RequestExecutor requestExecutor;
  final NotificationCleanupPolicy cleanupPolicy;
  final NotificationMessageSupport messageSupport;
  final int Function() nowSeconds;

  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    return _syncFeedRemote(ownerUid: ownerUid, type: type, force: true);
  }

  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) {
    return _syncFeedRemote(ownerUid: ownerUid, type: type, cursor: cursor, force: true);
  }

  Future<Result<void, AppError>> _syncFeedRemote({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
    bool force = false,
  }) async {
    final scope = 'feed:${type.value}:${cursor == null ? "head" : "older"}';
    if (!await cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    final now = nowSeconds();
    if (type == NotificationFeedType.system) {
      return (await messageSupport.fetchSystemNotifications()).when(
        success: (items) async {
          await database.transaction(() async {
            for (final item in items) {
              await database
                  .into(database.notificationFeedItems)
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
          await cleanupPolicy.touchCursor(
            ownerUid: ownerUid,
            scope: scope,
            cursorJson: null,
            hasMore: false,
          );
          await cleanupPolicy.maybeCleanup(ownerUid);
          return const Success(null);
        },
        failure: (error) async => Failure(error),
      );
    }

    return (await messageSupport.fetchReplyLikeAtResponse(
      type: type,
      id: cursor?.id,
      time: cursor?.time,
    )).when(
      success: (response) async {
        await database.transaction(() async {
          for (final item in response.items) {
            await database
                .into(database.notificationFeedItems)
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
            : NotificationFeedCursor(
                id: response.items.last.id,
                time: response.items.last.replyTime ?? response.items.last.likeTime ?? 0,
              );
        await cleanupPolicy.touchCursor(
          ownerUid: ownerUid,
          scope: scope,
          cursorJson: next == null
              ? null
              : jsonEncode({'id': next.id, 'time': next.time}),
          hasMore: !response.cursor.isEnd,
        );
        await cleanupPolicy.maybeCleanup(ownerUid);
        return const Success(null);
      },
      failure: (error) async => Failure(error),
    );
  }
}
