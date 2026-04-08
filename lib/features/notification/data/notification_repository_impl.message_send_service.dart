part of 'notification_repository_impl.dart';

class _NotificationMessageSendService with _NotificationMessageSendHelpersMixin {
  _NotificationMessageSendService(this.repo);

  @override
  final NotificationRepositoryImpl repo;
  @override
  late final _NotificationMessageSupport _support = _NotificationMessageSupport(repo);

  Future<void> retryFailedOutbox({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final query = repo._database.select(repo._database.notificationOutbox)
      ..where(
        (t) =>
            t.ownerUid.equals(ownerUid) &
            t.talkerId.equals(talkerId) &
            t.sessionType.equals(sessionType.value) &
            t.status.equals('failed'),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    final failed = await query.get();
    for (final item in failed) {
      await repo._database
          .update(repo._database.notificationOutbox)
          .replace(item.copyWith(status: 'pending', error: const Value(null)));
      await sendPrivateMessage(
        ownerUid: ownerUid,
        receiverId: item.receiverId,
        receiverType: PrivateMessageReceiverType.fromValue(item.receiverType),
        messageType: PrivateMessageType.fromValue(item.msgType),
        content: PrivateMessageContent.fromRaw(item.contentJson),
      );
    }
  }

  Future<Result<ImageUploadResult, AppError>> uploadImage(File file) async {
    final result = await repo.requestApiResult(() => repo._api.uploadImage(file: file));
    return result;
  }

  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final now = repo._nowSeconds();
    final localMsgSeqno = -DateTime.now().microsecondsSinceEpoch;
    final contentMap = content.toRawMap();
    final contentRawJson = jsonEncode(contentMap);
    final devId = const Uuid().v4().toUpperCase();

    await repo._database.transaction(() async {
      await repo._database
          .into(repo._database.notificationMessages)
          .insertOnConflictUpdate(
            NotificationMessagesCompanion.insert(
              ownerUid: ownerUid,
              sessionType: repo._sessionTypeFromReceiver(receiverType).value,
              talkerId: receiverId,
              msgSeqno: localMsgSeqno,
              senderUid: ownerUid,
              receiverType: receiverType.value,
              receiverId: receiverId,
              msgType: messageType.value,
              contentJson: contentRawJson,
              timestamp: now,
              atUidsJson: const Value(null),
              msgKey: const Value(null),
              msgStatus: const Value(0),
              notifyCode: const Value(null),
              newFaceVersion: const Value(null),
              msgSource: const Value(null),
              syncStatus: const Value('pending'),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await repo._database
          .into(repo._database.notificationOutbox)
          .insert(
            NotificationOutboxCompanion.insert(
              ownerUid: ownerUid,
              sessionType: repo._sessionTypeFromReceiver(receiverType).value,
              talkerId: receiverId,
              localMsgSeqno: localMsgSeqno,
              senderUid: ownerUid,
              receiverType: receiverType.value,
              receiverId: receiverId,
              msgType: messageType.value,
              contentJson: contentRawJson,
              timestamp: now,
              createdAt: now,
              updatedAt: now,
            ),
          );
    });

    final responseResult = await repo.requestApiResult(
      () => repo._api.sendPrivateMessage(
        wSenderUid: ownerUid,
        wReceiverId: receiverId,
        wDevId: devId,
        senderUid: ownerUid,
        receiverId: receiverId,
        receiverType: receiverType.value,
        msgType: messageType.value,
        devId: devId,
        timestamp: now,
        content: contentRawJson,
      ),
    );

    await responseResult.when(
      success: (value) async {
        await _markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'sent',
          msgKey: value.msgKey,
        );
        await repo.syncMessagesHead(
          ownerUid: ownerUid,
          talkerId: receiverId,
          sessionType: repo._sessionTypeFromReceiver(receiverType),
        );
      },
      failure: (error) async {
        await _markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'failed',
          error: error.message,
        );
      },
    );

    return responseResult;
  }

  Future<Result<ReplyResponse, AppError>> fetchReplyLikeAtResponse({
    required NotificationFeedType type,
    int? id,
    int? time,
  }) {
    return _support.fetchReplyLikeAtResponse(type: type, id: id, time: time);
  }

  Future<Result<List<SystemNotificationItem>, AppError>> fetchSystemNotifications() {
    return _support.fetchSystemNotifications();
  }

  void putEmojiVariants({
    required Map<String, String> map,
    required String rawKey,
    required String url,
    required bool overwrite,
  }) {
    _support.putEmojiVariants(map: map, rawKey: rawKey, url: url, overwrite: overwrite);
  }

  PrivateMessage rowToPrivateMessage(NotificationMessage row) {
    return _support.rowToPrivateMessage(row);
  }
}
