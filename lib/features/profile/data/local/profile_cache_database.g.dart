// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_cache_database.dart';

// ignore_for_file: type=lint
class $CachedProfileUsersTable extends CachedProfileUsers
    with TableInfo<$CachedProfileUsersTable, CachedProfileUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProfileUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bannerUrlMeta = const VerificationMeta('bannerUrl');
  @override
  late final GeneratedColumn<String> bannerUrl = GeneratedColumn<String>(
    'banner_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _followersCountMeta = const VerificationMeta(
    'followersCount',
  );
  @override
  late final GeneratedColumn<int> followersCount = GeneratedColumn<int>(
    'followers_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _followingCountMeta = const VerificationMeta(
    'followingCount',
  );
  @override
  late final GeneratedColumn<int> followingCount = GeneratedColumn<int>(
    'following_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _videosCountMeta = const VerificationMeta('videosCount');
  @override
  late final GeneratedColumn<int> videosCount = GeneratedColumn<int>(
    'videos_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dynamicCountMeta = const VerificationMeta(
    'dynamicCount',
  );
  @override
  late final GeneratedColumn<int> dynamicCount = GeneratedColumn<int>(
    'dynamic_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _likesCountMeta = const VerificationMeta('likesCount');
  @override
  late final GeneratedColumn<int> likesCount = GeneratedColumn<int>(
    'likes_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vipTypeMeta = const VerificationMeta('vipType');
  @override
  late final GeneratedColumn<int> vipType = GeneratedColumn<int>(
    'vip_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vipStatusMeta = const VerificationMeta('vipStatus');
  @override
  late final GeneratedColumn<int> vipStatus = GeneratedColumn<int>(
    'vip_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<double> coins = GeneratedColumn<double>(
    'coins',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bCoinsMeta = const VerificationMeta('bCoins');
  @override
  late final GeneratedColumn<double> bCoins = GeneratedColumn<double>(
    'b_coins',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentExpMeta = const VerificationMeta('currentExp');
  @override
  late final GeneratedColumn<int> currentExp = GeneratedColumn<int>(
    'current_exp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextExpMeta = const VerificationMeta('nextExp');
  @override
  late final GeneratedColumn<int> nextExp = GeneratedColumn<int>(
    'next_exp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentMinExpMeta = const VerificationMeta(
    'currentMinExp',
  );
  @override
  late final GeneratedColumn<int> currentMinExp = GeneratedColumn<int>(
    'current_min_exp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFollowingMeta = const VerificationMeta('isFollowing');
  @override
  late final GeneratedColumn<bool> isFollowing = GeneratedColumn<bool>(
    'is_following',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_following" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMillisMeta = const VerificationMeta(
    'createdAtMillis',
  );
  @override
  late final GeneratedColumn<int> createdAtMillis = GeneratedColumn<int>(
    'created_at_millis',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMillisMeta = const VerificationMeta(
    'cachedAtMillis',
  );
  @override
  late final GeneratedColumn<int> cachedAtMillis = GeneratedColumn<int>(
    'cached_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMillisMeta = const VerificationMeta(
    'expiresAtMillis',
  );
  @override
  late final GeneratedColumn<int> expiresAtMillis = GeneratedColumn<int>(
    'expires_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
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
    createdAtMillis,
    cachedAtMillis,
    expiresAtMillis,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_profile_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProfileUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('banner_url')) {
      context.handle(
        _bannerUrlMeta,
        bannerUrl.isAcceptableOrUnknown(data['banner_url']!, _bannerUrlMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(_bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('followers_count')) {
      context.handle(
        _followersCountMeta,
        followersCount.isAcceptableOrUnknown(
          data['followers_count']!,
          _followersCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_followersCountMeta);
    }
    if (data.containsKey('following_count')) {
      context.handle(
        _followingCountMeta,
        followingCount.isAcceptableOrUnknown(
          data['following_count']!,
          _followingCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_followingCountMeta);
    }
    if (data.containsKey('videos_count')) {
      context.handle(
        _videosCountMeta,
        videosCount.isAcceptableOrUnknown(data['videos_count']!, _videosCountMeta),
      );
    } else if (isInserting) {
      context.missing(_videosCountMeta);
    }
    if (data.containsKey('dynamic_count')) {
      context.handle(
        _dynamicCountMeta,
        dynamicCount.isAcceptableOrUnknown(data['dynamic_count']!, _dynamicCountMeta),
      );
    }
    if (data.containsKey('likes_count')) {
      context.handle(
        _likesCountMeta,
        likesCount.isAcceptableOrUnknown(data['likes_count']!, _likesCountMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(_levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('vip_type')) {
      context.handle(
        _vipTypeMeta,
        vipType.isAcceptableOrUnknown(data['vip_type']!, _vipTypeMeta),
      );
    }
    if (data.containsKey('vip_status')) {
      context.handle(
        _vipStatusMeta,
        vipStatus.isAcceptableOrUnknown(data['vip_status']!, _vipStatusMeta),
      );
    }
    if (data.containsKey('coins')) {
      context.handle(_coinsMeta, coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta));
    }
    if (data.containsKey('b_coins')) {
      context.handle(
        _bCoinsMeta,
        bCoins.isAcceptableOrUnknown(data['b_coins']!, _bCoinsMeta),
      );
    }
    if (data.containsKey('current_exp')) {
      context.handle(
        _currentExpMeta,
        currentExp.isAcceptableOrUnknown(data['current_exp']!, _currentExpMeta),
      );
    }
    if (data.containsKey('next_exp')) {
      context.handle(
        _nextExpMeta,
        nextExp.isAcceptableOrUnknown(data['next_exp']!, _nextExpMeta),
      );
    }
    if (data.containsKey('current_min_exp')) {
      context.handle(
        _currentMinExpMeta,
        currentMinExp.isAcceptableOrUnknown(data['current_min_exp']!, _currentMinExpMeta),
      );
    }
    if (data.containsKey('is_following')) {
      context.handle(
        _isFollowingMeta,
        isFollowing.isAcceptableOrUnknown(data['is_following']!, _isFollowingMeta),
      );
    } else if (isInserting) {
      context.missing(_isFollowingMeta);
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    } else if (isInserting) {
      context.missing(_isVerifiedMeta);
    }
    if (data.containsKey('created_at_millis')) {
      context.handle(
        _createdAtMillisMeta,
        createdAtMillis.isAcceptableOrUnknown(
          data['created_at_millis']!,
          _createdAtMillisMeta,
        ),
      );
    }
    if (data.containsKey('cached_at_millis')) {
      context.handle(
        _cachedAtMillisMeta,
        cachedAtMillis.isAcceptableOrUnknown(
          data['cached_at_millis']!,
          _cachedAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMillisMeta);
    }
    if (data.containsKey('expires_at_millis')) {
      context.handle(
        _expiresAtMillisMeta,
        expiresAtMillis.isAcceptableOrUnknown(
          data['expires_at_millis']!,
          _expiresAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMillisMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  CachedProfileUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProfileUser(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      bannerUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner_url'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      followersCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}followers_count'],
      )!,
      followingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}following_count'],
      )!,
      videosCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}videos_count'],
      )!,
      dynamicCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dynamic_count'],
      )!,
      likesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}likes_count'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      vipType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vip_type'],
      )!,
      vipStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vip_status'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coins'],
      ),
      bCoins: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}b_coins'],
      ),
      currentExp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_exp'],
      ),
      nextExp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_exp'],
      ),
      currentMinExp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_min_exp'],
      ),
      isFollowing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_following'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      createdAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_millis'],
      ),
      cachedAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cached_at_millis'],
      )!,
      expiresAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at_millis'],
      )!,
    );
  }

  @override
  $CachedProfileUsersTable createAlias(String alias) {
    return $CachedProfileUsersTable(attachedDatabase, alias);
  }
}

class CachedProfileUser extends DataClass implements Insertable<CachedProfileUser> {
  final String userId;
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
  final int? createdAtMillis;
  final int cachedAtMillis;
  final int expiresAtMillis;
  const CachedProfileUser({
    required this.userId,
    required this.username,
    this.avatarUrl,
    this.bannerUrl,
    this.bio,
    this.location,
    required this.followersCount,
    required this.followingCount,
    required this.videosCount,
    required this.dynamicCount,
    required this.likesCount,
    required this.level,
    required this.vipType,
    required this.vipStatus,
    this.coins,
    this.bCoins,
    this.currentExp,
    this.nextExp,
    this.currentMinExp,
    required this.isFollowing,
    required this.isVerified,
    this.createdAtMillis,
    required this.cachedAtMillis,
    required this.expiresAtMillis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || bannerUrl != null) {
      map['banner_url'] = Variable<String>(bannerUrl);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['followers_count'] = Variable<int>(followersCount);
    map['following_count'] = Variable<int>(followingCount);
    map['videos_count'] = Variable<int>(videosCount);
    map['dynamic_count'] = Variable<int>(dynamicCount);
    map['likes_count'] = Variable<int>(likesCount);
    map['level'] = Variable<int>(level);
    map['vip_type'] = Variable<int>(vipType);
    map['vip_status'] = Variable<int>(vipStatus);
    if (!nullToAbsent || coins != null) {
      map['coins'] = Variable<double>(coins);
    }
    if (!nullToAbsent || bCoins != null) {
      map['b_coins'] = Variable<double>(bCoins);
    }
    if (!nullToAbsent || currentExp != null) {
      map['current_exp'] = Variable<int>(currentExp);
    }
    if (!nullToAbsent || nextExp != null) {
      map['next_exp'] = Variable<int>(nextExp);
    }
    if (!nullToAbsent || currentMinExp != null) {
      map['current_min_exp'] = Variable<int>(currentMinExp);
    }
    map['is_following'] = Variable<bool>(isFollowing);
    map['is_verified'] = Variable<bool>(isVerified);
    if (!nullToAbsent || createdAtMillis != null) {
      map['created_at_millis'] = Variable<int>(createdAtMillis);
    }
    map['cached_at_millis'] = Variable<int>(cachedAtMillis);
    map['expires_at_millis'] = Variable<int>(expiresAtMillis);
    return map;
  }

  CachedProfileUsersCompanion toCompanion(bool nullToAbsent) {
    return CachedProfileUsersCompanion(
      userId: Value(userId),
      username: Value(username),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      bannerUrl: bannerUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(bannerUrl),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      location: location == null && nullToAbsent ? const Value.absent() : Value(location),
      followersCount: Value(followersCount),
      followingCount: Value(followingCount),
      videosCount: Value(videosCount),
      dynamicCount: Value(dynamicCount),
      likesCount: Value(likesCount),
      level: Value(level),
      vipType: Value(vipType),
      vipStatus: Value(vipStatus),
      coins: coins == null && nullToAbsent ? const Value.absent() : Value(coins),
      bCoins: bCoins == null && nullToAbsent ? const Value.absent() : Value(bCoins),
      currentExp: currentExp == null && nullToAbsent
          ? const Value.absent()
          : Value(currentExp),
      nextExp: nextExp == null && nullToAbsent ? const Value.absent() : Value(nextExp),
      currentMinExp: currentMinExp == null && nullToAbsent
          ? const Value.absent()
          : Value(currentMinExp),
      isFollowing: Value(isFollowing),
      isVerified: Value(isVerified),
      createdAtMillis: createdAtMillis == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAtMillis),
      cachedAtMillis: Value(cachedAtMillis),
      expiresAtMillis: Value(expiresAtMillis),
    );
  }

  factory CachedProfileUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProfileUser(
      userId: serializer.fromJson<String>(json['userId']),
      username: serializer.fromJson<String>(json['username']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      bannerUrl: serializer.fromJson<String?>(json['bannerUrl']),
      bio: serializer.fromJson<String?>(json['bio']),
      location: serializer.fromJson<String?>(json['location']),
      followersCount: serializer.fromJson<int>(json['followersCount']),
      followingCount: serializer.fromJson<int>(json['followingCount']),
      videosCount: serializer.fromJson<int>(json['videosCount']),
      dynamicCount: serializer.fromJson<int>(json['dynamicCount']),
      likesCount: serializer.fromJson<int>(json['likesCount']),
      level: serializer.fromJson<int>(json['level']),
      vipType: serializer.fromJson<int>(json['vipType']),
      vipStatus: serializer.fromJson<int>(json['vipStatus']),
      coins: serializer.fromJson<double?>(json['coins']),
      bCoins: serializer.fromJson<double?>(json['bCoins']),
      currentExp: serializer.fromJson<int?>(json['currentExp']),
      nextExp: serializer.fromJson<int?>(json['nextExp']),
      currentMinExp: serializer.fromJson<int?>(json['currentMinExp']),
      isFollowing: serializer.fromJson<bool>(json['isFollowing']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      createdAtMillis: serializer.fromJson<int?>(json['createdAtMillis']),
      cachedAtMillis: serializer.fromJson<int>(json['cachedAtMillis']),
      expiresAtMillis: serializer.fromJson<int>(json['expiresAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'username': serializer.toJson<String>(username),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'bannerUrl': serializer.toJson<String?>(bannerUrl),
      'bio': serializer.toJson<String?>(bio),
      'location': serializer.toJson<String?>(location),
      'followersCount': serializer.toJson<int>(followersCount),
      'followingCount': serializer.toJson<int>(followingCount),
      'videosCount': serializer.toJson<int>(videosCount),
      'dynamicCount': serializer.toJson<int>(dynamicCount),
      'likesCount': serializer.toJson<int>(likesCount),
      'level': serializer.toJson<int>(level),
      'vipType': serializer.toJson<int>(vipType),
      'vipStatus': serializer.toJson<int>(vipStatus),
      'coins': serializer.toJson<double?>(coins),
      'bCoins': serializer.toJson<double?>(bCoins),
      'currentExp': serializer.toJson<int?>(currentExp),
      'nextExp': serializer.toJson<int?>(nextExp),
      'currentMinExp': serializer.toJson<int?>(currentMinExp),
      'isFollowing': serializer.toJson<bool>(isFollowing),
      'isVerified': serializer.toJson<bool>(isVerified),
      'createdAtMillis': serializer.toJson<int?>(createdAtMillis),
      'cachedAtMillis': serializer.toJson<int>(cachedAtMillis),
      'expiresAtMillis': serializer.toJson<int>(expiresAtMillis),
    };
  }

  CachedProfileUser copyWith({
    String? userId,
    String? username,
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> bannerUrl = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    Value<String?> location = const Value.absent(),
    int? followersCount,
    int? followingCount,
    int? videosCount,
    int? dynamicCount,
    int? likesCount,
    int? level,
    int? vipType,
    int? vipStatus,
    Value<double?> coins = const Value.absent(),
    Value<double?> bCoins = const Value.absent(),
    Value<int?> currentExp = const Value.absent(),
    Value<int?> nextExp = const Value.absent(),
    Value<int?> currentMinExp = const Value.absent(),
    bool? isFollowing,
    bool? isVerified,
    Value<int?> createdAtMillis = const Value.absent(),
    int? cachedAtMillis,
    int? expiresAtMillis,
  }) => CachedProfileUser(
    userId: userId ?? this.userId,
    username: username ?? this.username,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    bannerUrl: bannerUrl.present ? bannerUrl.value : this.bannerUrl,
    bio: bio.present ? bio.value : this.bio,
    location: location.present ? location.value : this.location,
    followersCount: followersCount ?? this.followersCount,
    followingCount: followingCount ?? this.followingCount,
    videosCount: videosCount ?? this.videosCount,
    dynamicCount: dynamicCount ?? this.dynamicCount,
    likesCount: likesCount ?? this.likesCount,
    level: level ?? this.level,
    vipType: vipType ?? this.vipType,
    vipStatus: vipStatus ?? this.vipStatus,
    coins: coins.present ? coins.value : this.coins,
    bCoins: bCoins.present ? bCoins.value : this.bCoins,
    currentExp: currentExp.present ? currentExp.value : this.currentExp,
    nextExp: nextExp.present ? nextExp.value : this.nextExp,
    currentMinExp: currentMinExp.present ? currentMinExp.value : this.currentMinExp,
    isFollowing: isFollowing ?? this.isFollowing,
    isVerified: isVerified ?? this.isVerified,
    createdAtMillis: createdAtMillis.present
        ? createdAtMillis.value
        : this.createdAtMillis,
    cachedAtMillis: cachedAtMillis ?? this.cachedAtMillis,
    expiresAtMillis: expiresAtMillis ?? this.expiresAtMillis,
  );
  CachedProfileUser copyWithCompanion(CachedProfileUsersCompanion data) {
    return CachedProfileUser(
      userId: data.userId.present ? data.userId.value : this.userId,
      username: data.username.present ? data.username.value : this.username,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      bannerUrl: data.bannerUrl.present ? data.bannerUrl.value : this.bannerUrl,
      bio: data.bio.present ? data.bio.value : this.bio,
      location: data.location.present ? data.location.value : this.location,
      followersCount: data.followersCount.present
          ? data.followersCount.value
          : this.followersCount,
      followingCount: data.followingCount.present
          ? data.followingCount.value
          : this.followingCount,
      videosCount: data.videosCount.present ? data.videosCount.value : this.videosCount,
      dynamicCount: data.dynamicCount.present
          ? data.dynamicCount.value
          : this.dynamicCount,
      likesCount: data.likesCount.present ? data.likesCount.value : this.likesCount,
      level: data.level.present ? data.level.value : this.level,
      vipType: data.vipType.present ? data.vipType.value : this.vipType,
      vipStatus: data.vipStatus.present ? data.vipStatus.value : this.vipStatus,
      coins: data.coins.present ? data.coins.value : this.coins,
      bCoins: data.bCoins.present ? data.bCoins.value : this.bCoins,
      currentExp: data.currentExp.present ? data.currentExp.value : this.currentExp,
      nextExp: data.nextExp.present ? data.nextExp.value : this.nextExp,
      currentMinExp: data.currentMinExp.present
          ? data.currentMinExp.value
          : this.currentMinExp,
      isFollowing: data.isFollowing.present ? data.isFollowing.value : this.isFollowing,
      isVerified: data.isVerified.present ? data.isVerified.value : this.isVerified,
      createdAtMillis: data.createdAtMillis.present
          ? data.createdAtMillis.value
          : this.createdAtMillis,
      cachedAtMillis: data.cachedAtMillis.present
          ? data.cachedAtMillis.value
          : this.cachedAtMillis,
      expiresAtMillis: data.expiresAtMillis.present
          ? data.expiresAtMillis.value
          : this.expiresAtMillis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProfileUser(')
          ..write('userId: $userId, ')
          ..write('username: $username, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('bio: $bio, ')
          ..write('location: $location, ')
          ..write('followersCount: $followersCount, ')
          ..write('followingCount: $followingCount, ')
          ..write('videosCount: $videosCount, ')
          ..write('dynamicCount: $dynamicCount, ')
          ..write('likesCount: $likesCount, ')
          ..write('level: $level, ')
          ..write('vipType: $vipType, ')
          ..write('vipStatus: $vipStatus, ')
          ..write('coins: $coins, ')
          ..write('bCoins: $bCoins, ')
          ..write('currentExp: $currentExp, ')
          ..write('nextExp: $nextExp, ')
          ..write('currentMinExp: $currentMinExp, ')
          ..write('isFollowing: $isFollowing, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('cachedAtMillis: $cachedAtMillis, ')
          ..write('expiresAtMillis: $expiresAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    userId,
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
    createdAtMillis,
    cachedAtMillis,
    expiresAtMillis,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProfileUser &&
          other.userId == this.userId &&
          other.username == this.username &&
          other.avatarUrl == this.avatarUrl &&
          other.bannerUrl == this.bannerUrl &&
          other.bio == this.bio &&
          other.location == this.location &&
          other.followersCount == this.followersCount &&
          other.followingCount == this.followingCount &&
          other.videosCount == this.videosCount &&
          other.dynamicCount == this.dynamicCount &&
          other.likesCount == this.likesCount &&
          other.level == this.level &&
          other.vipType == this.vipType &&
          other.vipStatus == this.vipStatus &&
          other.coins == this.coins &&
          other.bCoins == this.bCoins &&
          other.currentExp == this.currentExp &&
          other.nextExp == this.nextExp &&
          other.currentMinExp == this.currentMinExp &&
          other.isFollowing == this.isFollowing &&
          other.isVerified == this.isVerified &&
          other.createdAtMillis == this.createdAtMillis &&
          other.cachedAtMillis == this.cachedAtMillis &&
          other.expiresAtMillis == this.expiresAtMillis);
}

class CachedProfileUsersCompanion extends UpdateCompanion<CachedProfileUser> {
  final Value<String> userId;
  final Value<String> username;
  final Value<String?> avatarUrl;
  final Value<String?> bannerUrl;
  final Value<String?> bio;
  final Value<String?> location;
  final Value<int> followersCount;
  final Value<int> followingCount;
  final Value<int> videosCount;
  final Value<int> dynamicCount;
  final Value<int> likesCount;
  final Value<int> level;
  final Value<int> vipType;
  final Value<int> vipStatus;
  final Value<double?> coins;
  final Value<double?> bCoins;
  final Value<int?> currentExp;
  final Value<int?> nextExp;
  final Value<int?> currentMinExp;
  final Value<bool> isFollowing;
  final Value<bool> isVerified;
  final Value<int?> createdAtMillis;
  final Value<int> cachedAtMillis;
  final Value<int> expiresAtMillis;
  final Value<int> rowid;
  const CachedProfileUsersCompanion({
    this.userId = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.location = const Value.absent(),
    this.followersCount = const Value.absent(),
    this.followingCount = const Value.absent(),
    this.videosCount = const Value.absent(),
    this.dynamicCount = const Value.absent(),
    this.likesCount = const Value.absent(),
    this.level = const Value.absent(),
    this.vipType = const Value.absent(),
    this.vipStatus = const Value.absent(),
    this.coins = const Value.absent(),
    this.bCoins = const Value.absent(),
    this.currentExp = const Value.absent(),
    this.nextExp = const Value.absent(),
    this.currentMinExp = const Value.absent(),
    this.isFollowing = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAtMillis = const Value.absent(),
    this.cachedAtMillis = const Value.absent(),
    this.expiresAtMillis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProfileUsersCompanion.insert({
    required String userId,
    required String username,
    this.avatarUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.location = const Value.absent(),
    required int followersCount,
    required int followingCount,
    required int videosCount,
    this.dynamicCount = const Value.absent(),
    this.likesCount = const Value.absent(),
    this.level = const Value.absent(),
    this.vipType = const Value.absent(),
    this.vipStatus = const Value.absent(),
    this.coins = const Value.absent(),
    this.bCoins = const Value.absent(),
    this.currentExp = const Value.absent(),
    this.nextExp = const Value.absent(),
    this.currentMinExp = const Value.absent(),
    required bool isFollowing,
    required bool isVerified,
    this.createdAtMillis = const Value.absent(),
    required int cachedAtMillis,
    required int expiresAtMillis,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       username = Value(username),
       followersCount = Value(followersCount),
       followingCount = Value(followingCount),
       videosCount = Value(videosCount),
       isFollowing = Value(isFollowing),
       isVerified = Value(isVerified),
       cachedAtMillis = Value(cachedAtMillis),
       expiresAtMillis = Value(expiresAtMillis);
  static Insertable<CachedProfileUser> custom({
    Expression<String>? userId,
    Expression<String>? username,
    Expression<String>? avatarUrl,
    Expression<String>? bannerUrl,
    Expression<String>? bio,
    Expression<String>? location,
    Expression<int>? followersCount,
    Expression<int>? followingCount,
    Expression<int>? videosCount,
    Expression<int>? dynamicCount,
    Expression<int>? likesCount,
    Expression<int>? level,
    Expression<int>? vipType,
    Expression<int>? vipStatus,
    Expression<double>? coins,
    Expression<double>? bCoins,
    Expression<int>? currentExp,
    Expression<int>? nextExp,
    Expression<int>? currentMinExp,
    Expression<bool>? isFollowing,
    Expression<bool>? isVerified,
    Expression<int>? createdAtMillis,
    Expression<int>? cachedAtMillis,
    Expression<int>? expiresAtMillis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bannerUrl != null) 'banner_url': bannerUrl,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (followersCount != null) 'followers_count': followersCount,
      if (followingCount != null) 'following_count': followingCount,
      if (videosCount != null) 'videos_count': videosCount,
      if (dynamicCount != null) 'dynamic_count': dynamicCount,
      if (likesCount != null) 'likes_count': likesCount,
      if (level != null) 'level': level,
      if (vipType != null) 'vip_type': vipType,
      if (vipStatus != null) 'vip_status': vipStatus,
      if (coins != null) 'coins': coins,
      if (bCoins != null) 'b_coins': bCoins,
      if (currentExp != null) 'current_exp': currentExp,
      if (nextExp != null) 'next_exp': nextExp,
      if (currentMinExp != null) 'current_min_exp': currentMinExp,
      if (isFollowing != null) 'is_following': isFollowing,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAtMillis != null) 'created_at_millis': createdAtMillis,
      if (cachedAtMillis != null) 'cached_at_millis': cachedAtMillis,
      if (expiresAtMillis != null) 'expires_at_millis': expiresAtMillis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProfileUsersCompanion copyWith({
    Value<String>? userId,
    Value<String>? username,
    Value<String?>? avatarUrl,
    Value<String?>? bannerUrl,
    Value<String?>? bio,
    Value<String?>? location,
    Value<int>? followersCount,
    Value<int>? followingCount,
    Value<int>? videosCount,
    Value<int>? dynamicCount,
    Value<int>? likesCount,
    Value<int>? level,
    Value<int>? vipType,
    Value<int>? vipStatus,
    Value<double?>? coins,
    Value<double?>? bCoins,
    Value<int?>? currentExp,
    Value<int?>? nextExp,
    Value<int?>? currentMinExp,
    Value<bool>? isFollowing,
    Value<bool>? isVerified,
    Value<int?>? createdAtMillis,
    Value<int>? cachedAtMillis,
    Value<int>? expiresAtMillis,
    Value<int>? rowid,
  }) {
    return CachedProfileUsersCompanion(
      userId: userId ?? this.userId,
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
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      cachedAtMillis: cachedAtMillis ?? this.cachedAtMillis,
      expiresAtMillis: expiresAtMillis ?? this.expiresAtMillis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (bannerUrl.present) {
      map['banner_url'] = Variable<String>(bannerUrl.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (followersCount.present) {
      map['followers_count'] = Variable<int>(followersCount.value);
    }
    if (followingCount.present) {
      map['following_count'] = Variable<int>(followingCount.value);
    }
    if (videosCount.present) {
      map['videos_count'] = Variable<int>(videosCount.value);
    }
    if (dynamicCount.present) {
      map['dynamic_count'] = Variable<int>(dynamicCount.value);
    }
    if (likesCount.present) {
      map['likes_count'] = Variable<int>(likesCount.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (vipType.present) {
      map['vip_type'] = Variable<int>(vipType.value);
    }
    if (vipStatus.present) {
      map['vip_status'] = Variable<int>(vipStatus.value);
    }
    if (coins.present) {
      map['coins'] = Variable<double>(coins.value);
    }
    if (bCoins.present) {
      map['b_coins'] = Variable<double>(bCoins.value);
    }
    if (currentExp.present) {
      map['current_exp'] = Variable<int>(currentExp.value);
    }
    if (nextExp.present) {
      map['next_exp'] = Variable<int>(nextExp.value);
    }
    if (currentMinExp.present) {
      map['current_min_exp'] = Variable<int>(currentMinExp.value);
    }
    if (isFollowing.present) {
      map['is_following'] = Variable<bool>(isFollowing.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (createdAtMillis.present) {
      map['created_at_millis'] = Variable<int>(createdAtMillis.value);
    }
    if (cachedAtMillis.present) {
      map['cached_at_millis'] = Variable<int>(cachedAtMillis.value);
    }
    if (expiresAtMillis.present) {
      map['expires_at_millis'] = Variable<int>(expiresAtMillis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedProfileUsersCompanion(')
          ..write('userId: $userId, ')
          ..write('username: $username, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('bio: $bio, ')
          ..write('location: $location, ')
          ..write('followersCount: $followersCount, ')
          ..write('followingCount: $followingCount, ')
          ..write('videosCount: $videosCount, ')
          ..write('dynamicCount: $dynamicCount, ')
          ..write('likesCount: $likesCount, ')
          ..write('level: $level, ')
          ..write('vipType: $vipType, ')
          ..write('vipStatus: $vipStatus, ')
          ..write('coins: $coins, ')
          ..write('bCoins: $bCoins, ')
          ..write('currentExp: $currentExp, ')
          ..write('nextExp: $nextExp, ')
          ..write('currentMinExp: $currentMinExp, ')
          ..write('isFollowing: $isFollowing, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('cachedAtMillis: $cachedAtMillis, ')
          ..write('expiresAtMillis: $expiresAtMillis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProfileCacheDatabase extends GeneratedDatabase {
  _$ProfileCacheDatabase(QueryExecutor e) : super(e);
  $ProfileCacheDatabaseManager get managers => $ProfileCacheDatabaseManager(this);
  late final $CachedProfileUsersTable cachedProfileUsers = $CachedProfileUsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedProfileUsers];
}

typedef $$CachedProfileUsersTableCreateCompanionBuilder =
    CachedProfileUsersCompanion Function({
      required String userId,
      required String username,
      Value<String?> avatarUrl,
      Value<String?> bannerUrl,
      Value<String?> bio,
      Value<String?> location,
      required int followersCount,
      required int followingCount,
      required int videosCount,
      Value<int> dynamicCount,
      Value<int> likesCount,
      Value<int> level,
      Value<int> vipType,
      Value<int> vipStatus,
      Value<double?> coins,
      Value<double?> bCoins,
      Value<int?> currentExp,
      Value<int?> nextExp,
      Value<int?> currentMinExp,
      required bool isFollowing,
      required bool isVerified,
      Value<int?> createdAtMillis,
      required int cachedAtMillis,
      required int expiresAtMillis,
      Value<int> rowid,
    });
typedef $$CachedProfileUsersTableUpdateCompanionBuilder =
    CachedProfileUsersCompanion Function({
      Value<String> userId,
      Value<String> username,
      Value<String?> avatarUrl,
      Value<String?> bannerUrl,
      Value<String?> bio,
      Value<String?> location,
      Value<int> followersCount,
      Value<int> followingCount,
      Value<int> videosCount,
      Value<int> dynamicCount,
      Value<int> likesCount,
      Value<int> level,
      Value<int> vipType,
      Value<int> vipStatus,
      Value<double?> coins,
      Value<double?> bCoins,
      Value<int?> currentExp,
      Value<int?> nextExp,
      Value<int?> currentMinExp,
      Value<bool> isFollowing,
      Value<bool> isVerified,
      Value<int?> createdAtMillis,
      Value<int> cachedAtMillis,
      Value<int> expiresAtMillis,
      Value<int> rowid,
    });

class $$CachedProfileUsersTableFilterComposer
    extends Composer<_$ProfileCacheDatabase, $CachedProfileUsersTable> {
  $$CachedProfileUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get followersCount => $composableBuilder(
    column: $table.followersCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get followingCount => $composableBuilder(
    column: $table.followingCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get videosCount => $composableBuilder(
    column: $table.videosCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dynamicCount => $composableBuilder(
    column: $table.dynamicCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likesCount => $composableBuilder(
    column: $table.likesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vipType => $composableBuilder(
    column: $table.vipType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vipStatus => $composableBuilder(
    column: $table.vipStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bCoins => $composableBuilder(
    column: $table.bCoins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentExp => $composableBuilder(
    column: $table.currentExp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextExp => $composableBuilder(
    column: $table.nextExp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentMinExp => $composableBuilder(
    column: $table.currentMinExp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFollowing => $composableBuilder(
    column: $table.isFollowing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cachedAtMillis => $composableBuilder(
    column: $table.cachedAtMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAtMillis => $composableBuilder(
    column: $table.expiresAtMillis,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedProfileUsersTableOrderingComposer
    extends Composer<_$ProfileCacheDatabase, $CachedProfileUsersTable> {
  $$CachedProfileUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get followersCount => $composableBuilder(
    column: $table.followersCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get followingCount => $composableBuilder(
    column: $table.followingCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get videosCount => $composableBuilder(
    column: $table.videosCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dynamicCount => $composableBuilder(
    column: $table.dynamicCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likesCount => $composableBuilder(
    column: $table.likesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vipType => $composableBuilder(
    column: $table.vipType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vipStatus => $composableBuilder(
    column: $table.vipStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bCoins => $composableBuilder(
    column: $table.bCoins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentExp => $composableBuilder(
    column: $table.currentExp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextExp => $composableBuilder(
    column: $table.nextExp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentMinExp => $composableBuilder(
    column: $table.currentMinExp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFollowing => $composableBuilder(
    column: $table.isFollowing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cachedAtMillis => $composableBuilder(
    column: $table.cachedAtMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAtMillis => $composableBuilder(
    column: $table.expiresAtMillis,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedProfileUsersTableAnnotationComposer
    extends Composer<_$ProfileCacheDatabase, $CachedProfileUsersTable> {
  $$CachedProfileUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get bannerUrl =>
      $composableBuilder(column: $table.bannerUrl, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get followersCount =>
      $composableBuilder(column: $table.followersCount, builder: (column) => column);

  GeneratedColumn<int> get followingCount =>
      $composableBuilder(column: $table.followingCount, builder: (column) => column);

  GeneratedColumn<int> get videosCount =>
      $composableBuilder(column: $table.videosCount, builder: (column) => column);

  GeneratedColumn<int> get dynamicCount =>
      $composableBuilder(column: $table.dynamicCount, builder: (column) => column);

  GeneratedColumn<int> get likesCount =>
      $composableBuilder(column: $table.likesCount, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get vipType =>
      $composableBuilder(column: $table.vipType, builder: (column) => column);

  GeneratedColumn<int> get vipStatus =>
      $composableBuilder(column: $table.vipStatus, builder: (column) => column);

  GeneratedColumn<double> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);

  GeneratedColumn<double> get bCoins =>
      $composableBuilder(column: $table.bCoins, builder: (column) => column);

  GeneratedColumn<int> get currentExp =>
      $composableBuilder(column: $table.currentExp, builder: (column) => column);

  GeneratedColumn<int> get nextExp =>
      $composableBuilder(column: $table.nextExp, builder: (column) => column);

  GeneratedColumn<int> get currentMinExp =>
      $composableBuilder(column: $table.currentMinExp, builder: (column) => column);

  GeneratedColumn<bool> get isFollowing =>
      $composableBuilder(column: $table.isFollowing, builder: (column) => column);

  GeneratedColumn<bool> get isVerified =>
      $composableBuilder(column: $table.isVerified, builder: (column) => column);

  GeneratedColumn<int> get createdAtMillis =>
      $composableBuilder(column: $table.createdAtMillis, builder: (column) => column);

  GeneratedColumn<int> get cachedAtMillis =>
      $composableBuilder(column: $table.cachedAtMillis, builder: (column) => column);

  GeneratedColumn<int> get expiresAtMillis =>
      $composableBuilder(column: $table.expiresAtMillis, builder: (column) => column);
}

class $$CachedProfileUsersTableTableManager
    extends
        RootTableManager<
          _$ProfileCacheDatabase,
          $CachedProfileUsersTable,
          CachedProfileUser,
          $$CachedProfileUsersTableFilterComposer,
          $$CachedProfileUsersTableOrderingComposer,
          $$CachedProfileUsersTableAnnotationComposer,
          $$CachedProfileUsersTableCreateCompanionBuilder,
          $$CachedProfileUsersTableUpdateCompanionBuilder,
          (
            CachedProfileUser,
            BaseReferences<
              _$ProfileCacheDatabase,
              $CachedProfileUsersTable,
              CachedProfileUser
            >,
          ),
          CachedProfileUser,
          PrefetchHooks Function()
        > {
  $$CachedProfileUsersTableTableManager(
    _$ProfileCacheDatabase db,
    $CachedProfileUsersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProfileUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedProfileUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedProfileUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> followersCount = const Value.absent(),
                Value<int> followingCount = const Value.absent(),
                Value<int> videosCount = const Value.absent(),
                Value<int> dynamicCount = const Value.absent(),
                Value<int> likesCount = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> vipType = const Value.absent(),
                Value<int> vipStatus = const Value.absent(),
                Value<double?> coins = const Value.absent(),
                Value<double?> bCoins = const Value.absent(),
                Value<int?> currentExp = const Value.absent(),
                Value<int?> nextExp = const Value.absent(),
                Value<int?> currentMinExp = const Value.absent(),
                Value<bool> isFollowing = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<int?> createdAtMillis = const Value.absent(),
                Value<int> cachedAtMillis = const Value.absent(),
                Value<int> expiresAtMillis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProfileUsersCompanion(
                userId: userId,
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
                createdAtMillis: createdAtMillis,
                cachedAtMillis: cachedAtMillis,
                expiresAtMillis: expiresAtMillis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String username,
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> location = const Value.absent(),
                required int followersCount,
                required int followingCount,
                required int videosCount,
                Value<int> dynamicCount = const Value.absent(),
                Value<int> likesCount = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> vipType = const Value.absent(),
                Value<int> vipStatus = const Value.absent(),
                Value<double?> coins = const Value.absent(),
                Value<double?> bCoins = const Value.absent(),
                Value<int?> currentExp = const Value.absent(),
                Value<int?> nextExp = const Value.absent(),
                Value<int?> currentMinExp = const Value.absent(),
                required bool isFollowing,
                required bool isVerified,
                Value<int?> createdAtMillis = const Value.absent(),
                required int cachedAtMillis,
                required int expiresAtMillis,
                Value<int> rowid = const Value.absent(),
              }) => CachedProfileUsersCompanion.insert(
                userId: userId,
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
                createdAtMillis: createdAtMillis,
                cachedAtMillis: cachedAtMillis,
                expiresAtMillis: expiresAtMillis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedProfileUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$ProfileCacheDatabase,
      $CachedProfileUsersTable,
      CachedProfileUser,
      $$CachedProfileUsersTableFilterComposer,
      $$CachedProfileUsersTableOrderingComposer,
      $$CachedProfileUsersTableAnnotationComposer,
      $$CachedProfileUsersTableCreateCompanionBuilder,
      $$CachedProfileUsersTableUpdateCompanionBuilder,
      (
        CachedProfileUser,
        BaseReferences<
          _$ProfileCacheDatabase,
          $CachedProfileUsersTable,
          CachedProfileUser
        >,
      ),
      CachedProfileUser,
      PrefetchHooks Function()
    >;

class $ProfileCacheDatabaseManager {
  final _$ProfileCacheDatabase _db;
  $ProfileCacheDatabaseManager(this._db);
  $$CachedProfileUsersTableTableManager get cachedProfileUsers =>
      $$CachedProfileUsersTableTableManager(_db, _db.cachedProfileUsers);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileCacheDatabase)
final profileCacheDatabaseProvider = ProfileCacheDatabaseProvider._();

final class ProfileCacheDatabaseProvider
    extends
        $FunctionalProvider<
          ProfileCacheDatabase,
          ProfileCacheDatabase,
          ProfileCacheDatabase
        >
    with $Provider<ProfileCacheDatabase> {
  ProfileCacheDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileCacheDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileCacheDatabaseHash();

  @$internal
  @override
  $ProviderElement<ProfileCacheDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileCacheDatabase create(Ref ref) {
    return profileCacheDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileCacheDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileCacheDatabase>(value),
    );
  }
}

String _$profileCacheDatabaseHash() => r'c96491958c016d1e2c5a3b488b4724eaed84db54';
