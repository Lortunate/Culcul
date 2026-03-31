import 'package:culcul/features/video/models/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_response.freezed.dart';
part 'popular_response.g.dart';

@freezed
sealed class PopularResponse with _$PopularResponse {
  const factory PopularResponse({
    @Default([]) List<VideoModel> list,
    @JsonKey(name: 'no_more') @Default(false) bool noMore,
  }) = _PopularResponse;

  factory PopularResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularResponseFromJson(json);
}
