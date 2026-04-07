part of 'notification_repository_impl.dart';

class _NotificationMessageSync {
  const _NotificationMessageSync(this.repo);

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
    if (!await repo._cleanupPolicy.shouldSync(ownerUid: ownerUid, scope: scope, force: force)) {
      return const Success(null);
    }

    final responseResult = await repo.requestApiResult(
      () => repo._api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType.value,
        size: NotificationRepositoryImpl._pageSize,
        endSeqno: endSeqno,
      ),
    );
    if (responseResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final response = responseResult.dataOrNull!;
    final now = repo._nowSeconds();
    final messages = response.messages ?? const <PrivateMessageDetail>[];

    await repo._database.transaction(() async {
      for (final message in messages) {
        await repo._messageSendService.upsertMessageDetail(
          ownerUid: ownerUid,
          sessionType: sessionType,
          talkerId: talkerId,
          message: message,
          now: now,
          syncStatus: 'synced',
        );
      }
      await repo._messageSendService.upsertMessageEmojis(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
        emojis: response.emojiInfos ?? const <PrivateMessageEmojiInfo>[],
        now: now,
      );
      await repo._messageSendService.reconcileTemporaryMessages(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
      );
    });

    await repo._cleanupPolicy.touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: jsonEncode({
        'minSeqno': response.minSeqno,
        'maxSeqno': response.maxSeqno,
      }),
      hasMore: response.hasMore == 1,
    );
    await repo._cleanupPolicy.maybeCleanup(ownerUid);
    return const Success(null);
  }
}
