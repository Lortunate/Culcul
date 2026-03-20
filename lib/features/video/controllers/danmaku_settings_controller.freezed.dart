// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'danmaku_settings_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DanmakuSettings {

 double get opacity; double get fontSizeScale; double get area;// 0.25, 0.5, 0.75, 1.0
 double get speed;// 1.0 is normal, smaller is slower? No, usually multiplier.
 bool get showTop; bool get showBottom; bool get showScroll; bool get showColor; bool get isEnabled; bool get enableAiMask; double get strokeWidth;
/// Create a copy of DanmakuSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DanmakuSettingsCopyWith<DanmakuSettings> get copyWith => _$DanmakuSettingsCopyWithImpl<DanmakuSettings>(this as DanmakuSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DanmakuSettings&&(identical(other.opacity, opacity) || other.opacity == opacity)&&(identical(other.fontSizeScale, fontSizeScale) || other.fontSizeScale == fontSizeScale)&&(identical(other.area, area) || other.area == area)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.showTop, showTop) || other.showTop == showTop)&&(identical(other.showBottom, showBottom) || other.showBottom == showBottom)&&(identical(other.showScroll, showScroll) || other.showScroll == showScroll)&&(identical(other.showColor, showColor) || other.showColor == showColor)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.enableAiMask, enableAiMask) || other.enableAiMask == enableAiMask)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth));
}


@override
int get hashCode => Object.hash(runtimeType,opacity,fontSizeScale,area,speed,showTop,showBottom,showScroll,showColor,isEnabled,enableAiMask,strokeWidth);

@override
String toString() {
  return 'DanmakuSettings(opacity: $opacity, fontSizeScale: $fontSizeScale, area: $area, speed: $speed, showTop: $showTop, showBottom: $showBottom, showScroll: $showScroll, showColor: $showColor, isEnabled: $isEnabled, enableAiMask: $enableAiMask, strokeWidth: $strokeWidth)';
}


}

/// @nodoc
abstract mixin class $DanmakuSettingsCopyWith<$Res>  {
  factory $DanmakuSettingsCopyWith(DanmakuSettings value, $Res Function(DanmakuSettings) _then) = _$DanmakuSettingsCopyWithImpl;
@useResult
$Res call({
 double opacity, double fontSizeScale, double area, double speed, bool showTop, bool showBottom, bool showScroll, bool showColor, bool isEnabled, bool enableAiMask, double strokeWidth
});




}
/// @nodoc
class _$DanmakuSettingsCopyWithImpl<$Res>
    implements $DanmakuSettingsCopyWith<$Res> {
  _$DanmakuSettingsCopyWithImpl(this._self, this._then);

  final DanmakuSettings _self;
  final $Res Function(DanmakuSettings) _then;

/// Create a copy of DanmakuSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opacity = null,Object? fontSizeScale = null,Object? area = null,Object? speed = null,Object? showTop = null,Object? showBottom = null,Object? showScroll = null,Object? showColor = null,Object? isEnabled = null,Object? enableAiMask = null,Object? strokeWidth = null,}) {
  return _then(_self.copyWith(
opacity: null == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double,fontSizeScale: null == fontSizeScale ? _self.fontSizeScale : fontSizeScale // ignore: cast_nullable_to_non_nullable
as double,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,showTop: null == showTop ? _self.showTop : showTop // ignore: cast_nullable_to_non_nullable
as bool,showBottom: null == showBottom ? _self.showBottom : showBottom // ignore: cast_nullable_to_non_nullable
as bool,showScroll: null == showScroll ? _self.showScroll : showScroll // ignore: cast_nullable_to_non_nullable
as bool,showColor: null == showColor ? _self.showColor : showColor // ignore: cast_nullable_to_non_nullable
as bool,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,enableAiMask: null == enableAiMask ? _self.enableAiMask : enableAiMask // ignore: cast_nullable_to_non_nullable
as bool,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DanmakuSettings].
extension DanmakuSettingsPatterns on DanmakuSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DanmakuSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DanmakuSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DanmakuSettings value)  $default,){
final _that = this;
switch (_that) {
case _DanmakuSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DanmakuSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DanmakuSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double opacity,  double fontSizeScale,  double area,  double speed,  bool showTop,  bool showBottom,  bool showScroll,  bool showColor,  bool isEnabled,  bool enableAiMask,  double strokeWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DanmakuSettings() when $default != null:
return $default(_that.opacity,_that.fontSizeScale,_that.area,_that.speed,_that.showTop,_that.showBottom,_that.showScroll,_that.showColor,_that.isEnabled,_that.enableAiMask,_that.strokeWidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double opacity,  double fontSizeScale,  double area,  double speed,  bool showTop,  bool showBottom,  bool showScroll,  bool showColor,  bool isEnabled,  bool enableAiMask,  double strokeWidth)  $default,) {final _that = this;
switch (_that) {
case _DanmakuSettings():
return $default(_that.opacity,_that.fontSizeScale,_that.area,_that.speed,_that.showTop,_that.showBottom,_that.showScroll,_that.showColor,_that.isEnabled,_that.enableAiMask,_that.strokeWidth);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double opacity,  double fontSizeScale,  double area,  double speed,  bool showTop,  bool showBottom,  bool showScroll,  bool showColor,  bool isEnabled,  bool enableAiMask,  double strokeWidth)?  $default,) {final _that = this;
switch (_that) {
case _DanmakuSettings() when $default != null:
return $default(_that.opacity,_that.fontSizeScale,_that.area,_that.speed,_that.showTop,_that.showBottom,_that.showScroll,_that.showColor,_that.isEnabled,_that.enableAiMask,_that.strokeWidth);case _:
  return null;

}
}

}

/// @nodoc


class _DanmakuSettings implements DanmakuSettings {
  const _DanmakuSettings({this.opacity = 1.0, this.fontSizeScale = 1.0, this.area = 1.0, this.speed = 1.0, this.showTop = true, this.showBottom = true, this.showScroll = true, this.showColor = true, this.isEnabled = true, this.enableAiMask = true, this.strokeWidth = 0.0});
  

@override@JsonKey() final  double opacity;
@override@JsonKey() final  double fontSizeScale;
@override@JsonKey() final  double area;
// 0.25, 0.5, 0.75, 1.0
@override@JsonKey() final  double speed;
// 1.0 is normal, smaller is slower? No, usually multiplier.
@override@JsonKey() final  bool showTop;
@override@JsonKey() final  bool showBottom;
@override@JsonKey() final  bool showScroll;
@override@JsonKey() final  bool showColor;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  bool enableAiMask;
@override@JsonKey() final  double strokeWidth;

/// Create a copy of DanmakuSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DanmakuSettingsCopyWith<_DanmakuSettings> get copyWith => __$DanmakuSettingsCopyWithImpl<_DanmakuSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DanmakuSettings&&(identical(other.opacity, opacity) || other.opacity == opacity)&&(identical(other.fontSizeScale, fontSizeScale) || other.fontSizeScale == fontSizeScale)&&(identical(other.area, area) || other.area == area)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.showTop, showTop) || other.showTop == showTop)&&(identical(other.showBottom, showBottom) || other.showBottom == showBottom)&&(identical(other.showScroll, showScroll) || other.showScroll == showScroll)&&(identical(other.showColor, showColor) || other.showColor == showColor)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.enableAiMask, enableAiMask) || other.enableAiMask == enableAiMask)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth));
}


@override
int get hashCode => Object.hash(runtimeType,opacity,fontSizeScale,area,speed,showTop,showBottom,showScroll,showColor,isEnabled,enableAiMask,strokeWidth);

@override
String toString() {
  return 'DanmakuSettings(opacity: $opacity, fontSizeScale: $fontSizeScale, area: $area, speed: $speed, showTop: $showTop, showBottom: $showBottom, showScroll: $showScroll, showColor: $showColor, isEnabled: $isEnabled, enableAiMask: $enableAiMask, strokeWidth: $strokeWidth)';
}


}

/// @nodoc
abstract mixin class _$DanmakuSettingsCopyWith<$Res> implements $DanmakuSettingsCopyWith<$Res> {
  factory _$DanmakuSettingsCopyWith(_DanmakuSettings value, $Res Function(_DanmakuSettings) _then) = __$DanmakuSettingsCopyWithImpl;
@override @useResult
$Res call({
 double opacity, double fontSizeScale, double area, double speed, bool showTop, bool showBottom, bool showScroll, bool showColor, bool isEnabled, bool enableAiMask, double strokeWidth
});




}
/// @nodoc
class __$DanmakuSettingsCopyWithImpl<$Res>
    implements _$DanmakuSettingsCopyWith<$Res> {
  __$DanmakuSettingsCopyWithImpl(this._self, this._then);

  final _DanmakuSettings _self;
  final $Res Function(_DanmakuSettings) _then;

/// Create a copy of DanmakuSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opacity = null,Object? fontSizeScale = null,Object? area = null,Object? speed = null,Object? showTop = null,Object? showBottom = null,Object? showScroll = null,Object? showColor = null,Object? isEnabled = null,Object? enableAiMask = null,Object? strokeWidth = null,}) {
  return _then(_DanmakuSettings(
opacity: null == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double,fontSizeScale: null == fontSizeScale ? _self.fontSizeScale : fontSizeScale // ignore: cast_nullable_to_non_nullable
as double,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,showTop: null == showTop ? _self.showTop : showTop // ignore: cast_nullable_to_non_nullable
as bool,showBottom: null == showBottom ? _self.showBottom : showBottom // ignore: cast_nullable_to_non_nullable
as bool,showScroll: null == showScroll ? _self.showScroll : showScroll // ignore: cast_nullable_to_non_nullable
as bool,showColor: null == showColor ? _self.showColor : showColor // ignore: cast_nullable_to_non_nullable
as bool,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,enableAiMask: null == enableAiMask ? _self.enableAiMask : enableAiMask // ignore: cast_nullable_to_non_nullable
as bool,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
