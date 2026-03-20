// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'to_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ToViewModel {

@JsonKey(name: 'aid') int? get aid;@JsonKey(name: 'videos') int? get videos;@JsonKey(name: 'tid') int? get tid;@JsonKey(name: 'tname') String? get tname;@JsonKey(name: 'copyright') int? get copyright;@JsonKey(name: 'pic') String? get pic;@JsonKey(name: 'title') String? get title;@JsonKey(name: 'pubdate') int? get pubdate;@JsonKey(name: 'ctime') int? get ctime;@JsonKey(name: 'desc') String? get desc;@JsonKey(name: 'state') int? get state;@JsonKey(name: 'duration') int? get duration;@JsonKey(name: 'rights') Map<String, dynamic>? get rights;@JsonKey(name: 'owner') FavUpperModel? get owner;@JsonKey(name: 'stat') ToViewStatModel? get stat;@JsonKey(name: 'dynamic') String? get dynamicText;@JsonKey(name: 'cid') int? get cid;@JsonKey(name: 'progress') int? get progress;@JsonKey(name: 'add_at') int? get addAt;@JsonKey(name: 'bvid') String? get bvid;
/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToViewModelCopyWith<ToViewModel> get copyWith => _$ToViewModelCopyWithImpl<ToViewModel>(this as ToViewModel, _$identity);

  /// Serializes this ToViewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToViewModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.tname, tname) || other.tname == tname)&&(identical(other.copyright, copyright) || other.copyright == copyright)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.title, title) || other.title == title)&&(identical(other.pubdate, pubdate) || other.pubdate == pubdate)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.state, state) || other.state == state)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.rights, rights)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.dynamicText, dynamicText) || other.dynamicText == dynamicText)&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.addAt, addAt) || other.addAt == addAt)&&(identical(other.bvid, bvid) || other.bvid == bvid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,aid,videos,tid,tname,copyright,pic,title,pubdate,ctime,desc,state,duration,const DeepCollectionEquality().hash(rights),owner,stat,dynamicText,cid,progress,addAt,bvid]);

@override
String toString() {
  return 'ToViewModel(aid: $aid, videos: $videos, tid: $tid, tname: $tname, copyright: $copyright, pic: $pic, title: $title, pubdate: $pubdate, ctime: $ctime, desc: $desc, state: $state, duration: $duration, rights: $rights, owner: $owner, stat: $stat, dynamicText: $dynamicText, cid: $cid, progress: $progress, addAt: $addAt, bvid: $bvid)';
}


}

/// @nodoc
abstract mixin class $ToViewModelCopyWith<$Res>  {
  factory $ToViewModelCopyWith(ToViewModel value, $Res Function(ToViewModel) _then) = _$ToViewModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'aid') int? aid,@JsonKey(name: 'videos') int? videos,@JsonKey(name: 'tid') int? tid,@JsonKey(name: 'tname') String? tname,@JsonKey(name: 'copyright') int? copyright,@JsonKey(name: 'pic') String? pic,@JsonKey(name: 'title') String? title,@JsonKey(name: 'pubdate') int? pubdate,@JsonKey(name: 'ctime') int? ctime,@JsonKey(name: 'desc') String? desc,@JsonKey(name: 'state') int? state,@JsonKey(name: 'duration') int? duration,@JsonKey(name: 'rights') Map<String, dynamic>? rights,@JsonKey(name: 'owner') FavUpperModel? owner,@JsonKey(name: 'stat') ToViewStatModel? stat,@JsonKey(name: 'dynamic') String? dynamicText,@JsonKey(name: 'cid') int? cid,@JsonKey(name: 'progress') int? progress,@JsonKey(name: 'add_at') int? addAt,@JsonKey(name: 'bvid') String? bvid
});


$FavUpperModelCopyWith<$Res>? get owner;$ToViewStatModelCopyWith<$Res>? get stat;

}
/// @nodoc
class _$ToViewModelCopyWithImpl<$Res>
    implements $ToViewModelCopyWith<$Res> {
  _$ToViewModelCopyWithImpl(this._self, this._then);

  final ToViewModel _self;
  final $Res Function(ToViewModel) _then;

/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aid = freezed,Object? videos = freezed,Object? tid = freezed,Object? tname = freezed,Object? copyright = freezed,Object? pic = freezed,Object? title = freezed,Object? pubdate = freezed,Object? ctime = freezed,Object? desc = freezed,Object? state = freezed,Object? duration = freezed,Object? rights = freezed,Object? owner = freezed,Object? stat = freezed,Object? dynamicText = freezed,Object? cid = freezed,Object? progress = freezed,Object? addAt = freezed,Object? bvid = freezed,}) {
  return _then(_self.copyWith(
aid: freezed == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int?,videos: freezed == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as int?,tname: freezed == tname ? _self.tname : tname // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as int?,pic: freezed == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,pubdate: freezed == pubdate ? _self.pubdate : pubdate // ignore: cast_nullable_to_non_nullable
as int?,ctime: freezed == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,rights: freezed == rights ? _self.rights : rights // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as FavUpperModel?,stat: freezed == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as ToViewStatModel?,dynamicText: freezed == dynamicText ? _self.dynamicText : dynamicText // ignore: cast_nullable_to_non_nullable
as String?,cid: freezed == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int?,addAt: freezed == addAt ? _self.addAt : addAt // ignore: cast_nullable_to_non_nullable
as int?,bvid: freezed == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $FavUpperModelCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToViewStatModelCopyWith<$Res>? get stat {
    if (_self.stat == null) {
    return null;
  }

  return $ToViewStatModelCopyWith<$Res>(_self.stat!, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [ToViewModel].
extension ToViewModelPatterns on ToViewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToViewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToViewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToViewModel value)  $default,){
final _that = this;
switch (_that) {
case _ToViewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToViewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ToViewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'aid')  int? aid, @JsonKey(name: 'videos')  int? videos, @JsonKey(name: 'tid')  int? tid, @JsonKey(name: 'tname')  String? tname, @JsonKey(name: 'copyright')  int? copyright, @JsonKey(name: 'pic')  String? pic, @JsonKey(name: 'title')  String? title, @JsonKey(name: 'pubdate')  int? pubdate, @JsonKey(name: 'ctime')  int? ctime, @JsonKey(name: 'desc')  String? desc, @JsonKey(name: 'state')  int? state, @JsonKey(name: 'duration')  int? duration, @JsonKey(name: 'rights')  Map<String, dynamic>? rights, @JsonKey(name: 'owner')  FavUpperModel? owner, @JsonKey(name: 'stat')  ToViewStatModel? stat, @JsonKey(name: 'dynamic')  String? dynamicText, @JsonKey(name: 'cid')  int? cid, @JsonKey(name: 'progress')  int? progress, @JsonKey(name: 'add_at')  int? addAt, @JsonKey(name: 'bvid')  String? bvid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToViewModel() when $default != null:
return $default(_that.aid,_that.videos,_that.tid,_that.tname,_that.copyright,_that.pic,_that.title,_that.pubdate,_that.ctime,_that.desc,_that.state,_that.duration,_that.rights,_that.owner,_that.stat,_that.dynamicText,_that.cid,_that.progress,_that.addAt,_that.bvid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'aid')  int? aid, @JsonKey(name: 'videos')  int? videos, @JsonKey(name: 'tid')  int? tid, @JsonKey(name: 'tname')  String? tname, @JsonKey(name: 'copyright')  int? copyright, @JsonKey(name: 'pic')  String? pic, @JsonKey(name: 'title')  String? title, @JsonKey(name: 'pubdate')  int? pubdate, @JsonKey(name: 'ctime')  int? ctime, @JsonKey(name: 'desc')  String? desc, @JsonKey(name: 'state')  int? state, @JsonKey(name: 'duration')  int? duration, @JsonKey(name: 'rights')  Map<String, dynamic>? rights, @JsonKey(name: 'owner')  FavUpperModel? owner, @JsonKey(name: 'stat')  ToViewStatModel? stat, @JsonKey(name: 'dynamic')  String? dynamicText, @JsonKey(name: 'cid')  int? cid, @JsonKey(name: 'progress')  int? progress, @JsonKey(name: 'add_at')  int? addAt, @JsonKey(name: 'bvid')  String? bvid)  $default,) {final _that = this;
switch (_that) {
case _ToViewModel():
return $default(_that.aid,_that.videos,_that.tid,_that.tname,_that.copyright,_that.pic,_that.title,_that.pubdate,_that.ctime,_that.desc,_that.state,_that.duration,_that.rights,_that.owner,_that.stat,_that.dynamicText,_that.cid,_that.progress,_that.addAt,_that.bvid);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'aid')  int? aid, @JsonKey(name: 'videos')  int? videos, @JsonKey(name: 'tid')  int? tid, @JsonKey(name: 'tname')  String? tname, @JsonKey(name: 'copyright')  int? copyright, @JsonKey(name: 'pic')  String? pic, @JsonKey(name: 'title')  String? title, @JsonKey(name: 'pubdate')  int? pubdate, @JsonKey(name: 'ctime')  int? ctime, @JsonKey(name: 'desc')  String? desc, @JsonKey(name: 'state')  int? state, @JsonKey(name: 'duration')  int? duration, @JsonKey(name: 'rights')  Map<String, dynamic>? rights, @JsonKey(name: 'owner')  FavUpperModel? owner, @JsonKey(name: 'stat')  ToViewStatModel? stat, @JsonKey(name: 'dynamic')  String? dynamicText, @JsonKey(name: 'cid')  int? cid, @JsonKey(name: 'progress')  int? progress, @JsonKey(name: 'add_at')  int? addAt, @JsonKey(name: 'bvid')  String? bvid)?  $default,) {final _that = this;
switch (_that) {
case _ToViewModel() when $default != null:
return $default(_that.aid,_that.videos,_that.tid,_that.tname,_that.copyright,_that.pic,_that.title,_that.pubdate,_that.ctime,_that.desc,_that.state,_that.duration,_that.rights,_that.owner,_that.stat,_that.dynamicText,_that.cid,_that.progress,_that.addAt,_that.bvid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToViewModel extends ToViewModel {
  const _ToViewModel({@JsonKey(name: 'aid') this.aid, @JsonKey(name: 'videos') this.videos = 0, @JsonKey(name: 'tid') this.tid = 0, @JsonKey(name: 'tname') this.tname = '', @JsonKey(name: 'copyright') this.copyright = 1, @JsonKey(name: 'pic') this.pic = '', @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'pubdate') this.pubdate = 0, @JsonKey(name: 'ctime') this.ctime = 0, @JsonKey(name: 'desc') this.desc = '', @JsonKey(name: 'state') this.state = 0, @JsonKey(name: 'duration') this.duration = 0, @JsonKey(name: 'rights') final  Map<String, dynamic>? rights, @JsonKey(name: 'owner') this.owner, @JsonKey(name: 'stat') this.stat, @JsonKey(name: 'dynamic') this.dynamicText, @JsonKey(name: 'cid') this.cid = 0, @JsonKey(name: 'progress') this.progress = 0, @JsonKey(name: 'add_at') this.addAt = 0, @JsonKey(name: 'bvid') this.bvid = ''}): _rights = rights,super._();
  factory _ToViewModel.fromJson(Map<String, dynamic> json) => _$ToViewModelFromJson(json);

@override@JsonKey(name: 'aid') final  int? aid;
@override@JsonKey(name: 'videos') final  int? videos;
@override@JsonKey(name: 'tid') final  int? tid;
@override@JsonKey(name: 'tname') final  String? tname;
@override@JsonKey(name: 'copyright') final  int? copyright;
@override@JsonKey(name: 'pic') final  String? pic;
@override@JsonKey(name: 'title') final  String? title;
@override@JsonKey(name: 'pubdate') final  int? pubdate;
@override@JsonKey(name: 'ctime') final  int? ctime;
@override@JsonKey(name: 'desc') final  String? desc;
@override@JsonKey(name: 'state') final  int? state;
@override@JsonKey(name: 'duration') final  int? duration;
 final  Map<String, dynamic>? _rights;
@override@JsonKey(name: 'rights') Map<String, dynamic>? get rights {
  final value = _rights;
  if (value == null) return null;
  if (_rights is EqualUnmodifiableMapView) return _rights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'owner') final  FavUpperModel? owner;
@override@JsonKey(name: 'stat') final  ToViewStatModel? stat;
@override@JsonKey(name: 'dynamic') final  String? dynamicText;
@override@JsonKey(name: 'cid') final  int? cid;
@override@JsonKey(name: 'progress') final  int? progress;
@override@JsonKey(name: 'add_at') final  int? addAt;
@override@JsonKey(name: 'bvid') final  String? bvid;

/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToViewModelCopyWith<_ToViewModel> get copyWith => __$ToViewModelCopyWithImpl<_ToViewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToViewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToViewModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.tname, tname) || other.tname == tname)&&(identical(other.copyright, copyright) || other.copyright == copyright)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.title, title) || other.title == title)&&(identical(other.pubdate, pubdate) || other.pubdate == pubdate)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.state, state) || other.state == state)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._rights, _rights)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.dynamicText, dynamicText) || other.dynamicText == dynamicText)&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.addAt, addAt) || other.addAt == addAt)&&(identical(other.bvid, bvid) || other.bvid == bvid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,aid,videos,tid,tname,copyright,pic,title,pubdate,ctime,desc,state,duration,const DeepCollectionEquality().hash(_rights),owner,stat,dynamicText,cid,progress,addAt,bvid]);

@override
String toString() {
  return 'ToViewModel(aid: $aid, videos: $videos, tid: $tid, tname: $tname, copyright: $copyright, pic: $pic, title: $title, pubdate: $pubdate, ctime: $ctime, desc: $desc, state: $state, duration: $duration, rights: $rights, owner: $owner, stat: $stat, dynamicText: $dynamicText, cid: $cid, progress: $progress, addAt: $addAt, bvid: $bvid)';
}


}

/// @nodoc
abstract mixin class _$ToViewModelCopyWith<$Res> implements $ToViewModelCopyWith<$Res> {
  factory _$ToViewModelCopyWith(_ToViewModel value, $Res Function(_ToViewModel) _then) = __$ToViewModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'aid') int? aid,@JsonKey(name: 'videos') int? videos,@JsonKey(name: 'tid') int? tid,@JsonKey(name: 'tname') String? tname,@JsonKey(name: 'copyright') int? copyright,@JsonKey(name: 'pic') String? pic,@JsonKey(name: 'title') String? title,@JsonKey(name: 'pubdate') int? pubdate,@JsonKey(name: 'ctime') int? ctime,@JsonKey(name: 'desc') String? desc,@JsonKey(name: 'state') int? state,@JsonKey(name: 'duration') int? duration,@JsonKey(name: 'rights') Map<String, dynamic>? rights,@JsonKey(name: 'owner') FavUpperModel? owner,@JsonKey(name: 'stat') ToViewStatModel? stat,@JsonKey(name: 'dynamic') String? dynamicText,@JsonKey(name: 'cid') int? cid,@JsonKey(name: 'progress') int? progress,@JsonKey(name: 'add_at') int? addAt,@JsonKey(name: 'bvid') String? bvid
});


@override $FavUpperModelCopyWith<$Res>? get owner;@override $ToViewStatModelCopyWith<$Res>? get stat;

}
/// @nodoc
class __$ToViewModelCopyWithImpl<$Res>
    implements _$ToViewModelCopyWith<$Res> {
  __$ToViewModelCopyWithImpl(this._self, this._then);

  final _ToViewModel _self;
  final $Res Function(_ToViewModel) _then;

/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aid = freezed,Object? videos = freezed,Object? tid = freezed,Object? tname = freezed,Object? copyright = freezed,Object? pic = freezed,Object? title = freezed,Object? pubdate = freezed,Object? ctime = freezed,Object? desc = freezed,Object? state = freezed,Object? duration = freezed,Object? rights = freezed,Object? owner = freezed,Object? stat = freezed,Object? dynamicText = freezed,Object? cid = freezed,Object? progress = freezed,Object? addAt = freezed,Object? bvid = freezed,}) {
  return _then(_ToViewModel(
aid: freezed == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int?,videos: freezed == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as int?,tname: freezed == tname ? _self.tname : tname // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as int?,pic: freezed == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,pubdate: freezed == pubdate ? _self.pubdate : pubdate // ignore: cast_nullable_to_non_nullable
as int?,ctime: freezed == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,rights: freezed == rights ? _self._rights : rights // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as FavUpperModel?,stat: freezed == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as ToViewStatModel?,dynamicText: freezed == dynamicText ? _self.dynamicText : dynamicText // ignore: cast_nullable_to_non_nullable
as String?,cid: freezed == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int?,addAt: freezed == addAt ? _self.addAt : addAt // ignore: cast_nullable_to_non_nullable
as int?,bvid: freezed == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $FavUpperModelCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of ToViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToViewStatModelCopyWith<$Res>? get stat {
    if (_self.stat == null) {
    return null;
  }

  return $ToViewStatModelCopyWith<$Res>(_self.stat!, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// @nodoc
mixin _$ToViewStatModel {

@JsonKey(name: 'aid') int? get aid;@JsonKey(name: 'view') int? get view;@JsonKey(name: 'danmaku') int? get danmaku;@JsonKey(name: 'reply') int? get reply;@JsonKey(name: 'favorite') int? get favorite;@JsonKey(name: 'coin') int? get coin;@JsonKey(name: 'share') int? get share;@JsonKey(name: 'like') int? get like;@JsonKey(name: 'dislike') int? get dislike;
/// Create a copy of ToViewStatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToViewStatModelCopyWith<ToViewStatModel> get copyWith => _$ToViewStatModelCopyWithImpl<ToViewStatModel>(this as ToViewStatModel, _$identity);

  /// Serializes this ToViewStatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToViewStatModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.view, view) || other.view == view)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.share, share) || other.share == share)&&(identical(other.like, like) || other.like == like)&&(identical(other.dislike, dislike) || other.dislike == dislike));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,view,danmaku,reply,favorite,coin,share,like,dislike);

@override
String toString() {
  return 'ToViewStatModel(aid: $aid, view: $view, danmaku: $danmaku, reply: $reply, favorite: $favorite, coin: $coin, share: $share, like: $like, dislike: $dislike)';
}


}

/// @nodoc
abstract mixin class $ToViewStatModelCopyWith<$Res>  {
  factory $ToViewStatModelCopyWith(ToViewStatModel value, $Res Function(ToViewStatModel) _then) = _$ToViewStatModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'aid') int? aid,@JsonKey(name: 'view') int? view,@JsonKey(name: 'danmaku') int? danmaku,@JsonKey(name: 'reply') int? reply,@JsonKey(name: 'favorite') int? favorite,@JsonKey(name: 'coin') int? coin,@JsonKey(name: 'share') int? share,@JsonKey(name: 'like') int? like,@JsonKey(name: 'dislike') int? dislike
});




}
/// @nodoc
class _$ToViewStatModelCopyWithImpl<$Res>
    implements $ToViewStatModelCopyWith<$Res> {
  _$ToViewStatModelCopyWithImpl(this._self, this._then);

  final ToViewStatModel _self;
  final $Res Function(ToViewStatModel) _then;

/// Create a copy of ToViewStatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aid = freezed,Object? view = freezed,Object? danmaku = freezed,Object? reply = freezed,Object? favorite = freezed,Object? coin = freezed,Object? share = freezed,Object? like = freezed,Object? dislike = freezed,}) {
  return _then(_self.copyWith(
aid: freezed == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int?,danmaku: freezed == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int?,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int?,favorite: freezed == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int?,coin: freezed == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int?,share: freezed == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as int?,like: freezed == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int?,dislike: freezed == dislike ? _self.dislike : dislike // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ToViewStatModel].
extension ToViewStatModelPatterns on ToViewStatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToViewStatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToViewStatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToViewStatModel value)  $default,){
final _that = this;
switch (_that) {
case _ToViewStatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToViewStatModel value)?  $default,){
final _that = this;
switch (_that) {
case _ToViewStatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'aid')  int? aid, @JsonKey(name: 'view')  int? view, @JsonKey(name: 'danmaku')  int? danmaku, @JsonKey(name: 'reply')  int? reply, @JsonKey(name: 'favorite')  int? favorite, @JsonKey(name: 'coin')  int? coin, @JsonKey(name: 'share')  int? share, @JsonKey(name: 'like')  int? like, @JsonKey(name: 'dislike')  int? dislike)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToViewStatModel() when $default != null:
return $default(_that.aid,_that.view,_that.danmaku,_that.reply,_that.favorite,_that.coin,_that.share,_that.like,_that.dislike);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'aid')  int? aid, @JsonKey(name: 'view')  int? view, @JsonKey(name: 'danmaku')  int? danmaku, @JsonKey(name: 'reply')  int? reply, @JsonKey(name: 'favorite')  int? favorite, @JsonKey(name: 'coin')  int? coin, @JsonKey(name: 'share')  int? share, @JsonKey(name: 'like')  int? like, @JsonKey(name: 'dislike')  int? dislike)  $default,) {final _that = this;
switch (_that) {
case _ToViewStatModel():
return $default(_that.aid,_that.view,_that.danmaku,_that.reply,_that.favorite,_that.coin,_that.share,_that.like,_that.dislike);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'aid')  int? aid, @JsonKey(name: 'view')  int? view, @JsonKey(name: 'danmaku')  int? danmaku, @JsonKey(name: 'reply')  int? reply, @JsonKey(name: 'favorite')  int? favorite, @JsonKey(name: 'coin')  int? coin, @JsonKey(name: 'share')  int? share, @JsonKey(name: 'like')  int? like, @JsonKey(name: 'dislike')  int? dislike)?  $default,) {final _that = this;
switch (_that) {
case _ToViewStatModel() when $default != null:
return $default(_that.aid,_that.view,_that.danmaku,_that.reply,_that.favorite,_that.coin,_that.share,_that.like,_that.dislike);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToViewStatModel implements ToViewStatModel {
  const _ToViewStatModel({@JsonKey(name: 'aid') this.aid, @JsonKey(name: 'view') this.view = 0, @JsonKey(name: 'danmaku') this.danmaku = 0, @JsonKey(name: 'reply') this.reply = 0, @JsonKey(name: 'favorite') this.favorite = 0, @JsonKey(name: 'coin') this.coin = 0, @JsonKey(name: 'share') this.share = 0, @JsonKey(name: 'like') this.like = 0, @JsonKey(name: 'dislike') this.dislike = 0});
  factory _ToViewStatModel.fromJson(Map<String, dynamic> json) => _$ToViewStatModelFromJson(json);

@override@JsonKey(name: 'aid') final  int? aid;
@override@JsonKey(name: 'view') final  int? view;
@override@JsonKey(name: 'danmaku') final  int? danmaku;
@override@JsonKey(name: 'reply') final  int? reply;
@override@JsonKey(name: 'favorite') final  int? favorite;
@override@JsonKey(name: 'coin') final  int? coin;
@override@JsonKey(name: 'share') final  int? share;
@override@JsonKey(name: 'like') final  int? like;
@override@JsonKey(name: 'dislike') final  int? dislike;

/// Create a copy of ToViewStatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToViewStatModelCopyWith<_ToViewStatModel> get copyWith => __$ToViewStatModelCopyWithImpl<_ToViewStatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToViewStatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToViewStatModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.view, view) || other.view == view)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.share, share) || other.share == share)&&(identical(other.like, like) || other.like == like)&&(identical(other.dislike, dislike) || other.dislike == dislike));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,view,danmaku,reply,favorite,coin,share,like,dislike);

@override
String toString() {
  return 'ToViewStatModel(aid: $aid, view: $view, danmaku: $danmaku, reply: $reply, favorite: $favorite, coin: $coin, share: $share, like: $like, dislike: $dislike)';
}


}

/// @nodoc
abstract mixin class _$ToViewStatModelCopyWith<$Res> implements $ToViewStatModelCopyWith<$Res> {
  factory _$ToViewStatModelCopyWith(_ToViewStatModel value, $Res Function(_ToViewStatModel) _then) = __$ToViewStatModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'aid') int? aid,@JsonKey(name: 'view') int? view,@JsonKey(name: 'danmaku') int? danmaku,@JsonKey(name: 'reply') int? reply,@JsonKey(name: 'favorite') int? favorite,@JsonKey(name: 'coin') int? coin,@JsonKey(name: 'share') int? share,@JsonKey(name: 'like') int? like,@JsonKey(name: 'dislike') int? dislike
});




}
/// @nodoc
class __$ToViewStatModelCopyWithImpl<$Res>
    implements _$ToViewStatModelCopyWith<$Res> {
  __$ToViewStatModelCopyWithImpl(this._self, this._then);

  final _ToViewStatModel _self;
  final $Res Function(_ToViewStatModel) _then;

/// Create a copy of ToViewStatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aid = freezed,Object? view = freezed,Object? danmaku = freezed,Object? reply = freezed,Object? favorite = freezed,Object? coin = freezed,Object? share = freezed,Object? like = freezed,Object? dislike = freezed,}) {
  return _then(_ToViewStatModel(
aid: freezed == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as int?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int?,danmaku: freezed == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int?,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int?,favorite: freezed == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int?,coin: freezed == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int?,share: freezed == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as int?,like: freezed == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int?,dislike: freezed == dislike ? _self.dislike : dislike // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ToViewListResponse {

@JsonKey(name: 'count') int get count;@JsonKey(name: 'list') List<ToViewModel> get list;
/// Create a copy of ToViewListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToViewListResponseCopyWith<ToViewListResponse> get copyWith => _$ToViewListResponseCopyWithImpl<ToViewListResponse>(this as ToViewListResponse, _$identity);

  /// Serializes this ToViewListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToViewListResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'ToViewListResponse(count: $count, list: $list)';
}


}

/// @nodoc
abstract mixin class $ToViewListResponseCopyWith<$Res>  {
  factory $ToViewListResponseCopyWith(ToViewListResponse value, $Res Function(ToViewListResponse) _then) = _$ToViewListResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'count') int count,@JsonKey(name: 'list') List<ToViewModel> list
});




}
/// @nodoc
class _$ToViewListResponseCopyWithImpl<$Res>
    implements $ToViewListResponseCopyWith<$Res> {
  _$ToViewListResponseCopyWithImpl(this._self, this._then);

  final ToViewListResponse _self;
  final $Res Function(ToViewListResponse) _then;

/// Create a copy of ToViewListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? list = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<ToViewModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ToViewListResponse].
extension ToViewListResponsePatterns on ToViewListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToViewListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToViewListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToViewListResponse value)  $default,){
final _that = this;
switch (_that) {
case _ToViewListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToViewListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ToViewListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'count')  int count, @JsonKey(name: 'list')  List<ToViewModel> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToViewListResponse() when $default != null:
return $default(_that.count,_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'count')  int count, @JsonKey(name: 'list')  List<ToViewModel> list)  $default,) {final _that = this;
switch (_that) {
case _ToViewListResponse():
return $default(_that.count,_that.list);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'count')  int count, @JsonKey(name: 'list')  List<ToViewModel> list)?  $default,) {final _that = this;
switch (_that) {
case _ToViewListResponse() when $default != null:
return $default(_that.count,_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToViewListResponse implements ToViewListResponse {
  const _ToViewListResponse({@JsonKey(name: 'count') this.count = 0, @JsonKey(name: 'list') final  List<ToViewModel> list = const []}): _list = list;
  factory _ToViewListResponse.fromJson(Map<String, dynamic> json) => _$ToViewListResponseFromJson(json);

@override@JsonKey(name: 'count') final  int count;
 final  List<ToViewModel> _list;
@override@JsonKey(name: 'list') List<ToViewModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of ToViewListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToViewListResponseCopyWith<_ToViewListResponse> get copyWith => __$ToViewListResponseCopyWithImpl<_ToViewListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToViewListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToViewListResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'ToViewListResponse(count: $count, list: $list)';
}


}

/// @nodoc
abstract mixin class _$ToViewListResponseCopyWith<$Res> implements $ToViewListResponseCopyWith<$Res> {
  factory _$ToViewListResponseCopyWith(_ToViewListResponse value, $Res Function(_ToViewListResponse) _then) = __$ToViewListResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'count') int count,@JsonKey(name: 'list') List<ToViewModel> list
});




}
/// @nodoc
class __$ToViewListResponseCopyWithImpl<$Res>
    implements _$ToViewListResponseCopyWith<$Res> {
  __$ToViewListResponseCopyWithImpl(this._self, this._then);

  final _ToViewListResponse _self;
  final $Res Function(_ToViewListResponse) _then;

/// Create a copy of ToViewListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? list = null,}) {
  return _then(_ToViewListResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ToViewModel>,
  ));
}


}

// dart format on
