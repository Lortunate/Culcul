import 'package:culcul/core/utils/json_utils.dart';
import 'package:flutter/foundation.dart' show listEquals;

final class VideoSubtitles {
  VideoSubtitles({List<SubtitleInfo> list = const []})
    : list = List<SubtitleInfo>.unmodifiable(list);

  factory VideoSubtitles.fromJson(Map<String, dynamic> json) {
    return VideoSubtitles(
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => SubtitleInfo.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
    );
  }

  final List<SubtitleInfo> list;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoSubtitles &&
            runtimeType == other.runtimeType &&
            listEquals(list, other.list);
  }

  @override
  int get hashCode => Object.hash(runtimeType, Object.hashAll(list));

  @override
  String toString() => 'VideoSubtitles(list: $list)';
}

final class SubtitleInfo {
  const SubtitleInfo({
    required this.id,
    required this.lan,
    required this.lanDoc,
    required this.subtitleUrl,
    this.isLock = false,
    this.idStr,
    this.type = 0,
  });

  factory SubtitleInfo.fromJson(Map<String, dynamic> json) {
    return SubtitleInfo(
      id:
          JsonUtils.parseInt(json['id']) ??
          (throw const FormatException('Expected numeric id')),
      lan: json['lan'] as String,
      lanDoc: json['lan_doc'] as String,
      subtitleUrl: json['subtitle_url'] as String,
      isLock: json['is_lock'] as bool? ?? false,
      idStr: json['id_str'] as String?,
      type: (json['type'] as num?)?.toInt() ?? 0,
    );
  }

  final int id;
  final String lan;
  final String lanDoc;
  final String subtitleUrl;
  final bool isLock;
  final String? idStr;
  final int type;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SubtitleInfo &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            lan == other.lan &&
            lanDoc == other.lanDoc &&
            subtitleUrl == other.subtitleUrl &&
            isLock == other.isLock &&
            idStr == other.idStr &&
            type == other.type;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, lan, lanDoc, subtitleUrl, isLock, idStr, type);
  }

  @override
  String toString() {
    return 'SubtitleInfo('
        'id: $id, '
        'lan: $lan, '
        'lanDoc: $lanDoc, '
        'subtitleUrl: $subtitleUrl, '
        'isLock: $isLock, '
        'idStr: $idStr, '
        'type: $type'
        ')';
  }
}

final class SubtitleContent {
  SubtitleContent({
    this.fontSize,
    this.fontColor,
    this.backgroundAlpha,
    this.backgroundColor,
    List<SubtitleItem> body = const [],
  }) : body = List<SubtitleItem>.unmodifiable(body);

  factory SubtitleContent.fromJson(Map<String, dynamic> json) {
    return SubtitleContent(
      fontSize: (json['font_size'] as num?)?.toDouble(),
      fontColor: json['font_color'] as String?,
      backgroundAlpha: (json['background_alpha'] as num?)?.toDouble(),
      backgroundColor: json['background_color'] as String?,
      body:
          (json['body'] as List<dynamic>?)
              ?.map((e) => SubtitleItem.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
    );
  }

  final double? fontSize;
  final String? fontColor;
  final double? backgroundAlpha;
  final String? backgroundColor;
  final List<SubtitleItem> body;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SubtitleContent &&
            runtimeType == other.runtimeType &&
            fontSize == other.fontSize &&
            fontColor == other.fontColor &&
            backgroundAlpha == other.backgroundAlpha &&
            backgroundColor == other.backgroundColor &&
            listEquals(body, other.body);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      fontSize,
      fontColor,
      backgroundAlpha,
      backgroundColor,
      Object.hashAll(body),
    );
  }

  @override
  String toString() {
    return 'SubtitleContent('
        'fontSize: $fontSize, '
        'fontColor: $fontColor, '
        'backgroundAlpha: $backgroundAlpha, '
        'backgroundColor: $backgroundColor, '
        'body: $body'
        ')';
  }
}

final class SubtitleItem {
  const SubtitleItem({
    required this.from,
    required this.to,
    required this.location,
    required this.content,
  });

  factory SubtitleItem.fromJson(Map<String, dynamic> json) {
    return SubtitleItem(
      from: _jsonDouble(json['from']),
      to: _jsonDouble(json['to']),
      location:
          JsonUtils.parseInt(json['location']) ??
          (throw const FormatException('Expected numeric location')),
      content: json['content'] as String,
    );
  }

  final double from;
  final double to;
  final int location;
  final String content;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SubtitleItem &&
            runtimeType == other.runtimeType &&
            from == other.from &&
            to == other.to &&
            location == other.location &&
            content == other.content;
  }

  @override
  int get hashCode => Object.hash(runtimeType, from, to, location, content);

  @override
  String toString() {
    return 'SubtitleItem(from: $from, to: $to, location: $location, content: $content)';
  }
}

double _jsonDouble(Object? value) => (value as num).toDouble();
