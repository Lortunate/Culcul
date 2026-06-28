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

  String? get primaryText => _data['content']?.toString() ?? _data['text']?.toString();
  String? get title => _data['title']?.toString();
  String? get imageUrl => _data['url']?.toString();
  String? get linkUrl =>
      _data['url']?.toString() ??
      _data['uri']?.toString() ??
      _data['jump_uri']?.toString();
  String? get jumpText => _data['jump_text']?.toString();
  String? get fallbackText => primaryText ?? title;

  List<String>? get systemTipTexts {
    final innerContentStr = _data['content']?.toString();
    if (innerContentStr == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(innerContentStr);
      if (decoded is! List) {
        return null;
      }
      return decoded
          .whereType<Map<String, dynamic>>()
          .map((item) => item['text']?.toString() ?? '')
          .where((text) => text.isNotEmpty)
          .toList();
    } catch (_) {
      return null;
    }
  }
}

final class PrivateMessageEmoji {
  const PrivateMessageEmoji({
    required String text,
    required String url,
    int size = 1,
    String? gifUrl,
  }) : this._(text: text, url: url, size: size, gifUrl: gifUrl);

  const PrivateMessageEmoji._({
    required this.text,
    required this.url,
    required this.size,
    this.gifUrl,
  });

  factory PrivateMessageEmoji.fromJson(Map<String, dynamic> json) {
    return PrivateMessageEmoji(
      text: json['text'] as String,
      url: json['url'] as String,
      size: (json['size'] as num?)?.toInt() ?? 1,
      gifUrl: json['gif_url'] as String?,
    );
  }

  final String text;
  final String url;
  final int size;
  final String? gifUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateMessageEmoji &&
            runtimeType == other.runtimeType &&
            text == other.text &&
            url == other.url &&
            size == other.size &&
            gifUrl == other.gifUrl;
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, url, size, gifUrl);

  @override
  String toString() {
    return 'PrivateMessageEmoji('
        'text: $text, '
        'url: $url, '
        'size: $size, '
        'gifUrl: $gifUrl'
        ')';
  }
}
