import 'package:flutter/foundation.dart' show listEquals;

final class PlayUrl {
  PlayUrl({
    required this.format,
    required this.quality,
    required this.timeLength,
    required this.acceptFormat,
    required List<String> acceptDescription,
    required List<int> acceptQuality,
    required this.videoCodecId,
    required List<Durl> durl,
    this.dash,
    List<SupportFormat> supportFormats = const [],
  }) : acceptDescription = List<String>.unmodifiable(acceptDescription),
       acceptQuality = List<int>.unmodifiable(acceptQuality),
       durl = List<Durl>.unmodifiable(durl),
       supportFormats = List<SupportFormat>.unmodifiable(supportFormats);

  factory PlayUrl.fromJson(Map<String, dynamic> json) {
    return PlayUrl(
      format: json['format'] as String,
      quality: (json['quality'] as num).toInt(),
      timeLength: (json['timelength'] as num).toInt(),
      acceptFormat: json['accept_format'] as String,
      acceptDescription: (json['accept_description'] as List<dynamic>)
          .map((e) => e as String)
          .toList(growable: false),
      acceptQuality: (json['accept_quality'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(growable: false),
      videoCodecId: (json['video_codecid'] as num).toInt(),
      durl: (json['durl'] as List<dynamic>)
          .map((e) => Durl.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      dash: json['dash'] == null
          ? null
          : DashInfo.fromJson(json['dash'] as Map<String, dynamic>),
      supportFormats:
          (json['support_formats'] as List<dynamic>?)
              ?.map((e) => SupportFormat.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
    );
  }

  final String format;
  final int quality;
  final int timeLength;
  final String acceptFormat;
  final List<String> acceptDescription;
  final List<int> acceptQuality;
  final int videoCodecId;
  final List<Durl> durl;
  final DashInfo? dash;
  final List<SupportFormat> supportFormats;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayUrl &&
            runtimeType == other.runtimeType &&
            format == other.format &&
            quality == other.quality &&
            timeLength == other.timeLength &&
            acceptFormat == other.acceptFormat &&
            listEquals(acceptDescription, other.acceptDescription) &&
            listEquals(acceptQuality, other.acceptQuality) &&
            videoCodecId == other.videoCodecId &&
            listEquals(durl, other.durl) &&
            dash == other.dash &&
            listEquals(supportFormats, other.supportFormats);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      format,
      quality,
      timeLength,
      acceptFormat,
      Object.hashAll(acceptDescription),
      Object.hashAll(acceptQuality),
      videoCodecId,
      Object.hashAll(durl),
      dash,
      Object.hashAll(supportFormats),
    );
  }

  @override
  String toString() {
    return 'PlayUrl('
        'format: $format, '
        'quality: $quality, '
        'timeLength: $timeLength, '
        'acceptFormat: $acceptFormat, '
        'acceptDescription: $acceptDescription, '
        'acceptQuality: $acceptQuality, '
        'videoCodecId: $videoCodecId, '
        'durl: $durl, '
        'dash: $dash, '
        'supportFormats: $supportFormats'
        ')';
  }
}

final class DashInfo {
  DashInfo({List<DashStream> audio = const []})
    : audio = List<DashStream>.unmodifiable(audio);

  factory DashInfo.fromJson(Map<String, dynamic> json) {
    return DashInfo(
      audio:
          (json['audio'] as List<dynamic>?)
              ?.map((e) => DashStream.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
    );
  }

  final List<DashStream> audio;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DashInfo &&
            runtimeType == other.runtimeType &&
            listEquals(audio, other.audio);
  }

  @override
  int get hashCode => Object.hash(runtimeType, Object.hashAll(audio));

  @override
  String toString() => 'DashInfo(audio: $audio)';
}

final class DashStream {
  DashStream({
    required this.id,
    required this.baseUrl,
    List<String> backupUrl = const [],
    this.bandwidth = 0,
  }) : backupUrl = List<String>.unmodifiable(backupUrl);

  factory DashStream.fromJson(Map<String, dynamic> json) {
    return DashStream(
      id: (json['id'] as num).toInt(),
      baseUrl: (json['baseUrl'] ?? json['base_url']) as String,
      backupUrl:
          ((json['backupUrl'] ?? json['backup_url']) as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(growable: false) ??
          const [],
      bandwidth: (json['bandwidth'] as num?)?.toInt() ?? 0,
    );
  }

  final int id;
  final String baseUrl;
  final List<String> backupUrl;
  final int bandwidth;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DashStream &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            baseUrl == other.baseUrl &&
            listEquals(backupUrl, other.backupUrl) &&
            bandwidth == other.bandwidth;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, baseUrl, Object.hashAll(backupUrl), bandwidth);
  }

  @override
  String toString() {
    return 'DashStream('
        'id: $id, '
        'baseUrl: $baseUrl, '
        'backupUrl: $backupUrl, '
        'bandwidth: $bandwidth'
        ')';
  }
}

final class Durl {
  Durl({
    required this.order,
    required this.length,
    required this.size,
    required this.url,
    List<String> backupUrl = const [],
  }) : backupUrl = List<String>.unmodifiable(backupUrl);

  factory Durl.fromJson(Map<String, dynamic> json) {
    return Durl(
      order: (json['order'] as num).toInt(),
      length: (json['length'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      url: json['url'] as String,
      backupUrl:
          (json['backup_url'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(growable: false) ??
          const [],
    );
  }

  final int order;
  final int length;
  final int size;
  final String url;
  final List<String> backupUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Durl &&
            runtimeType == other.runtimeType &&
            order == other.order &&
            length == other.length &&
            size == other.size &&
            url == other.url &&
            listEquals(backupUrl, other.backupUrl);
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, order, length, size, url, Object.hashAll(backupUrl));
  }

  @override
  String toString() {
    return 'Durl('
        'order: $order, '
        'length: $length, '
        'size: $size, '
        'url: $url, '
        'backupUrl: $backupUrl'
        ')';
  }
}

final class SupportFormat {
  SupportFormat({
    required this.quality,
    required this.format,
    required this.newDescription,
    required this.displayDesc,
    required this.superscript,
    List<String> codecs = const [],
  }) : codecs = List<String>.unmodifiable(codecs);

  factory SupportFormat.fromJson(Map<String, dynamic> json) {
    return SupportFormat(
      quality: (json['quality'] as num).toInt(),
      format: json['format'] as String,
      newDescription: json['new_description'] as String,
      displayDesc: json['display_desc'] as String,
      superscript: json['superscript'] as String,
      codecs:
          (json['codecs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(growable: false) ??
          const [],
    );
  }

  final int quality;
  final String format;
  final String newDescription;
  final String displayDesc;
  final String superscript;
  final List<String> codecs;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SupportFormat &&
            runtimeType == other.runtimeType &&
            quality == other.quality &&
            format == other.format &&
            newDescription == other.newDescription &&
            displayDesc == other.displayDesc &&
            superscript == other.superscript &&
            listEquals(codecs, other.codecs);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      quality,
      format,
      newDescription,
      displayDesc,
      superscript,
      Object.hashAll(codecs),
    );
  }

  @override
  String toString() {
    return 'SupportFormat('
        'quality: $quality, '
        'format: $format, '
        'newDescription: $newDescription, '
        'displayDesc: $displayDesc, '
        'superscript: $superscript, '
        'codecs: $codecs'
        ')';
  }
}
