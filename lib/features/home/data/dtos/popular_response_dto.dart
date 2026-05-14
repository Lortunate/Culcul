import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class PopularResponseDto {
  final List<VideoModel> list;

  const PopularResponseDto({this.list = const []});

  factory PopularResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PopularResponseDtoFromJson(json);
}
