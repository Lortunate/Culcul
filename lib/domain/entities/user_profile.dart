class UserProfile {
  final String id;
  final String username;
  final String? avatarUrl;
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

  UserProfile({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.bio,
    this.location,
    required this.followersCount,
    required this.followingCount,
    required this.videosCount,
    this.dynamicCount = 0,
    this.likesCount = 0,
    this.level = 0,
    this.vipType = 0,
    this.vipStatus = 0,
    this.coins,
    this.bCoins,
    this.currentExp,
    this.nextExp,
    this.currentMinExp,
    required this.isFollowing,
    required this.isVerified,
    this.createdAt,
  });

  UserProfile copyWith({
    String? id,
    String? username,
    String? avatarUrl,
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
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          avatarUrl == other.avatarUrl &&
          bio == other.bio &&
          location == other.location &&
          followersCount == other.followersCount &&
          followingCount == other.followingCount &&
          videosCount == other.videosCount &&
          dynamicCount == other.dynamicCount &&
          likesCount == other.likesCount &&
          level == other.level &&
          vipType == other.vipType &&
          vipStatus == other.vipStatus &&
          coins == other.coins &&
          bCoins == other.bCoins &&
          currentExp == other.currentExp &&
          nextExp == other.nextExp &&
          currentMinExp == other.currentMinExp &&
          isFollowing == other.isFollowing &&
          isVerified == other.isVerified &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      avatarUrl.hashCode ^
      bio.hashCode ^
      location.hashCode ^
      followersCount.hashCode ^
      followingCount.hashCode ^
      videosCount.hashCode ^
      dynamicCount.hashCode ^
      likesCount.hashCode ^
      level.hashCode ^
      vipType.hashCode ^
      vipStatus.hashCode ^
      coins.hashCode ^
      bCoins.hashCode ^
      currentExp.hashCode ^
      nextExp.hashCode ^
      currentMinExp.hashCode ^
      isFollowing.hashCode ^
      isVerified.hashCode ^
      createdAt.hashCode;
}
