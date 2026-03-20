// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_gold_rank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveGoldRankModel _$LiveGoldRankModelFromJson(Map<String, dynamic> json) =>
    _LiveGoldRankModel(
      onlineNum: (json['onlineNum'] as num).toInt(),
      list: (json['OnlineRankItem'] as List<dynamic>)
          .map((e) => LiveRankItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LiveGoldRankModelToJson(_LiveGoldRankModel instance) =>
    <String, dynamic>{
      'onlineNum': instance.onlineNum,
      'OnlineRankItem': instance.list,
    };

_LiveRankItem _$LiveRankItemFromJson(Map<String, dynamic> json) =>
    _LiveRankItem(
      userRank: (json['userRank'] as num).toInt(),
      uid: (json['uid'] as num).toInt(),
      name: json['name'] as String,
      face: json['face'] as String,
      score: (json['score'] as num).toInt(),
      medalInfo: LiveRankMedalInfo.fromJson(
        json['medalInfo'] as Map<String, dynamic>,
      ),
      guardLevel: (json['guard_level'] as num).toInt(),
      wealthLevel: (json['wealth_level'] as num).toInt(),
    );

Map<String, dynamic> _$LiveRankItemToJson(_LiveRankItem instance) =>
    <String, dynamic>{
      'userRank': instance.userRank,
      'uid': instance.uid,
      'name': instance.name,
      'face': instance.face,
      'score': instance.score,
      'medalInfo': instance.medalInfo,
      'guard_level': instance.guardLevel,
      'wealth_level': instance.wealthLevel,
    };

_LiveRankMedalInfo _$LiveRankMedalInfoFromJson(Map<String, dynamic> json) =>
    _LiveRankMedalInfo(
      guardLevel: (json['guardLevel'] as num).toInt(),
      medalColorStart: (json['medalColorStart'] as num).toInt(),
      medalColorEnd: (json['medalColorEnd'] as num).toInt(),
      medalColorBorder: (json['medalColorBorder'] as num).toInt(),
      medalName: json['medalName'] as String,
      level: (json['level'] as num).toInt(),
      targetId: (json['targetId'] as num).toInt(),
      isLight: (json['isLight'] as num).toInt(),
    );

Map<String, dynamic> _$LiveRankMedalInfoToJson(_LiveRankMedalInfo instance) =>
    <String, dynamic>{
      'guardLevel': instance.guardLevel,
      'medalColorStart': instance.medalColorStart,
      'medalColorEnd': instance.medalColorEnd,
      'medalColorBorder': instance.medalColorBorder,
      'medalName': instance.medalName,
      'level': instance.level,
      'targetId': instance.targetId,
      'isLight': instance.isLight,
    };
