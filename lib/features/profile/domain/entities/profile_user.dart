import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_user.freezed.dart';

@freezed
sealed class ProfileUser with _$ProfileUser {
  const factory ProfileUser({
    required String id,
    required String username,
    required String? avatarUrl,
    required String? bannerUrl,
    required String? bio,
    required String? location,
    required int followersCount,
    required int followingCount,
    required int videosCount,
    required int dynamicCount,
    required int likesCount,
    required int level,
    required int vipType,
    required int vipStatus,
    required double? coins,
    required double? bCoins,
    required int? currentExp,
    required int? nextExp,
    required int? currentMinExp,
    required bool isFollowing,
    required bool isVerified,
    required DateTime? createdAt,
  }) = _ProfileUser;
}
