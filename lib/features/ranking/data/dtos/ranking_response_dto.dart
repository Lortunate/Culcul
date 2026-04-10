import 'package:culcul/shared/network/dtos/video_model_contract_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_response_dto.freezed.dart';
part 'ranking_response_dto.g.dart';

@freezed
sealed class RankingResponseDto with _$RankingResponseDto {
  const factory RankingResponseDto({@Default([]) List<VideoModelDto> list}) =
      _RankingResponseDto;

  factory RankingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RankingResponseDtoFromJson(json);
}
