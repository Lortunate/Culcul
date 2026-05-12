import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_recommend_response.freezed.dart';
part 'live_recommend_response.g.dart';

@freezed
sealed class LiveRecommendResponse with _$LiveRecommendResponse {
  const factory LiveRecommendResponse({
    @JsonKey(name: 'recommend_room_list') required List<LiveRoomSummary> roomList,
  }) = _LiveRecommendResponse;

  factory LiveRecommendResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveRecommendResponseFromJson(json);
}
