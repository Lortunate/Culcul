import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/data/models/video/related_video.dart';
import 'package:culcul/data/models/video/video_model.dart';

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
      rcmd_reason: rcmdReason,
    );
  }
}

extension UserSpaceVideoModelMapping on UserSpaceVideoModel {
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
      rcmd_reason: reason,
    );
  }
}
