import 'package:culcul/core/network/dtos/video_model_contract_dto.dart';

class WeeklyModelDto {
  final List<VideoModel> list;

  const WeeklyModelDto({required this.list});

  factory WeeklyModelDto.fromJson(Map<String, dynamic> json) {
    final listJson = (json['list'] as List?) ?? const [];
    final videos = listJson
        .whereType<Map>()
        .map((e) => VideoModelDto.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return WeeklyModelDto(list: videos);
  }
}
