// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_resource_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavResourceModel _$FavResourceModelFromJson(Map<String, dynamic> json) =>
    _FavResourceModel(
      id: (json['id'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      title: json['title'] as String,
      cover: json['cover'] as String,
      intro: json['intro'] as String,
      page: (json['page'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      upper: FavUpperModel.fromJson(json['upper'] as Map<String, dynamic>),
      attr: (json['attr'] as num).toInt(),
      cntInfo: FavCntInfoModel.fromJson(
        json['cnt_info'] as Map<String, dynamic>,
      ),
      link: json['link'] as String,
      ctime: (json['ctime'] as num).toInt(),
      pubtime: (json['pubtime'] as num).toInt(),
      favTime: (json['fav_time'] as num).toInt(),
      bvId: json['bv_id'] as String?,
      bvid: json['bvid'] as String?,
    );

Map<String, dynamic> _$FavResourceModelToJson(_FavResourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'cover': instance.cover,
      'intro': instance.intro,
      'page': instance.page,
      'duration': instance.duration,
      'upper': instance.upper,
      'attr': instance.attr,
      'cnt_info': instance.cntInfo,
      'link': instance.link,
      'ctime': instance.ctime,
      'pubtime': instance.pubtime,
      'fav_time': instance.favTime,
      'bv_id': instance.bvId,
      'bvid': instance.bvid,
    };

_FavUpperModel _$FavUpperModelFromJson(Map<String, dynamic> json) =>
    _FavUpperModel(
      mid: (json['mid'] as num).toInt(),
      name: json['name'] as String,
      face: json['face'] as String,
    );

Map<String, dynamic> _$FavUpperModelToJson(_FavUpperModel instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'name': instance.name,
      'face': instance.face,
    };

_FavCntInfoModel _$FavCntInfoModelFromJson(Map<String, dynamic> json) =>
    _FavCntInfoModel(
      collect: (json['collect'] as num).toInt(),
      play: (json['play'] as num).toInt(),
      danmaku: (json['danmaku'] as num).toInt(),
    );

Map<String, dynamic> _$FavCntInfoModelToJson(_FavCntInfoModel instance) =>
    <String, dynamic>{
      'collect': instance.collect,
      'play': instance.play,
      'danmaku': instance.danmaku,
    };

_FavResourceListResponse _$FavResourceListResponseFromJson(
  Map<String, dynamic> json,
) => _FavResourceListResponse(
  info: FavFolderInfoModel.fromJson(json['info'] as Map<String, dynamic>),
  medias: (json['medias'] as List<dynamic>?)
      ?.map((e) => FavResourceModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasMore: json['has_more'] as bool,
);

Map<String, dynamic> _$FavResourceListResponseToJson(
  _FavResourceListResponse instance,
) => <String, dynamic>{
  'info': instance.info,
  'medias': instance.medias,
  'has_more': instance.hasMore,
};

_FavFolderInfoModel _$FavFolderInfoModelFromJson(Map<String, dynamic> json) =>
    _FavFolderInfoModel(
      id: (json['id'] as num).toInt(),
      fid: (json['fid'] as num).toInt(),
      mid: (json['mid'] as num).toInt(),
      attr: (json['attr'] as num).toInt(),
      title: json['title'] as String,
      cover: json['cover'] as String,
      upper: FavUpperModel.fromJson(json['upper'] as Map<String, dynamic>),
      mediaCount: (json['media_count'] as num).toInt(),
    );

Map<String, dynamic> _$FavFolderInfoModelToJson(_FavFolderInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fid': instance.fid,
      'mid': instance.mid,
      'attr': instance.attr,
      'title': instance.title,
      'cover': instance.cover,
      'upper': instance.upper,
      'media_count': instance.mediaCount,
    };
