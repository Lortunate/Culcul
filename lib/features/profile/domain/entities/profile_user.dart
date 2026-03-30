class ProfileUser {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? bannerUrl;
  final String? bio;
  final String? location;
  final int followersCount;
  final int followingCount;
  final int videosCount;
  final int dynamicCount;
  final int likesCount;
  final int level;
  final int vipType;
  final int vipStatus;
  final double? coins;
  final double? bCoins;
  final int? currentExp;
  final int? nextExp;
  final int? currentMinExp;
  final bool isFollowing;
  final bool isVerified;
  final DateTime? createdAt;

  const ProfileUser({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.bannerUrl,
    required this.bio,
    required this.location,
    required this.followersCount,
    required this.followingCount,
    required this.videosCount,
    required this.dynamicCount,
    required this.likesCount,
    required this.level,
    required this.vipType,
    required this.vipStatus,
    required this.coins,
    required this.bCoins,
    required this.currentExp,
    required this.nextExp,
    required this.currentMinExp,
    required this.isFollowing,
    required this.isVerified,
    required this.createdAt,
  });

  ProfileUser copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    String? bannerUrl,
    String? bio,
    String? location,
    int? followersCount,
    int? followingCount,
    int? videosCount,
    int? dynamicCount,
    int? likesCount,
    int? level,
    int? vipType,
    int? vipStatus,
    double? coins,
    double? bCoins,
    int? currentExp,
    int? nextExp,
    int? currentMinExp,
    bool? isFollowing,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return ProfileUser(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      videosCount: videosCount ?? this.videosCount,
      dynamicCount: dynamicCount ?? this.dynamicCount,
      likesCount: likesCount ?? this.likesCount,
      level: level ?? this.level,
      vipType: vipType ?? this.vipType,
      vipStatus: vipStatus ?? this.vipStatus,
      coins: coins ?? this.coins,
      bCoins: bCoins ?? this.bCoins,
      currentExp: currentExp ?? this.currentExp,
      nextExp: nextExp ?? this.nextExp,
      currentMinExp: currentMinExp ?? this.currentMinExp,
      isFollowing: isFollowing ?? this.isFollowing,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
