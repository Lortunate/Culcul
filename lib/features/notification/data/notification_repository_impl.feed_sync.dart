import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.cleanup_policy.dart';
import 'package:culcul/features/notification/models/notification_feed_cursor.dart';
import 'package:culcul/features/notification/models/notification_feed_type.dart';
import 'package:culcul/features/notification/models/private_session.dart';
import 'package:culcul/features/notification/models/system_notice.dart';

class NotificationFeedSync {
  const NotificationFeedSync({
    required this.database,
    required this.api,
    required this.requestExecutor,
    required this.cleanupPolicy,
    required this.pageSize,
    required this.nowSeconds,
  });

  final NotificationLocalDatabase database;
  final NotificationApi api;
  final RequestExecutor requestExecutor;
  final NotificationCleanupPolicy cleanupPolicy;
  final int pageSize;
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
      return (await _fetchSystemNotifications()).when(
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
                      itemJson: jsonEncode(systemNoticeToJson(item)),
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

    return (await _fetchReplyLikeAtResponse(
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

  Future<Result<ReplyResponse, AppError>> _fetchReplyLikeAtResponse({
    required NotificationFeedType type,
    int? id,
    int? time,
  }) async {
    switch (type) {
      case NotificationFeedType.reply:
        return requestExecutor.runApiDirect(
          () => api.getReplyList(id: id, replyTime: time),
        );
      case NotificationFeedType.at:
        return requestExecutor.runApiDirect(() => api.getAtList(id: id, atTime: time));
      case NotificationFeedType.like:
        return requestExecutor.runApi<ReplyResponse, Object>(
          () => api.getLikeList(id: id, likeTime: time),
          transform: (data) {
            final root = JsonUtils.asStringKeyedMap(data) ?? const <String, dynamic>{};
            final total =
                JsonUtils.asStringKeyedMap(root['total']) ?? const <String, dynamic>{};
            final cursor = JsonUtils.asStringKeyedMap(total['cursor']);
            return ReplyResponse(
              cursor: ReplyCursor.fromJson(cursor ?? const <String, dynamic>{}),
              items: JsonUtils.parseObjectList(
                total['items'],
              ).map(ReplyItem.fromJson).toList(growable: false),
            );
          },
        );
      case NotificationFeedType.system:
        return const Failure(
          AppError.data('System notifications use a dedicated API flow'),
        );
    }
  }

  Future<Result<List<SystemNotice>, AppError>> _fetchSystemNotifications() async {
    final sessionResult = await requestExecutor.runApiDirect(
      () => api.getPrivateSessions(
        sessionType: PrivateSessionType.system.value,
        size: pageSize,
      ),
    );
    return sessionResult.when(
      success: (sessionRes) async {
        int? talkerId;
        final systemMsgMap = sessionRes.systemMsg;
        if (systemMsgMap != null && systemMsgMap.isNotEmpty) {
          var preferred = systemMsgMap['5'] ?? systemMsgMap['7'];
          if (preferred == null || preferred <= 0) {
            for (final item in systemMsgMap.values) {
              if (item > 0) {
                preferred = item;
                break;
              }
            }
          }
          if (preferred != null && preferred > 0) {
            talkerId = preferred;
          }
        }

        if (talkerId == null) {
          final sessions = sessionRes.sessionList ?? const <PrivateMessageSession>[];
          for (final session in sessions) {
            if (session.sessionType == PrivateSessionType.system.value &&
                session.talkerId > 0) {
              talkerId = session.talkerId;
              break;
            }
          }
        }

        if (talkerId == null) {
          return const Success(<SystemNotice>[]);
        }
        final resolvedTalkerId = talkerId;

        final msgsResult = await requestExecutor.runApiDirect(
          () => api.getPrivateMessages(
            talkerId: resolvedTalkerId,
            sessionType: PrivateSessionType.user.value,
            size: pageSize,
          ),
        );
        return msgsResult.map(
          (msgsRes) =>
              msgsRes.messages?.map((msg) {
                final contentMap = msg.contentMap;
                final nestedContentMap = _toJsonMap(contentMap?['content']);
                return SystemNotice(
                  id: msg.msgSeqno,
                  title: _firstNonEmptyString([
                    contentMap?['title'],
                    nestedContentMap?['title'],
                  ]),
                  text: _extractSystemNoticeText(contentMap, nestedContentMap),
                  time: msg.timestamp,
                  uri: _extractSystemNoticeUri(contentMap, nestedContentMap),
                  jumpText: _firstNonEmptyString([
                    contentMap?['jump_text'],
                    contentMap?['jumpText'],
                    nestedContentMap?['jump_text'],
                    nestedContentMap?['jumpText'],
                  ]),
                );
              }).toList() ??
              const <SystemNotice>[],
        );
      },
      failure: (error) async => Failure(error),
    );
  }

  String? _extractSystemNoticeText(
    Map<String, dynamic>? contentMap,
    Map<String, dynamic>? nestedContentMap,
  ) {
    final contentString = _firstNonEmptyString([contentMap?['content']]);
    final decodedContent = _toJsonMap(contentString);
    return _firstNonEmptyString([
      contentMap?['text'],
      contentMap?['desc'],
      contentMap?['message'],
      decodedContent?['text'],
      decodedContent?['content'],
      nestedContentMap?['text'],
      nestedContentMap?['content'],
      contentString,
    ]);
  }

  String? _extractSystemNoticeUri(
    Map<String, dynamic>? contentMap,
    Map<String, dynamic>? nestedContentMap,
  ) {
    final contentString = _firstNonEmptyString([contentMap?['content']]);
    final decodedContent = _toJsonMap(contentString);
    return _firstNonEmptyString([
      contentMap?['url'],
      contentMap?['uri'],
      contentMap?['jump_uri'],
      contentMap?['jumpUrl'],
      nestedContentMap?['url'],
      nestedContentMap?['uri'],
      nestedContentMap?['jump_uri'],
      nestedContentMap?['jumpUrl'],
      decodedContent?['url'],
      decodedContent?['uri'],
      decodedContent?['jump_uri'],
      decodedContent?['jumpUrl'],
    ]);
  }

  String? _firstNonEmptyString(List<dynamic> values) {
    for (final value in values) {
      if (value is String) {
        final trimmed = value.trim();
        if (trimmed.isNotEmpty) {
          return trimmed;
        }
      }
    }
    return null;
  }

  Map<String, dynamic>? _toJsonMap(dynamic raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) return decoded;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
