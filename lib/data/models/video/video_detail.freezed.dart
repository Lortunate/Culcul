// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoDetail {

 String get bvid; int get aid; int get videos; int get tid; String get tname; dynamic get copyright; String get pic; String get title;@JsonKey(name: 'pubdate') int get pubDate; int get ctime; String get desc; Owner get owner; Stat get stat; VideoDimension get dimension; List<VideoPage> get pages; VideoSubtitle? get subtitle; List<VideoTag> get tag;@JsonKey(name: 'req_user') ReqUser? get reqUser;
/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoDetailCopyWith<VideoDetail> get copyWith => _$VideoDetailCopyWithImpl<VideoDetail>(this as VideoDetail, _$identity);

  /// Serializes this VideoDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoDetail&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.tname, tname) || other.tname == tname)&&const DeepCollectionEquality().equals(other.copyright, copyright)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.title, title) || other.title == title)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.dimension, dimension) || other.dimension == dimension)&&const DeepCollectionEquality().equals(other.pages, pages)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.tag, tag)&&(identical(other.reqUser, reqUser) || other.reqUser == reqUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bvid,aid,videos,tid,tname,const DeepCollectionEquality().hash(copyright),pic,title,pubDate,ctime,desc,owner,stat,dimension,const DeepCollectionEquality().hash(pages),subtitle,const DeepCollectionEquality().hash(tag),reqUser);

@override
String toString() {
  return 'VideoDetail(bvid: $bvid, aid: $aid, videos: $videos, tid: $tid, tname: $tname, copyright: $copyright, pic: $pic, title: $title, pubDate: $pubDate, ctime: $ctime, desc: $desc, owner: $owner, stat: $stat, dimension: $dimension, pages: $pages, subtitle: $subtitle, tag: $tag, reqUser: $reqUser)';
}


}

/// @nodoc
abstract mixin class $VideoDetailCopyWith<$Res>  {
  factory $VideoDetailCopyWith(VideoDetail value, $Res Function(VideoDetail) _then) = _$VideoDetailCopyWithImpl;
@useResult
$Res call({
 String bvid, int aid, int videos, int tid, String tname, dynamic copyright, String pic, String title,@JsonKey(name: 'pubdate') int pubDate, int ctime, String desc, Owner owner, Stat stat, VideoDimension dimension, List<VideoPage> pages, VideoSubtitle? subtitle, List<VideoTag> tag,@JsonKey(name: 'req_user') ReqUser? reqUser
});


$OwnerCopyWith<$Res> get owner;$StatCopyWith<$Res> get stat;$VideoDimensionCopyWith<$Res> get dimension;$VideoSubtitleCopyWith<$Res>? get subtitle;$ReqUserCopyWith<$Res>? get reqUser;

}
/// @nodoc
class _$VideoDetailCopyWithImpl<$Res>
    implements $VideoDetailCopyWith<$Res> {
  _$VideoDetailCopyWithImpl(this._self, this._then);

  final VideoDetail _self;
  final $Res Function(VideoDetail) _then;

/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bvid = null,Object? aid = null,Object? videos = null,Object? tid = null,Object? tname = null,Object? copyright = freezed,Object? pic = null,Object? title = null,Object? pubDate = null,Object? ctime = null,Object? desc = null,Object? owner = null,Object? stat = null,Object? dimension = null,Object? pages = null,Object? subtitle = freezed,Object? tag = null,Object? reqUser = freezed,}) {
  return _then(_self.copyWith(
bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int,tid: null == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as int,tname: null == tname ? _self.tname : tname // ignore: cast_nullable_to_non_nullable
as String,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as dynamic,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as Owner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as Stat,dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as VideoDimension,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<VideoPage>,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as VideoSubtitle?,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as List<VideoTag>,reqUser: freezed == reqUser ? _self.reqUser : reqUser // ignore: cast_nullable_to_non_nullable
as ReqUser?,
  ));
}
/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerCopyWith<$Res> get owner {
  
  return $OwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCopyWith<$Res> get stat {
  
  return $StatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoDimensionCopyWith<$Res> get dimension {
  
  return $VideoDimensionCopyWith<$Res>(_self.dimension, (value) {
    return _then(_self.copyWith(dimension: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSubtitleCopyWith<$Res>? get subtitle {
    if (_self.subtitle == null) {
    return null;
  }

  return $VideoSubtitleCopyWith<$Res>(_self.subtitle!, (value) {
    return _then(_self.copyWith(subtitle: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReqUserCopyWith<$Res>? get reqUser {
    if (_self.reqUser == null) {
    return null;
  }

  return $ReqUserCopyWith<$Res>(_self.reqUser!, (value) {
    return _then(_self.copyWith(reqUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoDetail].
extension VideoDetailPatterns on VideoDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoDetail value)  $default,){
final _that = this;
switch (_that) {
case _VideoDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoDetail value)?  $default,){
final _that = this;
switch (_that) {
case _VideoDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bvid,  int aid,  int videos,  int tid,  String tname,  dynamic copyright,  String pic,  String title, @JsonKey(name: 'pubdate')  int pubDate,  int ctime,  String desc,  Owner owner,  Stat stat,  VideoDimension dimension,  List<VideoPage> pages,  VideoSubtitle? subtitle,  List<VideoTag> tag, @JsonKey(name: 'req_user')  ReqUser? reqUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoDetail() when $default != null:
return $default(_that.bvid,_that.aid,_that.videos,_that.tid,_that.tname,_that.copyright,_that.pic,_that.title,_that.pubDate,_that.ctime,_that.desc,_that.owner,_that.stat,_that.dimension,_that.pages,_that.subtitle,_that.tag,_that.reqUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bvid,  int aid,  int videos,  int tid,  String tname,  dynamic copyright,  String pic,  String title, @JsonKey(name: 'pubdate')  int pubDate,  int ctime,  String desc,  Owner owner,  Stat stat,  VideoDimension dimension,  List<VideoPage> pages,  VideoSubtitle? subtitle,  List<VideoTag> tag, @JsonKey(name: 'req_user')  ReqUser? reqUser)  $default,) {final _that = this;
switch (_that) {
case _VideoDetail():
return $default(_that.bvid,_that.aid,_that.videos,_that.tid,_that.tname,_that.copyright,_that.pic,_that.title,_that.pubDate,_that.ctime,_that.desc,_that.owner,_that.stat,_that.dimension,_that.pages,_that.subtitle,_that.tag,_that.reqUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bvid,  int aid,  int videos,  int tid,  String tname,  dynamic copyright,  String pic,  String title, @JsonKey(name: 'pubdate')  int pubDate,  int ctime,  String desc,  Owner owner,  Stat stat,  VideoDimension dimension,  List<VideoPage> pages,  VideoSubtitle? subtitle,  List<VideoTag> tag, @JsonKey(name: 'req_user')  ReqUser? reqUser)?  $default,) {final _that = this;
switch (_that) {
case _VideoDetail() when $default != null:
return $default(_that.bvid,_that.aid,_that.videos,_that.tid,_that.tname,_that.copyright,_that.pic,_that.title,_that.pubDate,_that.ctime,_that.desc,_that.owner,_that.stat,_that.dimension,_that.pages,_that.subtitle,_that.tag,_that.reqUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoDetail implements VideoDetail {
  const _VideoDetail({required this.bvid, required this.aid, required this.videos, required this.tid, required this.tname, required this.copyright, required this.pic, required this.title, @JsonKey(name: 'pubdate') required this.pubDate, required this.ctime, required this.desc, required this.owner, required this.stat, this.dimension = const VideoDimension(), final  List<VideoPage> pages = const [], this.subtitle, final  List<VideoTag> tag = const [], @JsonKey(name: 'req_user') this.reqUser}): _pages = pages,_tag = tag;
  factory _VideoDetail.fromJson(Map<String, dynamic> json) => _$VideoDetailFromJson(json);

@override final  String bvid;
@override final  int aid;
@override final  int videos;
@override final  int tid;
@override final  String tname;
@override final  dynamic copyright;
@override final  String pic;
@override final  String title;
@override@JsonKey(name: 'pubdate') final  int pubDate;
@override final  int ctime;
@override final  String desc;
@override final  Owner owner;
@override final  Stat stat;
@override@JsonKey() final  VideoDimension dimension;
 final  List<VideoPage> _pages;
@override@JsonKey() List<VideoPage> get pages {
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pages);
}

@override final  VideoSubtitle? subtitle;
 final  List<VideoTag> _tag;
@override@JsonKey() List<VideoTag> get tag {
  if (_tag is EqualUnmodifiableListView) return _tag;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tag);
}

@override@JsonKey(name: 'req_user') final  ReqUser? reqUser;

/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoDetailCopyWith<_VideoDetail> get copyWith => __$VideoDetailCopyWithImpl<_VideoDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoDetail&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.tname, tname) || other.tname == tname)&&const DeepCollectionEquality().equals(other.copyright, copyright)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.title, title) || other.title == title)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.dimension, dimension) || other.dimension == dimension)&&const DeepCollectionEquality().equals(other._pages, _pages)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other._tag, _tag)&&(identical(other.reqUser, reqUser) || other.reqUser == reqUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bvid,aid,videos,tid,tname,const DeepCollectionEquality().hash(copyright),pic,title,pubDate,ctime,desc,owner,stat,dimension,const DeepCollectionEquality().hash(_pages),subtitle,const DeepCollectionEquality().hash(_tag),reqUser);

@override
String toString() {
  return 'VideoDetail(bvid: $bvid, aid: $aid, videos: $videos, tid: $tid, tname: $tname, copyright: $copyright, pic: $pic, title: $title, pubDate: $pubDate, ctime: $ctime, desc: $desc, owner: $owner, stat: $stat, dimension: $dimension, pages: $pages, subtitle: $subtitle, tag: $tag, reqUser: $reqUser)';
}


}

/// @nodoc
abstract mixin class _$VideoDetailCopyWith<$Res> implements $VideoDetailCopyWith<$Res> {
  factory _$VideoDetailCopyWith(_VideoDetail value, $Res Function(_VideoDetail) _then) = __$VideoDetailCopyWithImpl;
@override @useResult
$Res call({
 String bvid, int aid, int videos, int tid, String tname, dynamic copyright, String pic, String title,@JsonKey(name: 'pubdate') int pubDate, int ctime, String desc, Owner owner, Stat stat, VideoDimension dimension, List<VideoPage> pages, VideoSubtitle? subtitle, List<VideoTag> tag,@JsonKey(name: 'req_user') ReqUser? reqUser
});


@override $OwnerCopyWith<$Res> get owner;@override $StatCopyWith<$Res> get stat;@override $VideoDimensionCopyWith<$Res> get dimension;@override $VideoSubtitleCopyWith<$Res>? get subtitle;@override $ReqUserCopyWith<$Res>? get reqUser;

}
/// @nodoc
class __$VideoDetailCopyWithImpl<$Res>
    implements _$VideoDetailCopyWith<$Res> {
  __$VideoDetailCopyWithImpl(this._self, this._then);

  final _VideoDetail _self;
  final $Res Function(_VideoDetail) _then;

/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bvid = null,Object? aid = null,Object? videos = null,Object? tid = null,Object? tname = null,Object? copyright = freezed,Object? pic = null,Object? title = null,Object? pubDate = null,Object? ctime = null,Object? desc = null,Object? owner = null,Object? stat = null,Object? dimension = null,Object? pages = null,Object? subtitle = freezed,Object? tag = null,Object? reqUser = freezed,}) {
  return _then(_VideoDetail(
bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int,tid: null == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as int,tname: null == tname ? _self.tname : tname // ignore: cast_nullable_to_non_nullable
as String,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as dynamic,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as Owner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as Stat,dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as VideoDimension,pages: null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<VideoPage>,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as VideoSubtitle?,tag: null == tag ? _self._tag : tag // ignore: cast_nullable_to_non_nullable
as List<VideoTag>,reqUser: freezed == reqUser ? _self.reqUser : reqUser // ignore: cast_nullable_to_non_nullable
as ReqUser?,
  ));
}

/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerCopyWith<$Res> get owner {
  
  return $OwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCopyWith<$Res> get stat {
  
  return $StatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoDimensionCopyWith<$Res> get dimension {
  
  return $VideoDimensionCopyWith<$Res>(_self.dimension, (value) {
    return _then(_self.copyWith(dimension: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSubtitleCopyWith<$Res>? get subtitle {
    if (_self.subtitle == null) {
    return null;
  }

  return $VideoSubtitleCopyWith<$Res>(_self.subtitle!, (value) {
    return _then(_self.copyWith(subtitle: value));
  });
}/// Create a copy of VideoDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReqUserCopyWith<$Res>? get reqUser {
    if (_self.reqUser == null) {
    return null;
  }

  return $ReqUserCopyWith<$Res>(_self.reqUser!, (value) {
    return _then(_self.copyWith(reqUser: value));
  });
}
}


/// @nodoc
mixin _$ReqUser {

 int get attention;@JsonKey(name: 'guest_attention') int get guestAttention;
/// Create a copy of ReqUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReqUserCopyWith<ReqUser> get copyWith => _$ReqUserCopyWithImpl<ReqUser>(this as ReqUser, _$identity);

  /// Serializes this ReqUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReqUser&&(identical(other.attention, attention) || other.attention == attention)&&(identical(other.guestAttention, guestAttention) || other.guestAttention == guestAttention));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attention,guestAttention);

@override
String toString() {
  return 'ReqUser(attention: $attention, guestAttention: $guestAttention)';
}


}

/// @nodoc
abstract mixin class $ReqUserCopyWith<$Res>  {
  factory $ReqUserCopyWith(ReqUser value, $Res Function(ReqUser) _then) = _$ReqUserCopyWithImpl;
@useResult
$Res call({
 int attention,@JsonKey(name: 'guest_attention') int guestAttention
});




}
/// @nodoc
class _$ReqUserCopyWithImpl<$Res>
    implements $ReqUserCopyWith<$Res> {
  _$ReqUserCopyWithImpl(this._self, this._then);

  final ReqUser _self;
  final $Res Function(ReqUser) _then;

/// Create a copy of ReqUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attention = null,Object? guestAttention = null,}) {
  return _then(_self.copyWith(
attention: null == attention ? _self.attention : attention // ignore: cast_nullable_to_non_nullable
as int,guestAttention: null == guestAttention ? _self.guestAttention : guestAttention // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReqUser].
extension ReqUserPatterns on ReqUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReqUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReqUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReqUser value)  $default,){
final _that = this;
switch (_that) {
case _ReqUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReqUser value)?  $default,){
final _that = this;
switch (_that) {
case _ReqUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int attention, @JsonKey(name: 'guest_attention')  int guestAttention)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReqUser() when $default != null:
return $default(_that.attention,_that.guestAttention);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int attention, @JsonKey(name: 'guest_attention')  int guestAttention)  $default,) {final _that = this;
switch (_that) {
case _ReqUser():
return $default(_that.attention,_that.guestAttention);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int attention, @JsonKey(name: 'guest_attention')  int guestAttention)?  $default,) {final _that = this;
switch (_that) {
case _ReqUser() when $default != null:
return $default(_that.attention,_that.guestAttention);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReqUser implements ReqUser {
  const _ReqUser({this.attention = 0, @JsonKey(name: 'guest_attention') this.guestAttention = 0});
  factory _ReqUser.fromJson(Map<String, dynamic> json) => _$ReqUserFromJson(json);

@override@JsonKey() final  int attention;
@override@JsonKey(name: 'guest_attention') final  int guestAttention;

/// Create a copy of ReqUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReqUserCopyWith<_ReqUser> get copyWith => __$ReqUserCopyWithImpl<_ReqUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReqUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReqUser&&(identical(other.attention, attention) || other.attention == attention)&&(identical(other.guestAttention, guestAttention) || other.guestAttention == guestAttention));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attention,guestAttention);

@override
String toString() {
  return 'ReqUser(attention: $attention, guestAttention: $guestAttention)';
}


}

/// @nodoc
abstract mixin class _$ReqUserCopyWith<$Res> implements $ReqUserCopyWith<$Res> {
  factory _$ReqUserCopyWith(_ReqUser value, $Res Function(_ReqUser) _then) = __$ReqUserCopyWithImpl;
@override @useResult
$Res call({
 int attention,@JsonKey(name: 'guest_attention') int guestAttention
});




}
/// @nodoc
class __$ReqUserCopyWithImpl<$Res>
    implements _$ReqUserCopyWith<$Res> {
  __$ReqUserCopyWithImpl(this._self, this._then);

  final _ReqUser _self;
  final $Res Function(_ReqUser) _then;

/// Create a copy of ReqUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attention = null,Object? guestAttention = null,}) {
  return _then(_ReqUser(
attention: null == attention ? _self.attention : attention // ignore: cast_nullable_to_non_nullable
as int,guestAttention: null == guestAttention ? _self.guestAttention : guestAttention // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VideoPage {

 int get cid; int get page; String get from; String get part; int get duration; String get vid; String get weblink; VideoDimension get dimension;
/// Create a copy of VideoPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoPageCopyWith<VideoPage> get copyWith => _$VideoPageCopyWithImpl<VideoPage>(this as VideoPage, _$identity);

  /// Serializes this VideoPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoPage&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.page, page) || other.page == page)&&(identical(other.from, from) || other.from == from)&&(identical(other.part, part) || other.part == part)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.vid, vid) || other.vid == vid)&&(identical(other.weblink, weblink) || other.weblink == weblink)&&(identical(other.dimension, dimension) || other.dimension == dimension));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cid,page,from,part,duration,vid,weblink,dimension);

@override
String toString() {
  return 'VideoPage(cid: $cid, page: $page, from: $from, part: $part, duration: $duration, vid: $vid, weblink: $weblink, dimension: $dimension)';
}


}

/// @nodoc
abstract mixin class $VideoPageCopyWith<$Res>  {
  factory $VideoPageCopyWith(VideoPage value, $Res Function(VideoPage) _then) = _$VideoPageCopyWithImpl;
@useResult
$Res call({
 int cid, int page, String from, String part, int duration, String vid, String weblink, VideoDimension dimension
});


$VideoDimensionCopyWith<$Res> get dimension;

}
/// @nodoc
class _$VideoPageCopyWithImpl<$Res>
    implements $VideoPageCopyWith<$Res> {
  _$VideoPageCopyWithImpl(this._self, this._then);

  final VideoPage _self;
  final $Res Function(VideoPage) _then;

/// Create a copy of VideoPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cid = null,Object? page = null,Object? from = null,Object? part = null,Object? duration = null,Object? vid = null,Object? weblink = null,Object? dimension = null,}) {
  return _then(_self.copyWith(
cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,vid: null == vid ? _self.vid : vid // ignore: cast_nullable_to_non_nullable
as String,weblink: null == weblink ? _self.weblink : weblink // ignore: cast_nullable_to_non_nullable
as String,dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as VideoDimension,
  ));
}
/// Create a copy of VideoPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoDimensionCopyWith<$Res> get dimension {
  
  return $VideoDimensionCopyWith<$Res>(_self.dimension, (value) {
    return _then(_self.copyWith(dimension: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoPage].
extension VideoPagePatterns on VideoPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoPage value)  $default,){
final _that = this;
switch (_that) {
case _VideoPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoPage value)?  $default,){
final _that = this;
switch (_that) {
case _VideoPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cid,  int page,  String from,  String part,  int duration,  String vid,  String weblink,  VideoDimension dimension)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoPage() when $default != null:
return $default(_that.cid,_that.page,_that.from,_that.part,_that.duration,_that.vid,_that.weblink,_that.dimension);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cid,  int page,  String from,  String part,  int duration,  String vid,  String weblink,  VideoDimension dimension)  $default,) {final _that = this;
switch (_that) {
case _VideoPage():
return $default(_that.cid,_that.page,_that.from,_that.part,_that.duration,_that.vid,_that.weblink,_that.dimension);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cid,  int page,  String from,  String part,  int duration,  String vid,  String weblink,  VideoDimension dimension)?  $default,) {final _that = this;
switch (_that) {
case _VideoPage() when $default != null:
return $default(_that.cid,_that.page,_that.from,_that.part,_that.duration,_that.vid,_that.weblink,_that.dimension);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoPage implements VideoPage {
  const _VideoPage({required this.cid, this.page = 0, this.from = '', this.part = '', this.duration = 0, this.vid = '', this.weblink = '', this.dimension = const VideoDimension()});
  factory _VideoPage.fromJson(Map<String, dynamic> json) => _$VideoPageFromJson(json);

@override final  int cid;
@override@JsonKey() final  int page;
@override@JsonKey() final  String from;
@override@JsonKey() final  String part;
@override@JsonKey() final  int duration;
@override@JsonKey() final  String vid;
@override@JsonKey() final  String weblink;
@override@JsonKey() final  VideoDimension dimension;

/// Create a copy of VideoPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoPageCopyWith<_VideoPage> get copyWith => __$VideoPageCopyWithImpl<_VideoPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoPage&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.page, page) || other.page == page)&&(identical(other.from, from) || other.from == from)&&(identical(other.part, part) || other.part == part)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.vid, vid) || other.vid == vid)&&(identical(other.weblink, weblink) || other.weblink == weblink)&&(identical(other.dimension, dimension) || other.dimension == dimension));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cid,page,from,part,duration,vid,weblink,dimension);

@override
String toString() {
  return 'VideoPage(cid: $cid, page: $page, from: $from, part: $part, duration: $duration, vid: $vid, weblink: $weblink, dimension: $dimension)';
}


}

/// @nodoc
abstract mixin class _$VideoPageCopyWith<$Res> implements $VideoPageCopyWith<$Res> {
  factory _$VideoPageCopyWith(_VideoPage value, $Res Function(_VideoPage) _then) = __$VideoPageCopyWithImpl;
@override @useResult
$Res call({
 int cid, int page, String from, String part, int duration, String vid, String weblink, VideoDimension dimension
});


@override $VideoDimensionCopyWith<$Res> get dimension;

}
/// @nodoc
class __$VideoPageCopyWithImpl<$Res>
    implements _$VideoPageCopyWith<$Res> {
  __$VideoPageCopyWithImpl(this._self, this._then);

  final _VideoPage _self;
  final $Res Function(_VideoPage) _then;

/// Create a copy of VideoPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cid = null,Object? page = null,Object? from = null,Object? part = null,Object? duration = null,Object? vid = null,Object? weblink = null,Object? dimension = null,}) {
  return _then(_VideoPage(
cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,vid: null == vid ? _self.vid : vid // ignore: cast_nullable_to_non_nullable
as String,weblink: null == weblink ? _self.weblink : weblink // ignore: cast_nullable_to_non_nullable
as String,dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as VideoDimension,
  ));
}

/// Create a copy of VideoPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoDimensionCopyWith<$Res> get dimension {
  
  return $VideoDimensionCopyWith<$Res>(_self.dimension, (value) {
    return _then(_self.copyWith(dimension: value));
  });
}
}


/// @nodoc
mixin _$VideoDimension {

 int get width; int get height; int get rotate;
/// Create a copy of VideoDimension
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoDimensionCopyWith<VideoDimension> get copyWith => _$VideoDimensionCopyWithImpl<VideoDimension>(this as VideoDimension, _$identity);

  /// Serializes this VideoDimension to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoDimension&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotate, rotate) || other.rotate == rotate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,rotate);

@override
String toString() {
  return 'VideoDimension(width: $width, height: $height, rotate: $rotate)';
}


}

/// @nodoc
abstract mixin class $VideoDimensionCopyWith<$Res>  {
  factory $VideoDimensionCopyWith(VideoDimension value, $Res Function(VideoDimension) _then) = _$VideoDimensionCopyWithImpl;
@useResult
$Res call({
 int width, int height, int rotate
});




}
/// @nodoc
class _$VideoDimensionCopyWithImpl<$Res>
    implements $VideoDimensionCopyWith<$Res> {
  _$VideoDimensionCopyWithImpl(this._self, this._then);

  final VideoDimension _self;
  final $Res Function(VideoDimension) _then;

/// Create a copy of VideoDimension
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,Object? rotate = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,rotate: null == rotate ? _self.rotate : rotate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoDimension].
extension VideoDimensionPatterns on VideoDimension {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoDimension value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoDimension() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoDimension value)  $default,){
final _that = this;
switch (_that) {
case _VideoDimension():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoDimension value)?  $default,){
final _that = this;
switch (_that) {
case _VideoDimension() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int width,  int height,  int rotate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoDimension() when $default != null:
return $default(_that.width,_that.height,_that.rotate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int width,  int height,  int rotate)  $default,) {final _that = this;
switch (_that) {
case _VideoDimension():
return $default(_that.width,_that.height,_that.rotate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int width,  int height,  int rotate)?  $default,) {final _that = this;
switch (_that) {
case _VideoDimension() when $default != null:
return $default(_that.width,_that.height,_that.rotate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoDimension implements VideoDimension {
  const _VideoDimension({this.width = 0, this.height = 0, this.rotate = 0});
  factory _VideoDimension.fromJson(Map<String, dynamic> json) => _$VideoDimensionFromJson(json);

@override@JsonKey() final  int width;
@override@JsonKey() final  int height;
@override@JsonKey() final  int rotate;

/// Create a copy of VideoDimension
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoDimensionCopyWith<_VideoDimension> get copyWith => __$VideoDimensionCopyWithImpl<_VideoDimension>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoDimensionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoDimension&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotate, rotate) || other.rotate == rotate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,rotate);

@override
String toString() {
  return 'VideoDimension(width: $width, height: $height, rotate: $rotate)';
}


}

/// @nodoc
abstract mixin class _$VideoDimensionCopyWith<$Res> implements $VideoDimensionCopyWith<$Res> {
  factory _$VideoDimensionCopyWith(_VideoDimension value, $Res Function(_VideoDimension) _then) = __$VideoDimensionCopyWithImpl;
@override @useResult
$Res call({
 int width, int height, int rotate
});




}
/// @nodoc
class __$VideoDimensionCopyWithImpl<$Res>
    implements _$VideoDimensionCopyWith<$Res> {
  __$VideoDimensionCopyWithImpl(this._self, this._then);

  final _VideoDimension _self;
  final $Res Function(_VideoDimension) _then;

/// Create a copy of VideoDimension
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? rotate = null,}) {
  return _then(_VideoDimension(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,rotate: null == rotate ? _self.rotate : rotate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VideoTag {

@JsonKey(name: 'tag_id') int get tagId;@JsonKey(name: 'tag_name') String get tagName; String get cover; int get likes; int get hates; int get liked; int get hated; int get attribute;@JsonKey(name: 'is_activity') int get isActivity; String get uri;@JsonKey(name: 'tag_type') String get tagType; TagCount get count; int get type; int get state; int get ctime; int get mtime; int get atime;@JsonKey(name: 'is_atten') int get isAtten;@JsonKey(name: 'extra_attr') int get extraAttr;@JsonKey(name: 'music_id') String get musicId; String get content;@JsonKey(name: 'short_content') String get shortContent;@JsonKey(name: 'head_cover') String get headCover;
/// Create a copy of VideoTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoTagCopyWith<VideoTag> get copyWith => _$VideoTagCopyWithImpl<VideoTag>(this as VideoTag, _$identity);

  /// Serializes this VideoTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoTag&&(identical(other.tagId, tagId) || other.tagId == tagId)&&(identical(other.tagName, tagName) || other.tagName == tagName)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.hates, hates) || other.hates == hates)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.hated, hated) || other.hated == hated)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.isActivity, isActivity) || other.isActivity == isActivity)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.tagType, tagType) || other.tagType == tagType)&&(identical(other.count, count) || other.count == count)&&(identical(other.type, type) || other.type == type)&&(identical(other.state, state) || other.state == state)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.atime, atime) || other.atime == atime)&&(identical(other.isAtten, isAtten) || other.isAtten == isAtten)&&(identical(other.extraAttr, extraAttr) || other.extraAttr == extraAttr)&&(identical(other.musicId, musicId) || other.musicId == musicId)&&(identical(other.content, content) || other.content == content)&&(identical(other.shortContent, shortContent) || other.shortContent == shortContent)&&(identical(other.headCover, headCover) || other.headCover == headCover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tagId,tagName,cover,likes,hates,liked,hated,attribute,isActivity,uri,tagType,count,type,state,ctime,mtime,atime,isAtten,extraAttr,musicId,content,shortContent,headCover]);

@override
String toString() {
  return 'VideoTag(tagId: $tagId, tagName: $tagName, cover: $cover, likes: $likes, hates: $hates, liked: $liked, hated: $hated, attribute: $attribute, isActivity: $isActivity, uri: $uri, tagType: $tagType, count: $count, type: $type, state: $state, ctime: $ctime, mtime: $mtime, atime: $atime, isAtten: $isAtten, extraAttr: $extraAttr, musicId: $musicId, content: $content, shortContent: $shortContent, headCover: $headCover)';
}


}

/// @nodoc
abstract mixin class $VideoTagCopyWith<$Res>  {
  factory $VideoTagCopyWith(VideoTag value, $Res Function(VideoTag) _then) = _$VideoTagCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tag_id') int tagId,@JsonKey(name: 'tag_name') String tagName, String cover, int likes, int hates, int liked, int hated, int attribute,@JsonKey(name: 'is_activity') int isActivity, String uri,@JsonKey(name: 'tag_type') String tagType, TagCount count, int type, int state, int ctime, int mtime, int atime,@JsonKey(name: 'is_atten') int isAtten,@JsonKey(name: 'extra_attr') int extraAttr,@JsonKey(name: 'music_id') String musicId, String content,@JsonKey(name: 'short_content') String shortContent,@JsonKey(name: 'head_cover') String headCover
});


$TagCountCopyWith<$Res> get count;

}
/// @nodoc
class _$VideoTagCopyWithImpl<$Res>
    implements $VideoTagCopyWith<$Res> {
  _$VideoTagCopyWithImpl(this._self, this._then);

  final VideoTag _self;
  final $Res Function(VideoTag) _then;

/// Create a copy of VideoTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tagId = null,Object? tagName = null,Object? cover = null,Object? likes = null,Object? hates = null,Object? liked = null,Object? hated = null,Object? attribute = null,Object? isActivity = null,Object? uri = null,Object? tagType = null,Object? count = null,Object? type = null,Object? state = null,Object? ctime = null,Object? mtime = null,Object? atime = null,Object? isAtten = null,Object? extraAttr = null,Object? musicId = null,Object? content = null,Object? shortContent = null,Object? headCover = null,}) {
  return _then(_self.copyWith(
tagId: null == tagId ? _self.tagId : tagId // ignore: cast_nullable_to_non_nullable
as int,tagName: null == tagName ? _self.tagName : tagName // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,hates: null == hates ? _self.hates : hates // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as int,hated: null == hated ? _self.hated : hated // ignore: cast_nullable_to_non_nullable
as int,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as int,isActivity: null == isActivity ? _self.isActivity : isActivity // ignore: cast_nullable_to_non_nullable
as int,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,tagType: null == tagType ? _self.tagType : tagType // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as TagCount,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,mtime: null == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int,atime: null == atime ? _self.atime : atime // ignore: cast_nullable_to_non_nullable
as int,isAtten: null == isAtten ? _self.isAtten : isAtten // ignore: cast_nullable_to_non_nullable
as int,extraAttr: null == extraAttr ? _self.extraAttr : extraAttr // ignore: cast_nullable_to_non_nullable
as int,musicId: null == musicId ? _self.musicId : musicId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,shortContent: null == shortContent ? _self.shortContent : shortContent // ignore: cast_nullable_to_non_nullable
as String,headCover: null == headCover ? _self.headCover : headCover // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of VideoTag
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagCountCopyWith<$Res> get count {
  
  return $TagCountCopyWith<$Res>(_self.count, (value) {
    return _then(_self.copyWith(count: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoTag].
extension VideoTagPatterns on VideoTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoTag value)  $default,){
final _that = this;
switch (_that) {
case _VideoTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoTag value)?  $default,){
final _that = this;
switch (_that) {
case _VideoTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tag_id')  int tagId, @JsonKey(name: 'tag_name')  String tagName,  String cover,  int likes,  int hates,  int liked,  int hated,  int attribute, @JsonKey(name: 'is_activity')  int isActivity,  String uri, @JsonKey(name: 'tag_type')  String tagType,  TagCount count,  int type,  int state,  int ctime,  int mtime,  int atime, @JsonKey(name: 'is_atten')  int isAtten, @JsonKey(name: 'extra_attr')  int extraAttr, @JsonKey(name: 'music_id')  String musicId,  String content, @JsonKey(name: 'short_content')  String shortContent, @JsonKey(name: 'head_cover')  String headCover)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoTag() when $default != null:
return $default(_that.tagId,_that.tagName,_that.cover,_that.likes,_that.hates,_that.liked,_that.hated,_that.attribute,_that.isActivity,_that.uri,_that.tagType,_that.count,_that.type,_that.state,_that.ctime,_that.mtime,_that.atime,_that.isAtten,_that.extraAttr,_that.musicId,_that.content,_that.shortContent,_that.headCover);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tag_id')  int tagId, @JsonKey(name: 'tag_name')  String tagName,  String cover,  int likes,  int hates,  int liked,  int hated,  int attribute, @JsonKey(name: 'is_activity')  int isActivity,  String uri, @JsonKey(name: 'tag_type')  String tagType,  TagCount count,  int type,  int state,  int ctime,  int mtime,  int atime, @JsonKey(name: 'is_atten')  int isAtten, @JsonKey(name: 'extra_attr')  int extraAttr, @JsonKey(name: 'music_id')  String musicId,  String content, @JsonKey(name: 'short_content')  String shortContent, @JsonKey(name: 'head_cover')  String headCover)  $default,) {final _that = this;
switch (_that) {
case _VideoTag():
return $default(_that.tagId,_that.tagName,_that.cover,_that.likes,_that.hates,_that.liked,_that.hated,_that.attribute,_that.isActivity,_that.uri,_that.tagType,_that.count,_that.type,_that.state,_that.ctime,_that.mtime,_that.atime,_that.isAtten,_that.extraAttr,_that.musicId,_that.content,_that.shortContent,_that.headCover);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tag_id')  int tagId, @JsonKey(name: 'tag_name')  String tagName,  String cover,  int likes,  int hates,  int liked,  int hated,  int attribute, @JsonKey(name: 'is_activity')  int isActivity,  String uri, @JsonKey(name: 'tag_type')  String tagType,  TagCount count,  int type,  int state,  int ctime,  int mtime,  int atime, @JsonKey(name: 'is_atten')  int isAtten, @JsonKey(name: 'extra_attr')  int extraAttr, @JsonKey(name: 'music_id')  String musicId,  String content, @JsonKey(name: 'short_content')  String shortContent, @JsonKey(name: 'head_cover')  String headCover)?  $default,) {final _that = this;
switch (_that) {
case _VideoTag() when $default != null:
return $default(_that.tagId,_that.tagName,_that.cover,_that.likes,_that.hates,_that.liked,_that.hated,_that.attribute,_that.isActivity,_that.uri,_that.tagType,_that.count,_that.type,_that.state,_that.ctime,_that.mtime,_that.atime,_that.isAtten,_that.extraAttr,_that.musicId,_that.content,_that.shortContent,_that.headCover);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoTag implements VideoTag {
  const _VideoTag({@JsonKey(name: 'tag_id') this.tagId = 0, @JsonKey(name: 'tag_name') this.tagName = '', this.cover = '', this.likes = 0, this.hates = 0, this.liked = 0, this.hated = 0, this.attribute = 0, @JsonKey(name: 'is_activity') this.isActivity = 0, this.uri = '', @JsonKey(name: 'tag_type') this.tagType = '', this.count = const TagCount(), this.type = 0, this.state = 0, this.ctime = 0, this.mtime = 0, this.atime = 0, @JsonKey(name: 'is_atten') this.isAtten = 0, @JsonKey(name: 'extra_attr') this.extraAttr = 0, @JsonKey(name: 'music_id') this.musicId = '', this.content = '', @JsonKey(name: 'short_content') this.shortContent = '', @JsonKey(name: 'head_cover') this.headCover = ''});
  factory _VideoTag.fromJson(Map<String, dynamic> json) => _$VideoTagFromJson(json);

@override@JsonKey(name: 'tag_id') final  int tagId;
@override@JsonKey(name: 'tag_name') final  String tagName;
@override@JsonKey() final  String cover;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int hates;
@override@JsonKey() final  int liked;
@override@JsonKey() final  int hated;
@override@JsonKey() final  int attribute;
@override@JsonKey(name: 'is_activity') final  int isActivity;
@override@JsonKey() final  String uri;
@override@JsonKey(name: 'tag_type') final  String tagType;
@override@JsonKey() final  TagCount count;
@override@JsonKey() final  int type;
@override@JsonKey() final  int state;
@override@JsonKey() final  int ctime;
@override@JsonKey() final  int mtime;
@override@JsonKey() final  int atime;
@override@JsonKey(name: 'is_atten') final  int isAtten;
@override@JsonKey(name: 'extra_attr') final  int extraAttr;
@override@JsonKey(name: 'music_id') final  String musicId;
@override@JsonKey() final  String content;
@override@JsonKey(name: 'short_content') final  String shortContent;
@override@JsonKey(name: 'head_cover') final  String headCover;

/// Create a copy of VideoTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoTagCopyWith<_VideoTag> get copyWith => __$VideoTagCopyWithImpl<_VideoTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoTagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoTag&&(identical(other.tagId, tagId) || other.tagId == tagId)&&(identical(other.tagName, tagName) || other.tagName == tagName)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.hates, hates) || other.hates == hates)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.hated, hated) || other.hated == hated)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.isActivity, isActivity) || other.isActivity == isActivity)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.tagType, tagType) || other.tagType == tagType)&&(identical(other.count, count) || other.count == count)&&(identical(other.type, type) || other.type == type)&&(identical(other.state, state) || other.state == state)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.atime, atime) || other.atime == atime)&&(identical(other.isAtten, isAtten) || other.isAtten == isAtten)&&(identical(other.extraAttr, extraAttr) || other.extraAttr == extraAttr)&&(identical(other.musicId, musicId) || other.musicId == musicId)&&(identical(other.content, content) || other.content == content)&&(identical(other.shortContent, shortContent) || other.shortContent == shortContent)&&(identical(other.headCover, headCover) || other.headCover == headCover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tagId,tagName,cover,likes,hates,liked,hated,attribute,isActivity,uri,tagType,count,type,state,ctime,mtime,atime,isAtten,extraAttr,musicId,content,shortContent,headCover]);

@override
String toString() {
  return 'VideoTag(tagId: $tagId, tagName: $tagName, cover: $cover, likes: $likes, hates: $hates, liked: $liked, hated: $hated, attribute: $attribute, isActivity: $isActivity, uri: $uri, tagType: $tagType, count: $count, type: $type, state: $state, ctime: $ctime, mtime: $mtime, atime: $atime, isAtten: $isAtten, extraAttr: $extraAttr, musicId: $musicId, content: $content, shortContent: $shortContent, headCover: $headCover)';
}


}

/// @nodoc
abstract mixin class _$VideoTagCopyWith<$Res> implements $VideoTagCopyWith<$Res> {
  factory _$VideoTagCopyWith(_VideoTag value, $Res Function(_VideoTag) _then) = __$VideoTagCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tag_id') int tagId,@JsonKey(name: 'tag_name') String tagName, String cover, int likes, int hates, int liked, int hated, int attribute,@JsonKey(name: 'is_activity') int isActivity, String uri,@JsonKey(name: 'tag_type') String tagType, TagCount count, int type, int state, int ctime, int mtime, int atime,@JsonKey(name: 'is_atten') int isAtten,@JsonKey(name: 'extra_attr') int extraAttr,@JsonKey(name: 'music_id') String musicId, String content,@JsonKey(name: 'short_content') String shortContent,@JsonKey(name: 'head_cover') String headCover
});


@override $TagCountCopyWith<$Res> get count;

}
/// @nodoc
class __$VideoTagCopyWithImpl<$Res>
    implements _$VideoTagCopyWith<$Res> {
  __$VideoTagCopyWithImpl(this._self, this._then);

  final _VideoTag _self;
  final $Res Function(_VideoTag) _then;

/// Create a copy of VideoTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tagId = null,Object? tagName = null,Object? cover = null,Object? likes = null,Object? hates = null,Object? liked = null,Object? hated = null,Object? attribute = null,Object? isActivity = null,Object? uri = null,Object? tagType = null,Object? count = null,Object? type = null,Object? state = null,Object? ctime = null,Object? mtime = null,Object? atime = null,Object? isAtten = null,Object? extraAttr = null,Object? musicId = null,Object? content = null,Object? shortContent = null,Object? headCover = null,}) {
  return _then(_VideoTag(
tagId: null == tagId ? _self.tagId : tagId // ignore: cast_nullable_to_non_nullable
as int,tagName: null == tagName ? _self.tagName : tagName // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,hates: null == hates ? _self.hates : hates // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as int,hated: null == hated ? _self.hated : hated // ignore: cast_nullable_to_non_nullable
as int,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as int,isActivity: null == isActivity ? _self.isActivity : isActivity // ignore: cast_nullable_to_non_nullable
as int,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,tagType: null == tagType ? _self.tagType : tagType // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as TagCount,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,mtime: null == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int,atime: null == atime ? _self.atime : atime // ignore: cast_nullable_to_non_nullable
as int,isAtten: null == isAtten ? _self.isAtten : isAtten // ignore: cast_nullable_to_non_nullable
as int,extraAttr: null == extraAttr ? _self.extraAttr : extraAttr // ignore: cast_nullable_to_non_nullable
as int,musicId: null == musicId ? _self.musicId : musicId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,shortContent: null == shortContent ? _self.shortContent : shortContent // ignore: cast_nullable_to_non_nullable
as String,headCover: null == headCover ? _self.headCover : headCover // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of VideoTag
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagCountCopyWith<$Res> get count {
  
  return $TagCountCopyWith<$Res>(_self.count, (value) {
    return _then(_self.copyWith(count: value));
  });
}
}


/// @nodoc
mixin _$TagCount {

 int get view; int get use; int get atten;
/// Create a copy of TagCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagCountCopyWith<TagCount> get copyWith => _$TagCountCopyWithImpl<TagCount>(this as TagCount, _$identity);

  /// Serializes this TagCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagCount&&(identical(other.view, view) || other.view == view)&&(identical(other.use, use) || other.use == use)&&(identical(other.atten, atten) || other.atten == atten));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,view,use,atten);

@override
String toString() {
  return 'TagCount(view: $view, use: $use, atten: $atten)';
}


}

/// @nodoc
abstract mixin class $TagCountCopyWith<$Res>  {
  factory $TagCountCopyWith(TagCount value, $Res Function(TagCount) _then) = _$TagCountCopyWithImpl;
@useResult
$Res call({
 int view, int use, int atten
});




}
/// @nodoc
class _$TagCountCopyWithImpl<$Res>
    implements $TagCountCopyWith<$Res> {
  _$TagCountCopyWithImpl(this._self, this._then);

  final TagCount _self;
  final $Res Function(TagCount) _then;

/// Create a copy of TagCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? use = null,Object? atten = null,}) {
  return _then(_self.copyWith(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int,use: null == use ? _self.use : use // ignore: cast_nullable_to_non_nullable
as int,atten: null == atten ? _self.atten : atten // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TagCount].
extension TagCountPatterns on TagCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagCount value)  $default,){
final _that = this;
switch (_that) {
case _TagCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagCount value)?  $default,){
final _that = this;
switch (_that) {
case _TagCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int view,  int use,  int atten)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagCount() when $default != null:
return $default(_that.view,_that.use,_that.atten);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int view,  int use,  int atten)  $default,) {final _that = this;
switch (_that) {
case _TagCount():
return $default(_that.view,_that.use,_that.atten);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int view,  int use,  int atten)?  $default,) {final _that = this;
switch (_that) {
case _TagCount() when $default != null:
return $default(_that.view,_that.use,_that.atten);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TagCount implements TagCount {
  const _TagCount({this.view = 0, this.use = 0, this.atten = 0});
  factory _TagCount.fromJson(Map<String, dynamic> json) => _$TagCountFromJson(json);

@override@JsonKey() final  int view;
@override@JsonKey() final  int use;
@override@JsonKey() final  int atten;

/// Create a copy of TagCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagCountCopyWith<_TagCount> get copyWith => __$TagCountCopyWithImpl<_TagCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagCount&&(identical(other.view, view) || other.view == view)&&(identical(other.use, use) || other.use == use)&&(identical(other.atten, atten) || other.atten == atten));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,view,use,atten);

@override
String toString() {
  return 'TagCount(view: $view, use: $use, atten: $atten)';
}


}

/// @nodoc
abstract mixin class _$TagCountCopyWith<$Res> implements $TagCountCopyWith<$Res> {
  factory _$TagCountCopyWith(_TagCount value, $Res Function(_TagCount) _then) = __$TagCountCopyWithImpl;
@override @useResult
$Res call({
 int view, int use, int atten
});




}
/// @nodoc
class __$TagCountCopyWithImpl<$Res>
    implements _$TagCountCopyWith<$Res> {
  __$TagCountCopyWithImpl(this._self, this._then);

  final _TagCount _self;
  final $Res Function(_TagCount) _then;

/// Create a copy of TagCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = null,Object? use = null,Object? atten = null,}) {
  return _then(_TagCount(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int,use: null == use ? _self.use : use // ignore: cast_nullable_to_non_nullable
as int,atten: null == atten ? _self.atten : atten // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
