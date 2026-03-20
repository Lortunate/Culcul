// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerUiState implements DiagnosticableTreeMixin {

 bool get isPlaying; bool get isBuffering; Duration get position; Duration get duration; Duration get buffer; bool get isFullscreen; bool get isLocked; bool get showControls; DateTime? get sleepTimerTarget;
/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerUiStateCopyWith<PlayerUiState> get copyWith => _$PlayerUiStateCopyWithImpl<PlayerUiState>(this as PlayerUiState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlayerUiState'))
    ..add(DiagnosticsProperty('isPlaying', isPlaying))..add(DiagnosticsProperty('isBuffering', isBuffering))..add(DiagnosticsProperty('position', position))..add(DiagnosticsProperty('duration', duration))..add(DiagnosticsProperty('buffer', buffer))..add(DiagnosticsProperty('isFullscreen', isFullscreen))..add(DiagnosticsProperty('isLocked', isLocked))..add(DiagnosticsProperty('showControls', showControls))..add(DiagnosticsProperty('sleepTimerTarget', sleepTimerTarget));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerUiState&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isBuffering, isBuffering) || other.isBuffering == isBuffering)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.buffer, buffer) || other.buffer == buffer)&&(identical(other.isFullscreen, isFullscreen) || other.isFullscreen == isFullscreen)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.showControls, showControls) || other.showControls == showControls)&&(identical(other.sleepTimerTarget, sleepTimerTarget) || other.sleepTimerTarget == sleepTimerTarget));
}


@override
int get hashCode => Object.hash(runtimeType,isPlaying,isBuffering,position,duration,buffer,isFullscreen,isLocked,showControls,sleepTimerTarget);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlayerUiState(isPlaying: $isPlaying, isBuffering: $isBuffering, position: $position, duration: $duration, buffer: $buffer, isFullscreen: $isFullscreen, isLocked: $isLocked, showControls: $showControls, sleepTimerTarget: $sleepTimerTarget)';
}


}

/// @nodoc
abstract mixin class $PlayerUiStateCopyWith<$Res>  {
  factory $PlayerUiStateCopyWith(PlayerUiState value, $Res Function(PlayerUiState) _then) = _$PlayerUiStateCopyWithImpl;
@useResult
$Res call({
 bool isPlaying, bool isBuffering, Duration position, Duration duration, Duration buffer, bool isFullscreen, bool isLocked, bool showControls, DateTime? sleepTimerTarget
});




}
/// @nodoc
class _$PlayerUiStateCopyWithImpl<$Res>
    implements $PlayerUiStateCopyWith<$Res> {
  _$PlayerUiStateCopyWithImpl(this._self, this._then);

  final PlayerUiState _self;
  final $Res Function(PlayerUiState) _then;

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPlaying = null,Object? isBuffering = null,Object? position = null,Object? duration = null,Object? buffer = null,Object? isFullscreen = null,Object? isLocked = null,Object? showControls = null,Object? sleepTimerTarget = freezed,}) {
  return _then(_self.copyWith(
isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isBuffering: null == isBuffering ? _self.isBuffering : isBuffering // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,buffer: null == buffer ? _self.buffer : buffer // ignore: cast_nullable_to_non_nullable
as Duration,isFullscreen: null == isFullscreen ? _self.isFullscreen : isFullscreen // ignore: cast_nullable_to_non_nullable
as bool,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,showControls: null == showControls ? _self.showControls : showControls // ignore: cast_nullable_to_non_nullable
as bool,sleepTimerTarget: freezed == sleepTimerTarget ? _self.sleepTimerTarget : sleepTimerTarget // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerUiState].
extension PlayerUiStatePatterns on PlayerUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerUiState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerUiState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isPlaying,  bool isBuffering,  Duration position,  Duration duration,  Duration buffer,  bool isFullscreen,  bool isLocked,  bool showControls,  DateTime? sleepTimerTarget)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
return $default(_that.isPlaying,_that.isBuffering,_that.position,_that.duration,_that.buffer,_that.isFullscreen,_that.isLocked,_that.showControls,_that.sleepTimerTarget);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isPlaying,  bool isBuffering,  Duration position,  Duration duration,  Duration buffer,  bool isFullscreen,  bool isLocked,  bool showControls,  DateTime? sleepTimerTarget)  $default,) {final _that = this;
switch (_that) {
case _PlayerUiState():
return $default(_that.isPlaying,_that.isBuffering,_that.position,_that.duration,_that.buffer,_that.isFullscreen,_that.isLocked,_that.showControls,_that.sleepTimerTarget);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isPlaying,  bool isBuffering,  Duration position,  Duration duration,  Duration buffer,  bool isFullscreen,  bool isLocked,  bool showControls,  DateTime? sleepTimerTarget)?  $default,) {final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
return $default(_that.isPlaying,_that.isBuffering,_that.position,_that.duration,_that.buffer,_that.isFullscreen,_that.isLocked,_that.showControls,_that.sleepTimerTarget);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerUiState with DiagnosticableTreeMixin implements PlayerUiState {
  const _PlayerUiState({this.isPlaying = false, this.isBuffering = false, this.position = Duration.zero, this.duration = Duration.zero, this.buffer = Duration.zero, this.isFullscreen = false, this.isLocked = false, this.showControls = true, this.sleepTimerTarget});
  

@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool isBuffering;
@override@JsonKey() final  Duration position;
@override@JsonKey() final  Duration duration;
@override@JsonKey() final  Duration buffer;
@override@JsonKey() final  bool isFullscreen;
@override@JsonKey() final  bool isLocked;
@override@JsonKey() final  bool showControls;
@override final  DateTime? sleepTimerTarget;

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerUiStateCopyWith<_PlayerUiState> get copyWith => __$PlayerUiStateCopyWithImpl<_PlayerUiState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlayerUiState'))
    ..add(DiagnosticsProperty('isPlaying', isPlaying))..add(DiagnosticsProperty('isBuffering', isBuffering))..add(DiagnosticsProperty('position', position))..add(DiagnosticsProperty('duration', duration))..add(DiagnosticsProperty('buffer', buffer))..add(DiagnosticsProperty('isFullscreen', isFullscreen))..add(DiagnosticsProperty('isLocked', isLocked))..add(DiagnosticsProperty('showControls', showControls))..add(DiagnosticsProperty('sleepTimerTarget', sleepTimerTarget));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerUiState&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isBuffering, isBuffering) || other.isBuffering == isBuffering)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.buffer, buffer) || other.buffer == buffer)&&(identical(other.isFullscreen, isFullscreen) || other.isFullscreen == isFullscreen)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.showControls, showControls) || other.showControls == showControls)&&(identical(other.sleepTimerTarget, sleepTimerTarget) || other.sleepTimerTarget == sleepTimerTarget));
}


@override
int get hashCode => Object.hash(runtimeType,isPlaying,isBuffering,position,duration,buffer,isFullscreen,isLocked,showControls,sleepTimerTarget);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlayerUiState(isPlaying: $isPlaying, isBuffering: $isBuffering, position: $position, duration: $duration, buffer: $buffer, isFullscreen: $isFullscreen, isLocked: $isLocked, showControls: $showControls, sleepTimerTarget: $sleepTimerTarget)';
}


}

/// @nodoc
abstract mixin class _$PlayerUiStateCopyWith<$Res> implements $PlayerUiStateCopyWith<$Res> {
  factory _$PlayerUiStateCopyWith(_PlayerUiState value, $Res Function(_PlayerUiState) _then) = __$PlayerUiStateCopyWithImpl;
@override @useResult
$Res call({
 bool isPlaying, bool isBuffering, Duration position, Duration duration, Duration buffer, bool isFullscreen, bool isLocked, bool showControls, DateTime? sleepTimerTarget
});




}
/// @nodoc
class __$PlayerUiStateCopyWithImpl<$Res>
    implements _$PlayerUiStateCopyWith<$Res> {
  __$PlayerUiStateCopyWithImpl(this._self, this._then);

  final _PlayerUiState _self;
  final $Res Function(_PlayerUiState) _then;

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPlaying = null,Object? isBuffering = null,Object? position = null,Object? duration = null,Object? buffer = null,Object? isFullscreen = null,Object? isLocked = null,Object? showControls = null,Object? sleepTimerTarget = freezed,}) {
  return _then(_PlayerUiState(
isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isBuffering: null == isBuffering ? _self.isBuffering : isBuffering // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,buffer: null == buffer ? _self.buffer : buffer // ignore: cast_nullable_to_non_nullable
as Duration,isFullscreen: null == isFullscreen ? _self.isFullscreen : isFullscreen // ignore: cast_nullable_to_non_nullable
as bool,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,showControls: null == showControls ? _self.showControls : showControls // ignore: cast_nullable_to_non_nullable
as bool,sleepTimerTarget: freezed == sleepTimerTarget ? _self.sleepTimerTarget : sleepTimerTarget // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
