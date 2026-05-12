import 'package:culcul/core/contracts/video_model_contract.dart';

class WeeklyModelDto {
  final List<VideoModel> list;

  const WeeklyModelDto({required this.list});

  factory WeeklyModelDto.fromJson(Map<String, dynamic> json) {
    final listJson = (json['list'] as List<dynamic>?) ?? const <dynamic>[];
    final videos = listJson
        .whereType<Map<dynamic, dynamic>>()
        .map((e) => VideoModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return WeeklyModelDto(list: videos);
  }
}
