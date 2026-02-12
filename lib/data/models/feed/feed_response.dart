import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_response.freezed.dart';
part 'feed_response.g.dart';

@freezed
abstract class FeedResponse with _$FeedResponse {
  const factory FeedResponse({
    @Default([]) List<Map<String, dynamic>> item,
    @JsonKey(name: 'business_card') dynamic businessCard,
    @Default([]) List<dynamic> floor_info,
    @Default(0) int user_feature,
    @Default('') String side_bar_column,
  }) = _FeedResponse;

  factory FeedResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseFromJson(json);
}
