import 'live_room_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_recommend_response.freezed.dart';

@freezed
sealed class LiveRecommendResponse with _$LiveRecommendResponse {
  const factory LiveRecommendResponse({required List<LiveRoomModel> roomList}) =
      _LiveRecommendResponse;
}
