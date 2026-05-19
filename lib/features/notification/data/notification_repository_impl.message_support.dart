import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/data/notification_api.dart';
import 'package:culcul/features/notification/data/notification_mapper.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support_helpers.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/data/dtos/system_notice.dart';

class NotificationMessageSupport {
  const NotificationMessageSupport({
    required this.api,
    required this.requestExecutor,
    required this.pageSize,
  });

  final NotificationApi api;
  final RequestExecutor requestExecutor;
  final int pageSize;

  Future<Result<ReplyResponse, AppError>> fetchReplyLikeAtResponse({
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
        final likeResult = await requestExecutor.runApiDirect(
          () => api.getLikeList(id: id, likeTime: time),
        );
        return likeResult.map(
          (likeResponse) => ReplyResponse(
            cursor: likeResponse.total.cursor,
            items: likeResponse.total.items,
            lastViewAt: likeResponse.latest.lastViewAt,
          ),
        );
      case NotificationFeedType.system:
        return const Failure(
          AppError.data('System notifications use a dedicated API flow'),
        );
    }
  }

  Future<Result<List<SystemNotice>, AppError>> fetchSystemNotifications() async {
    final sessionResult = await requestExecutor.runApiDirect(
      () => api.getPrivateSessions(
        sessionType: PrivateSessionType.system.value,
        size: pageSize,
      ),
    );
    return sessionResult.when(
      success: (sessionRes) async {
        final talkerId = resolveSystemTalkerId(sessionRes);
        if (talkerId == null) {
          return const Success(<SystemNotice>[]);
        }

        final msgsResult = await requestExecutor.runApiDirect(
          () => api.getPrivateMessages(
            talkerId: talkerId,
            sessionType: PrivateSessionType.user.value,
            size: pageSize,
          ),
        );
        return msgsResult.map(
          (msgsRes) =>
              msgsRes.messages?.map((msg) {
                final contentMap = msg.contentMap;
                final nestedContentMap = toJsonMap(contentMap?['content']);
                return SystemNotice(
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
              const <SystemNotice>[],
        );
      },
      failure: (error) async => Failure(error),
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

  PrivateMessage rowToPrivateMessage(Map<String, dynamic> jsonMap) {
    return PrivateMessageDetail.fromJson(jsonMap).toDomain();
  }
}
