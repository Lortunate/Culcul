import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_response_dto.freezed.dart';
part 'ranking_response_dto.g.dart';

@freezed
sealed class RankingResponseDto with _$RankingResponseDto {
  const factory RankingResponseDto({@Default([]) List<VideoModel> list}) =
      _RankingResponseDto;

  factory RankingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RankingResponseDtoFromJson(json);
}
