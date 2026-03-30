import 'dart:convert';

enum PrivateMessageSummaryKind {
  withdrawn,
  text,
  image,
  notice,
  video,
  article,
  card,
  share,
  unknown,
}

class PrivateMessage {
  final int senderUid;
  final int receiverType;
  final int receiverId;
  final int msgType;
  final dynamic content;
  final int msgSeqno;
  final int timestamp;
  final List<int>? atUids;
  final int? msgKey;
  final int? msgStatus;
  final String? notifyCode;
  final int? newFaceVersion;
  final int? msgSource;

  const PrivateMessage({
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.msgType,
    required this.content,
    required this.msgSeqno,
    required this.timestamp,
    required this.atUids,
    required this.msgKey,
    required this.msgStatus,
    required this.notifyCode,
    required this.newFaceVersion,
    required this.msgSource,
  });

  Map<String, dynamic>? get contentMap {
    if (content is Map<String, dynamic>) return content as Map<String, dynamic>;
    if (content is Map) return Map<String, dynamic>.from(content as Map);
    if (content is String) {
      try {
        return jsonDecode(content as String) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  bool isMe(int currentUid) => senderUid == currentUid;

  String get textContent {
    if (msgType == 1) {
      return contentMap?['content'] as String? ?? '';
    }
    return '';
  }

  String? get imageUrl {
    if (msgType == 2 || msgType == 6) {
      return contentMap?['url'] as String?;
    }
    return null;
  }

  List<Map<String, dynamic>>? get systemTipContent {
    if (msgType == 18) {
      try {
        final innerContentStr = contentMap?['content'] as String?;
        if (innerContentStr != null) {
          final List<dynamic> list = jsonDecode(innerContentStr);
          return list.map((item) => Map<String, dynamic>.from(item as Map)).toList();
        }
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  bool get isWithdrawn => msgStatus == 1 || msgType == 5;

  PrivateMessageSummaryKind get summaryKind {
    if (isWithdrawn) {
      return PrivateMessageSummaryKind.withdrawn;
    }

    return switch (msgType) {
      1 => PrivateMessageSummaryKind.text,
      2 || 6 => PrivateMessageSummaryKind.image,
      10 => PrivateMessageSummaryKind.notice,
      11 => PrivateMessageSummaryKind.video,
      12 => PrivateMessageSummaryKind.article,
      13 => PrivateMessageSummaryKind.card,
      14 => PrivateMessageSummaryKind.share,
      _ => PrivateMessageSummaryKind.unknown,
    };
  }
}

class PrivateMessageEmoji {
  final String text;
  final String url;
  final int size;
  final String? gifUrl;

  const PrivateMessageEmoji({
    required this.text,
    required this.url,
    required this.size,
    required this.gifUrl,
  });
}

class PrivateMessagePage {
  final List<PrivateMessage> messages;
  final bool hasMore;
  final int? minSeqno;
  final int? maxSeqno;
  final List<PrivateMessageEmoji> emojiInfos;

  const PrivateMessagePage({
    required this.messages,
    required this.hasMore,
    required this.minSeqno,
    required this.maxSeqno,
    required this.emojiInfos,
  });
}
