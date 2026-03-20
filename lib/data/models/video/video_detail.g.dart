// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoDetail _$VideoDetailFromJson(Map<String, dynamic> json) => _VideoDetail(
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
  owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
  stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
  dimension: json['dimension'] == null
      ? const VideoDimension()
      : VideoDimension.fromJson(json['dimension'] as Map<String, dynamic>),
  pages:
      (json['pages'] as List<dynamic>?)
          ?.map((e) => VideoPage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  subtitle: json['subtitle'] == null
      ? null
      : VideoSubtitle.fromJson(json['subtitle'] as Map<String, dynamic>),
  tag:
      (json['tag'] as List<dynamic>?)
          ?.map((e) => VideoTag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  reqUser: json['req_user'] == null
      ? null
      : ReqUser.fromJson(json['req_user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VideoDetailToJson(_VideoDetail instance) =>
    <String, dynamic>{
      'bvid': instance.bvid,
      'aid': instance.aid,
      'videos': instance.videos,
      'tid': instance.tid,
      'tname': instance.tname,
      'copyright': instance.copyright,
      'pic': instance.pic,
      'title': instance.title,
      'pubdate': instance.pubDate,
      'ctime': instance.ctime,
      'desc': instance.desc,
      'owner': instance.owner,
      'stat': instance.stat,
      'dimension': instance.dimension,
      'pages': instance.pages,
      'subtitle': instance.subtitle,
      'tag': instance.tag,
      'req_user': instance.reqUser,
    };

_ReqUser _$ReqUserFromJson(Map<String, dynamic> json) => _ReqUser(
  attention: (json['attention'] as num?)?.toInt() ?? 0,
  guestAttention: (json['guest_attention'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ReqUserToJson(_ReqUser instance) => <String, dynamic>{
  'attention': instance.attention,
  'guest_attention': instance.guestAttention,
};

_VideoPage _$VideoPageFromJson(Map<String, dynamic> json) => _VideoPage(
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

Map<String, dynamic> _$VideoPageToJson(_VideoPage instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'page': instance.page,
      'from': instance.from,
      'part': instance.part,
      'duration': instance.duration,
      'vid': instance.vid,
      'weblink': instance.weblink,
      'dimension': instance.dimension,
    };

_VideoDimension _$VideoDimensionFromJson(Map<String, dynamic> json) =>
    _VideoDimension(
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
      rotate: (json['rotate'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VideoDimensionToJson(_VideoDimension instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'rotate': instance.rotate,
    };

_VideoTag _$VideoTagFromJson(Map<String, dynamic> json) => _VideoTag(
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

Map<String, dynamic> _$VideoTagToJson(_VideoTag instance) => <String, dynamic>{
  'tag_id': instance.tagId,
  'tag_name': instance.tagName,
  'cover': instance.cover,
  'likes': instance.likes,
  'hates': instance.hates,
  'liked': instance.liked,
  'hated': instance.hated,
  'attribute': instance.attribute,
  'is_activity': instance.isActivity,
  'uri': instance.uri,
  'tag_type': instance.tagType,
  'count': instance.count,
  'type': instance.type,
  'state': instance.state,
  'ctime': instance.ctime,
  'mtime': instance.mtime,
  'atime': instance.atime,
  'is_atten': instance.isAtten,
  'extra_attr': instance.extraAttr,
  'music_id': instance.musicId,
  'content': instance.content,
  'short_content': instance.shortContent,
  'head_cover': instance.headCover,
};

_TagCount _$TagCountFromJson(Map<String, dynamic> json) => _TagCount(
  view: (json['view'] as num?)?.toInt() ?? 0,
  use: (json['use'] as num?)?.toInt() ?? 0,
  atten: (json['atten'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TagCountToJson(_TagCount instance) => <String, dynamic>{
  'view': instance.view,
  'use': instance.use,
  'atten': instance.atten,
};
