import 'package:culcul/features/profile/models/user_space_video_model.dart';

import 'related_video.dart';
import 'video_model.dart';

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
      rcmdReason: reason,
    );
  }
}
