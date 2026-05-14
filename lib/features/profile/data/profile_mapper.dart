import 'package:culcul/features/profile/data/dtos/user_space_video_model.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';

extension UserSpaceVideoMapper on UserSpaceVideoModel {
  ProfileVideo toDomain() {
    return ProfileVideo(
      aid: aid,
      bvid: bvid,
      title: title,
      pic: pic,
      tname: tname,
      duration: duration,
      pubDate: pubDate,
      ctime: ctime,
      desc: desc,
      state: state,
      attribute: attribute,
      tid: tid,
      owner: owner,
      stats: stat,
      reason: reason,
      interVideo: interVideo,
    );
  }
}
