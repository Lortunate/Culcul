import 'package:flutter/foundation.dart' show listEquals;

final class LivePlayUrlModel {
  LivePlayUrlModel({
    required this.currentQuality,
    required List<String> acceptQuality,
    required this.currentQn,
    required List<LiveQualityDescription> qualityDescription,
    required List<LiveStreamUrl> durl,
  }) : acceptQuality = List<String>.unmodifiable(acceptQuality),
       qualityDescription = List<LiveQualityDescription>.unmodifiable(qualityDescription),
       durl = List<LiveStreamUrl>.unmodifiable(durl);

  factory LivePlayUrlModel.fromJson(Map<String, dynamic> json) {
    return LivePlayUrlModel(
      currentQuality: (json['current_quality'] as num).toInt(),
      acceptQuality: (json['accept_quality'] as List<dynamic>)
          .map((e) => e as String)
          .toList(growable: false),
      currentQn: (json['current_qn'] as num).toInt(),
      qualityDescription: (json['quality_description'] as List<dynamic>)
          .map((e) => LiveQualityDescription.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      durl: (json['durl'] as List<dynamic>)
          .map((e) => LiveStreamUrl.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  final int currentQuality;
  final List<String> acceptQuality;
  final int currentQn;
  final List<LiveQualityDescription> qualityDescription;
  final List<LiveStreamUrl> durl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LivePlayUrlModel &&
            runtimeType == other.runtimeType &&
            currentQuality == other.currentQuality &&
            listEquals(acceptQuality, other.acceptQuality) &&
            currentQn == other.currentQn &&
            listEquals(qualityDescription, other.qualityDescription) &&
            listEquals(durl, other.durl);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      currentQuality,
      Object.hashAll(acceptQuality),
      currentQn,
      Object.hashAll(qualityDescription),
      Object.hashAll(durl),
    );
  }

  @override
  String toString() {
    return 'LivePlayUrlModel('
        'currentQuality: $currentQuality, '
        'acceptQuality: $acceptQuality, '
        'currentQn: $currentQn, '
        'qualityDescription: $qualityDescription, '
        'durl: $durl'
        ')';
  }
}

final class LiveQualityDescription {
  const LiveQualityDescription({required this.qn, required this.desc});

  factory LiveQualityDescription.fromJson(Map<String, dynamic> json) {
    return LiveQualityDescription(
      qn: (json['qn'] as num).toInt(),
      desc: json['desc'] as String,
    );
  }

  final int qn;
  final String desc;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveQualityDescription &&
            runtimeType == other.runtimeType &&
            qn == other.qn &&
            desc == other.desc;
  }

  @override
  int get hashCode => Object.hash(runtimeType, qn, desc);

  @override
  String toString() => 'LiveQualityDescription(qn: $qn, desc: $desc)';
}

final class LiveStreamUrl {
  const LiveStreamUrl({
    required this.url,
    required this.length,
    required this.order,
    required this.streamType,
    required this.p2pType,
  });

  factory LiveStreamUrl.fromJson(Map<String, dynamic> json) {
    return LiveStreamUrl(
      url: json['url'] as String,
      length: (json['length'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      streamType: (json['stream_type'] as num).toInt(),
      p2pType: (json['p2p_type'] as num).toInt(),
    );
  }

  final String url;
  final int length;
  final int order;
  final int streamType;
  final int p2pType;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveStreamUrl &&
            runtimeType == other.runtimeType &&
            url == other.url &&
            length == other.length &&
            order == other.order &&
            streamType == other.streamType &&
            p2pType == other.p2pType;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, url, length, order, streamType, p2pType);
  }

  @override
  String toString() {
    return 'LiveStreamUrl('
        'url: $url, '
        'length: $length, '
        'order: $order, '
        'streamType: $streamType, '
        'p2pType: $p2pType'
        ')';
  }
}
