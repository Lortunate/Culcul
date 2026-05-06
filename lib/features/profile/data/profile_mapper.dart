import 'package:culcul/shared/network/dtos/video_model_contract_dto.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';

extension UserProfileMapper on UserProfile {
  ProfileUser toDomain() {
    return ProfileUser(
      id: id,
      username: username,
      avatarUrl: avatarUrl,
      bannerUrl: bannerUrl,
      bio: bio,
      location: location,
      followersCount: followersCount,
      followingCount: followingCount,
      videosCount: videosCount,
      dynamicCount: dynamicCount,
      likesCount: likesCount,
      level: level,
      vipType: vipType,
      vipStatus: vipStatus,
      coins: coins,
      bCoins: bCoins,
      currentExp: currentExp,
      nextExp: nextExp,
      currentMinExp: currentMinExp,
      isFollowing: isFollowing,
      isVerified: isVerified,
      createdAt: createdAt,
    );
  }
}

extension OfficialVerifyMapper on OfficialVerify {
  RelationOfficialVerify toDomain() {
    return RelationOfficialVerify(type: type, desc: desc);
  }
}

extension VipInfoMapper on VipInfo {
  RelationVipInfo toDomain() {
    return RelationVipInfo(
      vipType: vipType,
      vipStatus: vipStatus,
      nicknameColor: nicknameColor,
    );
  }
}

extension RelationUserMapper on RelationUser {
  ProfileRelationUser toDomain() {
    return ProfileRelationUser(
      mid: mid,
      uname: uname,
      face: face,
      sign: sign,
      attribute: attribute,
      officialVerify: officialVerify?.toDomain(),
      vip: vip?.toDomain(),
      mtime: mtime,
      special: special,
    );
  }
}

extension UserSpaceVideoOwnerMapper on VideoOwnerDto {
  ProfileVideoOwner toDomain() {
    return ProfileVideoOwner(mid: mid, name: name, face: face);
  }
}

extension UserSpaceVideoStatsMapper on VideoStatDto {
  ProfileVideoStats toDomain() {
    return ProfileVideoStats(
      view: view,
      danmaku: danmaku,
      reply: reply,
      like: like,
      coin: coin,
      favorite: favorite,
      share: share,
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
      owner: owner.toDomain(),
      stats: stat.toDomain(),
      reason: reason,
      interVideo: interVideo,
    );
  }
}
