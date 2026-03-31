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

  factory FeedResponse.fromJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);

    final rawItem = normalized['item'];
    if (rawItem is List) {
      normalized['item'] = rawItem
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } else {
      normalized['item'] = const <Map<String, dynamic>>[];
    }

    if (normalized['floor_info'] is! List) {
      normalized['floor_info'] = const <dynamic>[];
    }

    if (normalized['user_feature'] is! num) {
      normalized['user_feature'] = 0;
    }

    if (normalized['side_bar_column'] is! String) {
      normalized['side_bar_column'] = '';
    }

    return _$FeedResponseFromJson(normalized);
  }
}
