// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_space_video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSpaceVideoModel {

 int get aid; String get bvid; String get title; String get pic; String get tname; int get duration;@JsonKey(name: 'pubdate') int get pubDate; int get ctime; String get desc; int get state; int get attribute; int get tid; Owner get owner; Stat get stat; String get reason;@JsonKey(name: 'inter_video') bool get interVideo;
/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSpaceVideoModelCopyWith<UserSpaceVideoModel> get copyWith => _$UserSpaceVideoModelCopyWithImpl<UserSpaceVideoModel>(this as UserSpaceVideoModel, _$identity);

  /// Serializes this UserSpaceVideoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSpaceVideoModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.title, title) || other.title == title)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.tname, tname) || other.tname == tname)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.state, state) || other.state == state)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.interVideo, interVideo) || other.interVideo == interVideo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,bvid,title,pic,tname,duration,pubDate,ctime,desc,state,attribute,tid,owner,stat,reason,interVideo);

@override
String toString() {
  return 'UserSpaceVideoModel(aid: $aid, bvid: $bvid, title: $title, pic: $pic, tname: $tname, duration: $duration, pubDate: $pubDate, ctime: $ctime, desc: $desc, state: $state, attribute: $attribute, tid: $tid, owner: $owner, stat: $stat, reason: $reason, interVideo: $interVideo)';
}


}

/// @nodoc
abstract mixin class $UserSpaceVideoModelCopyWith<$Res>  {
  factory $UserSpaceVideoModelCopyWith(UserSpaceVideoModel value, $Res Function(UserSpaceVideoModel) _then) = _$UserSpaceVideoModelCopyWithImpl;
@useResult
$Res call({
 int aid, String bvid, String title, String pic, String tname, int duration,@JsonKey(name: 'pubdate') int pubDate, int ctime, String desc, int state, int attribute, int tid, Owner owner, Stat stat, String reason,@JsonKey(name: 'inter_video') bool interVideo
});


$OwnerCopyWith<$Res> get owner;$StatCopyWith<$Res> get stat;

}
/// @nodoc
class _$UserSpaceVideoModelCopyWithImpl<$Res>
    implements $UserSpaceVideoModelCopyWith<$Res> {
  _$UserSpaceVideoModelCopyWithImpl(this._self, this._then);

  final UserSpaceVideoModel _self;
  final $Res Function(UserSpaceVideoModel) _then;

/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aid = null,Object? bvid = null,Object? title = null,Object? pic = null,Object? tname = null,Object? duration = null,Object? pubDate = null,Object? ctime = null,Object? desc = null,Object? state = null,Object? attribute = null,Object? tid = null,Object? owner = null,Object? stat = null,Object? reason = null,Object? interVideo = null,}) {
  return _then(_self.copyWith(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,tname: null == tname ? _self.tname : tname // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as int,tid: null == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as int,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as Owner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as Stat,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,interVideo: null == interVideo ? _self.interVideo : interVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerCopyWith<$Res> get owner {
  
  return $OwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCopyWith<$Res> get stat {
  
  return $StatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserSpaceVideoModel].
extension UserSpaceVideoModelPatterns on UserSpaceVideoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSpaceVideoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSpaceVideoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSpaceVideoModel value)  $default,){
final _that = this;
switch (_that) {
case _UserSpaceVideoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSpaceVideoModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserSpaceVideoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int aid,  String bvid,  String title,  String pic,  String tname,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  int ctime,  String desc,  int state,  int attribute,  int tid,  Owner owner,  Stat stat,  String reason, @JsonKey(name: 'inter_video')  bool interVideo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSpaceVideoModel() when $default != null:
return $default(_that.aid,_that.bvid,_that.title,_that.pic,_that.tname,_that.duration,_that.pubDate,_that.ctime,_that.desc,_that.state,_that.attribute,_that.tid,_that.owner,_that.stat,_that.reason,_that.interVideo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int aid,  String bvid,  String title,  String pic,  String tname,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  int ctime,  String desc,  int state,  int attribute,  int tid,  Owner owner,  Stat stat,  String reason, @JsonKey(name: 'inter_video')  bool interVideo)  $default,) {final _that = this;
switch (_that) {
case _UserSpaceVideoModel():
return $default(_that.aid,_that.bvid,_that.title,_that.pic,_that.tname,_that.duration,_that.pubDate,_that.ctime,_that.desc,_that.state,_that.attribute,_that.tid,_that.owner,_that.stat,_that.reason,_that.interVideo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int aid,  String bvid,  String title,  String pic,  String tname,  int duration, @JsonKey(name: 'pubdate')  int pubDate,  int ctime,  String desc,  int state,  int attribute,  int tid,  Owner owner,  Stat stat,  String reason, @JsonKey(name: 'inter_video')  bool interVideo)?  $default,) {final _that = this;
switch (_that) {
case _UserSpaceVideoModel() when $default != null:
return $default(_that.aid,_that.bvid,_that.title,_that.pic,_that.tname,_that.duration,_that.pubDate,_that.ctime,_that.desc,_that.state,_that.attribute,_that.tid,_that.owner,_that.stat,_that.reason,_that.interVideo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSpaceVideoModel implements UserSpaceVideoModel {
  const _UserSpaceVideoModel({required this.aid, required this.bvid, required this.title, required this.pic, required this.tname, required this.duration, @JsonKey(name: 'pubdate') required this.pubDate, required this.ctime, this.desc = '', this.state = 0, this.attribute = 0, required this.tid, required this.owner, required this.stat, this.reason = '', @JsonKey(name: 'inter_video') this.interVideo = false});
  factory _UserSpaceVideoModel.fromJson(Map<String, dynamic> json) => _$UserSpaceVideoModelFromJson(json);

@override final  int aid;
@override final  String bvid;
@override final  String title;
@override final  String pic;
@override final  String tname;
@override final  int duration;
@override@JsonKey(name: 'pubdate') final  int pubDate;
@override final  int ctime;
@override@JsonKey() final  String desc;
@override@JsonKey() final  int state;
@override@JsonKey() final  int attribute;
@override final  int tid;
@override final  Owner owner;
@override final  Stat stat;
@override@JsonKey() final  String reason;
@override@JsonKey(name: 'inter_video') final  bool interVideo;

/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSpaceVideoModelCopyWith<_UserSpaceVideoModel> get copyWith => __$UserSpaceVideoModelCopyWithImpl<_UserSpaceVideoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSpaceVideoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSpaceVideoModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.title, title) || other.title == title)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.tname, tname) || other.tname == tname)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.state, state) || other.state == state)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.interVideo, interVideo) || other.interVideo == interVideo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,bvid,title,pic,tname,duration,pubDate,ctime,desc,state,attribute,tid,owner,stat,reason,interVideo);

@override
String toString() {
  return 'UserSpaceVideoModel(aid: $aid, bvid: $bvid, title: $title, pic: $pic, tname: $tname, duration: $duration, pubDate: $pubDate, ctime: $ctime, desc: $desc, state: $state, attribute: $attribute, tid: $tid, owner: $owner, stat: $stat, reason: $reason, interVideo: $interVideo)';
}


}

/// @nodoc
abstract mixin class _$UserSpaceVideoModelCopyWith<$Res> implements $UserSpaceVideoModelCopyWith<$Res> {
  factory _$UserSpaceVideoModelCopyWith(_UserSpaceVideoModel value, $Res Function(_UserSpaceVideoModel) _then) = __$UserSpaceVideoModelCopyWithImpl;
@override @useResult
$Res call({
 int aid, String bvid, String title, String pic, String tname, int duration,@JsonKey(name: 'pubdate') int pubDate, int ctime, String desc, int state, int attribute, int tid, Owner owner, Stat stat, String reason,@JsonKey(name: 'inter_video') bool interVideo
});


@override $OwnerCopyWith<$Res> get owner;@override $StatCopyWith<$Res> get stat;

}
/// @nodoc
class __$UserSpaceVideoModelCopyWithImpl<$Res>
    implements _$UserSpaceVideoModelCopyWith<$Res> {
  __$UserSpaceVideoModelCopyWithImpl(this._self, this._then);

  final _UserSpaceVideoModel _self;
  final $Res Function(_UserSpaceVideoModel) _then;

/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aid = null,Object? bvid = null,Object? title = null,Object? pic = null,Object? tname = null,Object? duration = null,Object? pubDate = null,Object? ctime = null,Object? desc = null,Object? state = null,Object? attribute = null,Object? tid = null,Object? owner = null,Object? stat = null,Object? reason = null,Object? interVideo = null,}) {
  return _then(_UserSpaceVideoModel(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pic: null == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String,tname: null == tname ? _self.tname : tname // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as int,tid: null == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as int,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as Owner,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as Stat,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,interVideo: null == interVideo ? _self.interVideo : interVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerCopyWith<$Res> get owner {
  
  return $OwnerCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of UserSpaceVideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCopyWith<$Res> get stat {
  
  return $StatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// @nodoc
mixin _$UserSpaceVideoListResponse {

 UserSpaceVideoList get list; UserSpacePage get page;
/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSpaceVideoListResponseCopyWith<UserSpaceVideoListResponse> get copyWith => _$UserSpaceVideoListResponseCopyWithImpl<UserSpaceVideoListResponse>(this as UserSpaceVideoListResponse, _$identity);

  /// Serializes this UserSpaceVideoListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSpaceVideoListResponse&&(identical(other.list, list) || other.list == list)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,page);

@override
String toString() {
  return 'UserSpaceVideoListResponse(list: $list, page: $page)';
}


}

/// @nodoc
abstract mixin class $UserSpaceVideoListResponseCopyWith<$Res>  {
  factory $UserSpaceVideoListResponseCopyWith(UserSpaceVideoListResponse value, $Res Function(UserSpaceVideoListResponse) _then) = _$UserSpaceVideoListResponseCopyWithImpl;
@useResult
$Res call({
 UserSpaceVideoList list, UserSpacePage page
});


$UserSpaceVideoListCopyWith<$Res> get list;$UserSpacePageCopyWith<$Res> get page;

}
/// @nodoc
class _$UserSpaceVideoListResponseCopyWithImpl<$Res>
    implements $UserSpaceVideoListResponseCopyWith<$Res> {
  _$UserSpaceVideoListResponseCopyWithImpl(this._self, this._then);

  final UserSpaceVideoListResponse _self;
  final $Res Function(UserSpaceVideoListResponse) _then;

/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? page = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as UserSpaceVideoList,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as UserSpacePage,
  ));
}
/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSpaceVideoListCopyWith<$Res> get list {
  
  return $UserSpaceVideoListCopyWith<$Res>(_self.list, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSpacePageCopyWith<$Res> get page {
  
  return $UserSpacePageCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserSpaceVideoListResponse].
extension UserSpaceVideoListResponsePatterns on UserSpaceVideoListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSpaceVideoListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSpaceVideoListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSpaceVideoListResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserSpaceVideoListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSpaceVideoListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserSpaceVideoListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserSpaceVideoList list,  UserSpacePage page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSpaceVideoListResponse() when $default != null:
return $default(_that.list,_that.page);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserSpaceVideoList list,  UserSpacePage page)  $default,) {final _that = this;
switch (_that) {
case _UserSpaceVideoListResponse():
return $default(_that.list,_that.page);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserSpaceVideoList list,  UserSpacePage page)?  $default,) {final _that = this;
switch (_that) {
case _UserSpaceVideoListResponse() when $default != null:
return $default(_that.list,_that.page);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSpaceVideoListResponse implements UserSpaceVideoListResponse {
  const _UserSpaceVideoListResponse({required this.list, required this.page});
  factory _UserSpaceVideoListResponse.fromJson(Map<String, dynamic> json) => _$UserSpaceVideoListResponseFromJson(json);

@override final  UserSpaceVideoList list;
@override final  UserSpacePage page;

/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSpaceVideoListResponseCopyWith<_UserSpaceVideoListResponse> get copyWith => __$UserSpaceVideoListResponseCopyWithImpl<_UserSpaceVideoListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSpaceVideoListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSpaceVideoListResponse&&(identical(other.list, list) || other.list == list)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,page);

@override
String toString() {
  return 'UserSpaceVideoListResponse(list: $list, page: $page)';
}


}

/// @nodoc
abstract mixin class _$UserSpaceVideoListResponseCopyWith<$Res> implements $UserSpaceVideoListResponseCopyWith<$Res> {
  factory _$UserSpaceVideoListResponseCopyWith(_UserSpaceVideoListResponse value, $Res Function(_UserSpaceVideoListResponse) _then) = __$UserSpaceVideoListResponseCopyWithImpl;
@override @useResult
$Res call({
 UserSpaceVideoList list, UserSpacePage page
});


@override $UserSpaceVideoListCopyWith<$Res> get list;@override $UserSpacePageCopyWith<$Res> get page;

}
/// @nodoc
class __$UserSpaceVideoListResponseCopyWithImpl<$Res>
    implements _$UserSpaceVideoListResponseCopyWith<$Res> {
  __$UserSpaceVideoListResponseCopyWithImpl(this._self, this._then);

  final _UserSpaceVideoListResponse _self;
  final $Res Function(_UserSpaceVideoListResponse) _then;

/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? page = null,}) {
  return _then(_UserSpaceVideoListResponse(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as UserSpaceVideoList,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as UserSpacePage,
  ));
}

/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSpaceVideoListCopyWith<$Res> get list {
  
  return $UserSpaceVideoListCopyWith<$Res>(_self.list, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of UserSpaceVideoListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSpacePageCopyWith<$Res> get page {
  
  return $UserSpacePageCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}


/// @nodoc
mixin _$UserSpaceVideoList {

 List<UserSpaceVideoModel> get vlist;
/// Create a copy of UserSpaceVideoList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSpaceVideoListCopyWith<UserSpaceVideoList> get copyWith => _$UserSpaceVideoListCopyWithImpl<UserSpaceVideoList>(this as UserSpaceVideoList, _$identity);

  /// Serializes this UserSpaceVideoList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSpaceVideoList&&const DeepCollectionEquality().equals(other.vlist, vlist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(vlist));

@override
String toString() {
  return 'UserSpaceVideoList(vlist: $vlist)';
}


}

/// @nodoc
abstract mixin class $UserSpaceVideoListCopyWith<$Res>  {
  factory $UserSpaceVideoListCopyWith(UserSpaceVideoList value, $Res Function(UserSpaceVideoList) _then) = _$UserSpaceVideoListCopyWithImpl;
@useResult
$Res call({
 List<UserSpaceVideoModel> vlist
});




}
/// @nodoc
class _$UserSpaceVideoListCopyWithImpl<$Res>
    implements $UserSpaceVideoListCopyWith<$Res> {
  _$UserSpaceVideoListCopyWithImpl(this._self, this._then);

  final UserSpaceVideoList _self;
  final $Res Function(UserSpaceVideoList) _then;

/// Create a copy of UserSpaceVideoList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vlist = null,}) {
  return _then(_self.copyWith(
vlist: null == vlist ? _self.vlist : vlist // ignore: cast_nullable_to_non_nullable
as List<UserSpaceVideoModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSpaceVideoList].
extension UserSpaceVideoListPatterns on UserSpaceVideoList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSpaceVideoList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSpaceVideoList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSpaceVideoList value)  $default,){
final _that = this;
switch (_that) {
case _UserSpaceVideoList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSpaceVideoList value)?  $default,){
final _that = this;
switch (_that) {
case _UserSpaceVideoList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserSpaceVideoModel> vlist)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSpaceVideoList() when $default != null:
return $default(_that.vlist);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserSpaceVideoModel> vlist)  $default,) {final _that = this;
switch (_that) {
case _UserSpaceVideoList():
return $default(_that.vlist);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserSpaceVideoModel> vlist)?  $default,) {final _that = this;
switch (_that) {
case _UserSpaceVideoList() when $default != null:
return $default(_that.vlist);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSpaceVideoList implements UserSpaceVideoList {
  const _UserSpaceVideoList({final  List<UserSpaceVideoModel> vlist = const []}): _vlist = vlist;
  factory _UserSpaceVideoList.fromJson(Map<String, dynamic> json) => _$UserSpaceVideoListFromJson(json);

 final  List<UserSpaceVideoModel> _vlist;
@override@JsonKey() List<UserSpaceVideoModel> get vlist {
  if (_vlist is EqualUnmodifiableListView) return _vlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vlist);
}


/// Create a copy of UserSpaceVideoList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSpaceVideoListCopyWith<_UserSpaceVideoList> get copyWith => __$UserSpaceVideoListCopyWithImpl<_UserSpaceVideoList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSpaceVideoListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSpaceVideoList&&const DeepCollectionEquality().equals(other._vlist, _vlist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vlist));

@override
String toString() {
  return 'UserSpaceVideoList(vlist: $vlist)';
}


}

/// @nodoc
abstract mixin class _$UserSpaceVideoListCopyWith<$Res> implements $UserSpaceVideoListCopyWith<$Res> {
  factory _$UserSpaceVideoListCopyWith(_UserSpaceVideoList value, $Res Function(_UserSpaceVideoList) _then) = __$UserSpaceVideoListCopyWithImpl;
@override @useResult
$Res call({
 List<UserSpaceVideoModel> vlist
});




}
/// @nodoc
class __$UserSpaceVideoListCopyWithImpl<$Res>
    implements _$UserSpaceVideoListCopyWith<$Res> {
  __$UserSpaceVideoListCopyWithImpl(this._self, this._then);

  final _UserSpaceVideoList _self;
  final $Res Function(_UserSpaceVideoList) _then;

/// Create a copy of UserSpaceVideoList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vlist = null,}) {
  return _then(_UserSpaceVideoList(
vlist: null == vlist ? _self._vlist : vlist // ignore: cast_nullable_to_non_nullable
as List<UserSpaceVideoModel>,
  ));
}


}


/// @nodoc
mixin _$UserSpacePage {

 int get pn; int get ps; int get count;
/// Create a copy of UserSpacePage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSpacePageCopyWith<UserSpacePage> get copyWith => _$UserSpacePageCopyWithImpl<UserSpacePage>(this as UserSpacePage, _$identity);

  /// Serializes this UserSpacePage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSpacePage&&(identical(other.pn, pn) || other.pn == pn)&&(identical(other.ps, ps) || other.ps == ps)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pn,ps,count);

@override
String toString() {
  return 'UserSpacePage(pn: $pn, ps: $ps, count: $count)';
}


}

/// @nodoc
abstract mixin class $UserSpacePageCopyWith<$Res>  {
  factory $UserSpacePageCopyWith(UserSpacePage value, $Res Function(UserSpacePage) _then) = _$UserSpacePageCopyWithImpl;
@useResult
$Res call({
 int pn, int ps, int count
});




}
/// @nodoc
class _$UserSpacePageCopyWithImpl<$Res>
    implements $UserSpacePageCopyWith<$Res> {
  _$UserSpacePageCopyWithImpl(this._self, this._then);

  final UserSpacePage _self;
  final $Res Function(UserSpacePage) _then;

/// Create a copy of UserSpacePage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pn = null,Object? ps = null,Object? count = null,}) {
  return _then(_self.copyWith(
pn: null == pn ? _self.pn : pn // ignore: cast_nullable_to_non_nullable
as int,ps: null == ps ? _self.ps : ps // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSpacePage].
extension UserSpacePagePatterns on UserSpacePage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSpacePage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSpacePage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSpacePage value)  $default,){
final _that = this;
switch (_that) {
case _UserSpacePage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSpacePage value)?  $default,){
final _that = this;
switch (_that) {
case _UserSpacePage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pn,  int ps,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSpacePage() when $default != null:
return $default(_that.pn,_that.ps,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pn,  int ps,  int count)  $default,) {final _that = this;
switch (_that) {
case _UserSpacePage():
return $default(_that.pn,_that.ps,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pn,  int ps,  int count)?  $default,) {final _that = this;
switch (_that) {
case _UserSpacePage() when $default != null:
return $default(_that.pn,_that.ps,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSpacePage implements UserSpacePage {
  const _UserSpacePage({this.pn = 1, this.ps = 30, this.count = 0});
  factory _UserSpacePage.fromJson(Map<String, dynamic> json) => _$UserSpacePageFromJson(json);

@override@JsonKey() final  int pn;
@override@JsonKey() final  int ps;
@override@JsonKey() final  int count;

/// Create a copy of UserSpacePage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSpacePageCopyWith<_UserSpacePage> get copyWith => __$UserSpacePageCopyWithImpl<_UserSpacePage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSpacePageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSpacePage&&(identical(other.pn, pn) || other.pn == pn)&&(identical(other.ps, ps) || other.ps == ps)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pn,ps,count);

@override
String toString() {
  return 'UserSpacePage(pn: $pn, ps: $ps, count: $count)';
}


}

/// @nodoc
abstract mixin class _$UserSpacePageCopyWith<$Res> implements $UserSpacePageCopyWith<$Res> {
  factory _$UserSpacePageCopyWith(_UserSpacePage value, $Res Function(_UserSpacePage) _then) = __$UserSpacePageCopyWithImpl;
@override @useResult
$Res call({
 int pn, int ps, int count
});




}
/// @nodoc
class __$UserSpacePageCopyWithImpl<$Res>
    implements _$UserSpacePageCopyWith<$Res> {
  __$UserSpacePageCopyWithImpl(this._self, this._then);

  final _UserSpacePage _self;
  final $Res Function(_UserSpacePage) _then;

/// Create a copy of UserSpacePage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pn = null,Object? ps = null,Object? count = null,}) {
  return _then(_UserSpacePage(
pn: null == pn ? _self.pn : pn // ignore: cast_nullable_to_non_nullable
as int,ps: null == ps ? _self.ps : ps // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
