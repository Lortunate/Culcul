part of 'dynamic_response.dart';

final class MajorPgc {
  const MajorPgc({
    required this.cover,
    required this.title,
    required this.jumpUrl,
    required this.stat,
    required this.seasonId,
    required this.epid,
    required this.subType,
    required this.type,
  });

  factory MajorPgc.fromJson(Map<String, dynamic> json) {
    return MajorPgc(
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      title: JsonUtils.parseStringWithDefault(json['title']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      stat: MajorStat.fromJson(json['stat'] as Map<String, dynamic>),
      seasonId: (json['season_id'] as num).toInt(),
      epid: (json['epid'] as num).toInt(),
      subType: (json['sub_type'] as num).toInt(),
      type: (json['type'] as num).toInt(),
    );
  }

  final String cover;
  final String title;
  final String jumpUrl;
  final MajorStat stat;
  final int seasonId;
  final int epid;
  final int subType;
  final int type;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorPgc &&
            other.cover == cover &&
            other.title == title &&
            other.jumpUrl == jumpUrl &&
            other.stat == stat &&
            other.seasonId == seasonId &&
            other.epid == epid &&
            other.subType == subType &&
            other.type == type;
  }

  @override
  int get hashCode =>
      Object.hash(cover, title, jumpUrl, stat, seasonId, epid, subType, type);

  @override
  String toString() {
    return 'MajorPgc('
        'cover: $cover, '
        'title: $title, '
        'jumpUrl: $jumpUrl, '
        'stat: $stat, '
        'seasonId: $seasonId, '
        'epid: $epid, '
        'subType: $subType, '
        'type: $type'
        ')';
  }
}

final class MajorCourses {
  const MajorCourses({
    required this.cover,
    required this.title,
    required this.subTitle,
    required this.desc,
    required this.jumpUrl,
    required this.id,
  });

  factory MajorCourses.fromJson(Map<String, dynamic> json) {
    return MajorCourses(
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      title: JsonUtils.parseStringWithDefault(json['title']),
      subTitle: JsonUtils.parseStringWithDefault(json['sub_title']),
      desc: JsonUtils.parseStringWithDefault(json['desc']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      id: (json['id'] as num).toInt(),
    );
  }

  final String cover;
  final String title;
  final String subTitle;
  final String desc;
  final String jumpUrl;
  final int id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorCourses &&
            other.cover == cover &&
            other.title == title &&
            other.subTitle == subTitle &&
            other.desc == desc &&
            other.jumpUrl == jumpUrl &&
            other.id == id;
  }

  @override
  int get hashCode => Object.hash(cover, title, subTitle, desc, jumpUrl, id);

  @override
  String toString() {
    return 'MajorCourses('
        'cover: $cover, '
        'title: $title, '
        'subTitle: $subTitle, '
        'desc: $desc, '
        'jumpUrl: $jumpUrl, '
        'id: $id'
        ')';
  }
}

final class MajorMusic {
  const MajorMusic({
    required this.cover,
    required this.title,
    required this.label,
    required this.jumpUrl,
    required this.id,
  });

  factory MajorMusic.fromJson(Map<String, dynamic> json) {
    return MajorMusic(
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      title: JsonUtils.parseStringWithDefault(json['title']),
      label: JsonUtils.parseStringWithDefault(json['label']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      id: (json['id'] as num).toInt(),
    );
  }

  final String cover;
  final String title;
  final String label;
  final String jumpUrl;
  final int id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorMusic &&
            other.cover == cover &&
            other.title == title &&
            other.label == label &&
            other.jumpUrl == jumpUrl &&
            other.id == id;
  }

  @override
  int get hashCode => Object.hash(cover, title, label, jumpUrl, id);

  @override
  String toString() {
    return 'MajorMusic('
        'cover: $cover, '
        'title: $title, '
        'label: $label, '
        'jumpUrl: $jumpUrl, '
        'id: $id'
        ')';
  }
}

final class MajorOpus {
  MajorOpus({this.title, this.summary, List<OpusPic>? pics, this.jumpUrl})
    : pics = pics == null ? null : List.unmodifiable(pics);

  factory MajorOpus.fromJson(Map<String, dynamic> json) {
    return MajorOpus(
      title: json['title'] as String?,
      summary: json['summary'] == null
          ? null
          : OpusSummary.fromJson(json['summary'] as Map<String, dynamic>),
      pics: (json['pics'] as List<dynamic>?)
          ?.map((item) => OpusPic.fromJson(item as Map<String, dynamic>))
          .toList(),
      jumpUrl: json['jump_url'] as String?,
    );
  }

  final String? title;
  final OpusSummary? summary;
  final List<OpusPic>? pics;
  final String? jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorOpus &&
            other.title == title &&
            other.summary == summary &&
            listEquals(other.pics, pics) &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode =>
      Object.hash(title, summary, pics == null ? null : Object.hashAll(pics!), jumpUrl);

  @override
  String toString() {
    return 'MajorOpus(title: $title, summary: $summary, pics: $pics, jumpUrl: $jumpUrl)';
  }
}

final class OpusSummary {
  OpusSummary({this.text, List<dynamic>? richTextNodes})
    : richTextNodes = richTextNodes == null ? null : List.unmodifiable(richTextNodes);

  factory OpusSummary.fromJson(Map<String, dynamic> json) {
    return OpusSummary(
      text: json['text'] as String?,
      richTextNodes: json['rich_text_nodes'] as List<dynamic>?,
    );
  }

  final String? text;
  final List<dynamic>? richTextNodes;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OpusSummary &&
            other.text == text &&
            listEquals(other.richTextNodes, richTextNodes);
  }

  @override
  int get hashCode =>
      Object.hash(text, richTextNodes == null ? null : Object.hashAll(richTextNodes!));

  @override
  String toString() => 'OpusSummary(text: $text, richTextNodes: $richTextNodes)';
}

final class OpusPic {
  const OpusPic({this.url, this.width, this.height, this.size});

  factory OpusPic.fromJson(Map<String, dynamic> json) {
    return OpusPic(
      url: json['url'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
    );
  }

  final String? url;
  final int? width;
  final int? height;
  final int? size;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OpusPic &&
            other.url == url &&
            other.width == width &&
            other.height == height &&
            other.size == size;
  }

  @override
  int get hashCode => Object.hash(url, width, height, size);

  @override
  String toString() {
    return 'OpusPic(url: $url, width: $width, height: $height, size: $size)';
  }
}

final class MajorLive {
  const MajorLive({
    required this.cover,
    required this.title,
    required this.liveState,
    required this.jumpUrl,
    required this.descFirst,
    required this.descSecond,
  });

  factory MajorLive.fromJson(Map<String, dynamic> json) {
    return MajorLive(
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      title: JsonUtils.parseStringWithDefault(json['title']),
      liveState: (json['live_state'] as num).toInt(),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      descFirst: JsonUtils.parseStringWithDefault(json['desc_first']),
      descSecond: JsonUtils.parseStringWithDefault(json['desc_second']),
    );
  }

  final String cover;
  final String title;
  final int liveState;
  final String jumpUrl;
  final String descFirst;
  final String descSecond;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorLive &&
            other.cover == cover &&
            other.title == title &&
            other.liveState == liveState &&
            other.jumpUrl == jumpUrl &&
            other.descFirst == descFirst &&
            other.descSecond == descSecond;
  }

  @override
  int get hashCode =>
      Object.hash(cover, title, liveState, jumpUrl, descFirst, descSecond);

  @override
  String toString() {
    return 'MajorLive('
        'cover: $cover, '
        'title: $title, '
        'liveState: $liveState, '
        'jumpUrl: $jumpUrl, '
        'descFirst: $descFirst, '
        'descSecond: $descSecond'
        ')';
  }
}

final class MajorLiveRcmd {
  const MajorLiveRcmd({required this.content, required this.reserveType});

  factory MajorLiveRcmd.fromJson(Map<String, dynamic> json) {
    return MajorLiveRcmd(
      content: JsonUtils.parseStringWithDefault(json['content']),
      reserveType: (json['reserve_type'] as num).toInt(),
    );
  }

  final String content;
  final int reserveType;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorLiveRcmd &&
            other.content == content &&
            other.reserveType == reserveType;
  }

  @override
  int get hashCode => Object.hash(content, reserveType);

  @override
  String toString() {
    return 'MajorLiveRcmd(content: $content, reserveType: $reserveType)';
  }
}
