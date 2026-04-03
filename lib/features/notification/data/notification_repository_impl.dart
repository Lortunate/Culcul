import 'dart:convert';
import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart'
    as domain;
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'notification_repository_impl.g.dart';

@riverpod
domain.NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    NotificationApi(ref.watch(dioClientProvider)),
    ref.watch(notificationLocalDatabaseProvider),
  );
}

class NotificationRepositoryImpl
    with RequestExecutorBinding
    implements domain.NotificationRepository {
  NotificationRepositoryImpl(
    this._api,
    this._database, {
    RequestExecutor? requestExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor();

  final NotificationApi _api;
  final NotificationLocalDatabase _database;
  final RequestExecutor _requestExecutor;

  static const int _pageSize = 20;
  static const int _syncThrottleSeconds = 60;
  static const int _retentionDays = 90;
  static const String _cleanupScope = '__cleanup__';
  static const NotificationSummary _emptySummary = NotificationSummary(
    at: 0,
    chat: 0,
    coin: 0,
    danmu: 0,
    favorite: 0,
    like: 0,
    recvLike: 0,
    recvReply: 0,
    reply: 0,
    system: 0,
    up: 0,
  );

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) async {
    final row =
        await (_database.select(_database.notificationUnreadSummaries)
              ..where((t) => t.ownerUid.equals(ownerUid))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    final dto = UnreadCountModel.fromJson(
      jsonDecode(row.summaryJson) as Map<String, dynamic>,
    );
    return dto.toDomain();
  }

  @override
  Future<List<SystemNotice>> listSystemNoticesFromLocal({required int ownerUid}) async {
    final rows =
        await (_database.select(_database.notificationFeedItems)
              ..where(
                (t) =>
                    t.ownerUid.equals(ownerUid) &
                    t.feedType.equals(NotificationFeedType.system.value),
              )
              ..orderBy([
                (t) => OrderingTerm.desc(t.eventTime),
                (t) => OrderingTerm.desc(t.eventId),
              ]))
            .get();

    return rows
        .map(
          (row) => SystemNotificationItem.fromJson(
            jsonDecode(row.itemJson) as Map<String, dynamic>,
          ).toDomain(),
        )
        .toList();
  }

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async {
    final query = _database.select(_database.notificationSessions)
      ..where(
        (t) =>
            t.ownerUid.equals(ownerUid) &
            t.sessionType.equals(sessionType.value) &
            (endTs == null
                ? const Constant(true)
                : t.sessionTs.isSmallerThanValue(endTs)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.sessionTs)])
      ..limit(_pageSize);
    final rows = await query.get();
    return rows
        .map(
          (row) => PrivateMessageSession.fromJson(
            jsonDecode(row.sessionJson) as Map<String, dynamic>,
          ).toDomain(),
        )
        .toList();
  }

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) async {
    final query = _database.select(_database.notificationMessages)
      ..where((t) {
        final base =
            t.ownerUid.equals(ownerUid) &
            t.sessionType.equals(sessionType.value) &
            t.talkerId.equals(talkerId);
        if (endSeqno == null) return base;
        return base & t.msgSeqno.isSmallerThanValue(endSeqno);
      })
      ..orderBy([
        (t) => OrderingTerm.desc(t.timestamp),
        (t) => OrderingTerm.desc(t.msgSeqno),
      ])
      ..limit(_pageSize);
    final rows = await query.get();
    return rows.map(_rowToPrivateMessage).toList();
  }

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    int? cursorId,
    int? cursorTime,
  }) async {
    if (type == NotificationFeedType.system) {
      return const <NotificationEntry>[];
    }

    final query = _database.select(_database.notificationFeedItems)
      ..where((t) {
        final base = t.ownerUid.equals(ownerUid) & t.feedType.equals(type.value);
        if (cursorId == null || cursorTime == null) return base;
        return base &
            (t.eventTime.isSmallerThanValue(cursorTime) |
                (t.eventTime.equals(cursorTime) &
                    t.eventId.isSmallerThanValue(cursorId)));
      })
      ..orderBy([
        (t) => OrderingTerm.desc(t.eventTime),
        (t) => OrderingTerm.desc(t.eventId),
      ])
      ..limit(_pageSize);
    final rows = await query.get();
    return rows
        .map(
          (row) => ReplyItem.fromJson(
            jsonDecode(row.itemJson) as Map<String, dynamic>,
          ).toDomain(),
        )
        .toList();
  }

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return (_database.select(_database.notificationUnreadSummaries)
          ..where((t) => t.ownerUid.equals(ownerUid))
          ..limit(1))
        .watchSingleOrNull()
        .map((row) {
          if (row == null) return _emptySummary;
          try {
            final dto = UnreadCountModel.fromJson(
              jsonDecode(row.summaryJson) as Map<String, dynamic>,
            );
            return dto.toDomain();
          } catch (_) {
            return _emptySummary;
          }
        });
  }

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return (_database.select(_database.notificationFeedItems)
          ..where(
            (t) =>
                t.ownerUid.equals(ownerUid) &
                t.feedType.equals(NotificationFeedType.system.value),
          )
          ..orderBy([
            (t) => OrderingTerm.desc(t.eventTime),
            (t) => OrderingTerm.desc(t.eventId),
          ]))
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => SystemNotificationItem.fromJson(
                  jsonDecode(row.itemJson) as Map<String, dynamic>,
                ).toDomain(),
              )
              .toList(),
        );
  }

  @override
  Future<void> syncUnreadCount({required int ownerUid, bool force = false}) async {
    if (!await _shouldSync(ownerUid: ownerUid, scope: 'unread', force: force)) return;
    final response = await requestApi(() => _api.getUnreadCount());
    final now = _nowSeconds();

    await _database
        .into(_database.notificationUnreadSummaries)
        .insertOnConflictUpdate(
          NotificationUnreadSummariesCompanion.insert(
            ownerUid: Value(ownerUid),
            summaryJson: jsonEncode(response.toJson()),
            updatedAt: now,
          ),
        );
    await _touchCursor(
      ownerUid: ownerUid,
      scope: 'unread',
      cursorJson: null,
      hasMore: true,
    );
    await _maybeCleanup(ownerUid);
  }

  @override
  Future<void> syncSessions({required int ownerUid, bool force = false}) async {
    await _syncSessionsRemote(
      ownerUid: ownerUid,
      sessionType: PrivateSessionType.user,
      force: force,
    );
  }

  @override
  Future<void> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) async {
    await _syncSessionsRemote(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
      force: true,
    );
  }

  Future<void> _syncSessionsRemote({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
    bool force = false,
  }) async {
    final scope = 'sessions:${sessionType.value}:${endTs == null ? "head" : "older"}';
    if (!await _shouldSync(ownerUid: ownerUid, scope: scope, force: force)) return;

    final response = await requestApi(
      () => _api.getPrivateSessions(
        sessionType: sessionType.value,
        size: _pageSize,
        endTs: endTs,
      ),
    );
    final now = _nowSeconds();
    final sessions = response.sessionList ?? const <PrivateMessageSession>[];

    await _database.transaction(() async {
      for (final session in sessions) {
        await _database
            .into(_database.notificationSessions)
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
          await _upsertMessageDetail(
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
    await _touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: nextCursor == null ? null : jsonEncode({'endTs': nextCursor}),
      hasMore: response.hasMore == 1,
    );
    await _maybeCleanup(ownerUid);
  }

  @override
  Future<void> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    await _syncMessagesRemote(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      force: true,
    );
  }

  @override
  Future<void> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) async {
    if (endSeqno <= 0) return;
    await _syncMessagesRemote(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
      force: true,
    );
  }

  Future<void> _syncMessagesRemote({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
    bool force = false,
  }) async {
    final scope =
        'messages:${sessionType.value}:$talkerId:${endSeqno == null ? "head" : "older"}';
    if (!await _shouldSync(ownerUid: ownerUid, scope: scope, force: force)) return;

    final response = await requestApi(
      () => _api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: sessionType.value,
        size: _pageSize,
        endSeqno: endSeqno,
      ),
    );
    final now = _nowSeconds();
    final messages = response.messages ?? const <PrivateMessageDetail>[];

    await _database.transaction(() async {
      for (final message in messages) {
        await _upsertMessageDetail(
          ownerUid: ownerUid,
          sessionType: sessionType,
          talkerId: talkerId,
          message: message,
          now: now,
          syncStatus: 'synced',
        );
      }
      await _reconcileTemporaryMessages(
        ownerUid: ownerUid,
        talkerId: talkerId,
        sessionType: sessionType,
      );
    });

    await _touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: jsonEncode({
        'minSeqno': response.minSeqno,
        'maxSeqno': response.maxSeqno,
      }),
      hasMore: response.hasMore == 1,
    );
    await _maybeCleanup(ownerUid);
  }

  @override
  Future<void> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) async {
    await _syncFeedRemote(ownerUid: ownerUid, type: type, force: true);
  }

  @override
  Future<void> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required int cursorId,
    required int cursorTime,
  }) async {
    await _syncFeedRemote(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursorId,
      cursorTime: cursorTime,
      force: true,
    );
  }

  Future<void> _syncFeedRemote({
    required int ownerUid,
    required NotificationFeedType type,
    int? cursorId,
    int? cursorTime,
    bool force = false,
  }) async {
    final scope = 'feed:${type.value}:${cursorId == null ? "head" : "older"}';
    if (!await _shouldSync(ownerUid: ownerUid, scope: scope, force: force)) return;

    final now = _nowSeconds();
    if (type == NotificationFeedType.system) {
      final items = await _fetchSystemNotifications();
      await _database.transaction(() async {
        for (final item in items) {
          await _database
              .into(_database.notificationFeedItems)
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
      await _touchCursor(
        ownerUid: ownerUid,
        scope: scope,
        cursorJson: null,
        hasMore: false,
      );
      await _maybeCleanup(ownerUid);
      return;
    }

    final response = await _fetchReplyLikeAtResponse(
      type: type,
      id: cursorId,
      time: cursorTime,
    );

    await _database.transaction(() async {
      for (final item in response.items) {
        await _database
            .into(_database.notificationFeedItems)
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
        : {
            'id': response.items.last.id,
            'time': response.items.last.replyTime ?? response.items.last.likeTime ?? 0,
          };
    await _touchCursor(
      ownerUid: ownerUid,
      scope: scope,
      cursorJson: next == null ? null : jsonEncode(next),
      hasMore: !response.cursor.isEnd,
    );
    await _maybeCleanup(ownerUid);
  }

  Future<void> retryFailedOutbox({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final query = _database.select(_database.notificationOutbox)
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
      await _database
          .update(_database.notificationOutbox)
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

  @override
  Future<Result<ImageUploadResult, AppError>> uploadImage(File file) async {
    return requestResult(() async {
      final response = await requestApi(() => _api.uploadImage(file: file));
      return response.toDomain();
    });
  }

  @override
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final now = _nowSeconds();
    final localMsgSeqno = -DateTime.now().microsecondsSinceEpoch;
    final contentMap = content.toRawMap();
    final contentRawJson = jsonEncode(contentMap);
    final devId = const Uuid().v4().toUpperCase();

    await _database.transaction(() async {
      await _database
          .into(_database.notificationMessages)
          .insertOnConflictUpdate(
            NotificationMessagesCompanion.insert(
              ownerUid: ownerUid,
              sessionType: _sessionTypeFromReceiver(receiverType).value,
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

      await _database
          .into(_database.notificationOutbox)
          .insert(
            NotificationOutboxCompanion.insert(
              ownerUid: ownerUid,
              sessionType: _sessionTypeFromReceiver(receiverType).value,
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

    final result = await requestResult(() async {
      final response = await requestApi(
        () => _api.sendPrivateMessage(
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
      return response.toDomain();
    });

    await result.when(
      success: (value) async {
        await _markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'sent',
          msgKey: value.msgKey,
        );
        await syncMessagesHead(
          ownerUid: ownerUid,
          talkerId: receiverId,
          sessionType: _sessionTypeFromReceiver(receiverType),
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

    return result;
  }

  Future<void> _markOutboxAndTempMessage({
    required int ownerUid,
    required int localMsgSeqno,
    required String status,
    String? error,
    int? msgKey,
  }) async {
    final now = _nowSeconds();
    await _database.transaction(() async {
      await (_database.update(_database.notificationOutbox)..where(
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

      await (_database.update(
            _database.notificationMessages,
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

  Future<void> _upsertMessageDetail({
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

    await _database
        .into(_database.notificationMessages)
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

  Future<void> _reconcileTemporaryMessages({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final tempQuery = _database.select(_database.notificationMessages)
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

    final syncedQuery = _database.select(_database.notificationMessages)
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
        await (_database.delete(_database.notificationMessages)..where(
              (t) => t.ownerUid.equals(ownerUid) & t.msgSeqno.equals(temp.msgSeqno),
            ))
            .go();
      }
    }
  }

  Future<ReplyResponse> _fetchReplyLikeAtResponse({
    required NotificationFeedType type,
    int? id,
    int? time,
  }) async {
    switch (type) {
      case NotificationFeedType.reply:
        return requestApi(() => _api.getReplyList(id: id, replyTime: time));
      case NotificationFeedType.at:
        return requestApi(() => _api.getAtList(id: id, atTime: time));
      case NotificationFeedType.like:
        final likeResponse = await requestApi(
          () => _api.getLikeList(id: id, likeTime: time),
        );
        return ReplyResponse(
          cursor: likeResponse.total.cursor,
          items: likeResponse.total.items,
          lastViewAt: likeResponse.latest.lastViewAt,
        );
      case NotificationFeedType.system:
        throw UnsupportedError('System notifications use a dedicated API flow');
    }
  }

  Future<List<SystemNotificationItem>> _fetchSystemNotifications() async {
    final sessionRes = await requestApi(
      () => _api.getPrivateSessions(
        sessionType: PrivateSessionType.system.value,
        size: _pageSize,
      ),
    );
    final systemMsgMap = sessionRes.systemMsg;
    if (systemMsgMap == null || !systemMsgMap.containsKey('5')) {
      return const <SystemNotificationItem>[];
    }

    final talkerId = systemMsgMap['5']!;
    final msgsRes = await requestApi(
      () => _api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: PrivateSessionType.user.value,
        size: _pageSize,
      ),
    );
    return msgsRes.messages?.map((msg) {
          final contentMap = msg.contentMap;
          return SystemNotificationItem(
            id: msg.msgSeqno,
            title: contentMap?['title'] as String?,
            text: contentMap?['content'] as String? ?? contentMap?['text'] as String?,
            time: msg.timestamp,
            uri:
                contentMap?['url'] as String? ??
                contentMap?['uri'] as String? ??
                contentMap?['jump_uri'] as String?,
            jumpText: contentMap?['jump_text'] as String?,
          );
        }).toList() ??
        const <SystemNotificationItem>[];
  }

  PrivateMessage _rowToPrivateMessage(NotificationMessage row) {
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

  Future<bool> _shouldSync({
    required int ownerUid,
    required String scope,
    required bool force,
  }) async {
    if (force) return true;
    final now = _nowSeconds();
    final existing =
        await (_database.select(_database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(scope))
              ..limit(1))
            .getSingleOrNull();
    if (existing == null) return true;
    return now - existing.lastSyncedAt >= _syncThrottleSeconds;
  }

  Future<void> _touchCursor({
    required int ownerUid,
    required String scope,
    required String? cursorJson,
    required bool hasMore,
  }) async {
    final now = _nowSeconds();
    await _database
        .into(_database.notificationSyncCursors)
        .insertOnConflictUpdate(
          NotificationSyncCursorsCompanion.insert(
            ownerUid: ownerUid,
            scope: scope,
            cursorJson: Value(cursorJson),
            hasMore: Value(hasMore),
            lastSyncedAt: Value(now),
          ),
        );
  }

  Future<void> _maybeCleanup(int ownerUid) async {
    final now = _nowSeconds();
    final cleanupCursor =
        await (_database.select(_database.notificationSyncCursors)
              ..where((t) => t.ownerUid.equals(ownerUid) & t.scope.equals(_cleanupScope))
              ..limit(1))
            .getSingleOrNull();

    if (cleanupCursor != null && now - cleanupCursor.lastSyncedAt < 24 * 60 * 60) {
      return;
    }

    final cutoff = now - (_retentionDays * 24 * 60 * 60);

    await _database.transaction(() async {
      await (_database.delete(_database.notificationMessages)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.timestamp.isSmallerThanValue(cutoff),
          ))
          .go();

      await (_database.delete(_database.notificationFeedItems)..where(
            (t) => t.ownerUid.equals(ownerUid) & t.eventTime.isSmallerThanValue(cutoff),
          ))
          .go();

      await (_database.delete(_database.notificationSessions)..where(
            (t) =>
                t.ownerUid.equals(ownerUid) &
                t.sessionTs.isSmallerThanValue(cutoff) &
                t.unreadCount.equals(0),
          ))
          .go();

      await _touchCursor(
        ownerUid: ownerUid,
        scope: _cleanupScope,
        cursorJson: null,
        hasMore: false,
      );
    });
  }

  int _nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  PrivateSessionType _sessionTypeFromReceiver(PrivateMessageReceiverType type) {
    return type == PrivateMessageReceiverType.group
        ? PrivateSessionType.group
        : PrivateSessionType.user;
  }
}
