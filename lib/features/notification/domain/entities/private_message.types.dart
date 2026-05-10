part of 'private_message.dart';

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
  const PrivateMessageContent._(this._data);

  final Map<String, dynamic> _data;

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

class PrivateMessageEmoji {
  final String text;
  final String url;
  final int size;
  final String? gifUrl;

  const PrivateMessageEmoji({
    required this.text,
    required this.url,
    this.size = 1,
    this.gifUrl,
  });
}
