// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PopularResponse {

 List<VideoModel> get list;@JsonKey(name: 'no_more') bool get noMore;
/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularResponseCopyWith<PopularResponse> get copyWith => _$PopularResponseCopyWithImpl<PopularResponse>(this as PopularResponse, _$identity);

  /// Serializes this PopularResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularResponse&&const DeepCollectionEquality().equals(other.list, list)&&(identical(other.noMore, noMore) || other.noMore == noMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list),noMore);

@override
String toString() {
  return 'PopularResponse(list: $list, noMore: $noMore)';
}


}

/// @nodoc
abstract mixin class $PopularResponseCopyWith<$Res>  {
  factory $PopularResponseCopyWith(PopularResponse value, $Res Function(PopularResponse) _then) = _$PopularResponseCopyWithImpl;
@useResult
$Res call({
 List<VideoModel> list,@JsonKey(name: 'no_more') bool noMore
});




}
/// @nodoc
class _$PopularResponseCopyWithImpl<$Res>
    implements $PopularResponseCopyWith<$Res> {
  _$PopularResponseCopyWithImpl(this._self, this._then);

  final PopularResponse _self;
  final $Res Function(PopularResponse) _then;

/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? noMore = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,noMore: null == noMore ? _self.noMore : noMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PopularResponse].
extension PopularResponsePatterns on PopularResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PopularResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PopularResponse value)  $default,){
final _that = this;
switch (_that) {
case _PopularResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PopularResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VideoModel> list, @JsonKey(name: 'no_more')  bool noMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
return $default(_that.list,_that.noMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VideoModel> list, @JsonKey(name: 'no_more')  bool noMore)  $default,) {final _that = this;
switch (_that) {
case _PopularResponse():
return $default(_that.list,_that.noMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VideoModel> list, @JsonKey(name: 'no_more')  bool noMore)?  $default,) {final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
return $default(_that.list,_that.noMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PopularResponse implements PopularResponse {
  const _PopularResponse({final  List<VideoModel> list = const [], @JsonKey(name: 'no_more') this.noMore = false}): _list = list;
  factory _PopularResponse.fromJson(Map<String, dynamic> json) => _$PopularResponseFromJson(json);

 final  List<VideoModel> _list;
@override@JsonKey() List<VideoModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

@override@JsonKey(name: 'no_more') final  bool noMore;

/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularResponseCopyWith<_PopularResponse> get copyWith => __$PopularResponseCopyWithImpl<_PopularResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularResponse&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.noMore, noMore) || other.noMore == noMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),noMore);

@override
String toString() {
  return 'PopularResponse(list: $list, noMore: $noMore)';
}


}

/// @nodoc
abstract mixin class _$PopularResponseCopyWith<$Res> implements $PopularResponseCopyWith<$Res> {
  factory _$PopularResponseCopyWith(_PopularResponse value, $Res Function(_PopularResponse) _then) = __$PopularResponseCopyWithImpl;
@override @useResult
$Res call({
 List<VideoModel> list,@JsonKey(name: 'no_more') bool noMore
});




}
/// @nodoc
class __$PopularResponseCopyWithImpl<$Res>
    implements _$PopularResponseCopyWith<$Res> {
  __$PopularResponseCopyWithImpl(this._self, this._then);

  final _PopularResponse _self;
  final $Res Function(_PopularResponse) _then;

/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? noMore = null,}) {
  return _then(_PopularResponse(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,noMore: null == noMore ? _self.noMore : noMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
