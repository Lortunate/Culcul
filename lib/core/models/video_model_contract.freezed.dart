// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_model_contract.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoModel {

 String get bvid; String get title; String get pic; VideoOwner get owner; VideoStat get stat; int get duration;@JsonKey(name: 'pubdate') int get pubDate; String get desc;@JsonKey(name: 'rcmd_reason')@RcmdReasonConverter() String get rcmdReason;
/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoModelCopyWith<VideoModel> get copyWith => _$VideoModelCopyWithImpl<VideoModel>(this as VideoModel, _$identity);

  /// Serializes this VideoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoModel&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.title, title) || other.title == title)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.rcmdReason, rcmdReason) || other.rcmdReason == rcmdReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bvid,title,pic,owner,stat,duration,pubDate,desc,rcmdReason);

@override
String toString() {
  return 'VideoModel(bvid: $bvid, title: $title, pic: $pic, owner: $owner, stat: $stat, duration: $duration, pubDate: $pubDate, desc: $desc, rcmdReason: $rcmdReason)';
}


}

/// @nodoc
abstract mixin class $VideoModelCopyWith<$Res>  {
  factory $VideoModelCopyWith(VideoModel value, $Res Function(VideoModel) _then) = _$VideoModelCopyWithImpl;
@useResult
$Res call({
 String bvid, String title, String pic, VideoOwner owner, VideoStat stat, int duration,@JsonKey(name: 'pubdate') int pubDate, String desc,@JsonKey(name: 'rcmd_reason')@RcmdReasonConverter() String rcmdReason
});


$VideoOwnerCopyWith<$Res> get owner;$VideoStatCopyWith<$Res> get stat;

}
/// @nodoc
class _$VideoModelCopyWithImpl<$Res>
    implements $VideoModelCopyWith<$Res> {
  _$VideoModelCopyWithImpl(this._self, this._then);

  final VideoModel _self;
  final $Res Function(VideoModel) _then;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bvid = null,Object? title = null,Object? pic = null,Object? owner = null,Object? stat = null,Object? duration = null,Object? pubDate = null,Object? desc = null,Object? rcmdReason = null,}) {
  return _then(_self.copyWith(
bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as VideoOwner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as VideoStat,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,rcmdReason: null == rcmdReason ? _self.rcmdReason : rcmdReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoOwnerCopyWith<$Res> get owner {
  
  return $VideoOwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoStatCopyWith<$Res> get stat {
  
  return $VideoStatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoModel].
extension VideoModelPatterns on VideoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoModel value)  $default,){
final _that = this;
switch (_that) {
case _VideoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoModel value)?  $default,){
final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bvid,  String title,  String pic,  VideoOwner owner,  VideoStat stat,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  String desc, @JsonKey(name: 'rcmd_reason')@RcmdReasonConverter()  String rcmdReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
return $default(_that.bvid,_that.title,_that.pic,_that.owner,_that.stat,_that.duration,_that.pubDate,_that.desc,_that.rcmdReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bvid,  String title,  String pic,  VideoOwner owner,  VideoStat stat,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  String desc, @JsonKey(name: 'rcmd_reason')@RcmdReasonConverter()  String rcmdReason)  $default,) {final _that = this;
switch (_that) {
case _VideoModel():
return $default(_that.bvid,_that.title,_that.pic,_that.owner,_that.stat,_that.duration,_that.pubDate,_that.desc,_that.rcmdReason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bvid,  String title,  String pic,  VideoOwner owner,  VideoStat stat,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  String desc, @JsonKey(name: 'rcmd_reason')@RcmdReasonConverter()  String rcmdReason)?  $default,) {final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
return $default(_that.bvid,_that.title,_that.pic,_that.owner,_that.stat,_that.duration,_that.pubDate,_that.desc,_that.rcmdReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoModel implements VideoModel {
  const _VideoModel({required this.bvid, required this.title, required this.pic, required this.owner, required this.stat, required this.duration, @JsonKey(name: 'pubdate') required this.pubDate, this.desc = '', @JsonKey(name: 'rcmd_reason')@RcmdReasonConverter() this.rcmdReason = ''});
  factory _VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

@override final  String bvid;
@override final  String title;
@override final  String pic;
@override final  VideoOwner owner;
@override final  VideoStat stat;
@override final  int duration;
@override@JsonKey(name: 'pubdate') final  int pubDate;
@override@JsonKey() final  String desc;
@override@JsonKey(name: 'rcmd_reason')@RcmdReasonConverter() final  String rcmdReason;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoModelCopyWith<_VideoModel> get copyWith => __$VideoModelCopyWithImpl<_VideoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoModel&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.title, title) || other.title == title)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.rcmdReason, rcmdReason) || other.rcmdReason == rcmdReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bvid,title,pic,owner,stat,duration,pubDate,desc,rcmdReason);

@override
String toString() {
  return 'VideoModel(bvid: $bvid, title: $title, pic: $pic, owner: $owner, stat: $stat, duration: $duration, pubDate: $pubDate, desc: $desc, rcmdReason: $rcmdReason)';
}


}

/// @nodoc
abstract mixin class _$VideoModelCopyWith<$Res> implements $VideoModelCopyWith<$Res> {
  factory _$VideoModelCopyWith(_VideoModel value, $Res Function(_VideoModel) _then) = __$VideoModelCopyWithImpl;
@override @useResult
$Res call({
 String bvid, String title, String pic, VideoOwner owner, VideoStat stat, int duration,@JsonKey(name: 'pubdate') int pubDate, String desc,@JsonKey(name: 'rcmd_reason')@RcmdReasonConverter() String rcmdReason
});


@override $VideoOwnerCopyWith<$Res> get owner;@override $VideoStatCopyWith<$Res> get stat;

}
/// @nodoc
class __$VideoModelCopyWithImpl<$Res>
    implements _$VideoModelCopyWith<$Res> {
  __$VideoModelCopyWithImpl(this._self, this._then);

  final _VideoModel _self;
  final $Res Function(_VideoModel) _then;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bvid = null,Object? title = null,Object? pic = null,Object? owner = null,Object? stat = null,Object? duration = null,Object? pubDate = null,Object? desc = null,Object? rcmdReason = null,}) {
  return _then(_VideoModel(
bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as VideoOwner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as VideoStat,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,rcmdReason: null == rcmdReason ? _self.rcmdReason : rcmdReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoOwnerCopyWith<$Res> get owner {
  
  return $VideoOwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoStatCopyWith<$Res> get stat {
  
  return $VideoStatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// @nodoc
mixin _$VideoOwner {

 int get mid; String get name; String get face;
/// Create a copy of VideoOwner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoOwnerCopyWith<VideoOwner> get copyWith => _$VideoOwnerCopyWithImpl<VideoOwner>(this as VideoOwner, _$identity);

  /// Serializes this VideoOwner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoOwner&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,face);

@override
String toString() {
  return 'VideoOwner(mid: $mid, name: $name, face: $face)';
}


}

/// @nodoc
abstract mixin class $VideoOwnerCopyWith<$Res>  {
  factory $VideoOwnerCopyWith(VideoOwner value, $Res Function(VideoOwner) _then) = _$VideoOwnerCopyWithImpl;
@useResult
$Res call({
 int mid, String name, String face
});




}
/// @nodoc
class _$VideoOwnerCopyWithImpl<$Res>
    implements $VideoOwnerCopyWith<$Res> {
  _$VideoOwnerCopyWithImpl(this._self, this._then);

  final VideoOwner _self;
  final $Res Function(VideoOwner) _then;

/// Create a copy of VideoOwner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? name = null,Object? face = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoOwner].
extension VideoOwnerPatterns on VideoOwner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoOwner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoOwner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoOwner value)  $default,){
final _that = this;
switch (_that) {
case _VideoOwner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoOwner value)?  $default,){
final _that = this;
switch (_that) {
case _VideoOwner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mid,  String name,  String face)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoOwner() when $default != null:
return $default(_that.mid,_that.name,_that.face);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mid,  String name,  String face)  $default,) {final _that = this;
switch (_that) {
case _VideoOwner():
return $default(_that.mid,_that.name,_that.face);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mid,  String name,  String face)?  $default,) {final _that = this;
switch (_that) {
case _VideoOwner() when $default != null:
return $default(_that.mid,_that.name,_that.face);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoOwner implements VideoOwner {
  const _VideoOwner({required this.mid, required this.name, this.face = ''});
  factory _VideoOwner.fromJson(Map<String, dynamic> json) => _$VideoOwnerFromJson(json);

@override final  int mid;
@override final  String name;
@override@JsonKey() final  String face;

/// Create a copy of VideoOwner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoOwnerCopyWith<_VideoOwner> get copyWith => __$VideoOwnerCopyWithImpl<_VideoOwner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoOwnerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoOwner&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,face);

@override
String toString() {
  return 'VideoOwner(mid: $mid, name: $name, face: $face)';
}


}

/// @nodoc
abstract mixin class _$VideoOwnerCopyWith<$Res> implements $VideoOwnerCopyWith<$Res> {
  factory _$VideoOwnerCopyWith(_VideoOwner value, $Res Function(_VideoOwner) _then) = __$VideoOwnerCopyWithImpl;
@override @useResult
$Res call({
 int mid, String name, String face
});




}
/// @nodoc
class __$VideoOwnerCopyWithImpl<$Res>
    implements _$VideoOwnerCopyWith<$Res> {
  __$VideoOwnerCopyWithImpl(this._self, this._then);

  final _VideoOwner _self;
  final $Res Function(_VideoOwner) _then;

/// Create a copy of VideoOwner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? name = null,Object? face = null,}) {
  return _then(_VideoOwner(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VideoStat {

 int get view; int get danmaku; int get reply; int get like; int get coin; int get favorite; int get share;
/// Create a copy of VideoStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoStatCopyWith<VideoStat> get copyWith => _$VideoStatCopyWithImpl<VideoStat>(this as VideoStat, _$identity);

  /// Serializes this VideoStat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoStat&&(identical(other.view, view) || other.view == view)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.like, like) || other.like == like)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.share, share) || other.share == share));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,view,danmaku,reply,like,coin,favorite,share);

@override
String toString() {
  return 'VideoStat(view: $view, danmaku: $danmaku, reply: $reply, like: $like, coin: $coin, favorite: $favorite, share: $share)';
}


}

/// @nodoc
abstract mixin class $VideoStatCopyWith<$Res>  {
  factory $VideoStatCopyWith(VideoStat value, $Res Function(VideoStat) _then) = _$VideoStatCopyWithImpl;
@useResult
$Res call({
 int view, int danmaku, int reply, int like, int coin, int favorite, int share
});




}
/// @nodoc
class _$VideoStatCopyWithImpl<$Res>
    implements $VideoStatCopyWith<$Res> {
  _$VideoStatCopyWithImpl(this._self, this._then);

  final VideoStat _self;
  final $Res Function(VideoStat) _then;

/// Create a copy of VideoStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? danmaku = null,Object? reply = null,Object? like = null,Object? coin = null,Object? favorite = null,Object? share = null,}) {
  return _then(_self.copyWith(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int,danmaku: null == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoStat].
extension VideoStatPatterns on VideoStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoStat value)  $default,){
final _that = this;
switch (_that) {
case _VideoStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoStat value)?  $default,){
final _that = this;
switch (_that) {
case _VideoStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int view,  int danmaku,  int reply,  int like,  int coin,  int favorite,  int share)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoStat() when $default != null:
return $default(_that.view,_that.danmaku,_that.reply,_that.like,_that.coin,_that.favorite,_that.share);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int view,  int danmaku,  int reply,  int like,  int coin,  int favorite,  int share)  $default,) {final _that = this;
switch (_that) {
case _VideoStat():
return $default(_that.view,_that.danmaku,_that.reply,_that.like,_that.coin,_that.favorite,_that.share);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int view,  int danmaku,  int reply,  int like,  int coin,  int favorite,  int share)?  $default,) {final _that = this;
switch (_that) {
case _VideoStat() when $default != null:
return $default(_that.view,_that.danmaku,_that.reply,_that.like,_that.coin,_that.favorite,_that.share);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoStat implements VideoStat {
  const _VideoStat({this.view = 0, this.danmaku = 0, this.reply = 0, this.like = 0, this.coin = 0, this.favorite = 0, this.share = 0});
  factory _VideoStat.fromJson(Map<String, dynamic> json) => _$VideoStatFromJson(json);

@override@JsonKey() final  int view;
@override@JsonKey() final  int danmaku;
@override@JsonKey() final  int reply;
@override@JsonKey() final  int like;
@override@JsonKey() final  int coin;
@override@JsonKey() final  int favorite;
@override@JsonKey() final  int share;

/// Create a copy of VideoStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoStatCopyWith<_VideoStat> get copyWith => __$VideoStatCopyWithImpl<_VideoStat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoStatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoStat&&(identical(other.view, view) || other.view == view)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.like, like) || other.like == like)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.share, share) || other.share == share));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,view,danmaku,reply,like,coin,favorite,share);

@override
String toString() {
  return 'VideoStat(view: $view, danmaku: $danmaku, reply: $reply, like: $like, coin: $coin, favorite: $favorite, share: $share)';
}


}

/// @nodoc
abstract mixin class _$VideoStatCopyWith<$Res> implements $VideoStatCopyWith<$Res> {
  factory _$VideoStatCopyWith(_VideoStat value, $Res Function(_VideoStat) _then) = __$VideoStatCopyWithImpl;
@override @useResult
$Res call({
 int view, int danmaku, int reply, int like, int coin, int favorite, int share
});




}
/// @nodoc
class __$VideoStatCopyWithImpl<$Res>
    implements _$VideoStatCopyWith<$Res> {
  __$VideoStatCopyWithImpl(this._self, this._then);

  final _VideoStat _self;
  final $Res Function(_VideoStat) _then;

/// Create a copy of VideoStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = null,Object? danmaku = null,Object? reply = null,Object? like = null,Object? coin = null,Object? favorite = null,Object? share = null,}) {
  return _then(_VideoStat(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int,danmaku: null == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
