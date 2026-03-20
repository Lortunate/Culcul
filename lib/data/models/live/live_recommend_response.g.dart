// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_recommend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveRecommendResponse _$LiveRecommendResponseFromJson(
  Map<String, dynamic> json,
) => _LiveRecommendResponse(
  roomList: (json['recommend_room_list'] as List<dynamic>)
      .map((e) => LiveRoomModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LiveRecommendResponseToJson(
  _LiveRecommendResponse instance,
) => <String, dynamic>{'recommend_room_list': instance.roomList};
