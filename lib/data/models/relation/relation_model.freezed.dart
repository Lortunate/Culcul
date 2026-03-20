// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RelationResponseData {

 List<RelationUser> get list; int get total;
/// Create a copy of RelationResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationResponseDataCopyWith<RelationResponseData> get copyWith => _$RelationResponseDataCopyWithImpl<RelationResponseData>(this as RelationResponseData, _$identity);

  /// Serializes this RelationResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationResponseData&&const DeepCollectionEquality().equals(other.list, list)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list),total);

@override
String toString() {
  return 'RelationResponseData(list: $list, total: $total)';
}


}

/// @nodoc
abstract mixin class $RelationResponseDataCopyWith<$Res>  {
  factory $RelationResponseDataCopyWith(RelationResponseData value, $Res Function(RelationResponseData) _then) = _$RelationResponseDataCopyWithImpl;
@useResult
$Res call({
 List<RelationUser> list, int total
});




}
/// @nodoc
class _$RelationResponseDataCopyWithImpl<$Res>
    implements $RelationResponseDataCopyWith<$Res> {
  _$RelationResponseDataCopyWithImpl(this._self, this._then);

  final RelationResponseData _self;
  final $Res Function(RelationResponseData) _then;

/// Create a copy of RelationResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? total = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<RelationUser>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RelationResponseData].
extension RelationResponseDataPatterns on RelationResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationResponseData value)  $default,){
final _that = this;
switch (_that) {
case _RelationResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _RelationResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RelationUser> list,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationResponseData() when $default != null:
return $default(_that.list,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RelationUser> list,  int total)  $default,) {final _that = this;
switch (_that) {
case _RelationResponseData():
return $default(_that.list,_that.total);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RelationUser> list,  int total)?  $default,) {final _that = this;
switch (_that) {
case _RelationResponseData() when $default != null:
return $default(_that.list,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelationResponseData implements RelationResponseData {
  const _RelationResponseData({final  List<RelationUser> list = const [], this.total = 0}): _list = list;
  factory _RelationResponseData.fromJson(Map<String, dynamic> json) => _$RelationResponseDataFromJson(json);

 final  List<RelationUser> _list;
@override@JsonKey() List<RelationUser> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

@override@JsonKey() final  int total;

/// Create a copy of RelationResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationResponseDataCopyWith<_RelationResponseData> get copyWith => __$RelationResponseDataCopyWithImpl<_RelationResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelationResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationResponseData&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),total);

@override
String toString() {
  return 'RelationResponseData(list: $list, total: $total)';
}


}

/// @nodoc
abstract mixin class _$RelationResponseDataCopyWith<$Res> implements $RelationResponseDataCopyWith<$Res> {
  factory _$RelationResponseDataCopyWith(_RelationResponseData value, $Res Function(_RelationResponseData) _then) = __$RelationResponseDataCopyWithImpl;
@override @useResult
$Res call({
 List<RelationUser> list, int total
});




}
/// @nodoc
class __$RelationResponseDataCopyWithImpl<$Res>
    implements _$RelationResponseDataCopyWith<$Res> {
  __$RelationResponseDataCopyWithImpl(this._self, this._then);

  final _RelationResponseData _self;
  final $Res Function(_RelationResponseData) _then;

/// Create a copy of RelationResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? total = null,}) {
  return _then(_RelationResponseData(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<RelationUser>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RelationUser {

 int get mid; String get uname; String get face; String get sign; int get attribute;// 0:未关注, 2:已关注, 6:已互粉
@JsonKey(name: 'official_verify') OfficialVerify? get officialVerify; VipInfo? get vip; int get mtime; int get special;
/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationUserCopyWith<RelationUser> get copyWith => _$RelationUserCopyWithImpl<RelationUser>(this as RelationUser, _$identity);

  /// Serializes this RelationUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationUser&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.face, face) || other.face == face)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.officialVerify, officialVerify) || other.officialVerify == officialVerify)&&(identical(other.vip, vip) || other.vip == vip)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.special, special) || other.special == special));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,uname,face,sign,attribute,officialVerify,vip,mtime,special);

@override
String toString() {
  return 'RelationUser(mid: $mid, uname: $uname, face: $face, sign: $sign, attribute: $attribute, officialVerify: $officialVerify, vip: $vip, mtime: $mtime, special: $special)';
}


}

/// @nodoc
abstract mixin class $RelationUserCopyWith<$Res>  {
  factory $RelationUserCopyWith(RelationUser value, $Res Function(RelationUser) _then) = _$RelationUserCopyWithImpl;
@useResult
$Res call({
 int mid, String uname, String face, String sign, int attribute,@JsonKey(name: 'official_verify') OfficialVerify? officialVerify, VipInfo? vip, int mtime, int special
});


$OfficialVerifyCopyWith<$Res>? get officialVerify;$VipInfoCopyWith<$Res>? get vip;

}
/// @nodoc
class _$RelationUserCopyWithImpl<$Res>
    implements $RelationUserCopyWith<$Res> {
  _$RelationUserCopyWithImpl(this._self, this._then);

  final RelationUser _self;
  final $Res Function(RelationUser) _then;

/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? uname = null,Object? face = null,Object? sign = null,Object? attribute = null,Object? officialVerify = freezed,Object? vip = freezed,Object? mtime = null,Object? special = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as int,officialVerify: freezed == officialVerify ? _self.officialVerify : officialVerify // ignore: cast_nullable_to_non_nullable
as OfficialVerify?,vip: freezed == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as VipInfo?,mtime: null == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int,special: null == special ? _self.special : special // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OfficialVerifyCopyWith<$Res>? get officialVerify {
    if (_self.officialVerify == null) {
    return null;
  }

  return $OfficialVerifyCopyWith<$Res>(_self.officialVerify!, (value) {
    return _then(_self.copyWith(officialVerify: value));
  });
}/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VipInfoCopyWith<$Res>? get vip {
    if (_self.vip == null) {
    return null;
  }

  return $VipInfoCopyWith<$Res>(_self.vip!, (value) {
    return _then(_self.copyWith(vip: value));
  });
}
}


/// Adds pattern-matching-related methods to [RelationUser].
extension RelationUserPatterns on RelationUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationUser value)  $default,){
final _that = this;
switch (_that) {
case _RelationUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationUser value)?  $default,){
final _that = this;
switch (_that) {
case _RelationUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mid,  String uname,  String face,  String sign,  int attribute, @JsonKey(name: 'official_verify')  OfficialVerify? officialVerify,  VipInfo? vip,  int mtime,  int special)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationUser() when $default != null:
return $default(_that.mid,_that.uname,_that.face,_that.sign,_that.attribute,_that.officialVerify,_that.vip,_that.mtime,_that.special);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mid,  String uname,  String face,  String sign,  int attribute, @JsonKey(name: 'official_verify')  OfficialVerify? officialVerify,  VipInfo? vip,  int mtime,  int special)  $default,) {final _that = this;
switch (_that) {
case _RelationUser():
return $default(_that.mid,_that.uname,_that.face,_that.sign,_that.attribute,_that.officialVerify,_that.vip,_that.mtime,_that.special);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mid,  String uname,  String face,  String sign,  int attribute, @JsonKey(name: 'official_verify')  OfficialVerify? officialVerify,  VipInfo? vip,  int mtime,  int special)?  $default,) {final _that = this;
switch (_that) {
case _RelationUser() when $default != null:
return $default(_that.mid,_that.uname,_that.face,_that.sign,_that.attribute,_that.officialVerify,_that.vip,_that.mtime,_that.special);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelationUser implements RelationUser {
  const _RelationUser({required this.mid, required this.uname, required this.face, this.sign = '', this.attribute = 0, @JsonKey(name: 'official_verify') this.officialVerify, this.vip, this.mtime = 0, this.special = 0});
  factory _RelationUser.fromJson(Map<String, dynamic> json) => _$RelationUserFromJson(json);

@override final  int mid;
@override final  String uname;
@override final  String face;
@override@JsonKey() final  String sign;
@override@JsonKey() final  int attribute;
// 0:未关注, 2:已关注, 6:已互粉
@override@JsonKey(name: 'official_verify') final  OfficialVerify? officialVerify;
@override final  VipInfo? vip;
@override@JsonKey() final  int mtime;
@override@JsonKey() final  int special;

/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationUserCopyWith<_RelationUser> get copyWith => __$RelationUserCopyWithImpl<_RelationUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelationUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationUser&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.face, face) || other.face == face)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.officialVerify, officialVerify) || other.officialVerify == officialVerify)&&(identical(other.vip, vip) || other.vip == vip)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.special, special) || other.special == special));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,uname,face,sign,attribute,officialVerify,vip,mtime,special);

@override
String toString() {
  return 'RelationUser(mid: $mid, uname: $uname, face: $face, sign: $sign, attribute: $attribute, officialVerify: $officialVerify, vip: $vip, mtime: $mtime, special: $special)';
}


}

/// @nodoc
abstract mixin class _$RelationUserCopyWith<$Res> implements $RelationUserCopyWith<$Res> {
  factory _$RelationUserCopyWith(_RelationUser value, $Res Function(_RelationUser) _then) = __$RelationUserCopyWithImpl;
@override @useResult
$Res call({
 int mid, String uname, String face, String sign, int attribute,@JsonKey(name: 'official_verify') OfficialVerify? officialVerify, VipInfo? vip, int mtime, int special
});


@override $OfficialVerifyCopyWith<$Res>? get officialVerify;@override $VipInfoCopyWith<$Res>? get vip;

}
/// @nodoc
class __$RelationUserCopyWithImpl<$Res>
    implements _$RelationUserCopyWith<$Res> {
  __$RelationUserCopyWithImpl(this._self, this._then);

  final _RelationUser _self;
  final $Res Function(_RelationUser) _then;

/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? uname = null,Object? face = null,Object? sign = null,Object? attribute = null,Object? officialVerify = freezed,Object? vip = freezed,Object? mtime = null,Object? special = null,}) {
  return _then(_RelationUser(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as int,officialVerify: freezed == officialVerify ? _self.officialVerify : officialVerify // ignore: cast_nullable_to_non_nullable
as OfficialVerify?,vip: freezed == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as VipInfo?,mtime: null == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int,special: null == special ? _self.special : special // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OfficialVerifyCopyWith<$Res>? get officialVerify {
    if (_self.officialVerify == null) {
    return null;
  }

  return $OfficialVerifyCopyWith<$Res>(_self.officialVerify!, (value) {
    return _then(_self.copyWith(officialVerify: value));
  });
}/// Create a copy of RelationUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VipInfoCopyWith<$Res>? get vip {
    if (_self.vip == null) {
    return null;
  }

  return $VipInfoCopyWith<$Res>(_self.vip!, (value) {
    return _then(_self.copyWith(vip: value));
  });
}
}


/// @nodoc
mixin _$OfficialVerify {

 int get type; String get desc;
/// Create a copy of OfficialVerify
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficialVerifyCopyWith<OfficialVerify> get copyWith => _$OfficialVerifyCopyWithImpl<OfficialVerify>(this as OfficialVerify, _$identity);

  /// Serializes this OfficialVerify to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfficialVerify&&(identical(other.type, type) || other.type == type)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,desc);

@override
String toString() {
  return 'OfficialVerify(type: $type, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $OfficialVerifyCopyWith<$Res>  {
  factory $OfficialVerifyCopyWith(OfficialVerify value, $Res Function(OfficialVerify) _then) = _$OfficialVerifyCopyWithImpl;
@useResult
$Res call({
 int type, String desc
});




}
/// @nodoc
class _$OfficialVerifyCopyWithImpl<$Res>
    implements $OfficialVerifyCopyWith<$Res> {
  _$OfficialVerifyCopyWithImpl(this._self, this._then);

  final OfficialVerify _self;
  final $Res Function(OfficialVerify) _then;

/// Create a copy of OfficialVerify
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? desc = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OfficialVerify].
extension OfficialVerifyPatterns on OfficialVerify {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfficialVerify value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfficialVerify() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfficialVerify value)  $default,){
final _that = this;
switch (_that) {
case _OfficialVerify():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfficialVerify value)?  $default,){
final _that = this;
switch (_that) {
case _OfficialVerify() when $default != null:
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
case _OfficialVerify() when $default != null:
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
case _OfficialVerify():
return $default(_that.type,_that.desc);}
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
case _OfficialVerify() when $default != null:
return $default(_that.type,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfficialVerify implements OfficialVerify {
  const _OfficialVerify({this.type = -1, this.desc = ''});
  factory _OfficialVerify.fromJson(Map<String, dynamic> json) => _$OfficialVerifyFromJson(json);

@override@JsonKey() final  int type;
@override@JsonKey() final  String desc;

/// Create a copy of OfficialVerify
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfficialVerifyCopyWith<_OfficialVerify> get copyWith => __$OfficialVerifyCopyWithImpl<_OfficialVerify>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficialVerifyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfficialVerify&&(identical(other.type, type) || other.type == type)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,desc);

@override
String toString() {
  return 'OfficialVerify(type: $type, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$OfficialVerifyCopyWith<$Res> implements $OfficialVerifyCopyWith<$Res> {
  factory _$OfficialVerifyCopyWith(_OfficialVerify value, $Res Function(_OfficialVerify) _then) = __$OfficialVerifyCopyWithImpl;
@override @useResult
$Res call({
 int type, String desc
});




}
/// @nodoc
class __$OfficialVerifyCopyWithImpl<$Res>
    implements _$OfficialVerifyCopyWith<$Res> {
  __$OfficialVerifyCopyWithImpl(this._self, this._then);

  final _OfficialVerify _self;
  final $Res Function(_OfficialVerify) _then;

/// Create a copy of OfficialVerify
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? desc = null,}) {
  return _then(_OfficialVerify(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VipInfo {

 int get vipType; int get vipStatus; String get nicknameColor;
/// Create a copy of VipInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VipInfoCopyWith<VipInfo> get copyWith => _$VipInfoCopyWithImpl<VipInfo>(this as VipInfo, _$identity);

  /// Serializes this VipInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VipInfo&&(identical(other.vipType, vipType) || other.vipType == vipType)&&(identical(other.vipStatus, vipStatus) || other.vipStatus == vipStatus)&&(identical(other.nicknameColor, nicknameColor) || other.nicknameColor == nicknameColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vipType,vipStatus,nicknameColor);

@override
String toString() {
  return 'VipInfo(vipType: $vipType, vipStatus: $vipStatus, nicknameColor: $nicknameColor)';
}


}

/// @nodoc
abstract mixin class $VipInfoCopyWith<$Res>  {
  factory $VipInfoCopyWith(VipInfo value, $Res Function(VipInfo) _then) = _$VipInfoCopyWithImpl;
@useResult
$Res call({
 int vipType, int vipStatus, String nicknameColor
});




}
/// @nodoc
class _$VipInfoCopyWithImpl<$Res>
    implements $VipInfoCopyWith<$Res> {
  _$VipInfoCopyWithImpl(this._self, this._then);

  final VipInfo _self;
  final $Res Function(VipInfo) _then;

/// Create a copy of VipInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vipType = null,Object? vipStatus = null,Object? nicknameColor = null,}) {
  return _then(_self.copyWith(
vipType: null == vipType ? _self.vipType : vipType // ignore: cast_nullable_to_non_nullable
as int,vipStatus: null == vipStatus ? _self.vipStatus : vipStatus // ignore: cast_nullable_to_non_nullable
as int,nicknameColor: null == nicknameColor ? _self.nicknameColor : nicknameColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VipInfo].
extension VipInfoPatterns on VipInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VipInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VipInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VipInfo value)  $default,){
final _that = this;
switch (_that) {
case _VipInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VipInfo value)?  $default,){
final _that = this;
switch (_that) {
case _VipInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int vipType,  int vipStatus,  String nicknameColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VipInfo() when $default != null:
return $default(_that.vipType,_that.vipStatus,_that.nicknameColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int vipType,  int vipStatus,  String nicknameColor)  $default,) {final _that = this;
switch (_that) {
case _VipInfo():
return $default(_that.vipType,_that.vipStatus,_that.nicknameColor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int vipType,  int vipStatus,  String nicknameColor)?  $default,) {final _that = this;
switch (_that) {
case _VipInfo() when $default != null:
return $default(_that.vipType,_that.vipStatus,_that.nicknameColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VipInfo implements VipInfo {
  const _VipInfo({this.vipType = 0, this.vipStatus = 0, this.nicknameColor = ''});
  factory _VipInfo.fromJson(Map<String, dynamic> json) => _$VipInfoFromJson(json);

@override@JsonKey() final  int vipType;
@override@JsonKey() final  int vipStatus;
@override@JsonKey() final  String nicknameColor;

/// Create a copy of VipInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VipInfoCopyWith<_VipInfo> get copyWith => __$VipInfoCopyWithImpl<_VipInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VipInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VipInfo&&(identical(other.vipType, vipType) || other.vipType == vipType)&&(identical(other.vipStatus, vipStatus) || other.vipStatus == vipStatus)&&(identical(other.nicknameColor, nicknameColor) || other.nicknameColor == nicknameColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vipType,vipStatus,nicknameColor);

@override
String toString() {
  return 'VipInfo(vipType: $vipType, vipStatus: $vipStatus, nicknameColor: $nicknameColor)';
}


}

/// @nodoc
abstract mixin class _$VipInfoCopyWith<$Res> implements $VipInfoCopyWith<$Res> {
  factory _$VipInfoCopyWith(_VipInfo value, $Res Function(_VipInfo) _then) = __$VipInfoCopyWithImpl;
@override @useResult
$Res call({
 int vipType, int vipStatus, String nicknameColor
});




}
/// @nodoc
class __$VipInfoCopyWithImpl<$Res>
    implements _$VipInfoCopyWith<$Res> {
  __$VipInfoCopyWithImpl(this._self, this._then);

  final _VipInfo _self;
  final $Res Function(_VipInfo) _then;

/// Create a copy of VipInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vipType = null,Object? vipStatus = null,Object? nicknameColor = null,}) {
  return _then(_VipInfo(
vipType: null == vipType ? _self.vipType : vipType // ignore: cast_nullable_to_non_nullable
as int,vipStatus: null == vipStatus ? _self.vipStatus : vipStatus // ignore: cast_nullable_to_non_nullable
as int,nicknameColor: null == nicknameColor ? _self.nicknameColor : nicknameColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
