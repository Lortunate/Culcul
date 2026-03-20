// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'related_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RelatedVideo {

 int get aid; String get bvid; int get cid; String get title; String get pic; Owner get owner; Stat get stat; int get duration;@JsonKey(name: 'pubdate') int get pubDate; String get desc;@JsonKey(name: 'short_link_v2') String get shortLink;@JsonKey(name: 'rcmd_reason') String get rcmdReason;
/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelatedVideoCopyWith<RelatedVideo> get copyWith => _$RelatedVideoCopyWithImpl<RelatedVideo>(this as RelatedVideo, _$identity);

  /// Serializes this RelatedVideo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelatedVideo&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.title, title) || other.title == title)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.shortLink, shortLink) || other.shortLink == shortLink)&&(identical(other.rcmdReason, rcmdReason) || other.rcmdReason == rcmdReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,bvid,cid,title,pic,owner,stat,duration,pubDate,desc,shortLink,rcmdReason);

@override
String toString() {
  return 'RelatedVideo(aid: $aid, bvid: $bvid, cid: $cid, title: $title, pic: $pic, owner: $owner, stat: $stat, duration: $duration, pubDate: $pubDate, desc: $desc, shortLink: $shortLink, rcmdReason: $rcmdReason)';
}


}

/// @nodoc
abstract mixin class $RelatedVideoCopyWith<$Res>  {
  factory $RelatedVideoCopyWith(RelatedVideo value, $Res Function(RelatedVideo) _then) = _$RelatedVideoCopyWithImpl;
@useResult
$Res call({
 int aid, String bvid, int cid, String title, String pic, Owner owner, Stat stat, int duration,@JsonKey(name: 'pubdate') int pubDate, String desc,@JsonKey(name: 'short_link_v2') String shortLink,@JsonKey(name: 'rcmd_reason') String rcmdReason
});


$OwnerCopyWith<$Res> get owner;$StatCopyWith<$Res> get stat;

}
/// @nodoc
class _$RelatedVideoCopyWithImpl<$Res>
    implements $RelatedVideoCopyWith<$Res> {
  _$RelatedVideoCopyWithImpl(this._self, this._then);

  final RelatedVideo _self;
  final $Res Function(RelatedVideo) _then;

/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aid = null,Object? bvid = null,Object? cid = null,Object? title = null,Object? pic = null,Object? owner = null,Object? stat = null,Object? duration = null,Object? pubDate = null,Object? desc = null,Object? shortLink = null,Object? rcmdReason = null,}) {
  return _then(_self.copyWith(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as Owner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as Stat,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,shortLink: null == shortLink ? _self.shortLink : shortLink // ignore: cast_nullable_to_non_nullable
as String,rcmdReason: null == rcmdReason ? _self.rcmdReason : rcmdReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerCopyWith<$Res> get owner {
  
  return $OwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCopyWith<$Res> get stat {
  
  return $StatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [RelatedVideo].
extension RelatedVideoPatterns on RelatedVideo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelatedVideo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelatedVideo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelatedVideo value)  $default,){
final _that = this;
switch (_that) {
case _RelatedVideo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelatedVideo value)?  $default,){
final _that = this;
switch (_that) {
case _RelatedVideo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int aid,  String bvid,  int cid,  String title,  String pic,  Owner owner,  Stat stat,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  String desc, @JsonKey(name: 'short_link_v2')  String shortLink, @JsonKey(name: 'rcmd_reason')  String rcmdReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelatedVideo() when $default != null:
return $default(_that.aid,_that.bvid,_that.cid,_that.title,_that.pic,_that.owner,_that.stat,_that.duration,_that.pubDate,_that.desc,_that.shortLink,_that.rcmdReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int aid,  String bvid,  int cid,  String title,  String pic,  Owner owner,  Stat stat,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  String desc, @JsonKey(name: 'short_link_v2')  String shortLink, @JsonKey(name: 'rcmd_reason')  String rcmdReason)  $default,) {final _that = this;
switch (_that) {
case _RelatedVideo():
return $default(_that.aid,_that.bvid,_that.cid,_that.title,_that.pic,_that.owner,_that.stat,_that.duration,_that.pubDate,_that.desc,_that.shortLink,_that.rcmdReason);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int aid,  String bvid,  int cid,  String title,  String pic,  Owner owner,  Stat stat,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  String desc, @JsonKey(name: 'short_link_v2')  String shortLink, @JsonKey(name: 'rcmd_reason')  String rcmdReason)?  $default,) {final _that = this;
switch (_that) {
case _RelatedVideo() when $default != null:
return $default(_that.aid,_that.bvid,_that.cid,_that.title,_that.pic,_that.owner,_that.stat,_that.duration,_that.pubDate,_that.desc,_that.shortLink,_that.rcmdReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelatedVideo implements RelatedVideo {
  const _RelatedVideo({required this.aid, required this.bvid, this.cid = 0, required this.title, required this.pic, required this.owner, required this.stat, required this.duration, @JsonKey(name: 'pubdate') required this.pubDate, this.desc = '', @JsonKey(name: 'short_link_v2') this.shortLink = '', @JsonKey(name: 'rcmd_reason') this.rcmdReason = ''});
  factory _RelatedVideo.fromJson(Map<String, dynamic> json) => _$RelatedVideoFromJson(json);

@override final  int aid;
@override final  String bvid;
@override@JsonKey() final  int cid;
@override final  String title;
@override final  String pic;
@override final  Owner owner;
@override final  Stat stat;
@override final  int duration;
@override@JsonKey(name: 'pubdate') final  int pubDate;
@override@JsonKey() final  String desc;
@override@JsonKey(name: 'short_link_v2') final  String shortLink;
@override@JsonKey(name: 'rcmd_reason') final  String rcmdReason;

/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelatedVideoCopyWith<_RelatedVideo> get copyWith => __$RelatedVideoCopyWithImpl<_RelatedVideo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelatedVideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelatedVideo&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.title, title) || other.title == title)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.shortLink, shortLink) || other.shortLink == shortLink)&&(identical(other.rcmdReason, rcmdReason) || other.rcmdReason == rcmdReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,bvid,cid,title,pic,owner,stat,duration,pubDate,desc,shortLink,rcmdReason);

@override
String toString() {
  return 'RelatedVideo(aid: $aid, bvid: $bvid, cid: $cid, title: $title, pic: $pic, owner: $owner, stat: $stat, duration: $duration, pubDate: $pubDate, desc: $desc, shortLink: $shortLink, rcmdReason: $rcmdReason)';
}


}

/// @nodoc
abstract mixin class _$RelatedVideoCopyWith<$Res> implements $RelatedVideoCopyWith<$Res> {
  factory _$RelatedVideoCopyWith(_RelatedVideo value, $Res Function(_RelatedVideo) _then) = __$RelatedVideoCopyWithImpl;
@override @useResult
$Res call({
 int aid, String bvid, int cid, String title, String pic, Owner owner, Stat stat, int duration,@JsonKey(name: 'pubdate') int pubDate, String desc,@JsonKey(name: 'short_link_v2') String shortLink,@JsonKey(name: 'rcmd_reason') String rcmdReason
});


@override $OwnerCopyWith<$Res> get owner;@override $StatCopyWith<$Res> get stat;

}
/// @nodoc
class __$RelatedVideoCopyWithImpl<$Res>
    implements _$RelatedVideoCopyWith<$Res> {
  __$RelatedVideoCopyWithImpl(this._self, this._then);

  final _RelatedVideo _self;
  final $Res Function(_RelatedVideo) _then;

/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aid = null,Object? bvid = null,Object? cid = null,Object? title = null,Object? pic = null,Object? owner = null,Object? stat = null,Object? duration = null,Object? pubDate = null,Object? desc = null,Object? shortLink = null,Object? rcmdReason = null,}) {
  return _then(_RelatedVideo(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as Owner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as Stat,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,shortLink: null == shortLink ? _self.shortLink : shortLink // ignore: cast_nullable_to_non_nullable
as String,rcmdReason: null == rcmdReason ? _self.rcmdReason : rcmdReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerCopyWith<$Res> get owner {
  
  return $OwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of RelatedVideo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCopyWith<$Res> get stat {
  
  return $StatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}

// dart format on
