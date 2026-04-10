import 'dart:convert';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/notification/data/dtos/notification_dtos.dart';
import 'package:culcul/features/notification/data/local/notification_local_database.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support_helpers.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';

class NotificationMessageSupport {
  const NotificationMessageSupport(this.repo);

  final NotificationRepositoryImpl repo;

  Future<Result<ReplyResponse, AppError>> fetchReplyLikeAtResponse({
    required NotificationFeedType type,
    int? id,
    int? time,
  }) async {
    switch (type) {
      case NotificationFeedType.reply:
        return repo.requestApiResult(
          () => repo.api.getReplyList(id: id, replyTime: time),
        );
      case NotificationFeedType.at:
        return repo.requestApiResult(() => repo.api.getAtList(id: id, atTime: time));
      case NotificationFeedType.like:
        final likeResult = await repo.requestApiResult(
          () => repo.api.getLikeList(id: id, likeTime: time),
        );
        return likeResult.map(
          (likeResponse) => ReplyResponse(
            cursor: likeResponse.total.cursor,
            items: likeResponse.total.items,
            lastViewAt: likeResponse.latest.lastViewAt,
          ),
        );
      case NotificationFeedType.system:
        return Failure(AppError.data('System notifications use a dedicated API flow'));
    }
  }

  Future<Result<List<SystemNotificationItem>, AppError>>
  fetchSystemNotifications() async {
    final sessionResult = await repo.requestApiResult(
      () => repo.api.getPrivateSessions(
        sessionType: PrivateSessionType.system.value,
        size: NotificationRepositoryImpl.pageSize,
      ),
    );
    if (sessionResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final sessionRes = sessionResult.dataOrNull!;
    final talkerId = resolveSystemTalkerId(sessionRes);
    if (talkerId == null) {
      return const Success(<SystemNotificationItem>[]);
    }

    final msgsResult = await repo.requestApiResult(
      () => repo.api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: PrivateSessionType.user.value,
        size: NotificationRepositoryImpl.pageSize,
      ),
    );
    return msgsResult.map(
      (msgsRes) =>
          msgsRes.messages?.map((msg) {
            final contentMap = msg.contentMap;
            final nestedContentMap = toJsonMap(contentMap?['content']);
            return SystemNotificationItem(
              id: msg.msgSeqno,
              title: firstNonEmptyString([
                contentMap?['title'],
                nestedContentMap?['title'],
              ]),
              text: extractSystemNoticeText(contentMap, nestedContentMap),
              time: msg.timestamp,
              uri: extractSystemNoticeUri(contentMap, nestedContentMap),
              jumpText: firstNonEmptyString([
                contentMap?['jump_text'],
                contentMap?['jumpText'],
                nestedContentMap?['jump_text'],
                nestedContentMap?['jumpText'],
              ]),
            );
          }).toList() ??
          const <SystemNotificationItem>[],
    );
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
}
