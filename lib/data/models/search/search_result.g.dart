// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResultResponse _$SearchResultResponseFromJson(
  Map<String, dynamic> json,
) => _SearchResultResponse(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  ttl: (json['ttl'] as num).toInt(),
  data: json['data'] == null
      ? null
      : SearchResultData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SearchResultResponseToJson(
  _SearchResultResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'ttl': instance.ttl,
  'data': instance.data,
};

_SearchResultData _$SearchResultDataFromJson(Map<String, dynamic> json) =>
    _SearchResultData(
      seid: json['seid'] as String,
      page: (json['page'] as num).toInt(),
      pageSize: (json['pagesize'] as num).toInt(),
      numResults: (json['numResults'] as num).toInt(),
      numPages: (json['numPages'] as num).toInt(),
      result: json['result'] == null
          ? const []
          : const _SearchResultConverter().fromJson(json['result']),
    );

Map<String, dynamic> _$SearchResultDataToJson(_SearchResultData instance) =>
    <String, dynamic>{
      'seid': instance.seid,
      'page': instance.page,
      'pagesize': instance.pageSize,
      'numResults': instance.numResults,
      'numPages': instance.numPages,
      'result': const _SearchResultConverter().toJson(instance.result),
    };

SearchVideoModel _$SearchVideoModelFromJson(Map<String, dynamic> json) =>
    SearchVideoModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      author: json['author'] as String?,
      pic: json['pic'] as String?,
      bvid: json['bvid'] as String?,
      duration: json['duration'] as String?,
      play: json['play'],
      view: json['view'],
      videoReview: (json['video_review'] as num?)?.toInt(),
      danmaku: (json['danmaku'] as num?)?.toInt(),
      favorites: (json['favorites'] as num?)?.toInt(),
      review: (json['review'] as num?)?.toInt(),
      pubdate: (json['pubdate'] as num?)?.toInt(),
      typename: json['typename'] as String?,
      arcurl: json['arcurl'] as String?,
    );

Map<String, dynamic> _$SearchVideoModelToJson(SearchVideoModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'author': instance.author,
      'pic': instance.pic,
      'bvid': instance.bvid,
      'duration': instance.duration,
      'play': instance.play,
      'view': instance.view,
      'video_review': instance.videoReview,
      'danmaku': instance.danmaku,
      'favorites': instance.favorites,
      'review': instance.review,
      'pubdate': instance.pubdate,
      'typename': instance.typename,
      'arcurl': instance.arcurl,
    };

SearchUserModel _$SearchUserModelFromJson(Map<String, dynamic> json) =>
    SearchUserModel(
      type: json['type'] as String?,
      uname: json['uname'] as String?,
      upic: json['upic'] as String?,
      upicUrl: json['upic_url'] as String?,
      usign: json['usign'] as String?,
      fans: (json['fans'] as num?)?.toInt(),
      videos: (json['videos'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      mid: (json['mid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchUserModelToJson(SearchUserModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'uname': instance.uname,
      'upic': instance.upic,
      'upic_url': instance.upicUrl,
      'usign': instance.usign,
      'fans': instance.fans,
      'videos': instance.videos,
      'level': instance.level,
      'mid': instance.mid,
    };

SearchBangumiModel _$SearchBangumiModelFromJson(Map<String, dynamic> json) =>
    SearchBangumiModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      cover: json['cover'] as String?,
      pic: json['pic'] as String?,
      seasonId: (json['season_id'] as num?)?.toInt(),
      pgcSeasonId: (json['pgc_season_id'] as num?)?.toInt(),
      seasonTypeName: json['season_type_name'] as String?,
      areas: json['areas'] as String?,
      styles: json['styles'] as String?,
      label: json['label'] as String?,
      gotoUrl: json['goto_url'] as String?,
    );

Map<String, dynamic> _$SearchBangumiModelToJson(SearchBangumiModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'cover': instance.cover,
      'pic': instance.pic,
      'season_id': instance.seasonId,
      'pgc_season_id': instance.pgcSeasonId,
      'season_type_name': instance.seasonTypeName,
      'areas': instance.areas,
      'styles': instance.styles,
      'label': instance.label,
      'goto_url': instance.gotoUrl,
    };

SearchArticleModel _$SearchArticleModelFromJson(Map<String, dynamic> json) =>
    SearchArticleModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      author: json['author'] as String?,
      uname: json['uname'] as String?,
      view: json['view'],
      review: (json['review'] as num?)?.toInt(),
      pubTime: (json['pub_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchArticleModelToJson(SearchArticleModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'image_urls': instance.imageUrls,
      'author': instance.author,
      'uname': instance.uname,
      'view': instance.view,
      'review': instance.review,
      'pub_time': instance.pubTime,
    };

SearchTopicModel _$SearchTopicModelFromJson(Map<String, dynamic> json) =>
    SearchTopicModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      tpId: (json['tp_id'] as num?)?.toInt(),
      arcurl: json['arcurl'] as String?,
      author: json['author'] as String?,
      update: (json['update'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchTopicModelToJson(SearchTopicModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'cover': instance.cover,
      'tp_id': instance.tpId,
      'arcurl': instance.arcurl,
      'author': instance.author,
      'update': instance.update,
    };
