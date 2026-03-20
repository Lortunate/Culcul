// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LikeResponse _$LikeResponseFromJson(Map<String, dynamic> json) =>
    _LikeResponse(
      latest: LikeLatest.fromJson(json['latest'] as Map<String, dynamic>),
      total: LikeTotal.fromJson(json['total'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikeResponseToJson(_LikeResponse instance) =>
    <String, dynamic>{'latest': instance.latest, 'total': instance.total};

_LikeLatest _$LikeLatestFromJson(Map<String, dynamic> json) => _LikeLatest(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ReplyItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  lastViewAt: (json['last_view_at'] as num).toInt(),
);

Map<String, dynamic> _$LikeLatestToJson(_LikeLatest instance) =>
    <String, dynamic>{
      'items': instance.items,
      'last_view_at': instance.lastViewAt,
    };

_LikeTotal _$LikeTotalFromJson(Map<String, dynamic> json) => _LikeTotal(
  cursor: ReplyCursor.fromJson(json['cursor'] as Map<String, dynamic>),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ReplyItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$LikeTotalToJson(_LikeTotal instance) =>
    <String, dynamic>{'cursor': instance.cursor, 'items': instance.items};
