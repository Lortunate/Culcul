import 'package:culcul/core/contracts/video_model_contract.dart';

class PopularResponseDto {
  final List<VideoModel> list;
  final bool noMore;

  const PopularResponseDto({this.list = const [], this.noMore = false});

  factory PopularResponseDto.fromJson(Map<String, dynamic> json) {
    final listJson = (json['list'] as List?) ?? const [];
    final videos = listJson
        .whereType<Map>()
        .map((e) => VideoModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return PopularResponseDto(list: videos, noMore: json['no_more'] == true);
  }
}
