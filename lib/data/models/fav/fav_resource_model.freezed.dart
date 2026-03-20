// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav_resource_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavResourceModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'type') int get type;@JsonKey(name: 'title') String get title;@JsonKey(name: 'cover') String get cover;@JsonKey(name: 'intro') String get intro;@JsonKey(name: 'page') int get page;@JsonKey(name: 'duration') int get duration;@JsonKey(name: 'upper') FavUpperModel get upper;@JsonKey(name: 'attr') int get attr;@JsonKey(name: 'cnt_info') FavCntInfoModel get cntInfo;@JsonKey(name: 'link') String get link;@JsonKey(name: 'ctime') int get ctime;@JsonKey(name: 'pubtime') int get pubtime;@JsonKey(name: 'fav_time') int get favTime;@JsonKey(name: 'bv_id') String? get bvId;@JsonKey(name: 'bvid') String? get bvid;
/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavResourceModelCopyWith<FavResourceModel> get copyWith => _$FavResourceModelCopyWithImpl<FavResourceModel>(this as FavResourceModel, _$identity);

  /// Serializes this FavResourceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavResourceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.page, page) || other.page == page)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.cntInfo, cntInfo) || other.cntInfo == cntInfo)&&(identical(other.link, link) || other.link == link)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.pubtime, pubtime) || other.pubtime == pubtime)&&(identical(other.favTime, favTime) || other.favTime == favTime)&&(identical(other.bvId, bvId) || other.bvId == bvId)&&(identical(other.bvid, bvid) || other.bvid == bvid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,cover,intro,page,duration,upper,attr,cntInfo,link,ctime,pubtime,favTime,bvId,bvid);

@override
String toString() {
  return 'FavResourceModel(id: $id, type: $type, title: $title, cover: $cover, intro: $intro, page: $page, duration: $duration, upper: $upper, attr: $attr, cntInfo: $cntInfo, link: $link, ctime: $ctime, pubtime: $pubtime, favTime: $favTime, bvId: $bvId, bvid: $bvid)';
}


}

/// @nodoc
abstract mixin class $FavResourceModelCopyWith<$Res>  {
  factory $FavResourceModelCopyWith(FavResourceModel value, $Res Function(FavResourceModel) _then) = _$FavResourceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'type') int type,@JsonKey(name: 'title') String title,@JsonKey(name: 'cover') String cover,@JsonKey(name: 'intro') String intro,@JsonKey(name: 'page') int page,@JsonKey(name: 'duration') int duration,@JsonKey(name: 'upper') FavUpperModel upper,@JsonKey(name: 'attr') int attr,@JsonKey(name: 'cnt_info') FavCntInfoModel cntInfo,@JsonKey(name: 'link') String link,@JsonKey(name: 'ctime') int ctime,@JsonKey(name: 'pubtime') int pubtime,@JsonKey(name: 'fav_time') int favTime,@JsonKey(name: 'bv_id') String? bvId,@JsonKey(name: 'bvid') String? bvid
});


$FavUpperModelCopyWith<$Res> get upper;$FavCntInfoModelCopyWith<$Res> get cntInfo;

}
/// @nodoc
class _$FavResourceModelCopyWithImpl<$Res>
    implements $FavResourceModelCopyWith<$Res> {
  _$FavResourceModelCopyWithImpl(this._self, this._then);

  final FavResourceModel _self;
  final $Res Function(FavResourceModel) _then;

/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? cover = null,Object? intro = null,Object? page = null,Object? duration = null,Object? upper = null,Object? attr = null,Object? cntInfo = null,Object? link = null,Object? ctime = null,Object? pubtime = null,Object? favTime = null,Object? bvId = freezed,Object? bvid = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as FavUpperModel,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,cntInfo: null == cntInfo ? _self.cntInfo : cntInfo // ignore: cast_nullable_to_non_nullable
as FavCntInfoModel,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,pubtime: null == pubtime ? _self.pubtime : pubtime // ignore: cast_nullable_to_non_nullable
as int,favTime: null == favTime ? _self.favTime : favTime // ignore: cast_nullable_to_non_nullable
as int,bvId: freezed == bvId ? _self.bvId : bvId // ignore: cast_nullable_to_non_nullable
as String?,bvid: freezed == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res> get upper {
  
  return $FavUpperModelCopyWith<$Res>(_self.upper, (value) {
    return _then(_self.copyWith(upper: value));
  });
}/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavCntInfoModelCopyWith<$Res> get cntInfo {
  
  return $FavCntInfoModelCopyWith<$Res>(_self.cntInfo, (value) {
    return _then(_self.copyWith(cntInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavResourceModel].
extension FavResourceModelPatterns on FavResourceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavResourceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavResourceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavResourceModel value)  $default,){
final _that = this;
switch (_that) {
case _FavResourceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavResourceModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavResourceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'type')  int type, @JsonKey(name: 'title')  String title, @JsonKey(name: 'cover')  String cover, @JsonKey(name: 'intro')  String intro, @JsonKey(name: 'page')  int page, @JsonKey(name: 'duration')  int duration, @JsonKey(name: 'upper')  FavUpperModel upper, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'cnt_info')  FavCntInfoModel cntInfo, @JsonKey(name: 'link')  String link, @JsonKey(name: 'ctime')  int ctime, @JsonKey(name: 'pubtime')  int pubtime, @JsonKey(name: 'fav_time')  int favTime, @JsonKey(name: 'bv_id')  String? bvId, @JsonKey(name: 'bvid')  String? bvid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavResourceModel() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.cover,_that.intro,_that.page,_that.duration,_that.upper,_that.attr,_that.cntInfo,_that.link,_that.ctime,_that.pubtime,_that.favTime,_that.bvId,_that.bvid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'type')  int type, @JsonKey(name: 'title')  String title, @JsonKey(name: 'cover')  String cover, @JsonKey(name: 'intro')  String intro, @JsonKey(name: 'page')  int page, @JsonKey(name: 'duration')  int duration, @JsonKey(name: 'upper')  FavUpperModel upper, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'cnt_info')  FavCntInfoModel cntInfo, @JsonKey(name: 'link')  String link, @JsonKey(name: 'ctime')  int ctime, @JsonKey(name: 'pubtime')  int pubtime, @JsonKey(name: 'fav_time')  int favTime, @JsonKey(name: 'bv_id')  String? bvId, @JsonKey(name: 'bvid')  String? bvid)  $default,) {final _that = this;
switch (_that) {
case _FavResourceModel():
return $default(_that.id,_that.type,_that.title,_that.cover,_that.intro,_that.page,_that.duration,_that.upper,_that.attr,_that.cntInfo,_that.link,_that.ctime,_that.pubtime,_that.favTime,_that.bvId,_that.bvid);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'type')  int type, @JsonKey(name: 'title')  String title, @JsonKey(name: 'cover')  String cover, @JsonKey(name: 'intro')  String intro, @JsonKey(name: 'page')  int page, @JsonKey(name: 'duration')  int duration, @JsonKey(name: 'upper')  FavUpperModel upper, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'cnt_info')  FavCntInfoModel cntInfo, @JsonKey(name: 'link')  String link, @JsonKey(name: 'ctime')  int ctime, @JsonKey(name: 'pubtime')  int pubtime, @JsonKey(name: 'fav_time')  int favTime, @JsonKey(name: 'bv_id')  String? bvId, @JsonKey(name: 'bvid')  String? bvid)?  $default,) {final _that = this;
switch (_that) {
case _FavResourceModel() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.cover,_that.intro,_that.page,_that.duration,_that.upper,_that.attr,_that.cntInfo,_that.link,_that.ctime,_that.pubtime,_that.favTime,_that.bvId,_that.bvid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavResourceModel implements FavResourceModel {
  const _FavResourceModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'type') required this.type, @JsonKey(name: 'title') required this.title, @JsonKey(name: 'cover') required this.cover, @JsonKey(name: 'intro') required this.intro, @JsonKey(name: 'page') required this.page, @JsonKey(name: 'duration') required this.duration, @JsonKey(name: 'upper') required this.upper, @JsonKey(name: 'attr') required this.attr, @JsonKey(name: 'cnt_info') required this.cntInfo, @JsonKey(name: 'link') required this.link, @JsonKey(name: 'ctime') required this.ctime, @JsonKey(name: 'pubtime') required this.pubtime, @JsonKey(name: 'fav_time') required this.favTime, @JsonKey(name: 'bv_id') this.bvId, @JsonKey(name: 'bvid') this.bvid});
  factory _FavResourceModel.fromJson(Map<String, dynamic> json) => _$FavResourceModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'type') final  int type;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'cover') final  String cover;
@override@JsonKey(name: 'intro') final  String intro;
@override@JsonKey(name: 'page') final  int page;
@override@JsonKey(name: 'duration') final  int duration;
@override@JsonKey(name: 'upper') final  FavUpperModel upper;
@override@JsonKey(name: 'attr') final  int attr;
@override@JsonKey(name: 'cnt_info') final  FavCntInfoModel cntInfo;
@override@JsonKey(name: 'link') final  String link;
@override@JsonKey(name: 'ctime') final  int ctime;
@override@JsonKey(name: 'pubtime') final  int pubtime;
@override@JsonKey(name: 'fav_time') final  int favTime;
@override@JsonKey(name: 'bv_id') final  String? bvId;
@override@JsonKey(name: 'bvid') final  String? bvid;

/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavResourceModelCopyWith<_FavResourceModel> get copyWith => __$FavResourceModelCopyWithImpl<_FavResourceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavResourceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavResourceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.page, page) || other.page == page)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.cntInfo, cntInfo) || other.cntInfo == cntInfo)&&(identical(other.link, link) || other.link == link)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.pubtime, pubtime) || other.pubtime == pubtime)&&(identical(other.favTime, favTime) || other.favTime == favTime)&&(identical(other.bvId, bvId) || other.bvId == bvId)&&(identical(other.bvid, bvid) || other.bvid == bvid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,cover,intro,page,duration,upper,attr,cntInfo,link,ctime,pubtime,favTime,bvId,bvid);

@override
String toString() {
  return 'FavResourceModel(id: $id, type: $type, title: $title, cover: $cover, intro: $intro, page: $page, duration: $duration, upper: $upper, attr: $attr, cntInfo: $cntInfo, link: $link, ctime: $ctime, pubtime: $pubtime, favTime: $favTime, bvId: $bvId, bvid: $bvid)';
}


}

/// @nodoc
abstract mixin class _$FavResourceModelCopyWith<$Res> implements $FavResourceModelCopyWith<$Res> {
  factory _$FavResourceModelCopyWith(_FavResourceModel value, $Res Function(_FavResourceModel) _then) = __$FavResourceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'type') int type,@JsonKey(name: 'title') String title,@JsonKey(name: 'cover') String cover,@JsonKey(name: 'intro') String intro,@JsonKey(name: 'page') int page,@JsonKey(name: 'duration') int duration,@JsonKey(name: 'upper') FavUpperModel upper,@JsonKey(name: 'attr') int attr,@JsonKey(name: 'cnt_info') FavCntInfoModel cntInfo,@JsonKey(name: 'link') String link,@JsonKey(name: 'ctime') int ctime,@JsonKey(name: 'pubtime') int pubtime,@JsonKey(name: 'fav_time') int favTime,@JsonKey(name: 'bv_id') String? bvId,@JsonKey(name: 'bvid') String? bvid
});


@override $FavUpperModelCopyWith<$Res> get upper;@override $FavCntInfoModelCopyWith<$Res> get cntInfo;

}
/// @nodoc
class __$FavResourceModelCopyWithImpl<$Res>
    implements _$FavResourceModelCopyWith<$Res> {
  __$FavResourceModelCopyWithImpl(this._self, this._then);

  final _FavResourceModel _self;
  final $Res Function(_FavResourceModel) _then;

/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? cover = null,Object? intro = null,Object? page = null,Object? duration = null,Object? upper = null,Object? attr = null,Object? cntInfo = null,Object? link = null,Object? ctime = null,Object? pubtime = null,Object? favTime = null,Object? bvId = freezed,Object? bvid = freezed,}) {
  return _then(_FavResourceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as FavUpperModel,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,cntInfo: null == cntInfo ? _self.cntInfo : cntInfo // ignore: cast_nullable_to_non_nullable
as FavCntInfoModel,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,pubtime: null == pubtime ? _self.pubtime : pubtime // ignore: cast_nullable_to_non_nullable
as int,favTime: null == favTime ? _self.favTime : favTime // ignore: cast_nullable_to_non_nullable
as int,bvId: freezed == bvId ? _self.bvId : bvId // ignore: cast_nullable_to_non_nullable
as String?,bvid: freezed == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res> get upper {
  
  return $FavUpperModelCopyWith<$Res>(_self.upper, (value) {
    return _then(_self.copyWith(upper: value));
  });
}/// Create a copy of FavResourceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavCntInfoModelCopyWith<$Res> get cntInfo {
  
  return $FavCntInfoModelCopyWith<$Res>(_self.cntInfo, (value) {
    return _then(_self.copyWith(cntInfo: value));
  });
}
}


/// @nodoc
mixin _$FavUpperModel {

@JsonKey(name: 'mid') int get mid;@JsonKey(name: 'name') String get name;@JsonKey(name: 'face') String get face;
/// Create a copy of FavUpperModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<FavUpperModel> get copyWith => _$FavUpperModelCopyWithImpl<FavUpperModel>(this as FavUpperModel, _$identity);

  /// Serializes this FavUpperModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavUpperModel&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,face);

@override
String toString() {
  return 'FavUpperModel(mid: $mid, name: $name, face: $face)';
}


}

/// @nodoc
abstract mixin class $FavUpperModelCopyWith<$Res>  {
  factory $FavUpperModelCopyWith(FavUpperModel value, $Res Function(FavUpperModel) _then) = _$FavUpperModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'mid') int mid,@JsonKey(name: 'name') String name,@JsonKey(name: 'face') String face
});




}
/// @nodoc
class _$FavUpperModelCopyWithImpl<$Res>
    implements $FavUpperModelCopyWith<$Res> {
  _$FavUpperModelCopyWithImpl(this._self, this._then);

  final FavUpperModel _self;
  final $Res Function(FavUpperModel) _then;

/// Create a copy of FavUpperModel
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


/// Adds pattern-matching-related methods to [FavUpperModel].
extension FavUpperModelPatterns on FavUpperModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavUpperModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavUpperModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavUpperModel value)  $default,){
final _that = this;
switch (_that) {
case _FavUpperModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavUpperModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavUpperModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'mid')  int mid, @JsonKey(name: 'name')  String name, @JsonKey(name: 'face')  String face)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavUpperModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'mid')  int mid, @JsonKey(name: 'name')  String name, @JsonKey(name: 'face')  String face)  $default,) {final _that = this;
switch (_that) {
case _FavUpperModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'mid')  int mid, @JsonKey(name: 'name')  String name, @JsonKey(name: 'face')  String face)?  $default,) {final _that = this;
switch (_that) {
case _FavUpperModel() when $default != null:
return $default(_that.mid,_that.name,_that.face);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavUpperModel implements FavUpperModel {
  const _FavUpperModel({@JsonKey(name: 'mid') required this.mid, @JsonKey(name: 'name') required this.name, @JsonKey(name: 'face') required this.face});
  factory _FavUpperModel.fromJson(Map<String, dynamic> json) => _$FavUpperModelFromJson(json);

@override@JsonKey(name: 'mid') final  int mid;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'face') final  String face;

/// Create a copy of FavUpperModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavUpperModelCopyWith<_FavUpperModel> get copyWith => __$FavUpperModelCopyWithImpl<_FavUpperModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavUpperModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavUpperModel&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,face);

@override
String toString() {
  return 'FavUpperModel(mid: $mid, name: $name, face: $face)';
}


}

/// @nodoc
abstract mixin class _$FavUpperModelCopyWith<$Res> implements $FavUpperModelCopyWith<$Res> {
  factory _$FavUpperModelCopyWith(_FavUpperModel value, $Res Function(_FavUpperModel) _then) = __$FavUpperModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'mid') int mid,@JsonKey(name: 'name') String name,@JsonKey(name: 'face') String face
});




}
/// @nodoc
class __$FavUpperModelCopyWithImpl<$Res>
    implements _$FavUpperModelCopyWith<$Res> {
  __$FavUpperModelCopyWithImpl(this._self, this._then);

  final _FavUpperModel _self;
  final $Res Function(_FavUpperModel) _then;

/// Create a copy of FavUpperModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? name = null,Object? face = null,}) {
  return _then(_FavUpperModel(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FavCntInfoModel {

@JsonKey(name: 'collect') int get collect;@JsonKey(name: 'play') int get play;@JsonKey(name: 'danmaku') int get danmaku;
/// Create a copy of FavCntInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavCntInfoModelCopyWith<FavCntInfoModel> get copyWith => _$FavCntInfoModelCopyWithImpl<FavCntInfoModel>(this as FavCntInfoModel, _$identity);

  /// Serializes this FavCntInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavCntInfoModel&&(identical(other.collect, collect) || other.collect == collect)&&(identical(other.play, play) || other.play == play)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,collect,play,danmaku);

@override
String toString() {
  return 'FavCntInfoModel(collect: $collect, play: $play, danmaku: $danmaku)';
}


}

/// @nodoc
abstract mixin class $FavCntInfoModelCopyWith<$Res>  {
  factory $FavCntInfoModelCopyWith(FavCntInfoModel value, $Res Function(FavCntInfoModel) _then) = _$FavCntInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'collect') int collect,@JsonKey(name: 'play') int play,@JsonKey(name: 'danmaku') int danmaku
});




}
/// @nodoc
class _$FavCntInfoModelCopyWithImpl<$Res>
    implements $FavCntInfoModelCopyWith<$Res> {
  _$FavCntInfoModelCopyWithImpl(this._self, this._then);

  final FavCntInfoModel _self;
  final $Res Function(FavCntInfoModel) _then;

/// Create a copy of FavCntInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collect = null,Object? play = null,Object? danmaku = null,}) {
  return _then(_self.copyWith(
collect: null == collect ? _self.collect : collect // ignore: cast_nullable_to_non_nullable
as int,play: null == play ? _self.play : play // ignore: cast_nullable_to_non_nullable
as int,danmaku: null == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FavCntInfoModel].
extension FavCntInfoModelPatterns on FavCntInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavCntInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavCntInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavCntInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _FavCntInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavCntInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavCntInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'collect')  int collect, @JsonKey(name: 'play')  int play, @JsonKey(name: 'danmaku')  int danmaku)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavCntInfoModel() when $default != null:
return $default(_that.collect,_that.play,_that.danmaku);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'collect')  int collect, @JsonKey(name: 'play')  int play, @JsonKey(name: 'danmaku')  int danmaku)  $default,) {final _that = this;
switch (_that) {
case _FavCntInfoModel():
return $default(_that.collect,_that.play,_that.danmaku);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'collect')  int collect, @JsonKey(name: 'play')  int play, @JsonKey(name: 'danmaku')  int danmaku)?  $default,) {final _that = this;
switch (_that) {
case _FavCntInfoModel() when $default != null:
return $default(_that.collect,_that.play,_that.danmaku);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavCntInfoModel implements FavCntInfoModel {
  const _FavCntInfoModel({@JsonKey(name: 'collect') required this.collect, @JsonKey(name: 'play') required this.play, @JsonKey(name: 'danmaku') required this.danmaku});
  factory _FavCntInfoModel.fromJson(Map<String, dynamic> json) => _$FavCntInfoModelFromJson(json);

@override@JsonKey(name: 'collect') final  int collect;
@override@JsonKey(name: 'play') final  int play;
@override@JsonKey(name: 'danmaku') final  int danmaku;

/// Create a copy of FavCntInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavCntInfoModelCopyWith<_FavCntInfoModel> get copyWith => __$FavCntInfoModelCopyWithImpl<_FavCntInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavCntInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavCntInfoModel&&(identical(other.collect, collect) || other.collect == collect)&&(identical(other.play, play) || other.play == play)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,collect,play,danmaku);

@override
String toString() {
  return 'FavCntInfoModel(collect: $collect, play: $play, danmaku: $danmaku)';
}


}

/// @nodoc
abstract mixin class _$FavCntInfoModelCopyWith<$Res> implements $FavCntInfoModelCopyWith<$Res> {
  factory _$FavCntInfoModelCopyWith(_FavCntInfoModel value, $Res Function(_FavCntInfoModel) _then) = __$FavCntInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'collect') int collect,@JsonKey(name: 'play') int play,@JsonKey(name: 'danmaku') int danmaku
});




}
/// @nodoc
class __$FavCntInfoModelCopyWithImpl<$Res>
    implements _$FavCntInfoModelCopyWith<$Res> {
  __$FavCntInfoModelCopyWithImpl(this._self, this._then);

  final _FavCntInfoModel _self;
  final $Res Function(_FavCntInfoModel) _then;

/// Create a copy of FavCntInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collect = null,Object? play = null,Object? danmaku = null,}) {
  return _then(_FavCntInfoModel(
collect: null == collect ? _self.collect : collect // ignore: cast_nullable_to_non_nullable
as int,play: null == play ? _self.play : play // ignore: cast_nullable_to_non_nullable
as int,danmaku: null == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FavResourceListResponse {

@JsonKey(name: 'info') FavFolderInfoModel get info;@JsonKey(name: 'medias') List<FavResourceModel>? get medias;@JsonKey(name: 'has_more') bool get hasMore;
/// Create a copy of FavResourceListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavResourceListResponseCopyWith<FavResourceListResponse> get copyWith => _$FavResourceListResponseCopyWithImpl<FavResourceListResponse>(this as FavResourceListResponse, _$identity);

  /// Serializes this FavResourceListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavResourceListResponse&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other.medias, medias)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(medias),hasMore);

@override
String toString() {
  return 'FavResourceListResponse(info: $info, medias: $medias, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $FavResourceListResponseCopyWith<$Res>  {
  factory $FavResourceListResponseCopyWith(FavResourceListResponse value, $Res Function(FavResourceListResponse) _then) = _$FavResourceListResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'info') FavFolderInfoModel info,@JsonKey(name: 'medias') List<FavResourceModel>? medias,@JsonKey(name: 'has_more') bool hasMore
});


$FavFolderInfoModelCopyWith<$Res> get info;

}
/// @nodoc
class _$FavResourceListResponseCopyWithImpl<$Res>
    implements $FavResourceListResponseCopyWith<$Res> {
  _$FavResourceListResponseCopyWithImpl(this._self, this._then);

  final FavResourceListResponse _self;
  final $Res Function(FavResourceListResponse) _then;

/// Create a copy of FavResourceListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? medias = freezed,Object? hasMore = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as FavFolderInfoModel,medias: freezed == medias ? _self.medias : medias // ignore: cast_nullable_to_non_nullable
as List<FavResourceModel>?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of FavResourceListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavFolderInfoModelCopyWith<$Res> get info {
  
  return $FavFolderInfoModelCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavResourceListResponse].
extension FavResourceListResponsePatterns on FavResourceListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavResourceListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavResourceListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavResourceListResponse value)  $default,){
final _that = this;
switch (_that) {
case _FavResourceListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavResourceListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FavResourceListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'info')  FavFolderInfoModel info, @JsonKey(name: 'medias')  List<FavResourceModel>? medias, @JsonKey(name: 'has_more')  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavResourceListResponse() when $default != null:
return $default(_that.info,_that.medias,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'info')  FavFolderInfoModel info, @JsonKey(name: 'medias')  List<FavResourceModel>? medias, @JsonKey(name: 'has_more')  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _FavResourceListResponse():
return $default(_that.info,_that.medias,_that.hasMore);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'info')  FavFolderInfoModel info, @JsonKey(name: 'medias')  List<FavResourceModel>? medias, @JsonKey(name: 'has_more')  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _FavResourceListResponse() when $default != null:
return $default(_that.info,_that.medias,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavResourceListResponse implements FavResourceListResponse {
  const _FavResourceListResponse({@JsonKey(name: 'info') required this.info, @JsonKey(name: 'medias') final  List<FavResourceModel>? medias, @JsonKey(name: 'has_more') required this.hasMore}): _medias = medias;
  factory _FavResourceListResponse.fromJson(Map<String, dynamic> json) => _$FavResourceListResponseFromJson(json);

@override@JsonKey(name: 'info') final  FavFolderInfoModel info;
 final  List<FavResourceModel>? _medias;
@override@JsonKey(name: 'medias') List<FavResourceModel>? get medias {
  final value = _medias;
  if (value == null) return null;
  if (_medias is EqualUnmodifiableListView) return _medias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'has_more') final  bool hasMore;

/// Create a copy of FavResourceListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavResourceListResponseCopyWith<_FavResourceListResponse> get copyWith => __$FavResourceListResponseCopyWithImpl<_FavResourceListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavResourceListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavResourceListResponse&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other._medias, _medias)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(_medias),hasMore);

@override
String toString() {
  return 'FavResourceListResponse(info: $info, medias: $medias, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$FavResourceListResponseCopyWith<$Res> implements $FavResourceListResponseCopyWith<$Res> {
  factory _$FavResourceListResponseCopyWith(_FavResourceListResponse value, $Res Function(_FavResourceListResponse) _then) = __$FavResourceListResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'info') FavFolderInfoModel info,@JsonKey(name: 'medias') List<FavResourceModel>? medias,@JsonKey(name: 'has_more') bool hasMore
});


@override $FavFolderInfoModelCopyWith<$Res> get info;

}
/// @nodoc
class __$FavResourceListResponseCopyWithImpl<$Res>
    implements _$FavResourceListResponseCopyWith<$Res> {
  __$FavResourceListResponseCopyWithImpl(this._self, this._then);

  final _FavResourceListResponse _self;
  final $Res Function(_FavResourceListResponse) _then;

/// Create a copy of FavResourceListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? medias = freezed,Object? hasMore = null,}) {
  return _then(_FavResourceListResponse(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as FavFolderInfoModel,medias: freezed == medias ? _self._medias : medias // ignore: cast_nullable_to_non_nullable
as List<FavResourceModel>?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FavResourceListResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavFolderInfoModelCopyWith<$Res> get info {
  
  return $FavFolderInfoModelCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// @nodoc
mixin _$FavFolderInfoModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'fid') int get fid;@JsonKey(name: 'mid') int get mid;@JsonKey(name: 'attr') int get attr;@JsonKey(name: 'title') String get title;@JsonKey(name: 'cover') String get cover;@JsonKey(name: 'upper') FavUpperModel get upper;@JsonKey(name: 'media_count') int get mediaCount;
/// Create a copy of FavFolderInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavFolderInfoModelCopyWith<FavFolderInfoModel> get copyWith => _$FavFolderInfoModelCopyWithImpl<FavFolderInfoModel>(this as FavFolderInfoModel, _$identity);

  /// Serializes this FavFolderInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavFolderInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fid, fid) || other.fid == fid)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.mediaCount, mediaCount) || other.mediaCount == mediaCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fid,mid,attr,title,cover,upper,mediaCount);

@override
String toString() {
  return 'FavFolderInfoModel(id: $id, fid: $fid, mid: $mid, attr: $attr, title: $title, cover: $cover, upper: $upper, mediaCount: $mediaCount)';
}


}

/// @nodoc
abstract mixin class $FavFolderInfoModelCopyWith<$Res>  {
  factory $FavFolderInfoModelCopyWith(FavFolderInfoModel value, $Res Function(FavFolderInfoModel) _then) = _$FavFolderInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'fid') int fid,@JsonKey(name: 'mid') int mid,@JsonKey(name: 'attr') int attr,@JsonKey(name: 'title') String title,@JsonKey(name: 'cover') String cover,@JsonKey(name: 'upper') FavUpperModel upper,@JsonKey(name: 'media_count') int mediaCount
});


$FavUpperModelCopyWith<$Res> get upper;

}
/// @nodoc
class _$FavFolderInfoModelCopyWithImpl<$Res>
    implements $FavFolderInfoModelCopyWith<$Res> {
  _$FavFolderInfoModelCopyWithImpl(this._self, this._then);

  final FavFolderInfoModel _self;
  final $Res Function(FavFolderInfoModel) _then;

/// Create a copy of FavFolderInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fid = null,Object? mid = null,Object? attr = null,Object? title = null,Object? cover = null,Object? upper = null,Object? mediaCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fid: null == fid ? _self.fid : fid // ignore: cast_nullable_to_non_nullable
as int,mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as FavUpperModel,mediaCount: null == mediaCount ? _self.mediaCount : mediaCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FavFolderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res> get upper {
  
  return $FavUpperModelCopyWith<$Res>(_self.upper, (value) {
    return _then(_self.copyWith(upper: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavFolderInfoModel].
extension FavFolderInfoModelPatterns on FavFolderInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavFolderInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavFolderInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavFolderInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _FavFolderInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavFolderInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavFolderInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'fid')  int fid, @JsonKey(name: 'mid')  int mid, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'title')  String title, @JsonKey(name: 'cover')  String cover, @JsonKey(name: 'upper')  FavUpperModel upper, @JsonKey(name: 'media_count')  int mediaCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavFolderInfoModel() when $default != null:
return $default(_that.id,_that.fid,_that.mid,_that.attr,_that.title,_that.cover,_that.upper,_that.mediaCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'fid')  int fid, @JsonKey(name: 'mid')  int mid, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'title')  String title, @JsonKey(name: 'cover')  String cover, @JsonKey(name: 'upper')  FavUpperModel upper, @JsonKey(name: 'media_count')  int mediaCount)  $default,) {final _that = this;
switch (_that) {
case _FavFolderInfoModel():
return $default(_that.id,_that.fid,_that.mid,_that.attr,_that.title,_that.cover,_that.upper,_that.mediaCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'fid')  int fid, @JsonKey(name: 'mid')  int mid, @JsonKey(name: 'attr')  int attr, @JsonKey(name: 'title')  String title, @JsonKey(name: 'cover')  String cover, @JsonKey(name: 'upper')  FavUpperModel upper, @JsonKey(name: 'media_count')  int mediaCount)?  $default,) {final _that = this;
switch (_that) {
case _FavFolderInfoModel() when $default != null:
return $default(_that.id,_that.fid,_that.mid,_that.attr,_that.title,_that.cover,_that.upper,_that.mediaCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavFolderInfoModel implements FavFolderInfoModel {
  const _FavFolderInfoModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'fid') required this.fid, @JsonKey(name: 'mid') required this.mid, @JsonKey(name: 'attr') required this.attr, @JsonKey(name: 'title') required this.title, @JsonKey(name: 'cover') required this.cover, @JsonKey(name: 'upper') required this.upper, @JsonKey(name: 'media_count') required this.mediaCount});
  factory _FavFolderInfoModel.fromJson(Map<String, dynamic> json) => _$FavFolderInfoModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'fid') final  int fid;
@override@JsonKey(name: 'mid') final  int mid;
@override@JsonKey(name: 'attr') final  int attr;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'cover') final  String cover;
@override@JsonKey(name: 'upper') final  FavUpperModel upper;
@override@JsonKey(name: 'media_count') final  int mediaCount;

/// Create a copy of FavFolderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavFolderInfoModelCopyWith<_FavFolderInfoModel> get copyWith => __$FavFolderInfoModelCopyWithImpl<_FavFolderInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavFolderInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavFolderInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fid, fid) || other.fid == fid)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.mediaCount, mediaCount) || other.mediaCount == mediaCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fid,mid,attr,title,cover,upper,mediaCount);

@override
String toString() {
  return 'FavFolderInfoModel(id: $id, fid: $fid, mid: $mid, attr: $attr, title: $title, cover: $cover, upper: $upper, mediaCount: $mediaCount)';
}


}

/// @nodoc
abstract mixin class _$FavFolderInfoModelCopyWith<$Res> implements $FavFolderInfoModelCopyWith<$Res> {
  factory _$FavFolderInfoModelCopyWith(_FavFolderInfoModel value, $Res Function(_FavFolderInfoModel) _then) = __$FavFolderInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'fid') int fid,@JsonKey(name: 'mid') int mid,@JsonKey(name: 'attr') int attr,@JsonKey(name: 'title') String title,@JsonKey(name: 'cover') String cover,@JsonKey(name: 'upper') FavUpperModel upper,@JsonKey(name: 'media_count') int mediaCount
});


@override $FavUpperModelCopyWith<$Res> get upper;

}
/// @nodoc
class __$FavFolderInfoModelCopyWithImpl<$Res>
    implements _$FavFolderInfoModelCopyWith<$Res> {
  __$FavFolderInfoModelCopyWithImpl(this._self, this._then);

  final _FavFolderInfoModel _self;
  final $Res Function(_FavFolderInfoModel) _then;

/// Create a copy of FavFolderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fid = null,Object? mid = null,Object? attr = null,Object? title = null,Object? cover = null,Object? upper = null,Object? mediaCount = null,}) {
  return _then(_FavFolderInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fid: null == fid ? _self.fid : fid // ignore: cast_nullable_to_non_nullable
as int,mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as FavUpperModel,mediaCount: null == mediaCount ? _self.mediaCount : mediaCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FavFolderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavUpperModelCopyWith<$Res> get upper {
  
  return $FavUpperModelCopyWith<$Res>(_self.upper, (value) {
    return _then(_self.copyWith(upper: value));
  });
}
}

// dart format on
