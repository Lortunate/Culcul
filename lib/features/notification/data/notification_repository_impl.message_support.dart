part of 'notification_repository_impl.dart';

class _NotificationMessageSupport {
  const _NotificationMessageSupport(this.repo);

  final NotificationRepositoryImpl repo;

  Future<Result<ReplyResponse, AppError>> fetchReplyLikeAtResponse({
    required NotificationFeedType type,
    int? id,
    int? time,
  }) async {
    switch (type) {
      case NotificationFeedType.reply:
        return repo.requestApiResult(
          () => repo._api.getReplyList(id: id, replyTime: time),
        );
      case NotificationFeedType.at:
        return repo.requestApiResult(() => repo._api.getAtList(id: id, atTime: time));
      case NotificationFeedType.like:
        final likeResult = await repo.requestApiResult(
          () => repo._api.getLikeList(id: id, likeTime: time),
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
      () => repo._api.getPrivateSessions(
        sessionType: PrivateSessionType.system.value,
        size: NotificationRepositoryImpl._pageSize,
      ),
    );
    if (sessionResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final sessionRes = sessionResult.dataOrNull!;
    final talkerId = _resolveSystemTalkerId(sessionRes);
    if (talkerId == null) {
      return const Success(<SystemNotificationItem>[]);
    }

    final msgsResult = await repo.requestApiResult(
      () => repo._api.getPrivateMessages(
        talkerId: talkerId,
        sessionType: PrivateSessionType.user.value,
        size: NotificationRepositoryImpl._pageSize,
      ),
    );
    return msgsResult.map(
      (msgsRes) =>
          msgsRes.messages?.map((msg) {
            final contentMap = msg.contentMap;
            final nestedContentMap = _toJsonMap(contentMap?['content']);
            return SystemNotificationItem(
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
