// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnreadCountModel _$UnreadCountModelFromJson(Map<String, dynamic> json) =>
    _UnreadCountModel(
      at: (json['at'] as num?)?.toInt() ?? 0,
      chat: (json['chat'] as num?)?.toInt() ?? 0,
      coin: (json['coin'] as num?)?.toInt() ?? 0,
      danmu: (json['danmu'] as num?)?.toInt() ?? 0,
      favorite: (json['favorite'] as num?)?.toInt() ?? 0,
      like: (json['like'] as num?)?.toInt() ?? 0,
      recvLike: (json['recv_like'] as num?)?.toInt() ?? 0,
      recvReply: (json['recv_reply'] as num?)?.toInt() ?? 0,
      reply: (json['reply'] as num?)?.toInt() ?? 0,
      sysMsg: (json['sys_msg'] as num?)?.toInt() ?? 0,
      up: (json['up'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UnreadCountModelToJson(_UnreadCountModel instance) =>
    <String, dynamic>{
      'at': instance.at,
      'chat': instance.chat,
      'coin': instance.coin,
      'danmu': instance.danmu,
      'favorite': instance.favorite,
      'like': instance.like,
      'recv_like': instance.recvLike,
      'recv_reply': instance.recvReply,
      'reply': instance.reply,
      'sys_msg': instance.sysMsg,
      'up': instance.up,
    };
