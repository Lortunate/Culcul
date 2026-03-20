// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedResponse _$FeedResponseFromJson(Map<String, dynamic> json) =>
    _FeedResponse(
      item:
          (json['item'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      businessCard: json['business_card'],
      floorInfo: json['floor_info'] as List<dynamic>? ?? const [],
      userFeature: (json['user_feature'] as num?)?.toInt() ?? 0,
      sideBarColumn: json['side_bar_column'] as String? ?? '',
    );

Map<String, dynamic> _$FeedResponseToJson(_FeedResponse instance) =>
    <String, dynamic>{
      'item': instance.item,
      'business_card': instance.businessCard,
      'floor_info': instance.floorInfo,
      'user_feature': instance.userFeature,
      'side_bar_column': instance.sideBarColumn,
    };
