// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerInfo {

@JsonKey(name: 'dm_mask') DmMask? get dmMask;
/// Create a copy of PlayerInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerInfoCopyWith<PlayerInfo> get copyWith => _$PlayerInfoCopyWithImpl<PlayerInfo>(this as PlayerInfo, _$identity);

  /// Serializes this PlayerInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerInfo&&(identical(other.dmMask, dmMask) || other.dmMask == dmMask));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dmMask);

@override
String toString() {
  return 'PlayerInfo(dmMask: $dmMask)';
}


}

/// @nodoc
abstract mixin class $PlayerInfoCopyWith<$Res>  {
  factory $PlayerInfoCopyWith(PlayerInfo value, $Res Function(PlayerInfo) _then) = _$PlayerInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'dm_mask') DmMask? dmMask
});


$DmMaskCopyWith<$Res>? get dmMask;

}
/// @nodoc
class _$PlayerInfoCopyWithImpl<$Res>
    implements $PlayerInfoCopyWith<$Res> {
  _$PlayerInfoCopyWithImpl(this._self, this._then);

  final PlayerInfo _self;
  final $Res Function(PlayerInfo) _then;

/// Create a copy of PlayerInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dmMask = freezed,}) {
  return _then(_self.copyWith(
dmMask: freezed == dmMask ? _self.dmMask : dmMask // ignore: cast_nullable_to_non_nullable
as DmMask?,
  ));
}
/// Create a copy of PlayerInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DmMaskCopyWith<$Res>? get dmMask {
    if (_self.dmMask == null) {
    return null;
  }

  return $DmMaskCopyWith<$Res>(_self.dmMask!, (value) {
    return _then(_self.copyWith(dmMask: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerInfo].
extension PlayerInfoPatterns on PlayerInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerInfo value)  $default,){
final _that = this;
switch (_that) {
case _PlayerInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'dm_mask')  DmMask? dmMask)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerInfo() when $default != null:
return $default(_that.dmMask);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'dm_mask')  DmMask? dmMask)  $default,) {final _that = this;
switch (_that) {
case _PlayerInfo():
return $default(_that.dmMask);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'dm_mask')  DmMask? dmMask)?  $default,) {final _that = this;
switch (_that) {
case _PlayerInfo() when $default != null:
return $default(_that.dmMask);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerInfo implements PlayerInfo {
  const _PlayerInfo({@JsonKey(name: 'dm_mask') this.dmMask});
  factory _PlayerInfo.fromJson(Map<String, dynamic> json) => _$PlayerInfoFromJson(json);

@override@JsonKey(name: 'dm_mask') final  DmMask? dmMask;

/// Create a copy of PlayerInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerInfoCopyWith<_PlayerInfo> get copyWith => __$PlayerInfoCopyWithImpl<_PlayerInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerInfo&&(identical(other.dmMask, dmMask) || other.dmMask == dmMask));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dmMask);

@override
String toString() {
  return 'PlayerInfo(dmMask: $dmMask)';
}


}

/// @nodoc
abstract mixin class _$PlayerInfoCopyWith<$Res> implements $PlayerInfoCopyWith<$Res> {
  factory _$PlayerInfoCopyWith(_PlayerInfo value, $Res Function(_PlayerInfo) _then) = __$PlayerInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'dm_mask') DmMask? dmMask
});


@override $DmMaskCopyWith<$Res>? get dmMask;

}
/// @nodoc
class __$PlayerInfoCopyWithImpl<$Res>
    implements _$PlayerInfoCopyWith<$Res> {
  __$PlayerInfoCopyWithImpl(this._self, this._then);

  final _PlayerInfo _self;
  final $Res Function(_PlayerInfo) _then;

/// Create a copy of PlayerInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dmMask = freezed,}) {
  return _then(_PlayerInfo(
dmMask: freezed == dmMask ? _self.dmMask : dmMask // ignore: cast_nullable_to_non_nullable
as DmMask?,
  ));
}

/// Create a copy of PlayerInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DmMaskCopyWith<$Res>? get dmMask {
    if (_self.dmMask == null) {
    return null;
  }

  return $DmMaskCopyWith<$Res>(_self.dmMask!, (value) {
    return _then(_self.copyWith(dmMask: value));
  });
}
}


/// @nodoc
mixin _$DmMask {

@JsonKey(name: 'mask_url') String get maskUrl; int get fps;
/// Create a copy of DmMask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DmMaskCopyWith<DmMask> get copyWith => _$DmMaskCopyWithImpl<DmMask>(this as DmMask, _$identity);

  /// Serializes this DmMask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DmMask&&(identical(other.maskUrl, maskUrl) || other.maskUrl == maskUrl)&&(identical(other.fps, fps) || other.fps == fps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maskUrl,fps);

@override
String toString() {
  return 'DmMask(maskUrl: $maskUrl, fps: $fps)';
}


}

/// @nodoc
abstract mixin class $DmMaskCopyWith<$Res>  {
  factory $DmMaskCopyWith(DmMask value, $Res Function(DmMask) _then) = _$DmMaskCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'mask_url') String maskUrl, int fps
});




}
/// @nodoc
class _$DmMaskCopyWithImpl<$Res>
    implements $DmMaskCopyWith<$Res> {
  _$DmMaskCopyWithImpl(this._self, this._then);

  final DmMask _self;
  final $Res Function(DmMask) _then;

/// Create a copy of DmMask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maskUrl = null,Object? fps = null,}) {
  return _then(_self.copyWith(
maskUrl: null == maskUrl ? _self.maskUrl : maskUrl // ignore: cast_nullable_to_non_nullable
as String,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DmMask].
extension DmMaskPatterns on DmMask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DmMask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DmMask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DmMask value)  $default,){
final _that = this;
switch (_that) {
case _DmMask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DmMask value)?  $default,){
final _that = this;
switch (_that) {
case _DmMask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'mask_url')  String maskUrl,  int fps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DmMask() when $default != null:
return $default(_that.maskUrl,_that.fps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'mask_url')  String maskUrl,  int fps)  $default,) {final _that = this;
switch (_that) {
case _DmMask():
return $default(_that.maskUrl,_that.fps);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'mask_url')  String maskUrl,  int fps)?  $default,) {final _that = this;
switch (_that) {
case _DmMask() when $default != null:
return $default(_that.maskUrl,_that.fps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DmMask implements DmMask {
  const _DmMask({@JsonKey(name: 'mask_url') required this.maskUrl, required this.fps});
  factory _DmMask.fromJson(Map<String, dynamic> json) => _$DmMaskFromJson(json);

@override@JsonKey(name: 'mask_url') final  String maskUrl;
@override final  int fps;

/// Create a copy of DmMask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DmMaskCopyWith<_DmMask> get copyWith => __$DmMaskCopyWithImpl<_DmMask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DmMaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DmMask&&(identical(other.maskUrl, maskUrl) || other.maskUrl == maskUrl)&&(identical(other.fps, fps) || other.fps == fps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maskUrl,fps);

@override
String toString() {
  return 'DmMask(maskUrl: $maskUrl, fps: $fps)';
}


}

/// @nodoc
abstract mixin class _$DmMaskCopyWith<$Res> implements $DmMaskCopyWith<$Res> {
  factory _$DmMaskCopyWith(_DmMask value, $Res Function(_DmMask) _then) = __$DmMaskCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'mask_url') String maskUrl, int fps
});




}
/// @nodoc
class __$DmMaskCopyWithImpl<$Res>
    implements _$DmMaskCopyWith<$Res> {
  __$DmMaskCopyWithImpl(this._self, this._then);

  final _DmMask _self;
  final $Res Function(_DmMask) _then;

/// Create a copy of DmMask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maskUrl = null,Object? fps = null,}) {
  return _then(_DmMask(
maskUrl: null == maskUrl ? _self.maskUrl : maskUrl // ignore: cast_nullable_to_non_nullable
as String,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
