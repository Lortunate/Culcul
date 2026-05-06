import 'package:culcul/core/network/dtos/video_model_contract_dto.dart';

class PopularResponseDto {
  final List<VideoModelDto> list;

  const PopularResponseDto({this.list = const []});

  factory PopularResponseDto.fromJson(Map<String, dynamic> json) {
    final listJson = (json['list'] as List?) ?? const [];
    final videos = listJson
        .whereType<Map>()
        .map((e) => VideoModelDto.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return PopularResponseDto(list: videos);
  }
}
