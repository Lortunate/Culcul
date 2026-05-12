import 'package:culcul/features/profile/data/dtos/relation_model.dart';
import 'package:culcul/features/profile/data/dtos/user_space_video_model.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';

extension RelationUserMapper on RelationUser {
  ProfileRelationUser toDomain() {
    return ProfileRelationUser(
      mid: mid,
      uname: uname,
      face: face,
      sign: sign,
      attribute: attribute,
      officialVerify: officialVerify,
      vip: vip,
      mtime: mtime,
      special: special,
    );
  }
}

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
