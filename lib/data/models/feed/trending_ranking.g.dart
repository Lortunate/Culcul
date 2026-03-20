// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrendingRankingResponse _$TrendingRankingResponseFromJson(
  Map<String, dynamic> json,
) => _TrendingRankingResponse(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  ttl: (json['ttl'] as num).toInt(),
  data: TrendingRankingData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TrendingRankingResponseToJson(
  _TrendingRankingResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'ttl': instance.ttl,
  'data': instance.data,
};

_TrendingRankingData _$TrendingRankingDataFromJson(Map<String, dynamic> json) =>
    _TrendingRankingData(
      trackid: json['trackid'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => TrendingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      topList: json['top_list'] as List<dynamic>,
      hotwordEggInfo: json['hotword_egg_info'] as String,
    );

Map<String, dynamic> _$TrendingRankingDataToJson(
  _TrendingRankingData instance,
) => <String, dynamic>{
  'trackid': instance.trackid,
  'list': instance.list,
  'top_list': instance.topList,
  'hotword_egg_info': instance.hotwordEggInfo,
};

_TrendingItem _$TrendingItemFromJson(Map<String, dynamic> json) =>
    _TrendingItem(
      position: (json['position'] as num).toInt(),
      keyword: json['keyword'] as String,
      showName: json['show_name'] as String,
      wordType: (json['word_type'] as num).toInt(),
      icon: json['icon'] as String?,
      hotId: (json['hot_id'] as num).toInt(),
      isCommercial: json['is_commercial'] as String?,
      resourceId: (json['resource_id'] as num?)?.toInt(),
      showLiveIcon: json['show_live_icon'] as bool?,
    );

Map<String, dynamic> _$TrendingItemToJson(_TrendingItem instance) =>
    <String, dynamic>{
      'position': instance.position,
      'keyword': instance.keyword,
      'show_name': instance.showName,
      'word_type': instance.wordType,
      'icon': instance.icon,
      'hot_id': instance.hotId,
      'is_commercial': instance.isCommercial,
      'resource_id': instance.resourceId,
      'show_live_icon': instance.showLiveIcon,
    };
