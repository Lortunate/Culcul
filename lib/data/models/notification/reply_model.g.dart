// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplyResponse _$ReplyResponseFromJson(Map<String, dynamic> json) =>
    _ReplyResponse(
      cursor: ReplyCursor.fromJson(json['cursor'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ReplyItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastViewAt: (json['last_view_at'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReplyResponseToJson(_ReplyResponse instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'items': instance.items,
      'last_view_at': instance.lastViewAt,
    };

_ReplyCursor _$ReplyCursorFromJson(Map<String, dynamic> json) => _ReplyCursor(
  isEnd: json['is_end'] as bool,
  id: (json['id'] as num).toInt(),
  time: (json['time'] as num).toInt(),
);

Map<String, dynamic> _$ReplyCursorToJson(_ReplyCursor instance) =>
    <String, dynamic>{
      'is_end': instance.isEnd,
      'id': instance.id,
      'time': instance.time,
    };

_ReplyItem _$ReplyItemFromJson(Map<String, dynamic> json) => _ReplyItem(
  id: (json['id'] as num).toInt(),
  users: (json['users'] as List<dynamic>?)
      ?.map((e) => ReplyUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  user: json['user'] == null
      ? null
      : ReplyUser.fromJson(json['user'] as Map<String, dynamic>),
  item: ReplyItemDetail.fromJson(json['item'] as Map<String, dynamic>),
  counts: (json['counts'] as num?)?.toInt() ?? 1,
  isMulti: (json['is_multi'] as num?)?.toInt() ?? 0,
  replyTime: (json['reply_time'] as num?)?.toInt(),
  likeTime: (json['like_time'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReplyItemToJson(_ReplyItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'user': instance.user,
      'item': instance.item,
      'counts': instance.counts,
      'is_multi': instance.isMulti,
      'reply_time': instance.replyTime,
      'like_time': instance.likeTime,
    };

_ReplyUser _$ReplyUserFromJson(Map<String, dynamic> json) => _ReplyUser(
  mid: (json['mid'] as num).toInt(),
  fans: (json['fans'] as num?)?.toInt() ?? 0,
  nickname: json['nickname'] as String,
  avatar: json['avatar'] as String,
  midLink: json['mid_link'] as String? ?? '',
  follow: json['follow'] as bool? ?? false,
);

Map<String, dynamic> _$ReplyUserToJson(_ReplyUser instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'fans': instance.fans,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'mid_link': instance.midLink,
      'follow': instance.follow,
    };

_ReplyItemDetail _$ReplyItemDetailFromJson(Map<String, dynamic> json) =>
    _ReplyItemDetail(
      subjectId: (_readSubjectId(json, 'subject_id') as num).toInt(),
      rootId: (json['root_id'] as num?)?.toInt() ?? 0,
      sourceId: (json['source_id'] as num?)?.toInt() ?? 0,
      targetId: (json['target_id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String,
      businessId: (json['business_id'] as num).toInt(),
      business: json['business'] as String,
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      image: json['image'] as String? ?? '',
      uri: json['uri'] as String? ?? '',
      nativeUri: json['native_uri'] as String? ?? '',
      rootReplyContent: json['root_reply_content'] as String? ?? '',
      sourceContent: json['source_content'] as String? ?? '',
      targetReplyContent: json['target_reply_content'] as String? ?? '',
      atDetails:
          (json['at_details'] as List<dynamic>?)
              ?.map((e) => ReplyUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hideReplyButton: json['hide_reply_button'] as bool? ?? false,
      hideLikeButton: json['hide_like_button'] as bool? ?? false,
      likeState: (json['like_state'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$ReplyItemDetailToJson(_ReplyItemDetail instance) =>
    <String, dynamic>{
      'subject_id': instance.subjectId,
      'root_id': instance.rootId,
      'source_id': instance.sourceId,
      'target_id': instance.targetId,
      'type': instance.type,
      'business_id': instance.businessId,
      'business': instance.business,
      'title': instance.title,
      'desc': instance.desc,
      'image': instance.image,
      'uri': instance.uri,
      'native_uri': instance.nativeUri,
      'root_reply_content': instance.rootReplyContent,
      'source_content': instance.sourceContent,
      'target_reply_content': instance.targetReplyContent,
      'at_details': instance.atDetails,
      'hide_reply_button': instance.hideReplyButton,
      'hide_like_button': instance.hideLikeButton,
      'like_state': instance.likeState,
      'message': instance.message,
    };
