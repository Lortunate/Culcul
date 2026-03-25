import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_response.freezed.dart';
part 'feed_response.g.dart';

@freezed
sealed class FeedResponse with _$FeedResponse {
  const factory FeedResponse({
    @Default([]) List<Map<String, dynamic>> item,
    @JsonKey(name: 'business_card') dynamic businessCard,
    @JsonKey(name: 'floor_info') @Default([]) List<dynamic> floorInfo,
    @JsonKey(name: 'user_feature') @Default(0) int userFeature,
    @JsonKey(name: 'side_bar_column') @Default('') String sideBarColumn,
  }) = _FeedResponse;

  factory FeedResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseFromJson(json);
}

