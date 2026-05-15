import 'dart:convert';

import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.message_support.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';

extension NotificationMessageSupportHelpers on NotificationMessageSupport {
  int? resolveSystemTalkerId(PrivateMessageSessionResponse response) {
    final systemMsgMap = response.systemMsg;
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
        return preferred;
      }
    }

    final sessions = response.sessionList ?? const <PrivateMessageSession>[];
    for (final session in sessions) {
      if (session.sessionType == PrivateSessionType.system.value &&
          session.talkerId > 0) {
        return session.talkerId;
      }
    }
    return null;
  }

  String? extractSystemNoticeText(
    Map<String, dynamic>? contentMap,
    Map<String, dynamic>? nestedContentMap,
  ) {
    final contentString = firstNonEmptyString([contentMap?['content']]);
    final decodedContent = toJsonMap(contentString);
    return firstNonEmptyString([
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

  String? extractSystemNoticeUri(
    Map<String, dynamic>? contentMap,
    Map<String, dynamic>? nestedContentMap,
  ) {
    final contentString = firstNonEmptyString([contentMap?['content']]);
    final decodedContent = toJsonMap(contentString);
    return firstNonEmptyString([
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

  String? firstNonEmptyString(List<dynamic> values) {
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

  Map<String, dynamic>? toJsonMap(dynamic raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) return decoded;
      } catch (_) {}
    }
    return null;
  }
}
