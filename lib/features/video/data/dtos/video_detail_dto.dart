import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/features/video/application/models/subtitle.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show listEquals;

const _deepEquality = DeepCollectionEquality();

final class VideoDetail {
  VideoDetail({
    required this.bvid,
    required this.aid,
    required this.videos,
    required this.tid,
    required this.tname,
    required this.copyright,
    required this.pic,
    required this.title,
    required this.pubDate,
    required this.ctime,
    required this.desc,
    required this.owner,
    required this.stat,
    this.dimension = const VideoDimension(),
    List<VideoPage> pages = const [],
    this.subtitle,
    List<VideoTag> tag = const [],
    this.reqUser,
  }) : pages = List<VideoPage>.unmodifiable(pages),
       tag = List<VideoTag>.unmodifiable(tag);

  factory VideoDetail.fromJson(Map<String, dynamic> json) {
    return VideoDetail(
      bvid: json['bvid'] as String,
      aid: (json['aid'] as num).toInt(),
      videos: (json['videos'] as num).toInt(),
      tid: (json['tid'] as num).toInt(),
      tname: json['tname'] as String,
      copyright: json['copyright'],
      pic: json['pic'] as String,
      title: json['title'] as String,
      pubDate: (json['pubdate'] as num).toInt(),
      ctime: (json['ctime'] as num).toInt(),
      desc: json['desc'] as String,
      owner: VideoOwner.fromJson(json['owner'] as Map<String, dynamic>),
      stat: VideoStat.fromJson(json['stat'] as Map<String, dynamic>),
      dimension: json['dimension'] == null
          ? const VideoDimension()
          : VideoDimension.fromJson(json['dimension'] as Map<String, dynamic>),
      pages:
          (json['pages'] as List<dynamic>?)
              ?.map((e) => VideoPage.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
      subtitle: json['subtitle'] == null
          ? null
          : VideoSubtitles.fromJson(json['subtitle'] as Map<String, dynamic>),
      tag:
          (json['tag'] as List<dynamic>?)
              ?.map((e) => VideoTag.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
      reqUser: json['req_user'] == null
          ? null
          : ReqUser.fromJson(json['req_user'] as Map<String, dynamic>),
    );
  }

  final String bvid;
  final int aid;
  final int videos;
  final int tid;
  final String tname;
  final dynamic copyright;
  final String pic;
  final String title;
  final int pubDate;
  final int ctime;
  final String desc;
  final VideoOwner owner;
  final VideoStat stat;
  final VideoDimension dimension;
  final List<VideoPage> pages;
  final VideoSubtitles? subtitle;
  final List<VideoTag> tag;
  final ReqUser? reqUser;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoDetail &&
            runtimeType == other.runtimeType &&
            bvid == other.bvid &&
            aid == other.aid &&
            videos == other.videos &&
            tid == other.tid &&
            tname == other.tname &&
            _deepEquality.equals(copyright, other.copyright) &&
            pic == other.pic &&
            title == other.title &&
            pubDate == other.pubDate &&
            ctime == other.ctime &&
            desc == other.desc &&
            owner == other.owner &&
            stat == other.stat &&
            dimension == other.dimension &&
            listEquals(pages, other.pages) &&
            subtitle == other.subtitle &&
            listEquals(tag, other.tag) &&
            reqUser == other.reqUser;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      bvid,
      aid,
      videos,
      tid,
      tname,
      _deepEquality.hash(copyright),
      pic,
      title,
      pubDate,
      ctime,
      desc,
      owner,
      stat,
      dimension,
      Object.hashAll(pages),
      subtitle,
      Object.hashAll(tag),
      reqUser,
    );
  }

  @override
  String toString() {
    return 'VideoDetail('
        'bvid: $bvid, '
        'aid: $aid, '
        'videos: $videos, '
        'tid: $tid, '
        'tname: $tname, '
        'copyright: $copyright, '
        'pic: $pic, '
        'title: $title, '
        'pubDate: $pubDate, '
        'ctime: $ctime, '
        'desc: $desc, '
        'owner: $owner, '
        'stat: $stat, '
        'dimension: $dimension, '
        'pages: $pages, '
        'subtitle: $subtitle, '
        'tag: $tag, '
        'reqUser: $reqUser'
        ')';
  }
}

final class ReqUser {
  const ReqUser({
    this.attention = 0,
    this.guestAttention = 0,
    this.like = 0,
    this.coin = 0,
    this.favorite = 0,
  });

  factory ReqUser.fromJson(Map<String, dynamic> json) {
    return ReqUser(
      attention: (json['attention'] as num?)?.toInt() ?? 0,
      guestAttention: (json['guest_attention'] as num?)?.toInt() ?? 0,
      like: (json['like'] as num?)?.toInt() ?? 0,
      coin: (json['coin'] as num?)?.toInt() ?? 0,
      favorite: (json['favorite'] as num?)?.toInt() ?? 0,
    );
  }

  final int attention;
  final int guestAttention;
  final int like;
  final int coin;
  final int favorite;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReqUser &&
            runtimeType == other.runtimeType &&
            attention == other.attention &&
            guestAttention == other.guestAttention &&
            like == other.like &&
            coin == other.coin &&
            favorite == other.favorite;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, attention, guestAttention, like, coin, favorite);
  }

  @override
  String toString() {
    return 'ReqUser('
        'attention: $attention, '
        'guestAttention: $guestAttention, '
        'like: $like, '
        'coin: $coin, '
        'favorite: $favorite'
        ')';
  }
}

final class VideoPage {
  const VideoPage({
    required this.cid,
    this.page = 0,
    this.from = '',
    this.part = '',
    this.duration = 0,
    this.vid = '',
    this.weblink = '',
    this.dimension = const VideoDimension(),
  });

  factory VideoPage.fromJson(Map<String, dynamic> json) {
    return VideoPage(
      cid: (json['cid'] as num).toInt(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      from: json['from'] as String? ?? '',
      part: json['part'] as String? ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      vid: json['vid'] as String? ?? '',
      weblink: json['weblink'] as String? ?? '',
      dimension: json['dimension'] == null
          ? const VideoDimension()
          : VideoDimension.fromJson(json['dimension'] as Map<String, dynamic>),
    );
  }

  final int cid;
  final int page;
  final String from;
  final String part;
  final int duration;
  final String vid;
  final String weblink;
  final VideoDimension dimension;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoPage &&
            runtimeType == other.runtimeType &&
            cid == other.cid &&
            page == other.page &&
            from == other.from &&
            part == other.part &&
            duration == other.duration &&
            vid == other.vid &&
            weblink == other.weblink &&
            dimension == other.dimension;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      cid,
      page,
      from,
      part,
      duration,
      vid,
      weblink,
      dimension,
    );
  }

  @override
  String toString() {
    return 'VideoPage('
        'cid: $cid, '
        'page: $page, '
        'from: $from, '
        'part: $part, '
        'duration: $duration, '
        'vid: $vid, '
        'weblink: $weblink, '
        'dimension: $dimension'
        ')';
  }
}

final class VideoDimension {
  const VideoDimension({this.width = 0, this.height = 0, this.rotate = 0});

  factory VideoDimension.fromJson(Map<String, dynamic> json) {
    return VideoDimension(
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
      rotate: (json['rotate'] as num?)?.toInt() ?? 0,
    );
  }

  final int width;
  final int height;
  final int rotate;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoDimension &&
            runtimeType == other.runtimeType &&
            width == other.width &&
            height == other.height &&
            rotate == other.rotate;
  }

  @override
  int get hashCode => Object.hash(runtimeType, width, height, rotate);

  @override
  String toString() => 'VideoDimension(width: $width, height: $height, rotate: $rotate)';
}

final class VideoTag {
  const VideoTag({
    this.tagId = 0,
    this.tagName = '',
    this.cover = '',
    this.likes = 0,
    this.hates = 0,
    this.liked = 0,
    this.hated = 0,
    this.attribute = 0,
    this.isActivity = 0,
    this.uri = '',
    this.tagType = '',
    this.count = const TagCount(),
    this.type = 0,
    this.state = 0,
    this.ctime = 0,
    this.mtime = 0,
    this.atime = 0,
    this.isAtten = 0,
    this.extraAttr = 0,
    this.musicId = '',
    this.content = '',
    this.shortContent = '',
    this.headCover = '',
  });

  factory VideoTag.fromJson(Map<String, dynamic> json) {
    return VideoTag(
      tagId: (json['tag_id'] as num?)?.toInt() ?? 0,
      tagName: json['tag_name'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      hates: (json['hates'] as num?)?.toInt() ?? 0,
      liked: (json['liked'] as num?)?.toInt() ?? 0,
      hated: (json['hated'] as num?)?.toInt() ?? 0,
      attribute: (json['attribute'] as num?)?.toInt() ?? 0,
      isActivity: (json['is_activity'] as num?)?.toInt() ?? 0,
      uri: json['uri'] as String? ?? '',
      tagType: json['tag_type'] as String? ?? '',
      count: json['count'] == null
          ? const TagCount()
          : TagCount.fromJson(json['count'] as Map<String, dynamic>),
      type: (json['type'] as num?)?.toInt() ?? 0,
      state: (json['state'] as num?)?.toInt() ?? 0,
      ctime: (json['ctime'] as num?)?.toInt() ?? 0,
      mtime: (json['mtime'] as num?)?.toInt() ?? 0,
      atime: (json['atime'] as num?)?.toInt() ?? 0,
      isAtten: (json['is_atten'] as num?)?.toInt() ?? 0,
      extraAttr: (json['extra_attr'] as num?)?.toInt() ?? 0,
      musicId: json['music_id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      shortContent: json['short_content'] as String? ?? '',
      headCover: json['head_cover'] as String? ?? '',
    );
  }

  final int tagId;
  final String tagName;
  final String cover;
  final int likes;
  final int hates;
  final int liked;
  final int hated;
  final int attribute;
  final int isActivity;
  final String uri;
  final String tagType;
  final TagCount count;
  final int type;
  final int state;
  final int ctime;
  final int mtime;
  final int atime;
  final int isAtten;
  final int extraAttr;
  final String musicId;
  final String content;
  final String shortContent;
  final String headCover;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoTag &&
            runtimeType == other.runtimeType &&
            tagId == other.tagId &&
            tagName == other.tagName &&
            cover == other.cover &&
            likes == other.likes &&
            hates == other.hates &&
            liked == other.liked &&
            hated == other.hated &&
            attribute == other.attribute &&
            isActivity == other.isActivity &&
            uri == other.uri &&
            tagType == other.tagType &&
            count == other.count &&
            type == other.type &&
            state == other.state &&
            ctime == other.ctime &&
            mtime == other.mtime &&
            atime == other.atime &&
            isAtten == other.isAtten &&
            extraAttr == other.extraAttr &&
            musicId == other.musicId &&
            content == other.content &&
            shortContent == other.shortContent &&
            headCover == other.headCover;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      tagId,
      tagName,
      cover,
      likes,
      hates,
      liked,
      hated,
      attribute,
      isActivity,
      uri,
      tagType,
      count,
      type,
      state,
      ctime,
      mtime,
      atime,
      isAtten,
      extraAttr,
      musicId,
      content,
      shortContent,
      headCover,
    ]);
  }

  @override
  String toString() {
    return 'VideoTag('
        'tagId: $tagId, '
        'tagName: $tagName, '
        'cover: $cover, '
        'likes: $likes, '
        'hates: $hates, '
        'liked: $liked, '
        'hated: $hated, '
        'attribute: $attribute, '
        'isActivity: $isActivity, '
        'uri: $uri, '
        'tagType: $tagType, '
        'count: $count, '
        'type: $type, '
        'state: $state, '
        'ctime: $ctime, '
        'mtime: $mtime, '
        'atime: $atime, '
        'isAtten: $isAtten, '
        'extraAttr: $extraAttr, '
        'musicId: $musicId, '
        'content: $content, '
        'shortContent: $shortContent, '
        'headCover: $headCover'
        ')';
  }
}

final class TagCount {
  const TagCount({this.view = 0, this.use = 0, this.atten = 0});

  factory TagCount.fromJson(Map<String, dynamic> json) {
    return TagCount(
      view: (json['view'] as num?)?.toInt() ?? 0,
      use: (json['use'] as num?)?.toInt() ?? 0,
      atten: (json['atten'] as num?)?.toInt() ?? 0,
    );
  }

  final int view;
  final int use;
  final int atten;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TagCount &&
            runtimeType == other.runtimeType &&
            view == other.view &&
            use == other.use &&
            atten == other.atten;
  }

  @override
  int get hashCode => Object.hash(runtimeType, view, use, atten);

  @override
  String toString() => 'TagCount(view: $view, use: $use, atten: $atten)';
}
