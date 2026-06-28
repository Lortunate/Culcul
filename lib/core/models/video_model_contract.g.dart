// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model_contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => _VideoModel(
  bvid: json['bvid'] as String,
  title: json['title'] as String,
  pic: json['pic'] as String,
  owner: VideoOwner.fromJson(json['owner'] as Map<String, dynamic>),
  stat: VideoStat.fromJson(json['stat'] as Map<String, dynamic>),
  duration: (json['duration'] as num).toInt(),
  pubDate: (json['pubdate'] as num).toInt(),
  desc: json['desc'] as String? ?? '',
  rcmdReason: json['rcmd_reason'] == null
      ? ''
      : const RcmdReasonConverter().fromJson(json['rcmd_reason']),
);

Map<String, dynamic> _$VideoModelToJson(_VideoModel instance) => <String, dynamic>{
  'bvid': instance.bvid,
  'title': instance.title,
  'pic': instance.pic,
  'owner': instance.owner,
  'stat': instance.stat,
  'duration': instance.duration,
  'pubdate': instance.pubDate,
  'desc': instance.desc,
  'rcmd_reason': const RcmdReasonConverter().toJson(instance.rcmdReason),
};

_VideoOwner _$VideoOwnerFromJson(Map<String, dynamic> json) => _VideoOwner(
  mid: (json['mid'] as num).toInt(),
  name: json['name'] as String,
  face: json['face'] as String? ?? '',
);

Map<String, dynamic> _$VideoOwnerToJson(_VideoOwner instance) => <String, dynamic>{
  'mid': instance.mid,
  'name': instance.name,
  'face': instance.face,
};

_VideoStat _$VideoStatFromJson(Map<String, dynamic> json) => _VideoStat(
  view: (json['view'] as num?)?.toInt() ?? 0,
  danmaku: (json['danmaku'] as num?)?.toInt() ?? 0,
  reply: (json['reply'] as num?)?.toInt() ?? 0,
  like: (json['like'] as num?)?.toInt() ?? 0,
  coin: (json['coin'] as num?)?.toInt() ?? 0,
  favorite: (json['favorite'] as num?)?.toInt() ?? 0,
  share: (json['share'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VideoStatToJson(_VideoStat instance) => <String, dynamic>{
  'view': instance.view,
  'danmaku': instance.danmaku,
  'reply': instance.reply,
  'like': instance.like,
  'coin': instance.coin,
  'favorite': instance.favorite,
  'share': instance.share,
};
