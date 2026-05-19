import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:culcul/features/notification/data/dtos/reply_model.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@freezed
sealed class LikeResponse with _$LikeResponse {
  const factory LikeResponse({required LikeLatest latest, required LikeTotal total}) =
      _LikeResponse;

  factory LikeResponse.fromJson(Map<String, dynamic> json) =>
      _$LikeResponseFromJson(json);
}

@freezed
sealed class LikeLatest with _$LikeLatest {
  const factory LikeLatest({
    @Default([]) List<ReplyItem> items,
    @JsonKey(name: 'last_view_at') required int lastViewAt,
  }) = _LikeLatest;

  factory LikeLatest.fromJson(Map<String, dynamic> json) => _$LikeLatestFromJson(json);
}

@freezed
sealed class LikeTotal with _$LikeTotal {
  const factory LikeTotal({
    required ReplyCursor cursor,
    @Default([]) List<ReplyItem> items,
  }) = _LikeTotal;

  factory LikeTotal.fromJson(Map<String, dynamic> json) => _$LikeTotalFromJson(json);
}
