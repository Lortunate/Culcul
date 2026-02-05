import 'package:culcul/domain/entities/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.id,
    required super.username,
    super.avatarUrl,
    super.bio,
    super.location,
    required super.followersCount,
    required super.followingCount,
    required super.videosCount,
    super.dynamicCount,
    super.likesCount,
    super.level,
    super.vipType,
    super.vipStatus,
    super.coins,
    super.bCoins,
    super.currentExp,
    super.nextExp,
    super.currentMinExp,
    required super.isFollowing,
    required super.isVerified,
    super.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  factory UserProfileModel.fromEntity(UserProfile profile) {
    return UserProfileModel(
      id: profile.id,
      username: profile.username,
      avatarUrl: profile.avatarUrl,
      bio: profile.bio,
      location: profile.location,
      followersCount: profile.followersCount,
      followingCount: profile.followingCount,
      videosCount: profile.videosCount,
      dynamicCount: profile.dynamicCount,
      likesCount: profile.likesCount,
      level: profile.level,
      vipType: profile.vipType,
      vipStatus: profile.vipStatus,
      coins: profile.coins,
      currentExp: profile.currentExp,
      nextExp: profile.nextExp,
      currentMinExp: profile.currentMinExp,
      isFollowing: profile.isFollowing,
      isVerified: profile.isVerified,
      createdAt: profile.createdAt,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      username: username,
      avatarUrl: avatarUrl,
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
