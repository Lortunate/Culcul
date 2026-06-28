class ProfileUser {
  const ProfileUser({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.bannerUrl,
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

  ProfileUser copyWith({
    String? id,
    String? username,
    Object? avatarUrl = _undefined,
    Object? bannerUrl = _undefined,
    Object? bio = _undefined,
    Object? location = _undefined,
    int? followersCount,
    int? followingCount,
    int? videosCount,
    int? dynamicCount,
    int? likesCount,
    int? level,
    int? vipType,
    int? vipStatus,
    Object? coins = _undefined,
    Object? bCoins = _undefined,
    Object? currentExp = _undefined,
    Object? nextExp = _undefined,
    Object? currentMinExp = _undefined,
    bool? isFollowing,
    bool? isVerified,
    Object? createdAt = _undefined,
  }) {
    return ProfileUser(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl == _undefined ? this.avatarUrl : avatarUrl as String?,
      bannerUrl: bannerUrl == _undefined ? this.bannerUrl : bannerUrl as String?,
      bio: bio == _undefined ? this.bio : bio as String?,
      location: location == _undefined ? this.location : location as String?,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      videosCount: videosCount ?? this.videosCount,
      dynamicCount: dynamicCount ?? this.dynamicCount,
      likesCount: likesCount ?? this.likesCount,
      level: level ?? this.level,
      vipType: vipType ?? this.vipType,
      vipStatus: vipStatus ?? this.vipStatus,
      coins: coins == _undefined ? this.coins : coins as double?,
      bCoins: bCoins == _undefined ? this.bCoins : bCoins as double?,
      currentExp: currentExp == _undefined ? this.currentExp : currentExp as int?,
      nextExp: nextExp == _undefined ? this.nextExp : nextExp as int?,
      currentMinExp: currentMinExp == _undefined
          ? this.currentMinExp
          : currentMinExp as int?,
      isFollowing: isFollowing ?? this.isFollowing,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt == _undefined ? this.createdAt : createdAt as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProfileUser &&
            other.id == id &&
            other.username == username &&
            other.avatarUrl == avatarUrl &&
            other.bannerUrl == bannerUrl &&
            other.bio == bio &&
            other.location == location &&
            other.followersCount == followersCount &&
            other.followingCount == followingCount &&
            other.videosCount == videosCount &&
            other.dynamicCount == dynamicCount &&
            other.likesCount == likesCount &&
            other.level == level &&
            other.vipType == vipType &&
            other.vipStatus == vipStatus &&
            other.coins == coins &&
            other.bCoins == bCoins &&
            other.currentExp == currentExp &&
            other.nextExp == nextExp &&
            other.currentMinExp == currentMinExp &&
            other.isFollowing == isFollowing &&
            other.isVerified == isVerified &&
            other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    id,
    username,
    avatarUrl,
    bannerUrl,
    bio,
    location,
    followersCount,
    followingCount,
    videosCount,
    dynamicCount,
    likesCount,
    level,
    vipType,
    vipStatus,
    coins,
    bCoins,
    currentExp,
    nextExp,
    currentMinExp,
    isFollowing,
    isVerified,
    createdAt,
  ]);

  @override
  String toString() {
    return 'ProfileUser(id: $id, username: $username, avatarUrl: $avatarUrl, '
        'bannerUrl: $bannerUrl, bio: $bio, location: $location, '
        'followersCount: $followersCount, followingCount: $followingCount, '
        'videosCount: $videosCount, dynamicCount: $dynamicCount, '
        'likesCount: $likesCount, level: $level, vipType: $vipType, '
        'vipStatus: $vipStatus, coins: $coins, bCoins: $bCoins, '
        'currentExp: $currentExp, nextExp: $nextExp, currentMinExp: $currentMinExp, '
        'isFollowing: $isFollowing, isVerified: $isVerified, createdAt: $createdAt)';
  }
}

const Object _undefined = Object();
