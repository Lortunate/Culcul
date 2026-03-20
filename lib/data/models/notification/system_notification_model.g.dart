// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SystemNotificationItem _$SystemNotificationItemFromJson(
  Map<String, dynamic> json,
) => _SystemNotificationItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  text: json['text'] as String?,
  time: (json['time'] as num).toInt(),
  uri: json['uri'] as String?,
  jumpText: json['jump_text'] as String?,
);

Map<String, dynamic> _$SystemNotificationItemToJson(
  _SystemNotificationItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'text': instance.text,
  'time': instance.time,
  'uri': instance.uri,
  'jump_text': instance.jumpText,
};
