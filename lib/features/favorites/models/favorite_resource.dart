import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/features/favorites/models/favorite_folder.dart';
import 'package:flutter/foundation.dart' show listEquals;

final class FavoriteResourceStats {
  const FavoriteResourceStats({
    required this.collect,
    required this.play,
    required this.danmaku,
  });

  factory FavoriteResourceStats.fromJson(Map<String, dynamic> json) {
    return FavoriteResourceStats(
      collect: (json['collect'] as num).toInt(),
      play: (json['play'] as num).toInt(),
      danmaku: (json['danmaku'] as num).toInt(),
    );
  }

  final int collect;
  final int play;
  final int danmaku;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteResourceStats &&
            runtimeType == other.runtimeType &&
            collect == other.collect &&
            play == other.play &&
            danmaku == other.danmaku;
  }

  @override
  int get hashCode => Object.hash(runtimeType, collect, play, danmaku);

  @override
  String toString() {
    return 'FavoriteResourceStats(collect: $collect, play: $play, danmaku: $danmaku)';
  }
}

final class FavoriteResource {
  const FavoriteResource({
    required this.id,
    required this.type,
    required this.title,
    required this.cover,
    required this.intro,
    required this.page,
    required this.duration,
    required this.upper,
    required this.attr,
    required this.stats,
    required this.link,
    required this.ctime,
    required this.pubtime,
    required this.favTime,
    required this.bvId,
    required this.bvid,
  });

  factory FavoriteResource.fromJson(Map<String, dynamic> json) {
    return FavoriteResource(
      id: (json['id'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      title: json['title'] as String,
      cover: json['cover'] as String,
      intro: json['intro'] as String,
      page: (json['page'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      upper: VideoOwner.fromJson(json['upper'] as Map<String, dynamic>),
      attr: (json['attr'] as num).toInt(),
      stats: FavoriteResourceStats.fromJson(json['cnt_info'] as Map<String, dynamic>),
      link: json['link'] as String,
      ctime: (json['ctime'] as num).toInt(),
      pubtime: (json['pubtime'] as num).toInt(),
      favTime: (json['fav_time'] as num).toInt(),
      bvId: json['bv_id'] as String?,
      bvid: json['bvid'] as String?,
    );
  }

  final int id;
  final int type;
  final String title;
  final String cover;
  final String intro;
  final int page;
  final int duration;
  final VideoOwner upper;
  final int attr;
  final FavoriteResourceStats stats;
  final String link;
  final int ctime;
  final int pubtime;
  final int favTime;
  final String? bvId;
  final String? bvid;

  String? get preferredBvid => bvid ?? bvId;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteResource &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            type == other.type &&
            title == other.title &&
            cover == other.cover &&
            intro == other.intro &&
            page == other.page &&
            duration == other.duration &&
            upper == other.upper &&
            attr == other.attr &&
            stats == other.stats &&
            link == other.link &&
            ctime == other.ctime &&
            pubtime == other.pubtime &&
            favTime == other.favTime &&
            bvId == other.bvId &&
            bvid == other.bvid;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      type,
      title,
      cover,
      intro,
      page,
      duration,
      upper,
      attr,
      stats,
      link,
      ctime,
      pubtime,
      favTime,
      bvId,
      bvid,
    );
  }

  @override
  String toString() {
    return 'FavoriteResource('
        'id: $id, '
        'type: $type, '
        'title: $title, '
        'cover: $cover, '
        'intro: $intro, '
        'page: $page, '
        'duration: $duration, '
        'upper: $upper, '
        'attr: $attr, '
        'stats: $stats, '
        'link: $link, '
        'ctime: $ctime, '
        'pubtime: $pubtime, '
        'favTime: $favTime, '
        'bvId: $bvId, '
        'bvid: $bvid'
        ')';
  }
}

final class FavoriteResourcePage {
  FavoriteResourcePage({
    required this.info,
    required List<FavoriteResource> medias,
    required this.hasMore,
  }) : medias = List<FavoriteResource>.unmodifiable(medias);

  final FavoriteFolder info;
  final List<FavoriteResource> medias;
  final bool hasMore;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteResourcePage &&
            runtimeType == other.runtimeType &&
            info == other.info &&
            listEquals(medias, other.medias) &&
            hasMore == other.hasMore;
  }

  @override
  int get hashCode => Object.hash(runtimeType, info, Object.hashAll(medias), hasMore);

  @override
  String toString() {
    return 'FavoriteResourcePage(info: $info, medias: $medias, hasMore: $hasMore)';
  }
}
