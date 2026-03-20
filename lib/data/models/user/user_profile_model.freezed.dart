// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get id; String get username; String? get avatarUrl; String? get bannerUrl; String? get bio; String? get location; int get followersCount; int get followingCount; int get videosCount; int get dynamicCount; int get likesCount; int get level; int get vipType; int get vipStatus; double? get coins; double? get bCoins; int? get currentExp; int? get nextExp; int? get currentMinExp; bool get isFollowing; bool get isVerified; DateTime? get createdAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.location, location) || other.location == location)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.videosCount, videosCount) || other.videosCount == videosCount)&&(identical(other.dynamicCount, dynamicCount) || other.dynamicCount == dynamicCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.level, level) || other.level == level)&&(identical(other.vipType, vipType) || other.vipType == vipType)&&(identical(other.vipStatus, vipStatus) || other.vipStatus == vipStatus)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.bCoins, bCoins) || other.bCoins == bCoins)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.nextExp, nextExp) || other.nextExp == nextExp)&&(identical(other.currentMinExp, currentMinExp) || other.currentMinExp == currentMinExp)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,avatarUrl,bannerUrl,bio,location,followersCount,followingCount,videosCount,dynamicCount,likesCount,level,vipType,vipStatus,coins,bCoins,currentExp,nextExp,currentMinExp,isFollowing,isVerified,createdAt]);

@override
String toString() {
  return 'UserProfile(id: $id, username: $username, avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, bio: $bio, location: $location, followersCount: $followersCount, followingCount: $followingCount, videosCount: $videosCount, dynamicCount: $dynamicCount, likesCount: $likesCount, level: $level, vipType: $vipType, vipStatus: $vipStatus, coins: $coins, bCoins: $bCoins, currentExp: $currentExp, nextExp: $nextExp, currentMinExp: $currentMinExp, isFollowing: $isFollowing, isVerified: $isVerified, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? avatarUrl, String? bannerUrl, String? bio, String? location, int followersCount, int followingCount, int videosCount, int dynamicCount, int likesCount, int level, int vipType, int vipStatus, double? coins, double? bCoins, int? currentExp, int? nextExp, int? currentMinExp, bool isFollowing, bool isVerified, DateTime? createdAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarUrl = freezed,Object? bannerUrl = freezed,Object? bio = freezed,Object? location = freezed,Object? followersCount = null,Object? followingCount = null,Object? videosCount = null,Object? dynamicCount = null,Object? likesCount = null,Object? level = null,Object? vipType = null,Object? vipStatus = null,Object? coins = freezed,Object? bCoins = freezed,Object? currentExp = freezed,Object? nextExp = freezed,Object? currentMinExp = freezed,Object? isFollowing = null,Object? isVerified = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,videosCount: null == videosCount ? _self.videosCount : videosCount // ignore: cast_nullable_to_non_nullable
as int,dynamicCount: null == dynamicCount ? _self.dynamicCount : dynamicCount // ignore: cast_nullable_to_non_nullable
as int,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,vipType: null == vipType ? _self.vipType : vipType // ignore: cast_nullable_to_non_nullable
as int,vipStatus: null == vipStatus ? _self.vipStatus : vipStatus // ignore: cast_nullable_to_non_nullable
as int,coins: freezed == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as double?,bCoins: freezed == bCoins ? _self.bCoins : bCoins // ignore: cast_nullable_to_non_nullable
as double?,currentExp: freezed == currentExp ? _self.currentExp : currentExp // ignore: cast_nullable_to_non_nullable
as int?,nextExp: freezed == nextExp ? _self.nextExp : nextExp // ignore: cast_nullable_to_non_nullable
as int?,currentMinExp: freezed == currentMinExp ? _self.currentMinExp : currentMinExp // ignore: cast_nullable_to_non_nullable
as int?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarUrl,  String? bannerUrl,  String? bio,  String? location,  int followersCount,  int followingCount,  int videosCount,  int dynamicCount,  int likesCount,  int level,  int vipType,  int vipStatus,  double? coins,  double? bCoins,  int? currentExp,  int? nextExp,  int? currentMinExp,  bool isFollowing,  bool isVerified,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.username,_that.avatarUrl,_that.bannerUrl,_that.bio,_that.location,_that.followersCount,_that.followingCount,_that.videosCount,_that.dynamicCount,_that.likesCount,_that.level,_that.vipType,_that.vipStatus,_that.coins,_that.bCoins,_that.currentExp,_that.nextExp,_that.currentMinExp,_that.isFollowing,_that.isVerified,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarUrl,  String? bannerUrl,  String? bio,  String? location,  int followersCount,  int followingCount,  int videosCount,  int dynamicCount,  int likesCount,  int level,  int vipType,  int vipStatus,  double? coins,  double? bCoins,  int? currentExp,  int? nextExp,  int? currentMinExp,  bool isFollowing,  bool isVerified,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.username,_that.avatarUrl,_that.bannerUrl,_that.bio,_that.location,_that.followersCount,_that.followingCount,_that.videosCount,_that.dynamicCount,_that.likesCount,_that.level,_that.vipType,_that.vipStatus,_that.coins,_that.bCoins,_that.currentExp,_that.nextExp,_that.currentMinExp,_that.isFollowing,_that.isVerified,_that.createdAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? avatarUrl,  String? bannerUrl,  String? bio,  String? location,  int followersCount,  int followingCount,  int videosCount,  int dynamicCount,  int likesCount,  int level,  int vipType,  int vipStatus,  double? coins,  double? bCoins,  int? currentExp,  int? nextExp,  int? currentMinExp,  bool isFollowing,  bool isVerified,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.username,_that.avatarUrl,_that.bannerUrl,_that.bio,_that.location,_that.followersCount,_that.followingCount,_that.videosCount,_that.dynamicCount,_that.likesCount,_that.level,_that.vipType,_that.vipStatus,_that.coins,_that.bCoins,_that.currentExp,_that.nextExp,_that.currentMinExp,_that.isFollowing,_that.isVerified,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, required this.username, this.avatarUrl, this.bannerUrl, this.bio, this.location, required this.followersCount, required this.followingCount, required this.videosCount, this.dynamicCount = 0, this.likesCount = 0, this.level = 0, this.vipType = 0, this.vipStatus = 0, this.coins, this.bCoins, this.currentExp, this.nextExp, this.currentMinExp, required this.isFollowing, required this.isVerified, this.createdAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? avatarUrl;
@override final  String? bannerUrl;
@override final  String? bio;
@override final  String? location;
@override final  int followersCount;
@override final  int followingCount;
@override final  int videosCount;
@override@JsonKey() final  int dynamicCount;
@override@JsonKey() final  int likesCount;
@override@JsonKey() final  int level;
@override@JsonKey() final  int vipType;
@override@JsonKey() final  int vipStatus;
@override final  double? coins;
@override final  double? bCoins;
@override final  int? currentExp;
@override final  int? nextExp;
@override final  int? currentMinExp;
@override final  bool isFollowing;
@override final  bool isVerified;
@override final  DateTime? createdAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.location, location) || other.location == location)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.videosCount, videosCount) || other.videosCount == videosCount)&&(identical(other.dynamicCount, dynamicCount) || other.dynamicCount == dynamicCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.level, level) || other.level == level)&&(identical(other.vipType, vipType) || other.vipType == vipType)&&(identical(other.vipStatus, vipStatus) || other.vipStatus == vipStatus)&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.bCoins, bCoins) || other.bCoins == bCoins)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.nextExp, nextExp) || other.nextExp == nextExp)&&(identical(other.currentMinExp, currentMinExp) || other.currentMinExp == currentMinExp)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,avatarUrl,bannerUrl,bio,location,followersCount,followingCount,videosCount,dynamicCount,likesCount,level,vipType,vipStatus,coins,bCoins,currentExp,nextExp,currentMinExp,isFollowing,isVerified,createdAt]);

@override
String toString() {
  return 'UserProfile(id: $id, username: $username, avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, bio: $bio, location: $location, followersCount: $followersCount, followingCount: $followingCount, videosCount: $videosCount, dynamicCount: $dynamicCount, likesCount: $likesCount, level: $level, vipType: $vipType, vipStatus: $vipStatus, coins: $coins, bCoins: $bCoins, currentExp: $currentExp, nextExp: $nextExp, currentMinExp: $currentMinExp, isFollowing: $isFollowing, isVerified: $isVerified, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? avatarUrl, String? bannerUrl, String? bio, String? location, int followersCount, int followingCount, int videosCount, int dynamicCount, int likesCount, int level, int vipType, int vipStatus, double? coins, double? bCoins, int? currentExp, int? nextExp, int? currentMinExp, bool isFollowing, bool isVerified, DateTime? createdAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarUrl = freezed,Object? bannerUrl = freezed,Object? bio = freezed,Object? location = freezed,Object? followersCount = null,Object? followingCount = null,Object? videosCount = null,Object? dynamicCount = null,Object? likesCount = null,Object? level = null,Object? vipType = null,Object? vipStatus = null,Object? coins = freezed,Object? bCoins = freezed,Object? currentExp = freezed,Object? nextExp = freezed,Object? currentMinExp = freezed,Object? isFollowing = null,Object? isVerified = null,Object? createdAt = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,videosCount: null == videosCount ? _self.videosCount : videosCount // ignore: cast_nullable_to_non_nullable
as int,dynamicCount: null == dynamicCount ? _self.dynamicCount : dynamicCount // ignore: cast_nullable_to_non_nullable
as int,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,vipType: null == vipType ? _self.vipType : vipType // ignore: cast_nullable_to_non_nullable
as int,vipStatus: null == vipStatus ? _self.vipStatus : vipStatus // ignore: cast_nullable_to_non_nullable
as int,coins: freezed == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as double?,bCoins: freezed == bCoins ? _self.bCoins : bCoins // ignore: cast_nullable_to_non_nullable
as double?,currentExp: freezed == currentExp ? _self.currentExp : currentExp // ignore: cast_nullable_to_non_nullable
as int?,nextExp: freezed == nextExp ? _self.nextExp : nextExp // ignore: cast_nullable_to_non_nullable
as int?,currentMinExp: freezed == currentMinExp ? _self.currentMinExp : currentMinExp // ignore: cast_nullable_to_non_nullable
as int?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
