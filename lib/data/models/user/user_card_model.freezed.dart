// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserCardModel {

 String get mid; String get name; String get face; bool get isFollowed;
/// Create a copy of UserCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCardModelCopyWith<UserCardModel> get copyWith => _$UserCardModelCopyWithImpl<UserCardModel>(this as UserCardModel, _$identity);

  /// Serializes this UserCardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCardModel&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,face,isFollowed);

@override
String toString() {
  return 'UserCardModel(mid: $mid, name: $name, face: $face, isFollowed: $isFollowed)';
}


}

/// @nodoc
abstract mixin class $UserCardModelCopyWith<$Res>  {
  factory $UserCardModelCopyWith(UserCardModel value, $Res Function(UserCardModel) _then) = _$UserCardModelCopyWithImpl;
@useResult
$Res call({
 String mid, String name, String face, bool isFollowed
});




}
/// @nodoc
class _$UserCardModelCopyWithImpl<$Res>
    implements $UserCardModelCopyWith<$Res> {
  _$UserCardModelCopyWithImpl(this._self, this._then);

  final UserCardModel _self;
  final $Res Function(UserCardModel) _then;

/// Create a copy of UserCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? name = null,Object? face = null,Object? isFollowed = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCardModel].
extension UserCardModelPatterns on UserCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCardModel value)  $default,){
final _that = this;
switch (_that) {
case _UserCardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCardModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserCardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mid,  String name,  String face,  bool isFollowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCardModel() when $default != null:
return $default(_that.mid,_that.name,_that.face,_that.isFollowed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mid,  String name,  String face,  bool isFollowed)  $default,) {final _that = this;
switch (_that) {
case _UserCardModel():
return $default(_that.mid,_that.name,_that.face,_that.isFollowed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mid,  String name,  String face,  bool isFollowed)?  $default,) {final _that = this;
switch (_that) {
case _UserCardModel() when $default != null:
return $default(_that.mid,_that.name,_that.face,_that.isFollowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserCardModel implements UserCardModel {
  const _UserCardModel({required this.mid, required this.name, required this.face, this.isFollowed = false});
  factory _UserCardModel.fromJson(Map<String, dynamic> json) => _$UserCardModelFromJson(json);

@override final  String mid;
@override final  String name;
@override final  String face;
@override@JsonKey() final  bool isFollowed;

/// Create a copy of UserCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCardModelCopyWith<_UserCardModel> get copyWith => __$UserCardModelCopyWithImpl<_UserCardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserCardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCardModel&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,face,isFollowed);

@override
String toString() {
  return 'UserCardModel(mid: $mid, name: $name, face: $face, isFollowed: $isFollowed)';
}


}

/// @nodoc
abstract mixin class _$UserCardModelCopyWith<$Res> implements $UserCardModelCopyWith<$Res> {
  factory _$UserCardModelCopyWith(_UserCardModel value, $Res Function(_UserCardModel) _then) = __$UserCardModelCopyWithImpl;
@override @useResult
$Res call({
 String mid, String name, String face, bool isFollowed
});




}
/// @nodoc
class __$UserCardModelCopyWithImpl<$Res>
    implements _$UserCardModelCopyWith<$Res> {
  __$UserCardModelCopyWithImpl(this._self, this._then);

  final _UserCardModel _self;
  final $Res Function(_UserCardModel) _then;

/// Create a copy of UserCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? name = null,Object? face = null,Object? isFollowed = null,}) {
  return _then(_UserCardModel(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
