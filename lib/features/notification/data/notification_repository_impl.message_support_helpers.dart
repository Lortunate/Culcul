part of 'notification_repository_impl.dart';

extension _NotificationMessageSupportHelpers on _NotificationMessageSupport {
  int? _resolveSystemTalkerId(PrivateMessageSessionResponse response) {
    final systemMsgMap = response.systemMsg;
    if (systemMsgMap != null && systemMsgMap.isNotEmpty) {
      final preferred =
          systemMsgMap['5'] ??
          systemMsgMap['7'] ??
          systemMsgMap.values.cast<int?>().firstWhere(
            (item) => item != null && item > 0,
            orElse: () => null,
          );
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
      } catch (_) {}
    }
    return null;
  }
}
