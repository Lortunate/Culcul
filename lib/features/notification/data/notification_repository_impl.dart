import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:culcul/core/models/uploaded_image_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide Uint8List;
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_message_persistence.dart';
import 'package:culcul/features/notification/data/notification_paging_constants.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.feed_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_sync.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.session_sync.dart';
import 'package:culcul/features/notification/models/notification_entry.dart';
import 'package:culcul/features/notification/models/notification_feed_cursor.dart';
import 'package:culcul/features/notification/models/notification_feed_type.dart';
import 'package:culcul/features/notification/models/notification_summary.dart';
import 'package:culcul/features/notification/models/private_message.dart';
import 'package:culcul/features/notification/models/private_session.dart';
import 'package:culcul/features/notification/models/send_message_result.dart';
import 'package:culcul/features/notification/models/system_notice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository_impl.g.dart';

@riverpod
NotificationRepositoryImpl notificationRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return NotificationRepositoryImpl(
    NotificationApi(dio),
    ref.watch(notificationLocalDatabaseProvider),
    dio,
  );
}

class NotificationRepositoryImpl {
  NotificationRepositoryImpl(
    this._api,
    this._database,
    this._dio, {
    RequestExecutor? requestExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor() {
    _persistence = NotificationMessagePersistence(_database);

    _cleanupPolicy = NotificationCleanupPolicy(
      database: _database,
      syncThrottleSeconds: syncThrottleSeconds,
      retentionDays: retentionDays,
      cleanupScope: cleanupScope,
      nowSeconds: nowSeconds,
    );

    _messageSync = NotificationMessageSync(
      database: _database,
      api: _api,
      requestExecutor: _requestExecutor,
      cleanupPolicy: _cleanupPolicy,
      persistence: _persistence,
      pageSize: notificationPrivateMessagePageSize,
      nowSeconds: nowSeconds,
    );

    _sessionSync = NotificationSessionSync(
      database: _database,
      api: _api,
      requestExecutor: _requestExecutor,
      cleanupPolicy: _cleanupPolicy,
      persistence: _persistence,
      nowSeconds: nowSeconds,
    );

    _feedSync = NotificationFeedSync(
      database: _database,
      api: _api,
      requestExecutor: _requestExecutor,
      cleanupPolicy: _cleanupPolicy,
      pageSize: notificationPrivateMessagePageSize,
      nowSeconds: nowSeconds,
    );
  }

  final NotificationApi _api;
  final NotificationLocalDatabase _database;
  final Dio _dio;
  final RequestExecutor _requestExecutor;

  late final NotificationMessagePersistence _persistence;
  late final NotificationCleanupPolicy _cleanupPolicy;
  late final NotificationMessageSync _messageSync;
  late final NotificationSessionSync _sessionSync;
  late final NotificationFeedSync _feedSync;

  static const int syncThrottleSeconds = 60;
  static const int retentionDays = 90;
  static const String cleanupScope = '__cleanup__';
  static const NotificationSummary emptySummary = NotificationSummary();

  int nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

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
      ..limit(notificationPrivateMessagePageSize);
    final rows = await query.get();
    final sessions = <PrivateSession>[];
    for (final row in rows) {
      final decoded = await jsonDecodeCompute(row.sessionJson);
      sessions.add(
        PrivateMessageSession.fromJson(decoded as Map<String, dynamic>).toDomain(),
      );
    }
    return sessions;
  }

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
      ..limit(notificationPrivateMessagePageSize);
    final rows = await query.get();
    return rows.map(_persistence.rowToPrivateMessage).toList();
  }

  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) async {
    final rows =
        await (_database.select(_database.notificationMessageEmojis)
              ..where(
                (t) =>
                    t.ownerUid.equals(ownerUid) &
                    t.sessionType.equals(sessionType.value) &
                    t.talkerId.equals(talkerId),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    final map = <String, String>{};
    for (final row in rows) {
      _persistence.putEmojiVariants(
        map: map,
        rawKey: row.emojiText,
        url: row.emojiUrl,
        overwrite: false,
      );
    }
    return map;
  }

  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async {
    if (type == NotificationFeedType.system) {
      return const <NotificationEntry>[];
    }

    final query = _database.select(_database.notificationFeedItems)
      ..where((t) {
        final base = t.ownerUid.equals(ownerUid) & t.feedType.equals(type.value);
        if (cursor == null) return base;
        return base &
            (t.eventTime.isSmallerThanValue(cursor.time) |
                (t.eventTime.equals(cursor.time) &
                    t.eventId.isSmallerThanValue(cursor.id)));
      })
      ..orderBy([
        (t) => OrderingTerm.desc(t.eventTime),
        (t) => OrderingTerm.desc(t.eventId),
      ])
      ..limit(notificationPrivateMessagePageSize);
    final rows = await query.get();
    final items = <NotificationEntry>[];
    for (final row in rows) {
      final decoded = await jsonDecodeCompute(row.itemJson);
      items.add(ReplyItem.fromJson(decoded as Map<String, dynamic>).toDomain());
    }
    return items;
  }

  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return (_database.select(_database.notificationUnreadSummaries)
          ..where((t) => t.ownerUid.equals(ownerUid))
          ..limit(1))
        .watchSingleOrNull()
        .asyncMap((row) async {
          if (row == null) return emptySummary;
          try {
            final decoded = await jsonDecodeCompute(row.summaryJson);
            final json = decoded as Map<String, dynamic>;
            return NotificationSummary(
              at: JsonUtils.parseIntWithDefault(json['at']),
              chat: JsonUtils.parseIntWithDefault(json['chat']),
              coin: JsonUtils.parseIntWithDefault(json['coin']),
              danmu: JsonUtils.parseIntWithDefault(json['danmu']),
              favorite: JsonUtils.parseIntWithDefault(json['favorite']),
              like: JsonUtils.parseIntWithDefault(json['like']),
              recvLike: JsonUtils.parseIntWithDefault(json['recv_like']),
              recvReply: JsonUtils.parseIntWithDefault(json['recv_reply']),
              reply: JsonUtils.parseIntWithDefault(json['reply']),
              system: JsonUtils.parseIntWithDefault(json['sys_msg']),
              up: JsonUtils.parseIntWithDefault(json['up']),
            );
          } catch (_) {
            return emptySummary;
          }
        });
  }

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
        .asyncMap((rows) async {
          final notices = <SystemNotice>[];
          for (final row in rows) {
            final json = (await jsonDecodeCompute(row.itemJson)) as Map<String, dynamic>;
            notices.add(systemNoticeFromJson(json));
          }
          return notices;
        });
  }

  Future<Result<void, AppError>> syncSystemNotices({required int ownerUid}) {
    return syncFeedHead(ownerUid: ownerUid, type: NotificationFeedType.system);
  }

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return _sessionSync.syncUnreadCount(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _sessionSync.syncSessions(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return _sessionSync.syncSessionsOlder(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
    );
  }

  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _messageSync.syncMessagesHead(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) {
    return _messageSync.syncMessagesOlder(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
    );
  }

  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    return _feedSync.syncFeedHead(ownerUid: ownerUid, type: type);
  }

  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) {
    return _feedSync.syncFeedOlder(ownerUid: ownerUid, type: type, cursor: cursor);
  }

  PrivateSessionType _sessionTypeFromReceiver(PrivateMessageReceiverType type) {
    return type == PrivateMessageReceiverType.group
        ? PrivateSessionType.group
        : PrivateSessionType.user;
  }

  Future<Result<UploadedImage, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  ) async {
    final result = await _requestExecutor.runApiDirect(() async {
      final formData = FormData.fromMap({
        'file_up': MultipartFile.fromBytes(bytes, filename: filename),
        'biz': 'draw',
        'category': 'daily',
        'build': '0',
        'mobi_app': 'web',
      });
      final response = await _dio.post<Map<String, dynamic>>(
        'https://api.vc.bilibili.com/api/v1/drawImage/upload',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data!,
        (json) => Map<String, dynamic>.from(json as Map),
      );
    });
    return result.map(UploadedImage.fromJson);
  }

  Future<Result<SendMessageResult, AppError>> sendPrivateMessage({
    required int ownerUid,
    required int receiverId,
    required PrivateMessageReceiverType receiverType,
    required PrivateMessageType messageType,
    required PrivateMessageContent content,
  }) async {
    final now = nowSeconds();
    final localMsgSeqno = -DateTime.now().microsecondsSinceEpoch;
    final contentMap = content.toRawMap();
    final contentRawJson = jsonEncode(contentMap);
    final devId = _generateUuidV4();

    SendMessageResult parseSendMessageResult(Map<String, dynamic> json) {
      final msgContentRaw = json['msg_content'];
      final msgContent = msgContentRaw?.toString();

      return SendMessageResult(
        msgKey: JsonUtils.parseIntWithDefault(json['msg_key']),
        msgContent: msgContent == null || msgContent.isEmpty ? null : msgContent,
        keyHitInfos: JsonUtils.asStringKeyedMap(json['key_hit_infos']),
      );
    }

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

    final responseResult = await _requestExecutor.runApiDirect(
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

    await responseResult.when(
      success: (responseJson) async {
        final response = parseSendMessageResult(responseJson as Map<String, dynamic>);
        await _persistence.markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'sent',
          now: nowSeconds(),
          msgKey: response.msgKey,
        );
        await _messageSync.syncMessagesHead(
          ownerUid: ownerUid,
          talkerId: receiverId,
          sessionType: _sessionTypeFromReceiver(receiverType),
        );
      },
      failure: (error) async {
        await _persistence.markOutboxAndTempMessage(
          ownerUid: ownerUid,
          localMsgSeqno: localMsgSeqno,
          status: 'failed',
          now: nowSeconds(),
          error: error.message,
        );
      },
    );

    return responseResult.map(
      (json) => parseSendMessageResult(json as Map<String, dynamic>),
    );
  }
}

String _generateUuidV4() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));

  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  String hex(int byte) => byte.toRadixString(16).padLeft(2, '0');

  final buffer = StringBuffer()
    ..write(hex(bytes[0]))
    ..write(hex(bytes[1]))
    ..write(hex(bytes[2]))
    ..write(hex(bytes[3]))
    ..write('-')
    ..write(hex(bytes[4]))
    ..write(hex(bytes[5]))
    ..write('-')
    ..write(hex(bytes[6]))
    ..write(hex(bytes[7]))
    ..write('-')
    ..write(hex(bytes[8]))
    ..write(hex(bytes[9]))
    ..write('-')
    ..write(hex(bytes[10]))
    ..write(hex(bytes[11]))
    ..write(hex(bytes[12]))
    ..write(hex(bytes[13]))
    ..write(hex(bytes[14]))
    ..write(hex(bytes[15]));

  return buffer.toString().toUpperCase();
}
