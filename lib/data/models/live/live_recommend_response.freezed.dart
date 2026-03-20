// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_recommend_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveRecommendResponse {

@JsonKey(name: 'recommend_room_list') List<LiveRoomModel> get roomList;
/// Create a copy of LiveRecommendResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRecommendResponseCopyWith<LiveRecommendResponse> get copyWith => _$LiveRecommendResponseCopyWithImpl<LiveRecommendResponse>(this as LiveRecommendResponse, _$identity);

  /// Serializes this LiveRecommendResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRecommendResponse&&const DeepCollectionEquality().equals(other.roomList, roomList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(roomList));

@override
String toString() {
  return 'LiveRecommendResponse(roomList: $roomList)';
}


}

/// @nodoc
abstract mixin class $LiveRecommendResponseCopyWith<$Res>  {
  factory $LiveRecommendResponseCopyWith(LiveRecommendResponse value, $Res Function(LiveRecommendResponse) _then) = _$LiveRecommendResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'recommend_room_list') List<LiveRoomModel> roomList
});




}
/// @nodoc
class _$LiveRecommendResponseCopyWithImpl<$Res>
    implements $LiveRecommendResponseCopyWith<$Res> {
  _$LiveRecommendResponseCopyWithImpl(this._self, this._then);

  final LiveRecommendResponse _self;
  final $Res Function(LiveRecommendResponse) _then;

/// Create a copy of LiveRecommendResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomList = null,}) {
  return _then(_self.copyWith(
roomList: null == roomList ? _self.roomList : roomList // ignore: cast_nullable_to_non_nullable
as List<LiveRoomModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveRecommendResponse].
extension LiveRecommendResponsePatterns on LiveRecommendResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRecommendResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRecommendResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRecommendResponse value)  $default,){
final _that = this;
switch (_that) {
case _LiveRecommendResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRecommendResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRecommendResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'recommend_room_list')  List<LiveRoomModel> roomList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRecommendResponse() when $default != null:
return $default(_that.roomList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'recommend_room_list')  List<LiveRoomModel> roomList)  $default,) {final _that = this;
switch (_that) {
case _LiveRecommendResponse():
return $default(_that.roomList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'recommend_room_list')  List<LiveRoomModel> roomList)?  $default,) {final _that = this;
switch (_that) {
case _LiveRecommendResponse() when $default != null:
return $default(_that.roomList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveRecommendResponse implements LiveRecommendResponse {
  const _LiveRecommendResponse({@JsonKey(name: 'recommend_room_list') required final  List<LiveRoomModel> roomList}): _roomList = roomList;
  factory _LiveRecommendResponse.fromJson(Map<String, dynamic> json) => _$LiveRecommendResponseFromJson(json);

 final  List<LiveRoomModel> _roomList;
@override@JsonKey(name: 'recommend_room_list') List<LiveRoomModel> get roomList {
  if (_roomList is EqualUnmodifiableListView) return _roomList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roomList);
}


/// Create a copy of LiveRecommendResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRecommendResponseCopyWith<_LiveRecommendResponse> get copyWith => __$LiveRecommendResponseCopyWithImpl<_LiveRecommendResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveRecommendResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRecommendResponse&&const DeepCollectionEquality().equals(other._roomList, _roomList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roomList));

@override
String toString() {
  return 'LiveRecommendResponse(roomList: $roomList)';
}


}

/// @nodoc
abstract mixin class _$LiveRecommendResponseCopyWith<$Res> implements $LiveRecommendResponseCopyWith<$Res> {
  factory _$LiveRecommendResponseCopyWith(_LiveRecommendResponse value, $Res Function(_LiveRecommendResponse) _then) = __$LiveRecommendResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'recommend_room_list') List<LiveRoomModel> roomList
});




}
/// @nodoc
class __$LiveRecommendResponseCopyWithImpl<$Res>
    implements _$LiveRecommendResponseCopyWith<$Res> {
  __$LiveRecommendResponseCopyWithImpl(this._self, this._then);

  final _LiveRecommendResponse _self;
  final $Res Function(_LiveRecommendResponse) _then;

/// Create a copy of LiveRecommendResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomList = null,}) {
  return _then(_LiveRecommendResponse(
roomList: null == roomList ? _self._roomList : roomList // ignore: cast_nullable_to_non_nullable
as List<LiveRoomModel>,
  ));
}


}

// dart format on
