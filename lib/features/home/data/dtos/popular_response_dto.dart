import 'package:culcul/core/contracts/video_model_contract.dart';

class PopularResponseDto {
  final List<VideoModel> list;

  const PopularResponseDto({this.list = const []});

  factory PopularResponseDto.fromJson(Map<String, dynamic> json) {
    final listJson = (json['list'] as List<dynamic>?) ?? const <dynamic>[];
    final videos = listJson
        .whereType<Map<dynamic, dynamic>>()
        .map((e) => VideoModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return PopularResponseDto(list: videos);
  }
}
