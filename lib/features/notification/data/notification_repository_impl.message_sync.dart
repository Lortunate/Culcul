import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_message_persistence.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/models/private_message.dart';
import 'package:culcul/features/notification/models/private_session.dart';

class NotificationMessageSync {
  const NotificationMessageSync({
    required this.database,
    required this.api,
    required this.requestExecutor,
    required this.cleanupPolicy,
    required this.persistence,
    required this.pageSize,
    required this.nowSeconds,
  });

  final NotificationLocalDatabase database;
  final NotificationApi api;
  final RequestExecutor requestExecutor;
  final NotificationCleanupPolicy cleanupPolicy;
  final NotificationMessagePersistence persistence;
  final int pageSize;
  final int Function() nowSeconds;

  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _syncMessagesRemote(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      force: true,
    );
  }

  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) {
    if (endSeqno <= 0) return Future.value(const Success(null));
    return _syncMessagesRemote(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
      force: true,
    );
  }

  Future<Result<void, AppError>> _syncMessagesRemote({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
    bool force = false,
  }) async {
    final scope =
        'messages:${sessionType.value}:$talkerId:${endSeqno == null ? "head" : "older"}';
    if (!await cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    return (await requestExecutor.runApiDirect(
      () => api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType.value,
        size: pageSize,
        endSeqno: endSeqno,
      ),
    )).when(
      success: (response) async {
        final now = nowSeconds();
        final messages = response.messages ?? const <PrivateMessageDetail>[];

        await database.transaction(() async {
          for (final message in messages) {
            await persistence.upsertMessageDetail(
              ownerUid: ownerUid,
              sessionType: sessionType,
              talkerId: talkerId,
              message: message,
              now: now,
              syncStatus: 'synced',
            );
          }
          await persistence.upsertMessageEmojis(
            ownerUid: ownerUid,
            talkerId: talkerId,
            sessionType: sessionType,
            emojis: response.emojiInfos ?? const <PrivateMessageEmoji>[],
            now: now,
          );
          await persistence.reconcileTemporaryMessages(
            ownerUid: ownerUid,
            talkerId: talkerId,
            sessionType: sessionType,
          );
        });

        await cleanupPolicy.touchCursor(
          ownerUid: ownerUid,
          scope: scope,
          cursorJson: jsonEncode({
            'minSeqno': response.minSeqno,
            'maxSeqno': response.maxSeqno,
          }),
          hasMore: response.hasMore == 1,
        );
        await cleanupPolicy.maybeCleanup(ownerUid);
        return const Success(null);
      },
      failure: (error) async => Failure(error),
    );
  }
}
