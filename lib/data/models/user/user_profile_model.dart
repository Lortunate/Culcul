import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const factory UserProfile({
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
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
