import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_trending_keyword.freezed.dart';

@freezed
sealed class SearchTrendingKeyword with _$SearchTrendingKeyword {
  const factory SearchTrendingKeyword({
    required int position,
    required String keyword,
    required String label,
  }) = _SearchTrendingKeyword;
}
