import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:drift/drift.dart';

mixin NotificationMessageSendHelpersMixin on Object {
  abstract final NotificationRepositoryImpl repo;
  abstract final NotificationMessageSupport support;

  Future<Result<void, AppError>> markOutboxAndTempMessage({
    required int ownerUid,
    required int localMsgSeqno,
    required String status,
    String? error,
    int? msgKey,
  }) async {
    final now = repo.nowSeconds();
    await repo.database.transaction(() async {
      await (repo.database.update(repo.database.notificationOutbox)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.localMsgSeqno.equals(localMsgSeqno),
          ))
          .write(
            NotificationOutboxCompanion(
              status: Value(status),
              error: Value(error),
              msgKey: Value(msgKey),
              updatedAt: Value(now),
            ),
          );

      await (repo.database.update(
            repo.database.notificationMessages,
          )..where((t) => t.ownerUid.equals(ownerUid) & t.msgSeqno.equals(localMsgSeqno)))
          .write(
            NotificationMessagesCompanion(
              syncStatus: Value(status),
              msgKey: Value(msgKey),
              updatedAt: Value(now),
            ),
          );
    });
    return const Success(null);
  }

  Future<void> upsertMessageDetail({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int talkerId,
    required PrivateMessageDetail message,
    required int now,
    required String syncStatus,
  }) async {
    final atUidsJson = message.atUids == null ? null : jsonEncode(message.atUids);
    final contentRaw = message.content;
    final contentJson = contentRaw is String ? contentRaw : jsonEncode(contentRaw);

    await repo.database
        .into(repo.database.notificationMessages)
        .insertOnConflictUpdate(
          NotificationMessagesCompanion.insert(
            ownerUid: ownerUid,
            sessionType: sessionType.value,
            talkerId: talkerId,
            msgSeqno: message.msgSeqno,
            senderUid: message.senderUid,
            receiverType: message.receiverType,
            receiverId: message.receiverId,
            msgType: message.msgType,
            contentJson: contentJson,
            timestamp: message.timestamp,
            atUidsJson: Value(atUidsJson),
            msgKey: Value(message.msgKey),
            msgStatus: Value(message.msgStatus),
            notifyCode: Value(message.notifyCode),
            newFaceVersion: Value(message.newFaceVersion),
            msgSource: Value(message.msgSource),
            syncStatus: Value(syncStatus),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<void> reconcileTemporaryMessages({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final tempQuery = repo.database.select(repo.database.notificationMessages)
      ..where(
        (t) =>
            t.ownerUid.equals(ownerUid) &
            t.talkerId.equals(talkerId) &
            t.sessionType.equals(sessionType.value) &
            t.msgSeqno.isSmallerOrEqualValue(0) &
            (t.syncStatus.equals('pending') | t.syncStatus.equals('sent')),
      );
    final temps = await tempQuery.get();
    if (temps.isEmpty) return;

    final syncedQuery = repo.database.select(repo.database.notificationMessages)
      ..where(
        (t) =>
            t.ownerUid.equals(ownerUid) &
            t.talkerId.equals(talkerId) &
            t.sessionType.equals(sessionType.value) &
            t.msgSeqno.isBiggerThanValue(0),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
      ..limit(100);
    final synced = await syncedQuery.get();
    if (synced.isEmpty) return;

    for (final temp in temps) {
      final matched = synced.any(
        (item) =>
            item.senderUid == temp.senderUid &&
            item.msgType == temp.msgType &&
            item.contentJson == temp.contentJson &&
            (item.timestamp - temp.timestamp).abs() <= 15,
      );
      if (matched) {
        await (repo.database.delete(repo.database.notificationMessages)..where(
              (t) => t.ownerUid.equals(ownerUid) & t.msgSeqno.equals(temp.msgSeqno),
            ))
            .go();
      }
    }
  }

  Future<void> upsertMessageEmojis({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required List<PrivateMessageEmoji> emojis,
    required int now,
  }) async {
    for (final emoji in emojis) {
      final canonicalKey = support.canonicalEmojiKey(emoji.text);
      final url = emoji.url.trim();
      if (canonicalKey == null || url.isEmpty) continue;

      await repo.database
          .into(repo.database.notificationMessageEmojis)
          .insertOnConflictUpdate(
            NotificationMessageEmojisCompanion.insert(
              ownerUid: ownerUid,
              sessionType: sessionType.value,
              talkerId: talkerId,
              emojiText: canonicalKey,
              emojiUrl: url,
              updatedAt: now,
            ),
          );
    }
  }
}
