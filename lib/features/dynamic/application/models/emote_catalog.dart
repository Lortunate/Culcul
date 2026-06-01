import 'package:culcul/core/utils/json_utils.dart';

class EmoteCatalogPackage {
  final int id;
  final String text;
  final String url;
  final List<EmoteCatalogItem> emotes;

  const EmoteCatalogPackage({
    required this.id,
    required this.text,
    required this.url,
    required this.emotes,
  });

  factory EmoteCatalogPackage.fromObject(Object? value) {
    final json = JsonUtils.asStringKeyedMap(value);
    if (json == null) {
      throw const FormatException('Expected JSON object');
    }
    return EmoteCatalogPackage.fromJson(json);
  }

  factory EmoteCatalogPackage.fromJson(Map<String, dynamic> json) {
    final emotesJson = json['emote'];
    if (emotesJson is! List) {
      throw const FormatException('Missing emote list');
    }

    return EmoteCatalogPackage(
      id:
          JsonUtils.parseInt(json['id']) ??
          (throw const FormatException('Expected numeric id')),
      text:
          json['text'] as String? ??
          (throw const FormatException('Expected string text')),
      url: json['url'] as String? ?? (throw const FormatException('Expected string url')),
      emotes: [
        for (final emote in emotesJson)
          EmoteCatalogItem.fromJson(
            JsonUtils.asStringKeyedMap(emote) ??
                (throw const FormatException('Expected JSON object')),
          ),
      ],
    );
  }
}

class EmoteCatalogItem {
  final int id;
  final String text;
  final String url;

  const EmoteCatalogItem({required this.id, required this.text, required this.url});

  factory EmoteCatalogItem.fromJson(Map<String, dynamic> json) {
    return EmoteCatalogItem(
      id:
          JsonUtils.parseInt(json['id']) ??
          (throw const FormatException('Expected numeric id')),
      text:
          json['text'] as String? ??
          (throw const FormatException('Expected string text')),
      url: json['url'] as String? ?? (throw const FormatException('Expected string url')),
    );
  }
}
