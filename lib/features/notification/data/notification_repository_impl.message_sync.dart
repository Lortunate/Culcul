import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';

class NotificationMessageSync {
  const NotificationMessageSync(this.repo);

  final NotificationRepositoryImpl repo;

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
    if (!await repo.cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    final responseResult = await repo.requestApiResult(
      () => repo.api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType.value,
        size: NotificationRepositoryImpl.pageSize,
        endSeqno: endSeqno,
      ),
    );
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;
    final now = repo.nowSeconds();
    final messages = response.messages ?? const <PrivateMessageDetail>[];

    await repo.database.transaction(() async {
      for (final message in messages) {
        await repo.messageSendService.upsertMessageDetail(
          ownerUid: ownerUid,
          sessionType: sessionType,
          talkerId: talkerId,
          message: message,
          now: now,
          syncStatus: 'synced',
        );
      }
      await repo.messageSendService.upsertMessageEmojis(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
        emojis: response.emojiInfos ?? const <PrivateMessageEmojiInfo>[],
        now: now,
      );
      await repo.messageSendService.reconcileTemporaryMessages(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
      );
    });

    await repo.cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: jsonEncode({
        'minSeqno': response.minSeqno,
        'maxSeqno': response.maxSeqno,
      }),
      hasMore: response.hasMore == 1,
    );
    await repo.cleanupPolicy.maybeCleanup(ownerUid);
    return const Success(null);
  }
}
