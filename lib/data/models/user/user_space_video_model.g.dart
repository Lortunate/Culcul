// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_space_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSpaceVideoModel _$UserSpaceVideoModelFromJson(Map<String, dynamic> json) =>
    _UserSpaceVideoModel(
      aid: (json['aid'] as num).toInt(),
      bvid: json['bvid'] as String,
      title: json['title'] as String,
      pic: json['pic'] as String,
      tname: json['tname'] as String,
      duration: (json['duration'] as num).toInt(),
      pubDate: (json['pubdate'] as num).toInt(),
      ctime: (json['ctime'] as num).toInt(),
      desc: json['desc'] as String? ?? '',
      state: (json['state'] as num?)?.toInt() ?? 0,
      attribute: (json['attribute'] as num?)?.toInt() ?? 0,
      tid: (json['tid'] as num).toInt(),
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
      reason: json['reason'] as String? ?? '',
      interVideo: json['inter_video'] as bool? ?? false,
    );

Map<String, dynamic> _$UserSpaceVideoModelToJson(
  _UserSpaceVideoModel instance,
) => <String, dynamic>{
  'aid': instance.aid,
  'bvid': instance.bvid,
  'title': instance.title,
  'pic': instance.pic,
  'tname': instance.tname,
  'duration': instance.duration,
  'pubdate': instance.pubDate,
  'ctime': instance.ctime,
  'desc': instance.desc,
  'state': instance.state,
  'attribute': instance.attribute,
  'tid': instance.tid,
  'owner': instance.owner,
  'stat': instance.stat,
  'reason': instance.reason,
  'inter_video': instance.interVideo,
};

_UserSpaceVideoListResponse _$UserSpaceVideoListResponseFromJson(
  Map<String, dynamic> json,
) => _UserSpaceVideoListResponse(
  list: UserSpaceVideoList.fromJson(json['list'] as Map<String, dynamic>),
  page: UserSpacePage.fromJson(json['page'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserSpaceVideoListResponseToJson(
  _UserSpaceVideoListResponse instance,
) => <String, dynamic>{'list': instance.list, 'page': instance.page};

_UserSpaceVideoList _$UserSpaceVideoListFromJson(Map<String, dynamic> json) =>
    _UserSpaceVideoList(
      vlist:
          (json['vlist'] as List<dynamic>?)
              ?.map(
                (e) => UserSpaceVideoModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserSpaceVideoListToJson(_UserSpaceVideoList instance) =>
    <String, dynamic>{'vlist': instance.vlist};

_UserSpacePage _$UserSpacePageFromJson(Map<String, dynamic> json) =>
    _UserSpacePage(
      pn: (json['pn'] as num?)?.toInt() ?? 1,
      ps: (json['ps'] as num?)?.toInt() ?? 30,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserSpacePageToJson(_UserSpacePage instance) =>
    <String, dynamic>{
      'pn': instance.pn,
      'ps': instance.ps,
      'count': instance.count,
    };
