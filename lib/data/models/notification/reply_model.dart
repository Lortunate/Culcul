import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_model.freezed.dart';
part 'reply_model.g.dart';

@freezed
sealed class ReplyResponse with _$ReplyResponse {
  const factory ReplyResponse({
    required ReplyCursor cursor,
    @Default([]) List<ReplyItem> items,
    @JsonKey(name: 'last_view_at') @Default(0) int lastViewAt,
  }) = _ReplyResponse;

  factory ReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$ReplyResponseFromJson(json);
}

Object? _readSubjectId(Map json, String key) {
  return json['subject_id'] ?? json['item_id'] ?? 0;
}

@freezed
sealed class ReplyCursor with _$ReplyCursor {
  const factory ReplyCursor({
    @JsonKey(name: 'is_end') required bool isEnd,
    required int id,
    required int time,
  }) = _ReplyCursor;

  factory ReplyCursor.fromJson(Map<String, dynamic> json) =>
      _$ReplyCursorFromJson(json);
}

@freezed
sealed class ReplyItem with _$ReplyItem {
  const factory ReplyItem({
    required int id,
    @JsonKey(name: 'users')
    List<ReplyUser>? users, // Like API returns 'users' array
    @JsonKey(name: 'user')
    ReplyUser? user, // Reply/At API returns single 'user'
    required ReplyItemDetail item,
    @Default(1) int counts,
    @JsonKey(name: 'is_multi') @Default(0) int isMulti,
    @JsonKey(name: 'reply_time') int? replyTime, // Reply/At API has this
    @JsonKey(name: 'like_time') int? likeTime, // Like API has this
  }) = _ReplyItem;

  factory ReplyItem.fromJson(Map<String, dynamic> json) =>
      _$ReplyItemFromJson(json);
}

@freezed
sealed class ReplyUser with _$ReplyUser {
  const factory ReplyUser({
    required int mid,
    @Default(0) int fans,
    required String nickname,
    required String avatar,
    @JsonKey(name: 'mid_link') @Default('') String midLink,
    @Default(false) bool follow,
  }) = _ReplyUser;

  factory ReplyUser.fromJson(Map<String, dynamic> json) =>
      _$ReplyUserFromJson(json);
}

@freezed
sealed class ReplyItemDetail with _$ReplyItemDetail {
  const factory ReplyItemDetail({
    @JsonKey(name: 'subject_id', readValue: _readSubjectId)
    required int subjectId,
    @JsonKey(name: 'root_id') @Default(0) int rootId,
    @JsonKey(name: 'source_id') @Default(0) int sourceId,
    @JsonKey(name: 'target_id') @Default(0) int targetId,
    required String type,
    @JsonKey(name: 'business_id') required int businessId,
    required String business,
    @Default('') String title,
    @Default('') String desc,
    @Default('') String image,
    @Default('') String uri,
    @JsonKey(name: 'native_uri') @Default('') String nativeUri,
    @JsonKey(name: 'root_reply_content') @Default('') String rootReplyContent,
    @JsonKey(name: 'source_content') @Default('') String sourceContent,
    @JsonKey(name: 'target_reply_content')
    @Default('')
    String targetReplyContent,
    @JsonKey(name: 'at_details') @Default([]) List<ReplyUser> atDetails,
    @JsonKey(name: 'hide_reply_button') @Default(false) bool hideReplyButton,
    @JsonKey(name: 'hide_like_button') @Default(false) bool hideLikeButton,
    @JsonKey(name: 'like_state') @Default(0) int likeState,
    @Default('') String message,
  }) = _ReplyItemDetail;

  factory ReplyItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ReplyItemDetailFromJson(json);
}
