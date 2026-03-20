// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ToViewModel _$ToViewModelFromJson(Map<String, dynamic> json) => _ToViewModel(
  aid: (json['aid'] as num?)?.toInt(),
  videos: (json['videos'] as num?)?.toInt() ?? 0,
  tid: (json['tid'] as num?)?.toInt() ?? 0,
  tname: json['tname'] as String? ?? '',
  copyright: (json['copyright'] as num?)?.toInt() ?? 1,
  pic: json['pic'] as String? ?? '',
  title: json['title'] as String? ?? '',
  pubdate: (json['pubdate'] as num?)?.toInt() ?? 0,
  ctime: (json['ctime'] as num?)?.toInt() ?? 0,
  desc: json['desc'] as String? ?? '',
  state: (json['state'] as num?)?.toInt() ?? 0,
  duration: (json['duration'] as num?)?.toInt() ?? 0,
  rights: json['rights'] as Map<String, dynamic>?,
  owner: json['owner'] == null
      ? null
      : FavUpperModel.fromJson(json['owner'] as Map<String, dynamic>),
  stat: json['stat'] == null
      ? null
      : ToViewStatModel.fromJson(json['stat'] as Map<String, dynamic>),
  dynamicText: json['dynamic'] as String?,
  cid: (json['cid'] as num?)?.toInt() ?? 0,
  progress: (json['progress'] as num?)?.toInt() ?? 0,
  addAt: (json['add_at'] as num?)?.toInt() ?? 0,
  bvid: json['bvid'] as String? ?? '',
);

Map<String, dynamic> _$ToViewModelToJson(_ToViewModel instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'videos': instance.videos,
      'tid': instance.tid,
      'tname': instance.tname,
      'copyright': instance.copyright,
      'pic': instance.pic,
      'title': instance.title,
      'pubdate': instance.pubdate,
      'ctime': instance.ctime,
      'desc': instance.desc,
      'state': instance.state,
      'duration': instance.duration,
      'rights': instance.rights,
      'owner': instance.owner,
      'stat': instance.stat,
      'dynamic': instance.dynamicText,
      'cid': instance.cid,
      'progress': instance.progress,
      'add_at': instance.addAt,
      'bvid': instance.bvid,
    };

_ToViewStatModel _$ToViewStatModelFromJson(Map<String, dynamic> json) =>
    _ToViewStatModel(
      aid: (json['aid'] as num?)?.toInt(),
      view: (json['view'] as num?)?.toInt() ?? 0,
      danmaku: (json['danmaku'] as num?)?.toInt() ?? 0,
      reply: (json['reply'] as num?)?.toInt() ?? 0,
      favorite: (json['favorite'] as num?)?.toInt() ?? 0,
      coin: (json['coin'] as num?)?.toInt() ?? 0,
      share: (json['share'] as num?)?.toInt() ?? 0,
      like: (json['like'] as num?)?.toInt() ?? 0,
      dislike: (json['dislike'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ToViewStatModelToJson(_ToViewStatModel instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'view': instance.view,
      'danmaku': instance.danmaku,
      'reply': instance.reply,
      'favorite': instance.favorite,
      'coin': instance.coin,
      'share': instance.share,
      'like': instance.like,
      'dislike': instance.dislike,
    };

_ToViewListResponse _$ToViewListResponseFromJson(Map<String, dynamic> json) =>
    _ToViewListResponse(
      count: (json['count'] as num?)?.toInt() ?? 0,
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => ToViewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ToViewListResponseToJson(_ToViewListResponse instance) =>
    <String, dynamic>{'count': instance.count, 'list': instance.list};
