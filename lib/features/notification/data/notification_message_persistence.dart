import 'dart:convert';

import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/models/private_message.dart';
import 'package:culcul/features/notification/models/private_session.dart';
import 'package:drift/drift.dart';

class NotificationMessagePersistence {
  const NotificationMessagePersistence(this.database);

  final NotificationLocalDatabase database;

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

    await database
        .into(database.notificationMessages)
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

  Future<void> upsertMessageEmojis({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required List<PrivateMessageEmoji> emojis,
    required int now,
  }) async {
    for (final emoji in emojis) {
      final canonicalKey = canonicalEmojiKey(emoji.text);
      final url = emoji.url.trim();
      if (canonicalKey == null || url.isEmpty) continue;

      await database
          .into(database.notificationMessageEmojis)
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

  Future<void> reconcileTemporaryMessages({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final tempQuery = database.select(database.notificationMessages)
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

    final syncedQuery = database.select(database.notificationMessages)
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
        await (database.delete(database.notificationMessages)..where(
              (t) => t.ownerUid.equals(ownerUid) & t.msgSeqno.equals(temp.msgSeqno),
            ))
            .go();
      }
    }
  }

  Future<void> markOutboxAndTempMessage({
    required int ownerUid,
    required int localMsgSeqno,
    required String status,
    required int now,
    String? error,
    int? msgKey,
  }) async {
    await database.transaction(() async {
      await (database.update(database.notificationOutbox)..where(
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

      await (database.update(
            database.notificationMessages,
          )..where((t) => t.ownerUid.equals(ownerUid) & t.msgSeqno.equals(localMsgSeqno)))
          .write(
            NotificationMessagesCompanion(
              syncStatus: Value(status),
              msgKey: Value(msgKey),
              updatedAt: Value(now),
            ),
          );
    });
  }

  PrivateMessage rowToPrivateMessage(NotificationMessage row) {
    final jsonMap = <String, dynamic>{
      'sender_uid': row.senderUid,
      'receiver_type': row.receiverType,
      'receiver_id': row.receiverId,
      'msg_type': row.msgType,
      'content': row.contentJson,
      'msg_seqno': row.msgSeqno,
      'timestamp': row.timestamp,
      'at_uids': row.atUidsJson == null
          ? null
          : jsonDecode(row.atUidsJson!) as List<dynamic>,
      'msg_key': row.msgKey,
      'msg_status': row.msgStatus,
      'notify_code': row.notifyCode,
      'new_face_version': row.newFaceVersion,
      'msg_source': row.msgSource,
    };
    return PrivateMessageDetail.fromJson(jsonMap).toDomain();
  }

  String? canonicalEmojiKey(String rawKey) {
    final trimmed = rawKey.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
      final inner = trimmed.substring(1, trimmed.length - 1).trim();
      if (inner.isEmpty) return null;
      return '[$inner]';
    }
    return '[$trimmed]';
  }

  void putEmojiVariants({
    required Map<String, String> map,
    required String rawKey,
    required String url,
    required bool overwrite,
  }) {
    final canonical = canonicalEmojiKey(rawKey);
    if (canonical == null) return;
    final plain = canonical.substring(1, canonical.length - 1);
    if (overwrite) {
      map[canonical] = url;
      map[plain] = url;
      return;
    }
    map.putIfAbsent(canonical, () => url);
    map.putIfAbsent(plain, () => url);
  }
}
