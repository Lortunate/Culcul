import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_response.freezed.dart';
part 'ranking_response.g.dart';

@freezed
sealed class RankingResponse with _$RankingResponse {
  const factory RankingResponse({@Default([]) List<VideoModel> list}) = _RankingResponse;

  factory RankingResponse.fromJson(Map<String, dynamic> json) =>
      _$RankingResponseFromJson(json);
}
