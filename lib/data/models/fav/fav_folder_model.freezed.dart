// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav_folder_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavFolderModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'fid') int get fid;@JsonKey(name: 'mid') int get mid;@JsonKey(name: 'attr') int get attr;@JsonKey(name: 'title') String get title;@JsonKey(name: 'fav_state') int get favState;@JsonKey(name: 'media_count') int get mediaCount;@JsonKey(name: 'cover') String? get cover;@JsonKey(name: 'upper') FavUpperModel? get upper;@JsonKey(name: 'intro') String? get intro;@JsonKey(name: 'ctime') int? get ctime;@JsonKey(name: 'mtime') int? get mtime;@JsonKey(name: 'state') int? get state;
/// Create a copy of FavFolderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavFolderModelCopyWith<FavFolderModel> get copyWith => _$FavFolderModelCopyWithImpl<FavFolderModel>(this as FavFolderModel, _$identity);

  /// Serializes this FavFolderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavFolderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fid, fid) || other.fid == fid)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.title, title) || other.title == title)&&(identical(other.favState, favState) || other.favState == favState)&&(identical(other.mediaCount, mediaCount) || other.mediaCount == mediaCount)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fid,mid,attr,title,favState,mediaCount,cover,upper,intro,ctime,mtime,state);

@override
String toString() {
  return 'FavFolderModel(id: $id, fid: $fid, mid: $mid, attr: $attr, title: $title, favState: $favState, mediaCount: $mediaCount, cover: $cover, upper: $upper, intro: $intro, ctime: $ctime, mtime: $mtime, state: $state)';
}


}

/// @nodoc
abstract mixin class $FavFolderModelCopyWith<$Res>  {
  factory $FavFolderModelCopyWith(FavFolderModel value, $Res Function(FavFolderModel) _then) = _$FavFolderModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'fid') int fid,@JsonKey(name: 'mid') int mid,@JsonKey(name: 'attr') int attr,@JsonKey(name: 'title') String title,@JsonKey(name: 'fav_state') int favState,@JsonKey(name: 'media_count') int mediaCount,@JsonKey(name: 'cover') String? cover,@JsonKey(name: 'upper') FavUpperModel? upper,@JsonKey(name: 'intro') String? intro,@JsonKey(name: 'ctime') int? ctime,@JsonKey(name: 'mtime') int? mtime,@JsonKey(name: 'state') int? state
});


$FavUpperModelCopyWith<$Res>? get upper;

}
/// @nodoc
class _$FavFolderModelCopyWithImpl<$Res>
    implements $FavFolderModelCopyWith<$Res> {
  _$FavFolderModelCopyWithImpl(this._self, this._then);

  final FavFolderModel _self;
  final $Res Function(FavFolderModel) _then;

/// Create a copy of FavFolderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fid = null,Object? mid = null,Object? attr = null,Object? title = null,Object? favState = null,Object? mediaCount = null,Object? cover = freezed,Object? upper = freezed,Object? intro = freezed,Object? ctime = freezed,Object? mtime = freezed,Object? state = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fid: null == fid ? _self.fid : fid // ignore: cast_nullable_to_non_nullable
as int,mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,favState: null == favState ? _self.favState : favState // ignore: cast_nullable_to_non_nullable
as int,mediaCount: null == mediaCount ? _self.mediaCount : mediaCount // ignore: cast_nullable_to_non_nullable
as int,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,upper: freezed == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as FavUpperModel?,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,ctime: freezed == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int?,mtime: freezed == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of FavFolderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res>? get upper {
    if (_self.upper == null) {
    return null;
  }

  return $FavUpperModelCopyWith<$Res>(_self.upper!, (value) {
    return _then(_self.copyWith(upper: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavFolderModel].
extension FavFolderModelPatterns on FavFolderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavFolderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavFolderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavFolderModel value)  $default,){
final _that = this;
switch (_that) {
case _FavFolderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavFolderModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavFolderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'fid')  int fid, @JsonKey(name: 'mid')  int mid, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'title')  String title, @JsonKey(name: 'fav_state')  int favState, @JsonKey(name: 'media_count')  int mediaCount, @JsonKey(name: 'cover')  String? cover, @JsonKey(name: 'upper')  FavUpperModel? upper, @JsonKey(name: 'intro')  String? intro, @JsonKey(name: 'ctime')  int? ctime, @JsonKey(name: 'mtime')  int? mtime, @JsonKey(name: 'state')  int? state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavFolderModel() when $default != null:
return $default(_that.id,_that.fid,_that.mid,_that.attr,_that.title,_that.favState,_that.mediaCount,_that.cover,_that.upper,_that.intro,_that.ctime,_that.mtime,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'fid')  int fid, @JsonKey(name: 'mid')  int mid, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'title')  String title, @JsonKey(name: 'fav_state')  int favState, @JsonKey(name: 'media_count')  int mediaCount, @JsonKey(name: 'cover')  String? cover, @JsonKey(name: 'upper')  FavUpperModel? upper, @JsonKey(name: 'intro')  String? intro, @JsonKey(name: 'ctime')  int? ctime, @JsonKey(name: 'mtime')  int? mtime, @JsonKey(name: 'state')  int? state)  $default,) {final _that = this;
switch (_that) {
case _FavFolderModel():
return $default(_that.id,_that.fid,_that.mid,_that.attr,_that.title,_that.favState,_that.mediaCount,_that.cover,_that.upper,_that.intro,_that.ctime,_that.mtime,_that.state);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'fid')  int fid, @JsonKey(name: 'mid')  int mid, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'title')  String title, @JsonKey(name: 'fav_state')  int favState, @JsonKey(name: 'media_count')  int mediaCount, @JsonKey(name: 'cover')  String? cover, @JsonKey(name: 'upper')  FavUpperModel? upper, @JsonKey(name: 'intro')  String? intro, @JsonKey(name: 'ctime')  int? ctime, @JsonKey(name: 'mtime')  int? mtime, @JsonKey(name: 'state')  int? state)?  $default,) {final _that = this;
switch (_that) {
case _FavFolderModel() when $default != null:
return $default(_that.id,_that.fid,_that.mid,_that.attr,_that.title,_that.favState,_that.mediaCount,_that.cover,_that.upper,_that.intro,_that.ctime,_that.mtime,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavFolderModel implements FavFolderModel {
  const _FavFolderModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'fid') required this.fid, @JsonKey(name: 'mid') required this.mid, @JsonKey(name: 'attr') required this.attr, @JsonKey(name: 'title') required this.title, @JsonKey(name: 'fav_state') required this.favState, @JsonKey(name: 'media_count') required this.mediaCount, @JsonKey(name: 'cover') this.cover, @JsonKey(name: 'upper') this.upper, @JsonKey(name: 'intro') this.intro, @JsonKey(name: 'ctime') this.ctime, @JsonKey(name: 'mtime') this.mtime, @JsonKey(name: 'state') this.state});
  factory _FavFolderModel.fromJson(Map<String, dynamic> json) => _$FavFolderModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'fid') final  int fid;
@override@JsonKey(name: 'mid') final  int mid;
@override@JsonKey(name: 'attr') final  int attr;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'fav_state') final  int favState;
@override@JsonKey(name: 'media_count') final  int mediaCount;
@override@JsonKey(name: 'cover') final  String? cover;
@override@JsonKey(name: 'upper') final  FavUpperModel? upper;
@override@JsonKey(name: 'intro') final  String? intro;
@override@JsonKey(name: 'ctime') final  int? ctime;
@override@JsonKey(name: 'mtime') final  int? mtime;
@override@JsonKey(name: 'state') final  int? state;

/// Create a copy of FavFolderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavFolderModelCopyWith<_FavFolderModel> get copyWith => __$FavFolderModelCopyWithImpl<_FavFolderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavFolderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavFolderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fid, fid) || other.fid == fid)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.title, title) || other.title == title)&&(identical(other.favState, favState) || other.favState == favState)&&(identical(other.mediaCount, mediaCount) || other.mediaCount == mediaCount)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fid,mid,attr,title,favState,mediaCount,cover,upper,intro,ctime,mtime,state);

@override
String toString() {
  return 'FavFolderModel(id: $id, fid: $fid, mid: $mid, attr: $attr, title: $title, favState: $favState, mediaCount: $mediaCount, cover: $cover, upper: $upper, intro: $intro, ctime: $ctime, mtime: $mtime, state: $state)';
}


}

/// @nodoc
abstract mixin class _$FavFolderModelCopyWith<$Res> implements $FavFolderModelCopyWith<$Res> {
  factory _$FavFolderModelCopyWith(_FavFolderModel value, $Res Function(_FavFolderModel) _then) = __$FavFolderModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'fid') int fid,@JsonKey(name: 'mid') int mid,@JsonKey(name: 'attr') int attr,@JsonKey(name: 'title') String title,@JsonKey(name: 'fav_state') int favState,@JsonKey(name: 'media_count') int mediaCount,@JsonKey(name: 'cover') String? cover,@JsonKey(name: 'upper') FavUpperModel? upper,@JsonKey(name: 'intro') String? intro,@JsonKey(name: 'ctime') int? ctime,@JsonKey(name: 'mtime') int? mtime,@JsonKey(name: 'state') int? state
});


@override $FavUpperModelCopyWith<$Res>? get upper;

}
/// @nodoc
class __$FavFolderModelCopyWithImpl<$Res>
    implements _$FavFolderModelCopyWith<$Res> {
  __$FavFolderModelCopyWithImpl(this._self, this._then);

  final _FavFolderModel _self;
  final $Res Function(_FavFolderModel) _then;

/// Create a copy of FavFolderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fid = null,Object? mid = null,Object? attr = null,Object? title = null,Object? favState = null,Object? mediaCount = null,Object? cover = freezed,Object? upper = freezed,Object? intro = freezed,Object? ctime = freezed,Object? mtime = freezed,Object? state = freezed,}) {
  return _then(_FavFolderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fid: null == fid ? _self.fid : fid // ignore: cast_nullable_to_non_nullable
as int,mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,favState: null == favState ? _self.favState : favState // ignore: cast_nullable_to_non_nullable
as int,mediaCount: null == mediaCount ? _self.mediaCount : mediaCount // ignore: cast_nullable_to_non_nullable
as int,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,upper: freezed == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as FavUpperModel?,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,ctime: freezed == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int?,mtime: freezed == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of FavFolderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res>? get upper {
    if (_self.upper == null) {
    return null;
  }

  return $FavUpperModelCopyWith<$Res>(_self.upper!, (value) {
    return _then(_self.copyWith(upper: value));
  });
}
}


/// @nodoc
mixin _$FavFolderListResponse {

@JsonKey(name: 'count') int get count;@JsonKey(name: 'list') List<FavFolderModel>? get list;
/// Create a copy of FavFolderListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavFolderListResponseCopyWith<FavFolderListResponse> get copyWith => _$FavFolderListResponseCopyWithImpl<FavFolderListResponse>(this as FavFolderListResponse, _$identity);

  /// Serializes this FavFolderListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavFolderListResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'FavFolderListResponse(count: $count, list: $list)';
}


}

/// @nodoc
abstract mixin class $FavFolderListResponseCopyWith<$Res>  {
  factory $FavFolderListResponseCopyWith(FavFolderListResponse value, $Res Function(FavFolderListResponse) _then) = _$FavFolderListResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'count') int count,@JsonKey(name: 'list') List<FavFolderModel>? list
});




}
/// @nodoc
class _$FavFolderListResponseCopyWithImpl<$Res>
    implements $FavFolderListResponseCopyWith<$Res> {
  _$FavFolderListResponseCopyWithImpl(this._self, this._then);

  final FavFolderListResponse _self;
  final $Res Function(FavFolderListResponse) _then;

/// Create a copy of FavFolderListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? list = freezed,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,list: freezed == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<FavFolderModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavFolderListResponse].
extension FavFolderListResponsePatterns on FavFolderListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavFolderListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavFolderListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavFolderListResponse value)  $default,){
final _that = this;
switch (_that) {
case _FavFolderListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavFolderListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FavFolderListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'count')  int count, @JsonKey(name: 'list')  List<FavFolderModel>? list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavFolderListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'count')  int count, @JsonKey(name: 'list')  List<FavFolderModel>? list)  $default,) {final _that = this;
switch (_that) {
case _FavFolderListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'count')  int count, @JsonKey(name: 'list')  List<FavFolderModel>? list)?  $default,) {final _that = this;
switch (_that) {
case _FavFolderListResponse() when $default != null:
return $default(_that.count,_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavFolderListResponse implements FavFolderListResponse {
  const _FavFolderListResponse({@JsonKey(name: 'count') required this.count, @JsonKey(name: 'list') final  List<FavFolderModel>? list}): _list = list;
  factory _FavFolderListResponse.fromJson(Map<String, dynamic> json) => _$FavFolderListResponseFromJson(json);

@override@JsonKey(name: 'count') final  int count;
 final  List<FavFolderModel>? _list;
@override@JsonKey(name: 'list') List<FavFolderModel>? get list {
  final value = _list;
  if (value == null) return null;
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FavFolderListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavFolderListResponseCopyWith<_FavFolderListResponse> get copyWith => __$FavFolderListResponseCopyWithImpl<_FavFolderListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavFolderListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavFolderListResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'FavFolderListResponse(count: $count, list: $list)';
}


}

/// @nodoc
abstract mixin class _$FavFolderListResponseCopyWith<$Res> implements $FavFolderListResponseCopyWith<$Res> {
  factory _$FavFolderListResponseCopyWith(_FavFolderListResponse value, $Res Function(_FavFolderListResponse) _then) = __$FavFolderListResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'count') int count,@JsonKey(name: 'list') List<FavFolderModel>? list
});




}
/// @nodoc
class __$FavFolderListResponseCopyWithImpl<$Res>
    implements _$FavFolderListResponseCopyWith<$Res> {
  __$FavFolderListResponseCopyWithImpl(this._self, this._then);

  final _FavFolderListResponse _self;
  final $Res Function(_FavFolderListResponse) _then;

/// Create a copy of FavFolderListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? list = freezed,}) {
  return _then(_FavFolderListResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,list: freezed == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<FavFolderModel>?,
  ));
}


}

// dart format on
