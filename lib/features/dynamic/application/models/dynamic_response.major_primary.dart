part of 'dynamic_response.dart';

final class ModuleDesc {
  ModuleDesc({required this.text, List<dynamic>? richTextNodes})
    : richTextNodes = richTextNodes == null ? null : List.unmodifiable(richTextNodes);

  factory ModuleDesc.fromJson(Map<String, dynamic> json) {
    return ModuleDesc(
      text: JsonUtils.parseStringWithDefault(json['text']),
      richTextNodes: json['rich_text_nodes'] as List<dynamic>?,
    );
  }

  final String text;
  final List<dynamic>? richTextNodes;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleDesc &&
            other.text == text &&
            listEquals(other.richTextNodes, richTextNodes);
  }

  @override
  int get hashCode =>
      Object.hash(text, richTextNodes == null ? null : Object.hashAll(richTextNodes!));

  @override
  String toString() => 'ModuleDesc(text: $text, richTextNodes: $richTextNodes)';
}

final class ModuleMajor {
  const ModuleMajor({
    required this.type,
    this.archive,
    this.draw,
    this.ugcSeason,
    this.article,
    this.common,
    this.pgc,
    this.courses,
    this.music,
    this.opus,
    this.live,
    this.liveRcmd,
  });

  factory ModuleMajor.fromJson(Map<String, dynamic> json) {
    return ModuleMajor(
      type: JsonUtils.parseStringWithDefault(json['type']),
      archive: json['archive'] == null
          ? null
          : MajorArchive.fromJson(json['archive'] as Map<String, dynamic>),
      draw: json['draw'] == null
          ? null
          : MajorDraw.fromJson(json['draw'] as Map<String, dynamic>),
      ugcSeason: json['ugc_season'] == null
          ? null
          : MajorArchive.fromJson(json['ugc_season'] as Map<String, dynamic>),
      article: json['article'] == null
          ? null
          : MajorArticle.fromJson(json['article'] as Map<String, dynamic>),
      common: json['common'] == null
          ? null
          : MajorCommon.fromJson(json['common'] as Map<String, dynamic>),
      pgc: json['pgc'] == null
          ? null
          : MajorPgc.fromJson(json['pgc'] as Map<String, dynamic>),
      courses: json['courses'] == null
          ? null
          : MajorCourses.fromJson(json['courses'] as Map<String, dynamic>),
      music: json['music'] == null
          ? null
          : MajorMusic.fromJson(json['music'] as Map<String, dynamic>),
      opus: json['opus'] == null
          ? null
          : MajorOpus.fromJson(json['opus'] as Map<String, dynamic>),
      live: json['live'] == null
          ? null
          : MajorLive.fromJson(json['live'] as Map<String, dynamic>),
      liveRcmd: json['live_rcmd'] == null
          ? null
          : MajorLiveRcmd.fromJson(json['live_rcmd'] as Map<String, dynamic>),
    );
  }

  final String type;
  final MajorArchive? archive;
  final MajorDraw? draw;
  final MajorArchive? ugcSeason;
  final MajorArticle? article;
  final MajorCommon? common;
  final MajorPgc? pgc;
  final MajorCourses? courses;
  final MajorMusic? music;
  final MajorOpus? opus;
  final MajorLive? live;
  final MajorLiveRcmd? liveRcmd;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleMajor &&
            other.type == type &&
            other.archive == archive &&
            other.draw == draw &&
            other.ugcSeason == ugcSeason &&
            other.article == article &&
            other.common == common &&
            other.pgc == pgc &&
            other.courses == courses &&
            other.music == music &&
            other.opus == opus &&
            other.live == live &&
            other.liveRcmd == liveRcmd;
  }

  @override
  int get hashCode => Object.hash(
    type,
    archive,
    draw,
    ugcSeason,
    article,
    common,
    pgc,
    courses,
    music,
    opus,
    live,
    liveRcmd,
  );

  @override
  String toString() {
    return 'ModuleMajor('
        'type: $type, '
        'archive: $archive, '
        'draw: $draw, '
        'ugcSeason: $ugcSeason, '
        'article: $article, '
        'common: $common, '
        'pgc: $pgc, '
        'courses: $courses, '
        'music: $music, '
        'opus: $opus, '
        'live: $live, '
        'liveRcmd: $liveRcmd'
        ')';
  }
}

final class MajorArchive {
  const MajorArchive({
    required this.cover,
    required this.title,
    required this.desc,
    required this.durationText,
    required this.stat,
    required this.aid,
    required this.bvid,
    required this.jumpUrl,
  });

  factory MajorArchive.fromJson(Map<String, dynamic> json) {
    return MajorArchive(
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      title: JsonUtils.parseStringWithDefault(json['title']),
      desc: JsonUtils.parseStringWithDefault(json['desc']),
      durationText: JsonUtils.parseStringWithDefault(json['duration_text']),
      stat: MajorStat.fromJson(json['stat'] as Map<String, dynamic>),
      aid: JsonUtils.parseStringWithDefault(json['aid']),
      bvid: JsonUtils.parseStringWithDefault(json['bvid']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
    );
  }

  final String cover;
  final String title;
  final String desc;
  final String durationText;
  final MajorStat stat;
  final String aid;
  final String bvid;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorArchive &&
            other.cover == cover &&
            other.title == title &&
            other.desc == desc &&
            other.durationText == durationText &&
            other.stat == stat &&
            other.aid == aid &&
            other.bvid == bvid &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode =>
      Object.hash(cover, title, desc, durationText, stat, aid, bvid, jumpUrl);

  @override
  String toString() {
    return 'MajorArchive('
        'cover: $cover, '
        'title: $title, '
        'desc: $desc, '
        'durationText: $durationText, '
        'stat: $stat, '
        'aid: $aid, '
        'bvid: $bvid, '
        'jumpUrl: $jumpUrl'
        ')';
  }
}

final class MajorDraw {
  MajorDraw({required this.id, required List<DrawItem> items})
    : items = List.unmodifiable(items);

  factory MajorDraw.fromJson(Map<String, dynamic> json) {
    return MajorDraw(
      id: (json['id'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((item) => DrawItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  final int id;
  final List<DrawItem> items;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorDraw && other.id == id && listEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hash(id, Object.hashAll(items));

  @override
  String toString() => 'MajorDraw(id: $id, items: $items)';
}

final class DrawItem {
  const DrawItem({
    required this.src,
    required this.width,
    required this.height,
    required this.size,
  });

  factory DrawItem.fromJson(Map<String, dynamic> json) {
    return DrawItem(
      src: JsonUtils.parseStringWithDefault(json['src']),
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );
  }

  final String src;
  final int width;
  final int height;
  final int size;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DrawItem &&
            other.src == src &&
            other.width == width &&
            other.height == height &&
            other.size == size;
  }

  @override
  int get hashCode => Object.hash(src, width, height, size);

  @override
  String toString() {
    return 'DrawItem(src: $src, width: $width, height: $height, size: $size)';
  }
}

final class MajorArticle {
  MajorArticle({
    required this.id,
    required this.title,
    required this.desc,
    required List<String> covers,
    required this.label,
    required this.jumpUrl,
  }) : covers = List.unmodifiable(covers);

  factory MajorArticle.fromJson(Map<String, dynamic> json) {
    return MajorArticle(
      id: (json['id'] as num).toInt(),
      title: JsonUtils.parseStringWithDefault(json['title']),
      desc: JsonUtils.parseStringWithDefault(json['desc']),
      covers: JsonUtils.parseStringListWithDefault(json['covers']),
      label: JsonUtils.parseStringWithDefault(json['label']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
    );
  }

  final int id;
  final String title;
  final String desc;
  final List<String> covers;
  final String label;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorArticle &&
            other.id == id &&
            other.title == title &&
            other.desc == desc &&
            listEquals(other.covers, covers) &&
            other.label == label &&
            other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, desc, Object.hashAll(covers), label, jumpUrl);

  @override
  String toString() {
    return 'MajorArticle('
        'id: $id, '
        'title: $title, '
        'desc: $desc, '
        'covers: $covers, '
        'label: $label, '
        'jumpUrl: $jumpUrl'
        ')';
  }
}

final class MajorCommon {
  const MajorCommon({
    required this.title,
    required this.desc,
    required this.cover,
    required this.jumpUrl,
    required this.label,
  });

  factory MajorCommon.fromJson(Map<String, dynamic> json) {
    return MajorCommon(
      title: JsonUtils.parseStringWithDefault(json['title']),
      desc: JsonUtils.parseStringWithDefault(json['desc']),
      cover: JsonUtils.parseStringWithDefault(json['cover']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
      label: JsonUtils.parseStringWithDefault(json['label']),
    );
  }

  final String title;
  final String desc;
  final String cover;
  final String jumpUrl;
  final String label;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorCommon &&
            other.title == title &&
            other.desc == desc &&
            other.cover == cover &&
            other.jumpUrl == jumpUrl &&
            other.label == label;
  }

  @override
  int get hashCode => Object.hash(title, desc, cover, jumpUrl, label);

  @override
  String toString() {
    return 'MajorCommon('
        'title: $title, '
        'desc: $desc, '
        'cover: $cover, '
        'jumpUrl: $jumpUrl, '
        'label: $label'
        ')';
  }
}

final class MajorStat {
  const MajorStat({required this.play, required this.danmaku});

  factory MajorStat.fromJson(Map<String, dynamic> json) {
    return MajorStat(
      play: JsonUtils.parseStringWithDefault(json['play']),
      danmaku: JsonUtils.parseStringWithDefault(json['danmaku']),
    );
  }

  final String play;
  final String danmaku;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MajorStat && other.play == play && other.danmaku == danmaku;
  }

  @override
  int get hashCode => Object.hash(play, danmaku);

  @override
  String toString() => 'MajorStat(play: $play, danmaku: $danmaku)';
}

final class ModuleStat {
  const ModuleStat({required this.like, required this.comment, required this.forward});

  factory ModuleStat.fromJson(Map<String, dynamic> json) {
    return ModuleStat(
      like: StatLike.fromJson(json['like'] as Map<String, dynamic>),
      comment: StatCommon.fromJson(json['comment'] as Map<String, dynamic>),
      forward: StatCommon.fromJson(json['forward'] as Map<String, dynamic>),
    );
  }

  final StatLike like;
  final StatCommon comment;
  final StatCommon forward;

  ModuleStat copyWith({StatLike? like, StatCommon? comment, StatCommon? forward}) {
    return ModuleStat(
      like: like ?? this.like,
      comment: comment ?? this.comment,
      forward: forward ?? this.forward,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleStat &&
            other.like == like &&
            other.comment == comment &&
            other.forward == forward;
  }

  @override
  int get hashCode => Object.hash(like, comment, forward);

  @override
  String toString() {
    return 'ModuleStat(like: $like, comment: $comment, forward: $forward)';
  }
}

final class StatLike {
  const StatLike({required this.count, required this.status});

  factory StatLike.fromJson(Map<String, dynamic> json) {
    return StatLike(
      count: (json['count'] as num).toInt(),
      status: json['status'] as bool,
    );
  }

  final int count;
  final bool status;

  StatLike copyWith({int? count, bool? status}) {
    return StatLike(count: count ?? this.count, status: status ?? this.status);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StatLike && other.count == count && other.status == status;
  }

  @override
  int get hashCode => Object.hash(count, status);

  @override
  String toString() => 'StatLike(count: $count, status: $status)';
}

final class StatCommon {
  const StatCommon({required this.count});

  factory StatCommon.fromJson(Map<String, dynamic> json) {
    return StatCommon(count: (json['count'] as num).toInt());
  }

  final int count;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is StatCommon && other.count == count;
  }

  @override
  int get hashCode => count.hashCode;

  @override
  String toString() => 'StatCommon(count: $count)';
}

final class ModuleTopic {
  const ModuleTopic({required this.name, required this.jumpUrl});

  factory ModuleTopic.fromJson(Map<String, dynamic> json) {
    return ModuleTopic(
      name: JsonUtils.parseStringWithDefault(json['name']),
      jumpUrl: JsonUtils.parseStringWithDefault(json['jump_url']),
    );
  }

  final String name;
  final String jumpUrl;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleTopic && other.name == name && other.jumpUrl == jumpUrl;
  }

  @override
  int get hashCode => Object.hash(name, jumpUrl);

  @override
  String toString() => 'ModuleTopic(name: $name, jumpUrl: $jumpUrl)';
}
