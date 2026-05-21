import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_trending_item.freezed.dart';

@freezed
sealed class SearchTrendingItem with _$SearchTrendingItem {
  const factory SearchTrendingItem({
    required int position,
    required String keyword,
    required String label,
    required int wordType,
    String? icon,
    required int hotId,
    String? isCommercial,
    int? resourceId,
    bool? showLiveIcon,
  }) = _SearchTrendingItem;
}
