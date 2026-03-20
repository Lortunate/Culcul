// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankingResponse {

 List<VideoModel> get list;
/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingResponseCopyWith<RankingResponse> get copyWith => _$RankingResponseCopyWithImpl<RankingResponse>(this as RankingResponse, _$identity);

  /// Serializes this RankingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingResponse&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'RankingResponse(list: $list)';
}


}

/// @nodoc
abstract mixin class $RankingResponseCopyWith<$Res>  {
  factory $RankingResponseCopyWith(RankingResponse value, $Res Function(RankingResponse) _then) = _$RankingResponseCopyWithImpl;
@useResult
$Res call({
 List<VideoModel> list
});




}
/// @nodoc
class _$RankingResponseCopyWithImpl<$Res>
    implements $RankingResponseCopyWith<$Res> {
  _$RankingResponseCopyWithImpl(this._self, this._then);

  final RankingResponse _self;
  final $Res Function(RankingResponse) _then;

/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingResponse].
extension RankingResponsePatterns on RankingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingResponse value)  $default,){
final _that = this;
switch (_that) {
case _RankingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VideoModel> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
return $default(_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VideoModel> list)  $default,) {final _that = this;
switch (_that) {
case _RankingResponse():
return $default(_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VideoModel> list)?  $default,) {final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingResponse implements RankingResponse {
  const _RankingResponse({final  List<VideoModel> list = const []}): _list = list;
  factory _RankingResponse.fromJson(Map<String, dynamic> json) => _$RankingResponseFromJson(json);

 final  List<VideoModel> _list;
@override@JsonKey() List<VideoModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingResponseCopyWith<_RankingResponse> get copyWith => __$RankingResponseCopyWithImpl<_RankingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingResponse&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'RankingResponse(list: $list)';
}


}

/// @nodoc
abstract mixin class _$RankingResponseCopyWith<$Res> implements $RankingResponseCopyWith<$Res> {
  factory _$RankingResponseCopyWith(_RankingResponse value, $Res Function(_RankingResponse) _then) = __$RankingResponseCopyWithImpl;
@override @useResult
$Res call({
 List<VideoModel> list
});




}
/// @nodoc
class __$RankingResponseCopyWithImpl<$Res>
    implements _$RankingResponseCopyWith<$Res> {
  __$RankingResponseCopyWithImpl(this._self, this._then);

  final _RankingResponse _self;
  final $Res Function(_RankingResponse) _then;

/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_RankingResponse(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,
  ));
}


}

// dart format on
