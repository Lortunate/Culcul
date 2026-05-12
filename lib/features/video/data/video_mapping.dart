import 'dtos/related_video_dto.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';

extension RelatedVideoMapping on RelatedVideo {
  VideoModel toVideoModel() {
    return VideoModel(
      bvid: bvid,
      title: title,
      pic: pic,
      owner: owner,
      stat: stat,
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      rcmdReason: rcmdReason,
    );
  }
}
