import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weekly_model_dto.g.dart';

@JsonSerializable(createToJson: false)
class WeeklyModelDto {
  final List<VideoModel> list;

  const WeeklyModelDto({this.list = const []});

  factory WeeklyModelDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyModelDtoFromJson(json);
}
