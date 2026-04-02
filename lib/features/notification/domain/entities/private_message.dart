import 'dart:convert';

enum PrivateMessageReceiverType {
  unknown(0),
  user(1),
  group(2);

  const PrivateMessageReceiverType(this.value);

  final int value;

  static PrivateMessageReceiverType fromValue(int value) {
    return values.firstWhere(
      (type) => type.value == value,
      orElse: () => PrivateMessageReceiverType.unknown,
    );
  }
}

enum PrivateMessageType {
  unknown(0),
  text(1),
  image(2),
  withdrawn(5),
  imageVariant(6),
  notice(10),
  video(11),
  article(12),
  card(13),
  share(14),
  systemTip(18);

  const PrivateMessageType(this.value);

  final int value;

  static PrivateMessageType fromValue(int value) {
    return values.firstWhere(
      (type) => type.value == value,
      orElse: () => PrivateMessageType.unknown,
    );
  }

  bool get isImage =>
      this == PrivateMessageType.image || this == PrivateMessageType.imageVariant;
}

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

class PrivateMessageContent {
  final Map<String, dynamic> _data;

  const PrivateMessageContent._(this._data);

  factory PrivateMessageContent.fromRaw(dynamic rawContent) {
    if (rawContent is PrivateMessageContent) {
      return rawContent;
    }
    if (rawContent is Map<String, dynamic>) {
      return PrivateMessageContent._(Map<String, dynamic>.from(rawContent));
    }
    if (rawContent is Map) {
      return PrivateMessageContent._(Map<String, dynamic>.from(rawContent));
    }
    if (rawContent is String) {
      try {
        final decoded = jsonDecode(rawContent);
        if (decoded is Map) {
          return PrivateMessageContent._(Map<String, dynamic>.from(decoded));
        }
      } catch (_) {
        return const PrivateMessageContent._({});
      }
    }
    return const PrivateMessageContent._({});
  }

  factory PrivateMessageContent.text(String value) {
    return PrivateMessageContent._({'content': value});
  }

  factory PrivateMessageContent.image({
    required String url,
    required int height,
    required int width,
    required String imageType,
    required num size,
    int original = 1,
  }) {
    return PrivateMessageContent._({
      'url': url,
      'height': height,
      'width': width,
      'imageType': imageType,
      'original': original,
      'size': size,
    });
  }

  Map<String, dynamic> toRawMap() => Map<String, dynamic>.from(_data);

  String? get primaryText => _readString('content') ?? _readString('text');

  String? get title => _readString('title');

  String? get imageUrl => _readString('url');

  String? get linkUrl =>
      _readString('url') ?? _readString('uri') ?? _readString('jump_uri');

  String? get jumpText => _readString('jump_text');

  String? get fallbackText => primaryText ?? title;

  List<String>? get systemTipTexts {
    final innerContentStr = _readString('content');
    if (innerContentStr == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(innerContentStr);
      if (decoded is! List) {
        return null;
      }
      return decoded
          .whereType<Map>()
          .map((item) => item['text']?.toString() ?? '')
          .where((text) => text.isNotEmpty)
          .toList();
    } catch (_) {
      return null;
    }
  }

  String? _readString(String key) => _data[key]?.toString();
}

class PrivateMessage {
  final int senderUid;
  final PrivateMessageReceiverType receiverType;
  final int receiverId;
  final PrivateMessageType type;
  final PrivateMessageContent content;
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
    required this.type,
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
    final json = content.toRawMap();
    return json.isEmpty ? null : json;
  }

  bool isMe(int currentUid) => senderUid == currentUid;

  String? get primaryText => content.primaryText;

  String? get titleText => content.title;

  String get textContent {
    if (type == PrivateMessageType.text) {
      return content.primaryText ?? '';
    }
    return '';
  }

  String? get imageUrl {
    if (type.isImage) {
      return content.imageUrl;
    }
    return null;
  }

  List<String>? get systemTipTexts {
    if (type == PrivateMessageType.systemTip) {
      return content.systemTipTexts;
    }
    return null;
  }

  String? get linkUrl => content.linkUrl;

  String? get jumpText => content.jumpText;

  String? get fallbackSummaryText => content.fallbackText;

  bool get isWithdrawn => msgStatus == 1 || type == PrivateMessageType.withdrawn;

  PrivateMessageSummaryKind get summaryKind {
    if (isWithdrawn) {
      return PrivateMessageSummaryKind.withdrawn;
    }

    return switch (type) {
      PrivateMessageType.text => PrivateMessageSummaryKind.text,
      PrivateMessageType.image ||
      PrivateMessageType.imageVariant => PrivateMessageSummaryKind.image,
      PrivateMessageType.notice => PrivateMessageSummaryKind.notice,
      PrivateMessageType.video => PrivateMessageSummaryKind.video,
      PrivateMessageType.article => PrivateMessageSummaryKind.article,
      PrivateMessageType.card => PrivateMessageSummaryKind.card,
      PrivateMessageType.share => PrivateMessageSummaryKind.share,
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
