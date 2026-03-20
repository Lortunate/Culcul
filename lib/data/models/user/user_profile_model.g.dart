// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  username: json['username'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  bio: json['bio'] as String?,
  location: json['location'] as String?,
  followersCount: (json['followersCount'] as num).toInt(),
  followingCount: (json['followingCount'] as num).toInt(),
  videosCount: (json['videosCount'] as num).toInt(),
  dynamicCount: (json['dynamicCount'] as num?)?.toInt() ?? 0,
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  level: (json['level'] as num?)?.toInt() ?? 0,
  vipType: (json['vipType'] as num?)?.toInt() ?? 0,
  vipStatus: (json['vipStatus'] as num?)?.toInt() ?? 0,
  coins: (json['coins'] as num?)?.toDouble(),
  bCoins: (json['bCoins'] as num?)?.toDouble(),
  currentExp: (json['currentExp'] as num?)?.toInt(),
  nextExp: (json['nextExp'] as num?)?.toInt(),
  currentMinExp: (json['currentMinExp'] as num?)?.toInt(),
  isFollowing: json['isFollowing'] as bool,
  isVerified: json['isVerified'] as bool,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'bannerUrl': instance.bannerUrl,
      'bio': instance.bio,
      'location': instance.location,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'videosCount': instance.videosCount,
      'dynamicCount': instance.dynamicCount,
      'likesCount': instance.likesCount,
      'level': instance.level,
      'vipType': instance.vipType,
      'vipStatus': instance.vipStatus,
      'coins': instance.coins,
      'bCoins': instance.bCoins,
      'currentExp': instance.currentExp,
      'nextExp': instance.nextExp,
      'currentMinExp': instance.currentMinExp,
      'isFollowing': instance.isFollowing,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
