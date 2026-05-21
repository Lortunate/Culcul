import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_user.freezed.dart';

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
