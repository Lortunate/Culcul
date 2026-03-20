// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryResponseData _$HistoryResponseDataFromJson(Map<String, dynamic> json) =>
    _HistoryResponseData(
      cursor: HistoryCursor.fromJson(json['cursor'] as Map<String, dynamic>),
      tab: (json['tab'] as List<dynamic>)
          .map((e) => HistoryTab.fromJson(e as Map<String, dynamic>))
          .toList(),
      list: (json['list'] as List<dynamic>)
          .map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryResponseDataToJson(
  _HistoryResponseData instance,
) => <String, dynamic>{
  'cursor': instance.cursor,
  'tab': instance.tab,
  'list': instance.list,
};

_HistoryCursor _$HistoryCursorFromJson(Map<String, dynamic> json) =>
    _HistoryCursor(
      max: (json['max'] as num).toInt(),
      viewAt: (json['view_at'] as num).toInt(),
      business: json['business'] as String,
      ps: (json['ps'] as num).toInt(),
    );

Map<String, dynamic> _$HistoryCursorToJson(_HistoryCursor instance) =>
    <String, dynamic>{
      'max': instance.max,
      'view_at': instance.viewAt,
      'business': instance.business,
      'ps': instance.ps,
    };

_HistoryTab _$HistoryTabFromJson(Map<String, dynamic> json) =>
    _HistoryTab(type: json['type'] as String, name: json['name'] as String);

Map<String, dynamic> _$HistoryTabToJson(_HistoryTab instance) =>
    <String, dynamic>{'type': instance.type, 'name': instance.name};

_HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) => _HistoryItem(
  title: json['title'] as String,
  longTitle: json['long_title'] as String,
  cover: json['cover'] as String,
  covers: (json['covers'] as List<dynamic>?)?.map((e) => e as String).toList(),
  uri: json['uri'] as String,
  history: HistoryDetail.fromJson(json['history'] as Map<String, dynamic>),
  videos: (json['videos'] as num).toInt(),
  authorName: json['author_name'] as String,
  authorFace: json['author_face'] as String,
  authorMid: (json['author_mid'] as num).toInt(),
  viewAt: (json['view_at'] as num).toInt(),
  progress: (json['progress'] as num).toInt(),
  badge: json['badge'] as String,
  showTitle: json['show_title'] as String,
  duration: (json['duration'] as num).toInt(),
  current: json['current'] as String,
  total: (json['total'] as num).toInt(),
  newDesc: json['new_desc'] as String,
  isFinish: (json['is_finish'] as num).toInt(),
  isFav: (json['is_fav'] as num).toInt(),
  kid: (json['kid'] as num).toInt(),
  tagName: json['tag_name'] as String,
  liveStatus: (json['live_status'] as num).toInt(),
);

Map<String, dynamic> _$HistoryItemToJson(_HistoryItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'long_title': instance.longTitle,
      'cover': instance.cover,
      'covers': instance.covers,
      'uri': instance.uri,
      'history': instance.history,
      'videos': instance.videos,
      'author_name': instance.authorName,
      'author_face': instance.authorFace,
      'author_mid': instance.authorMid,
      'view_at': instance.viewAt,
      'progress': instance.progress,
      'badge': instance.badge,
      'show_title': instance.showTitle,
      'duration': instance.duration,
      'current': instance.current,
      'total': instance.total,
      'new_desc': instance.newDesc,
      'is_finish': instance.isFinish,
      'is_fav': instance.isFav,
      'kid': instance.kid,
      'tag_name': instance.tagName,
      'live_status': instance.liveStatus,
    };

_HistoryDetail _$HistoryDetailFromJson(Map<String, dynamic> json) =>
    _HistoryDetail(
      oid: (json['oid'] as num).toInt(),
      epid: (json['epid'] as num).toInt(),
      bvid: json['bvid'] as String,
      page: (json['page'] as num).toInt(),
      cid: (json['cid'] as num).toInt(),
      part: json['part'] as String,
      business: json['business'] as String,
      dt: (json['dt'] as num).toInt(),
    );

Map<String, dynamic> _$HistoryDetailToJson(_HistoryDetail instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'epid': instance.epid,
      'bvid': instance.bvid,
      'page': instance.page,
      'cid': instance.cid,
      'part': instance.part,
      'business': instance.business,
      'dt': instance.dt,
    };
