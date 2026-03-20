// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => _VideoModel(
  bvid: json['bvid'] as String,
  title: json['title'] as String,
  pic: json['pic'] as String,
  owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
  stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
  duration: (json['duration'] as num).toInt(),
  pubDate: (json['pubdate'] as num).toInt(),
  desc: json['desc'] as String? ?? '',
  rcmd_reason: json['rcmd_reason'] == null
      ? ''
      : const RcmdReasonConverter().fromJson(json['rcmd_reason']),
);

Map<String, dynamic> _$VideoModelToJson(_VideoModel instance) =>
    <String, dynamic>{
      'bvid': instance.bvid,
      'title': instance.title,
      'pic': instance.pic,
      'owner': instance.owner,
      'stat': instance.stat,
      'duration': instance.duration,
      'pubdate': instance.pubDate,
      'desc': instance.desc,
      'rcmd_reason': const RcmdReasonConverter().toJson(instance.rcmd_reason),
    };

_Owner _$OwnerFromJson(Map<String, dynamic> json) => _Owner(
  mid: (json['mid'] as num).toInt(),
  name: json['name'] as String,
  face: json['face'] as String? ?? '',
);

Map<String, dynamic> _$OwnerToJson(_Owner instance) => <String, dynamic>{
  'mid': instance.mid,
  'name': instance.name,
  'face': instance.face,
};

_Stat _$StatFromJson(Map<String, dynamic> json) => _Stat(
  view: (json['view'] as num?)?.toInt() ?? 0,
  danmaku: (json['danmaku'] as num?)?.toInt() ?? 0,
  reply: (json['reply'] as num?)?.toInt() ?? 0,
  like: (json['like'] as num?)?.toInt() ?? 0,
  coin: (json['coin'] as num?)?.toInt() ?? 0,
  favorite: (json['favorite'] as num?)?.toInt() ?? 0,
  share: (json['share'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$StatToJson(_Stat instance) => <String, dynamic>{
  'view': instance.view,
  'danmaku': instance.danmaku,
  'reply': instance.reply,
  'like': instance.like,
  'coin': instance.coin,
  'favorite': instance.favorite,
  'share': instance.share,
};
