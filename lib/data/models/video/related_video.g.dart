// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RelatedVideo _$RelatedVideoFromJson(Map<String, dynamic> json) =>
    _RelatedVideo(
      aid: (json['aid'] as num).toInt(),
      bvid: json['bvid'] as String,
      cid: (json['cid'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      pic: json['pic'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
      duration: (json['duration'] as num).toInt(),
      pubDate: (json['pubdate'] as num).toInt(),
      desc: json['desc'] as String? ?? '',
      shortLink: json['short_link_v2'] as String? ?? '',
      rcmdReason: json['rcmd_reason'] as String? ?? '',
    );

Map<String, dynamic> _$RelatedVideoToJson(_RelatedVideo instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'bvid': instance.bvid,
      'cid': instance.cid,
      'title': instance.title,
      'pic': instance.pic,
      'owner': instance.owner,
      'stat': instance.stat,
      'duration': instance.duration,
      'pubdate': instance.pubDate,
      'desc': instance.desc,
      'short_link_v2': instance.shortLink,
      'rcmd_reason': instance.rcmdReason,
    };
