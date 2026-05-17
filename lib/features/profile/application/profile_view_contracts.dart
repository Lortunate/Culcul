import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/profile/data/dtos/profile_user.dart' as dto;
import 'package:culcul/features/profile/data/dtos/profile_video.dart' as dto;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_view_contracts.freezed.dart';

@freezed
sealed class ProfileUser with _$ProfileUser {
  const factory ProfileUser({
    required String id,
    required String username,
    String? avatarUrl,
    String? bannerUrl,
    String? bio,
    String? location,
    required int followersCount,
    required int followingCount,
    required int videosCount,
    @Default(0) int dynamicCount,
    @Default(0) int likesCount,
    @Default(0) int level,
    @Default(0) int vipType,
    @Default(0) int vipStatus,
    double? coins,
    double? bCoins,
    int? currentExp,
    int? nextExp,
    int? currentMinExp,
    required bool isFollowing,
    required bool isVerified,
    DateTime? createdAt,
  }) = _ProfileUser;
}

@freezed
sealed class ProfileVideo with _$ProfileVideo {
  const factory ProfileVideo({
    required int aid,
    required String bvid,
    required String title,
    required String pic,
    required String tname,
    required int duration,
    required int pubDate,
    required int ctime,
    required String desc,
    required int state,
    required int attribute,
    required int tid,
    required VideoOwner owner,
    required VideoStat stats,
    required String reason,
    required bool interVideo,
  }) = _ProfileVideo;
}

extension ProfileUserDtoMapper on dto.ProfileUser {
  ProfileUser toProfileUser() {
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

extension ProfileVideoDtoMapper on dto.ProfileVideo {
  ProfileVideo toProfileVideo() {
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
      stats: stats,
      reason: reason,
      interVideo: interVideo,
    );
  }
}

extension ProfileVideoDtoListMapper on Iterable<dto.ProfileVideo> {
  List<ProfileVideo> toProfileVideos() {
    return map((item) => item.toProfileVideo()).toList();
  }
}
