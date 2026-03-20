// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_anchor_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveAnchorInfoModel {

 LiveAnchorInfo get info; LiveAnchorExp get exp;@JsonKey(name: 'follower_num') int get followerNum;@JsonKey(name: 'room_id') int get roomId;@JsonKey(name: 'medal_name') String get medalName;@JsonKey(name: 'glory_count') int get gloryCount; String get pendant;
/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveAnchorInfoModelCopyWith<LiveAnchorInfoModel> get copyWith => _$LiveAnchorInfoModelCopyWithImpl<LiveAnchorInfoModel>(this as LiveAnchorInfoModel, _$identity);

  /// Serializes this LiveAnchorInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveAnchorInfoModel&&(identical(other.info, info) || other.info == info)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.followerNum, followerNum) || other.followerNum == followerNum)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.medalName, medalName) || other.medalName == medalName)&&(identical(other.gloryCount, gloryCount) || other.gloryCount == gloryCount)&&(identical(other.pendant, pendant) || other.pendant == pendant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,exp,followerNum,roomId,medalName,gloryCount,pendant);

@override
String toString() {
  return 'LiveAnchorInfoModel(info: $info, exp: $exp, followerNum: $followerNum, roomId: $roomId, medalName: $medalName, gloryCount: $gloryCount, pendant: $pendant)';
}


}

/// @nodoc
abstract mixin class $LiveAnchorInfoModelCopyWith<$Res>  {
  factory $LiveAnchorInfoModelCopyWith(LiveAnchorInfoModel value, $Res Function(LiveAnchorInfoModel) _then) = _$LiveAnchorInfoModelCopyWithImpl;
@useResult
$Res call({
 LiveAnchorInfo info, LiveAnchorExp exp,@JsonKey(name: 'follower_num') int followerNum,@JsonKey(name: 'room_id') int roomId,@JsonKey(name: 'medal_name') String medalName,@JsonKey(name: 'glory_count') int gloryCount, String pendant
});


$LiveAnchorInfoCopyWith<$Res> get info;$LiveAnchorExpCopyWith<$Res> get exp;

}
/// @nodoc
class _$LiveAnchorInfoModelCopyWithImpl<$Res>
    implements $LiveAnchorInfoModelCopyWith<$Res> {
  _$LiveAnchorInfoModelCopyWithImpl(this._self, this._then);

  final LiveAnchorInfoModel _self;
  final $Res Function(LiveAnchorInfoModel) _then;

/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? exp = null,Object? followerNum = null,Object? roomId = null,Object? medalName = null,Object? gloryCount = null,Object? pendant = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as LiveAnchorInfo,exp: null == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as LiveAnchorExp,followerNum: null == followerNum ? _self.followerNum : followerNum // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,medalName: null == medalName ? _self.medalName : medalName // ignore: cast_nullable_to_non_nullable
as String,gloryCount: null == gloryCount ? _self.gloryCount : gloryCount // ignore: cast_nullable_to_non_nullable
as int,pendant: null == pendant ? _self.pendant : pendant // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorInfoCopyWith<$Res> get info {
  
  return $LiveAnchorInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorExpCopyWith<$Res> get exp {
  
  return $LiveAnchorExpCopyWith<$Res>(_self.exp, (value) {
    return _then(_self.copyWith(exp: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveAnchorInfoModel].
extension LiveAnchorInfoModelPatterns on LiveAnchorInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveAnchorInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveAnchorInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveAnchorInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveAnchorInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiveAnchorInfo info,  LiveAnchorExp exp, @JsonKey(name: 'follower_num')  int followerNum, @JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'medal_name')  String medalName, @JsonKey(name: 'glory_count')  int gloryCount,  String pendant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveAnchorInfoModel() when $default != null:
return $default(_that.info,_that.exp,_that.followerNum,_that.roomId,_that.medalName,_that.gloryCount,_that.pendant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiveAnchorInfo info,  LiveAnchorExp exp, @JsonKey(name: 'follower_num')  int followerNum, @JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'medal_name')  String medalName, @JsonKey(name: 'glory_count')  int gloryCount,  String pendant)  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorInfoModel():
return $default(_that.info,_that.exp,_that.followerNum,_that.roomId,_that.medalName,_that.gloryCount,_that.pendant);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiveAnchorInfo info,  LiveAnchorExp exp, @JsonKey(name: 'follower_num')  int followerNum, @JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'medal_name')  String medalName, @JsonKey(name: 'glory_count')  int gloryCount,  String pendant)?  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorInfoModel() when $default != null:
return $default(_that.info,_that.exp,_that.followerNum,_that.roomId,_that.medalName,_that.gloryCount,_that.pendant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveAnchorInfoModel implements LiveAnchorInfoModel {
  const _LiveAnchorInfoModel({required this.info, required this.exp, @JsonKey(name: 'follower_num') required this.followerNum, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'medal_name') required this.medalName, @JsonKey(name: 'glory_count') required this.gloryCount, required this.pendant});
  factory _LiveAnchorInfoModel.fromJson(Map<String, dynamic> json) => _$LiveAnchorInfoModelFromJson(json);

@override final  LiveAnchorInfo info;
@override final  LiveAnchorExp exp;
@override@JsonKey(name: 'follower_num') final  int followerNum;
@override@JsonKey(name: 'room_id') final  int roomId;
@override@JsonKey(name: 'medal_name') final  String medalName;
@override@JsonKey(name: 'glory_count') final  int gloryCount;
@override final  String pendant;

/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveAnchorInfoModelCopyWith<_LiveAnchorInfoModel> get copyWith => __$LiveAnchorInfoModelCopyWithImpl<_LiveAnchorInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveAnchorInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveAnchorInfoModel&&(identical(other.info, info) || other.info == info)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.followerNum, followerNum) || other.followerNum == followerNum)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.medalName, medalName) || other.medalName == medalName)&&(identical(other.gloryCount, gloryCount) || other.gloryCount == gloryCount)&&(identical(other.pendant, pendant) || other.pendant == pendant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,exp,followerNum,roomId,medalName,gloryCount,pendant);

@override
String toString() {
  return 'LiveAnchorInfoModel(info: $info, exp: $exp, followerNum: $followerNum, roomId: $roomId, medalName: $medalName, gloryCount: $gloryCount, pendant: $pendant)';
}


}

/// @nodoc
abstract mixin class _$LiveAnchorInfoModelCopyWith<$Res> implements $LiveAnchorInfoModelCopyWith<$Res> {
  factory _$LiveAnchorInfoModelCopyWith(_LiveAnchorInfoModel value, $Res Function(_LiveAnchorInfoModel) _then) = __$LiveAnchorInfoModelCopyWithImpl;
@override @useResult
$Res call({
 LiveAnchorInfo info, LiveAnchorExp exp,@JsonKey(name: 'follower_num') int followerNum,@JsonKey(name: 'room_id') int roomId,@JsonKey(name: 'medal_name') String medalName,@JsonKey(name: 'glory_count') int gloryCount, String pendant
});


@override $LiveAnchorInfoCopyWith<$Res> get info;@override $LiveAnchorExpCopyWith<$Res> get exp;

}
/// @nodoc
class __$LiveAnchorInfoModelCopyWithImpl<$Res>
    implements _$LiveAnchorInfoModelCopyWith<$Res> {
  __$LiveAnchorInfoModelCopyWithImpl(this._self, this._then);

  final _LiveAnchorInfoModel _self;
  final $Res Function(_LiveAnchorInfoModel) _then;

/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? exp = null,Object? followerNum = null,Object? roomId = null,Object? medalName = null,Object? gloryCount = null,Object? pendant = null,}) {
  return _then(_LiveAnchorInfoModel(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as LiveAnchorInfo,exp: null == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as LiveAnchorExp,followerNum: null == followerNum ? _self.followerNum : followerNum // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,medalName: null == medalName ? _self.medalName : medalName // ignore: cast_nullable_to_non_nullable
as String,gloryCount: null == gloryCount ? _self.gloryCount : gloryCount // ignore: cast_nullable_to_non_nullable
as int,pendant: null == pendant ? _self.pendant : pendant // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorInfoCopyWith<$Res> get info {
  
  return $LiveAnchorInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of LiveAnchorInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorExpCopyWith<$Res> get exp {
  
  return $LiveAnchorExpCopyWith<$Res>(_self.exp, (value) {
    return _then(_self.copyWith(exp: value));
  });
}
}


/// @nodoc
mixin _$LiveAnchorInfo {

 int get uid; String get uname; String get face;@JsonKey(name: 'official_verify') LiveAnchorVerify get officialVerify; int get gender;
/// Create a copy of LiveAnchorInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveAnchorInfoCopyWith<LiveAnchorInfo> get copyWith => _$LiveAnchorInfoCopyWithImpl<LiveAnchorInfo>(this as LiveAnchorInfo, _$identity);

  /// Serializes this LiveAnchorInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveAnchorInfo&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.face, face) || other.face == face)&&(identical(other.officialVerify, officialVerify) || other.officialVerify == officialVerify)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,uname,face,officialVerify,gender);

@override
String toString() {
  return 'LiveAnchorInfo(uid: $uid, uname: $uname, face: $face, officialVerify: $officialVerify, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $LiveAnchorInfoCopyWith<$Res>  {
  factory $LiveAnchorInfoCopyWith(LiveAnchorInfo value, $Res Function(LiveAnchorInfo) _then) = _$LiveAnchorInfoCopyWithImpl;
@useResult
$Res call({
 int uid, String uname, String face,@JsonKey(name: 'official_verify') LiveAnchorVerify officialVerify, int gender
});


$LiveAnchorVerifyCopyWith<$Res> get officialVerify;

}
/// @nodoc
class _$LiveAnchorInfoCopyWithImpl<$Res>
    implements $LiveAnchorInfoCopyWith<$Res> {
  _$LiveAnchorInfoCopyWithImpl(this._self, this._then);

  final LiveAnchorInfo _self;
  final $Res Function(LiveAnchorInfo) _then;

/// Create a copy of LiveAnchorInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? uname = null,Object? face = null,Object? officialVerify = null,Object? gender = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,officialVerify: null == officialVerify ? _self.officialVerify : officialVerify // ignore: cast_nullable_to_non_nullable
as LiveAnchorVerify,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LiveAnchorInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorVerifyCopyWith<$Res> get officialVerify {
  
  return $LiveAnchorVerifyCopyWith<$Res>(_self.officialVerify, (value) {
    return _then(_self.copyWith(officialVerify: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveAnchorInfo].
extension LiveAnchorInfoPatterns on LiveAnchorInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveAnchorInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveAnchorInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveAnchorInfo value)  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveAnchorInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int uid,  String uname,  String face, @JsonKey(name: 'official_verify')  LiveAnchorVerify officialVerify,  int gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveAnchorInfo() when $default != null:
return $default(_that.uid,_that.uname,_that.face,_that.officialVerify,_that.gender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int uid,  String uname,  String face, @JsonKey(name: 'official_verify')  LiveAnchorVerify officialVerify,  int gender)  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorInfo():
return $default(_that.uid,_that.uname,_that.face,_that.officialVerify,_that.gender);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int uid,  String uname,  String face, @JsonKey(name: 'official_verify')  LiveAnchorVerify officialVerify,  int gender)?  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorInfo() when $default != null:
return $default(_that.uid,_that.uname,_that.face,_that.officialVerify,_that.gender);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveAnchorInfo implements LiveAnchorInfo {
  const _LiveAnchorInfo({required this.uid, required this.uname, required this.face, @JsonKey(name: 'official_verify') required this.officialVerify, required this.gender});
  factory _LiveAnchorInfo.fromJson(Map<String, dynamic> json) => _$LiveAnchorInfoFromJson(json);

@override final  int uid;
@override final  String uname;
@override final  String face;
@override@JsonKey(name: 'official_verify') final  LiveAnchorVerify officialVerify;
@override final  int gender;

/// Create a copy of LiveAnchorInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveAnchorInfoCopyWith<_LiveAnchorInfo> get copyWith => __$LiveAnchorInfoCopyWithImpl<_LiveAnchorInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveAnchorInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveAnchorInfo&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.face, face) || other.face == face)&&(identical(other.officialVerify, officialVerify) || other.officialVerify == officialVerify)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,uname,face,officialVerify,gender);

@override
String toString() {
  return 'LiveAnchorInfo(uid: $uid, uname: $uname, face: $face, officialVerify: $officialVerify, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$LiveAnchorInfoCopyWith<$Res> implements $LiveAnchorInfoCopyWith<$Res> {
  factory _$LiveAnchorInfoCopyWith(_LiveAnchorInfo value, $Res Function(_LiveAnchorInfo) _then) = __$LiveAnchorInfoCopyWithImpl;
@override @useResult
$Res call({
 int uid, String uname, String face,@JsonKey(name: 'official_verify') LiveAnchorVerify officialVerify, int gender
});


@override $LiveAnchorVerifyCopyWith<$Res> get officialVerify;

}
/// @nodoc
class __$LiveAnchorInfoCopyWithImpl<$Res>
    implements _$LiveAnchorInfoCopyWith<$Res> {
  __$LiveAnchorInfoCopyWithImpl(this._self, this._then);

  final _LiveAnchorInfo _self;
  final $Res Function(_LiveAnchorInfo) _then;

/// Create a copy of LiveAnchorInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? uname = null,Object? face = null,Object? officialVerify = null,Object? gender = null,}) {
  return _then(_LiveAnchorInfo(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,officialVerify: null == officialVerify ? _self.officialVerify : officialVerify // ignore: cast_nullable_to_non_nullable
as LiveAnchorVerify,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LiveAnchorInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorVerifyCopyWith<$Res> get officialVerify {
  
  return $LiveAnchorVerifyCopyWith<$Res>(_self.officialVerify, (value) {
    return _then(_self.copyWith(officialVerify: value));
  });
}
}


/// @nodoc
mixin _$LiveAnchorVerify {

 int get type; String get desc;
/// Create a copy of LiveAnchorVerify
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveAnchorVerifyCopyWith<LiveAnchorVerify> get copyWith => _$LiveAnchorVerifyCopyWithImpl<LiveAnchorVerify>(this as LiveAnchorVerify, _$identity);

  /// Serializes this LiveAnchorVerify to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveAnchorVerify&&(identical(other.type, type) || other.type == type)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,desc);

@override
String toString() {
  return 'LiveAnchorVerify(type: $type, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $LiveAnchorVerifyCopyWith<$Res>  {
  factory $LiveAnchorVerifyCopyWith(LiveAnchorVerify value, $Res Function(LiveAnchorVerify) _then) = _$LiveAnchorVerifyCopyWithImpl;
@useResult
$Res call({
 int type, String desc
});




}
/// @nodoc
class _$LiveAnchorVerifyCopyWithImpl<$Res>
    implements $LiveAnchorVerifyCopyWith<$Res> {
  _$LiveAnchorVerifyCopyWithImpl(this._self, this._then);

  final LiveAnchorVerify _self;
  final $Res Function(LiveAnchorVerify) _then;

/// Create a copy of LiveAnchorVerify
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? desc = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveAnchorVerify].
extension LiveAnchorVerifyPatterns on LiveAnchorVerify {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveAnchorVerify value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveAnchorVerify() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveAnchorVerify value)  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorVerify():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveAnchorVerify value)?  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorVerify() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int type,  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveAnchorVerify() when $default != null:
return $default(_that.type,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int type,  String desc)  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorVerify():
return $default(_that.type,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int type,  String desc)?  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorVerify() when $default != null:
return $default(_that.type,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveAnchorVerify implements LiveAnchorVerify {
  const _LiveAnchorVerify({required this.type, required this.desc});
  factory _LiveAnchorVerify.fromJson(Map<String, dynamic> json) => _$LiveAnchorVerifyFromJson(json);

@override final  int type;
@override final  String desc;

/// Create a copy of LiveAnchorVerify
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveAnchorVerifyCopyWith<_LiveAnchorVerify> get copyWith => __$LiveAnchorVerifyCopyWithImpl<_LiveAnchorVerify>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveAnchorVerifyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveAnchorVerify&&(identical(other.type, type) || other.type == type)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,desc);

@override
String toString() {
  return 'LiveAnchorVerify(type: $type, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$LiveAnchorVerifyCopyWith<$Res> implements $LiveAnchorVerifyCopyWith<$Res> {
  factory _$LiveAnchorVerifyCopyWith(_LiveAnchorVerify value, $Res Function(_LiveAnchorVerify) _then) = __$LiveAnchorVerifyCopyWithImpl;
@override @useResult
$Res call({
 int type, String desc
});




}
/// @nodoc
class __$LiveAnchorVerifyCopyWithImpl<$Res>
    implements _$LiveAnchorVerifyCopyWith<$Res> {
  __$LiveAnchorVerifyCopyWithImpl(this._self, this._then);

  final _LiveAnchorVerify _self;
  final $Res Function(_LiveAnchorVerify) _then;

/// Create a copy of LiveAnchorVerify
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? desc = null,}) {
  return _then(_LiveAnchorVerify(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LiveAnchorExp {

@JsonKey(name: 'master_level') LiveMasterLevel get masterLevel;
/// Create a copy of LiveAnchorExp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveAnchorExpCopyWith<LiveAnchorExp> get copyWith => _$LiveAnchorExpCopyWithImpl<LiveAnchorExp>(this as LiveAnchorExp, _$identity);

  /// Serializes this LiveAnchorExp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveAnchorExp&&(identical(other.masterLevel, masterLevel) || other.masterLevel == masterLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,masterLevel);

@override
String toString() {
  return 'LiveAnchorExp(masterLevel: $masterLevel)';
}


}

/// @nodoc
abstract mixin class $LiveAnchorExpCopyWith<$Res>  {
  factory $LiveAnchorExpCopyWith(LiveAnchorExp value, $Res Function(LiveAnchorExp) _then) = _$LiveAnchorExpCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'master_level') LiveMasterLevel masterLevel
});


$LiveMasterLevelCopyWith<$Res> get masterLevel;

}
/// @nodoc
class _$LiveAnchorExpCopyWithImpl<$Res>
    implements $LiveAnchorExpCopyWith<$Res> {
  _$LiveAnchorExpCopyWithImpl(this._self, this._then);

  final LiveAnchorExp _self;
  final $Res Function(LiveAnchorExp) _then;

/// Create a copy of LiveAnchorExp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? masterLevel = null,}) {
  return _then(_self.copyWith(
masterLevel: null == masterLevel ? _self.masterLevel : masterLevel // ignore: cast_nullable_to_non_nullable
as LiveMasterLevel,
  ));
}
/// Create a copy of LiveAnchorExp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMasterLevelCopyWith<$Res> get masterLevel {
  
  return $LiveMasterLevelCopyWith<$Res>(_self.masterLevel, (value) {
    return _then(_self.copyWith(masterLevel: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveAnchorExp].
extension LiveAnchorExpPatterns on LiveAnchorExp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveAnchorExp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveAnchorExp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveAnchorExp value)  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorExp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveAnchorExp value)?  $default,){
final _that = this;
switch (_that) {
case _LiveAnchorExp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'master_level')  LiveMasterLevel masterLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveAnchorExp() when $default != null:
return $default(_that.masterLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'master_level')  LiveMasterLevel masterLevel)  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorExp():
return $default(_that.masterLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'master_level')  LiveMasterLevel masterLevel)?  $default,) {final _that = this;
switch (_that) {
case _LiveAnchorExp() when $default != null:
return $default(_that.masterLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveAnchorExp implements LiveAnchorExp {
  const _LiveAnchorExp({@JsonKey(name: 'master_level') required this.masterLevel});
  factory _LiveAnchorExp.fromJson(Map<String, dynamic> json) => _$LiveAnchorExpFromJson(json);

@override@JsonKey(name: 'master_level') final  LiveMasterLevel masterLevel;

/// Create a copy of LiveAnchorExp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveAnchorExpCopyWith<_LiveAnchorExp> get copyWith => __$LiveAnchorExpCopyWithImpl<_LiveAnchorExp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveAnchorExpToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveAnchorExp&&(identical(other.masterLevel, masterLevel) || other.masterLevel == masterLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,masterLevel);

@override
String toString() {
  return 'LiveAnchorExp(masterLevel: $masterLevel)';
}


}

/// @nodoc
abstract mixin class _$LiveAnchorExpCopyWith<$Res> implements $LiveAnchorExpCopyWith<$Res> {
  factory _$LiveAnchorExpCopyWith(_LiveAnchorExp value, $Res Function(_LiveAnchorExp) _then) = __$LiveAnchorExpCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'master_level') LiveMasterLevel masterLevel
});


@override $LiveMasterLevelCopyWith<$Res> get masterLevel;

}
/// @nodoc
class __$LiveAnchorExpCopyWithImpl<$Res>
    implements _$LiveAnchorExpCopyWith<$Res> {
  __$LiveAnchorExpCopyWithImpl(this._self, this._then);

  final _LiveAnchorExp _self;
  final $Res Function(_LiveAnchorExp) _then;

/// Create a copy of LiveAnchorExp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? masterLevel = null,}) {
  return _then(_LiveAnchorExp(
masterLevel: null == masterLevel ? _self.masterLevel : masterLevel // ignore: cast_nullable_to_non_nullable
as LiveMasterLevel,
  ));
}

/// Create a copy of LiveAnchorExp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMasterLevelCopyWith<$Res> get masterLevel {
  
  return $LiveMasterLevelCopyWith<$Res>(_self.masterLevel, (value) {
    return _then(_self.copyWith(masterLevel: value));
  });
}
}


/// @nodoc
mixin _$LiveMasterLevel {

 int get level; int get color; List<int> get current; List<int> get next;
/// Create a copy of LiveMasterLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMasterLevelCopyWith<LiveMasterLevel> get copyWith => _$LiveMasterLevelCopyWithImpl<LiveMasterLevel>(this as LiveMasterLevel, _$identity);

  /// Serializes this LiveMasterLevel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMasterLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.current, current)&&const DeepCollectionEquality().equals(other.next, next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,color,const DeepCollectionEquality().hash(current),const DeepCollectionEquality().hash(next));

@override
String toString() {
  return 'LiveMasterLevel(level: $level, color: $color, current: $current, next: $next)';
}


}

/// @nodoc
abstract mixin class $LiveMasterLevelCopyWith<$Res>  {
  factory $LiveMasterLevelCopyWith(LiveMasterLevel value, $Res Function(LiveMasterLevel) _then) = _$LiveMasterLevelCopyWithImpl;
@useResult
$Res call({
 int level, int color, List<int> current, List<int> next
});




}
/// @nodoc
class _$LiveMasterLevelCopyWithImpl<$Res>
    implements $LiveMasterLevelCopyWith<$Res> {
  _$LiveMasterLevelCopyWithImpl(this._self, this._then);

  final LiveMasterLevel _self;
  final $Res Function(LiveMasterLevel) _then;

/// Create a copy of LiveMasterLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? color = null,Object? current = null,Object? next = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as List<int>,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMasterLevel].
extension LiveMasterLevelPatterns on LiveMasterLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMasterLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMasterLevel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMasterLevel value)  $default,){
final _that = this;
switch (_that) {
case _LiveMasterLevel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMasterLevel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMasterLevel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level,  int color,  List<int> current,  List<int> next)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMasterLevel() when $default != null:
return $default(_that.level,_that.color,_that.current,_that.next);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level,  int color,  List<int> current,  List<int> next)  $default,) {final _that = this;
switch (_that) {
case _LiveMasterLevel():
return $default(_that.level,_that.color,_that.current,_that.next);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level,  int color,  List<int> current,  List<int> next)?  $default,) {final _that = this;
switch (_that) {
case _LiveMasterLevel() when $default != null:
return $default(_that.level,_that.color,_that.current,_that.next);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveMasterLevel implements LiveMasterLevel {
  const _LiveMasterLevel({required this.level, required this.color, required final  List<int> current, required final  List<int> next}): _current = current,_next = next;
  factory _LiveMasterLevel.fromJson(Map<String, dynamic> json) => _$LiveMasterLevelFromJson(json);

@override final  int level;
@override final  int color;
 final  List<int> _current;
@override List<int> get current {
  if (_current is EqualUnmodifiableListView) return _current;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_current);
}

 final  List<int> _next;
@override List<int> get next {
  if (_next is EqualUnmodifiableListView) return _next;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_next);
}


/// Create a copy of LiveMasterLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMasterLevelCopyWith<_LiveMasterLevel> get copyWith => __$LiveMasterLevelCopyWithImpl<_LiveMasterLevel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveMasterLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMasterLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._current, _current)&&const DeepCollectionEquality().equals(other._next, _next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,color,const DeepCollectionEquality().hash(_current),const DeepCollectionEquality().hash(_next));

@override
String toString() {
  return 'LiveMasterLevel(level: $level, color: $color, current: $current, next: $next)';
}


}

/// @nodoc
abstract mixin class _$LiveMasterLevelCopyWith<$Res> implements $LiveMasterLevelCopyWith<$Res> {
  factory _$LiveMasterLevelCopyWith(_LiveMasterLevel value, $Res Function(_LiveMasterLevel) _then) = __$LiveMasterLevelCopyWithImpl;
@override @useResult
$Res call({
 int level, int color, List<int> current, List<int> next
});




}
/// @nodoc
class __$LiveMasterLevelCopyWithImpl<$Res>
    implements _$LiveMasterLevelCopyWith<$Res> {
  __$LiveMasterLevelCopyWithImpl(this._self, this._then);

  final _LiveMasterLevel _self;
  final $Res Function(_LiveMasterLevel) _then;

/// Create a copy of LiveMasterLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? color = null,Object? current = null,Object? next = null,}) {
  return _then(_LiveMasterLevel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,current: null == current ? _self._current : current // ignore: cast_nullable_to_non_nullable
as List<int>,next: null == next ? _self._next : next // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
