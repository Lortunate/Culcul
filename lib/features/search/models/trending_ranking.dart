import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending_ranking.freezed.dart';
part 'trending_ranking.g.dart';

@freezed
sealed class TrendingRankingResponse with _$TrendingRankingResponse {
  const factory TrendingRankingResponse({
    required int code,
    required String message,
    required int ttl,
    required TrendingRankingData data,
  }) = _TrendingRankingResponse;

  factory TrendingRankingResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingRankingResponseFromJson(json);
}

@freezed
sealed class TrendingRankingData with _$TrendingRankingData {
  const factory TrendingRankingData({
    required String trackid,
    required List<TrendingItem> list,
    @JsonKey(name: 'top_list') required List<dynamic> topList,
    @JsonKey(name: 'hotword_egg_info') required String hotwordEggInfo,
  }) = _TrendingRankingData;

  factory TrendingRankingData.fromJson(Map<String, dynamic> json) =>
      _$TrendingRankingDataFromJson(json);
}

@freezed
sealed class TrendingItem with _$TrendingItem {
  const factory TrendingItem({
    required int position,
    required String keyword,
    @JsonKey(name: 'show_name') required String showName,
    @JsonKey(name: 'word_type') required int wordType,
    String? icon,
    @JsonKey(name: 'hot_id') required int hotId,
    @JsonKey(name: 'is_commercial') String? isCommercial,
    @JsonKey(name: 'resource_id') int? resourceId,
    @JsonKey(name: 'show_live_icon') bool? showLiveIcon,
  }) = _TrendingItem;

  factory TrendingItem.fromJson(Map<String, dynamic> json) =>
      _$TrendingItemFromJson(json);
}
