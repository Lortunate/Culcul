// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubtitleState {

 List<SubtitleInfo> get availableSubtitles; SubtitleInfo? get selectedSubtitle; List<SubtitleItem> get content; bool get isLoading; bool get isEnabled; String? get error;
/// Create a copy of SubtitleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleStateCopyWith<SubtitleState> get copyWith => _$SubtitleStateCopyWithImpl<SubtitleState>(this as SubtitleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleState&&const DeepCollectionEquality().equals(other.availableSubtitles, availableSubtitles)&&(identical(other.selectedSubtitle, selectedSubtitle) || other.selectedSubtitle == selectedSubtitle)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availableSubtitles),selectedSubtitle,const DeepCollectionEquality().hash(content),isLoading,isEnabled,error);

@override
String toString() {
  return 'SubtitleState(availableSubtitles: $availableSubtitles, selectedSubtitle: $selectedSubtitle, content: $content, isLoading: $isLoading, isEnabled: $isEnabled, error: $error)';
}


}

/// @nodoc
abstract mixin class $SubtitleStateCopyWith<$Res>  {
  factory $SubtitleStateCopyWith(SubtitleState value, $Res Function(SubtitleState) _then) = _$SubtitleStateCopyWithImpl;
@useResult
$Res call({
 List<SubtitleInfo> availableSubtitles, SubtitleInfo? selectedSubtitle, List<SubtitleItem> content, bool isLoading, bool isEnabled, String? error
});


$SubtitleInfoCopyWith<$Res>? get selectedSubtitle;

}
/// @nodoc
class _$SubtitleStateCopyWithImpl<$Res>
    implements $SubtitleStateCopyWith<$Res> {
  _$SubtitleStateCopyWithImpl(this._self, this._then);

  final SubtitleState _self;
  final $Res Function(SubtitleState) _then;

/// Create a copy of SubtitleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableSubtitles = null,Object? selectedSubtitle = freezed,Object? content = null,Object? isLoading = null,Object? isEnabled = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
availableSubtitles: null == availableSubtitles ? _self.availableSubtitles : availableSubtitles // ignore: cast_nullable_to_non_nullable
as List<SubtitleInfo>,selectedSubtitle: freezed == selectedSubtitle ? _self.selectedSubtitle : selectedSubtitle // ignore: cast_nullable_to_non_nullable
as SubtitleInfo?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<SubtitleItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SubtitleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubtitleInfoCopyWith<$Res>? get selectedSubtitle {
    if (_self.selectedSubtitle == null) {
    return null;
  }

  return $SubtitleInfoCopyWith<$Res>(_self.selectedSubtitle!, (value) {
    return _then(_self.copyWith(selectedSubtitle: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubtitleState].
extension SubtitleStatePatterns on SubtitleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleState value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleState value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SubtitleInfo> availableSubtitles,  SubtitleInfo? selectedSubtitle,  List<SubtitleItem> content,  bool isLoading,  bool isEnabled,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleState() when $default != null:
return $default(_that.availableSubtitles,_that.selectedSubtitle,_that.content,_that.isLoading,_that.isEnabled,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SubtitleInfo> availableSubtitles,  SubtitleInfo? selectedSubtitle,  List<SubtitleItem> content,  bool isLoading,  bool isEnabled,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SubtitleState():
return $default(_that.availableSubtitles,_that.selectedSubtitle,_that.content,_that.isLoading,_that.isEnabled,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SubtitleInfo> availableSubtitles,  SubtitleInfo? selectedSubtitle,  List<SubtitleItem> content,  bool isLoading,  bool isEnabled,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleState() when $default != null:
return $default(_that.availableSubtitles,_that.selectedSubtitle,_that.content,_that.isLoading,_that.isEnabled,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SubtitleState implements SubtitleState {
  const _SubtitleState({final  List<SubtitleInfo> availableSubtitles = const [], this.selectedSubtitle, final  List<SubtitleItem> content = const [], this.isLoading = false, this.isEnabled = false, this.error}): _availableSubtitles = availableSubtitles,_content = content;
  

 final  List<SubtitleInfo> _availableSubtitles;
@override@JsonKey() List<SubtitleInfo> get availableSubtitles {
  if (_availableSubtitles is EqualUnmodifiableListView) return _availableSubtitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSubtitles);
}

@override final  SubtitleInfo? selectedSubtitle;
 final  List<SubtitleItem> _content;
@override@JsonKey() List<SubtitleItem> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isEnabled;
@override final  String? error;

/// Create a copy of SubtitleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleStateCopyWith<_SubtitleState> get copyWith => __$SubtitleStateCopyWithImpl<_SubtitleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleState&&const DeepCollectionEquality().equals(other._availableSubtitles, _availableSubtitles)&&(identical(other.selectedSubtitle, selectedSubtitle) || other.selectedSubtitle == selectedSubtitle)&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableSubtitles),selectedSubtitle,const DeepCollectionEquality().hash(_content),isLoading,isEnabled,error);

@override
String toString() {
  return 'SubtitleState(availableSubtitles: $availableSubtitles, selectedSubtitle: $selectedSubtitle, content: $content, isLoading: $isLoading, isEnabled: $isEnabled, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SubtitleStateCopyWith<$Res> implements $SubtitleStateCopyWith<$Res> {
  factory _$SubtitleStateCopyWith(_SubtitleState value, $Res Function(_SubtitleState) _then) = __$SubtitleStateCopyWithImpl;
@override @useResult
$Res call({
 List<SubtitleInfo> availableSubtitles, SubtitleInfo? selectedSubtitle, List<SubtitleItem> content, bool isLoading, bool isEnabled, String? error
});


@override $SubtitleInfoCopyWith<$Res>? get selectedSubtitle;

}
/// @nodoc
class __$SubtitleStateCopyWithImpl<$Res>
    implements _$SubtitleStateCopyWith<$Res> {
  __$SubtitleStateCopyWithImpl(this._self, this._then);

  final _SubtitleState _self;
  final $Res Function(_SubtitleState) _then;

/// Create a copy of SubtitleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableSubtitles = null,Object? selectedSubtitle = freezed,Object? content = null,Object? isLoading = null,Object? isEnabled = null,Object? error = freezed,}) {
  return _then(_SubtitleState(
availableSubtitles: null == availableSubtitles ? _self._availableSubtitles : availableSubtitles // ignore: cast_nullable_to_non_nullable
as List<SubtitleInfo>,selectedSubtitle: freezed == selectedSubtitle ? _self.selectedSubtitle : selectedSubtitle // ignore: cast_nullable_to_non_nullable
as SubtitleInfo?,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<SubtitleItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SubtitleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubtitleInfoCopyWith<$Res>? get selectedSubtitle {
    if (_self.selectedSubtitle == null) {
    return null;
  }

  return $SubtitleInfoCopyWith<$Res>(_self.selectedSubtitle!, (value) {
    return _then(_self.copyWith(selectedSubtitle: value));
  });
}
}

// dart format on
