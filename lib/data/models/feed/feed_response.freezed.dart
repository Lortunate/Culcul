// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedResponse {

 List<Map<String, dynamic>> get item;@JsonKey(name: 'business_card') dynamic get businessCard;@JsonKey(name: 'floor_info') List<dynamic> get floorInfo;@JsonKey(name: 'user_feature') int get userFeature;@JsonKey(name: 'side_bar_column') String get sideBarColumn;
/// Create a copy of FeedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedResponseCopyWith<FeedResponse> get copyWith => _$FeedResponseCopyWithImpl<FeedResponse>(this as FeedResponse, _$identity);

  /// Serializes this FeedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedResponse&&const DeepCollectionEquality().equals(other.item, item)&&const DeepCollectionEquality().equals(other.businessCard, businessCard)&&const DeepCollectionEquality().equals(other.floorInfo, floorInfo)&&(identical(other.userFeature, userFeature) || other.userFeature == userFeature)&&(identical(other.sideBarColumn, sideBarColumn) || other.sideBarColumn == sideBarColumn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(item),const DeepCollectionEquality().hash(businessCard),const DeepCollectionEquality().hash(floorInfo),userFeature,sideBarColumn);

@override
String toString() {
  return 'FeedResponse(item: $item, businessCard: $businessCard, floorInfo: $floorInfo, userFeature: $userFeature, sideBarColumn: $sideBarColumn)';
}


}

/// @nodoc
abstract mixin class $FeedResponseCopyWith<$Res>  {
  factory $FeedResponseCopyWith(FeedResponse value, $Res Function(FeedResponse) _then) = _$FeedResponseCopyWithImpl;
@useResult
$Res call({
 List<Map<String, dynamic>> item,@JsonKey(name: 'business_card') dynamic businessCard,@JsonKey(name: 'floor_info') List<dynamic> floorInfo,@JsonKey(name: 'user_feature') int userFeature,@JsonKey(name: 'side_bar_column') String sideBarColumn
});




}
/// @nodoc
class _$FeedResponseCopyWithImpl<$Res>
    implements $FeedResponseCopyWith<$Res> {
  _$FeedResponseCopyWithImpl(this._self, this._then);

  final FeedResponse _self;
  final $Res Function(FeedResponse) _then;

/// Create a copy of FeedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,Object? businessCard = freezed,Object? floorInfo = null,Object? userFeature = null,Object? sideBarColumn = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,businessCard: freezed == businessCard ? _self.businessCard : businessCard // ignore: cast_nullable_to_non_nullable
as dynamic,floorInfo: null == floorInfo ? _self.floorInfo : floorInfo // ignore: cast_nullable_to_non_nullable
as List<dynamic>,userFeature: null == userFeature ? _self.userFeature : userFeature // ignore: cast_nullable_to_non_nullable
as int,sideBarColumn: null == sideBarColumn ? _self.sideBarColumn : sideBarColumn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedResponse].
extension FeedResponsePatterns on FeedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Map<String, dynamic>> item, @JsonKey(name: 'business_card')  dynamic businessCard, @JsonKey(name: 'floor_info')  List<dynamic> floorInfo, @JsonKey(name: 'user_feature')  int userFeature, @JsonKey(name: 'side_bar_column')  String sideBarColumn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedResponse() when $default != null:
return $default(_that.item,_that.businessCard,_that.floorInfo,_that.userFeature,_that.sideBarColumn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Map<String, dynamic>> item, @JsonKey(name: 'business_card')  dynamic businessCard, @JsonKey(name: 'floor_info')  List<dynamic> floorInfo, @JsonKey(name: 'user_feature')  int userFeature, @JsonKey(name: 'side_bar_column')  String sideBarColumn)  $default,) {final _that = this;
switch (_that) {
case _FeedResponse():
return $default(_that.item,_that.businessCard,_that.floorInfo,_that.userFeature,_that.sideBarColumn);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Map<String, dynamic>> item, @JsonKey(name: 'business_card')  dynamic businessCard, @JsonKey(name: 'floor_info')  List<dynamic> floorInfo, @JsonKey(name: 'user_feature')  int userFeature, @JsonKey(name: 'side_bar_column')  String sideBarColumn)?  $default,) {final _that = this;
switch (_that) {
case _FeedResponse() when $default != null:
return $default(_that.item,_that.businessCard,_that.floorInfo,_that.userFeature,_that.sideBarColumn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedResponse implements FeedResponse {
  const _FeedResponse({final  List<Map<String, dynamic>> item = const [], @JsonKey(name: 'business_card') this.businessCard, @JsonKey(name: 'floor_info') final  List<dynamic> floorInfo = const [], @JsonKey(name: 'user_feature') this.userFeature = 0, @JsonKey(name: 'side_bar_column') this.sideBarColumn = ''}): _item = item,_floorInfo = floorInfo;
  factory _FeedResponse.fromJson(Map<String, dynamic> json) => _$FeedResponseFromJson(json);

 final  List<Map<String, dynamic>> _item;
@override@JsonKey() List<Map<String, dynamic>> get item {
  if (_item is EqualUnmodifiableListView) return _item;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_item);
}

@override@JsonKey(name: 'business_card') final  dynamic businessCard;
 final  List<dynamic> _floorInfo;
@override@JsonKey(name: 'floor_info') List<dynamic> get floorInfo {
  if (_floorInfo is EqualUnmodifiableListView) return _floorInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_floorInfo);
}

@override@JsonKey(name: 'user_feature') final  int userFeature;
@override@JsonKey(name: 'side_bar_column') final  String sideBarColumn;

/// Create a copy of FeedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedResponseCopyWith<_FeedResponse> get copyWith => __$FeedResponseCopyWithImpl<_FeedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedResponse&&const DeepCollectionEquality().equals(other._item, _item)&&const DeepCollectionEquality().equals(other.businessCard, businessCard)&&const DeepCollectionEquality().equals(other._floorInfo, _floorInfo)&&(identical(other.userFeature, userFeature) || other.userFeature == userFeature)&&(identical(other.sideBarColumn, sideBarColumn) || other.sideBarColumn == sideBarColumn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_item),const DeepCollectionEquality().hash(businessCard),const DeepCollectionEquality().hash(_floorInfo),userFeature,sideBarColumn);

@override
String toString() {
  return 'FeedResponse(item: $item, businessCard: $businessCard, floorInfo: $floorInfo, userFeature: $userFeature, sideBarColumn: $sideBarColumn)';
}


}

/// @nodoc
abstract mixin class _$FeedResponseCopyWith<$Res> implements $FeedResponseCopyWith<$Res> {
  factory _$FeedResponseCopyWith(_FeedResponse value, $Res Function(_FeedResponse) _then) = __$FeedResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Map<String, dynamic>> item,@JsonKey(name: 'business_card') dynamic businessCard,@JsonKey(name: 'floor_info') List<dynamic> floorInfo,@JsonKey(name: 'user_feature') int userFeature,@JsonKey(name: 'side_bar_column') String sideBarColumn
});




}
/// @nodoc
class __$FeedResponseCopyWithImpl<$Res>
    implements _$FeedResponseCopyWith<$Res> {
  __$FeedResponseCopyWithImpl(this._self, this._then);

  final _FeedResponse _self;
  final $Res Function(_FeedResponse) _then;

/// Create a copy of FeedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? businessCard = freezed,Object? floorInfo = null,Object? userFeature = null,Object? sideBarColumn = null,}) {
  return _then(_FeedResponse(
item: null == item ? _self._item : item // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,businessCard: freezed == businessCard ? _self.businessCard : businessCard // ignore: cast_nullable_to_non_nullable
as dynamic,floorInfo: null == floorInfo ? _self._floorInfo : floorInfo // ignore: cast_nullable_to_non_nullable
as List<dynamic>,userFeature: null == userFeature ? _self.userFeature : userFeature // ignore: cast_nullable_to_non_nullable
as int,sideBarColumn: null == sideBarColumn ? _self.sideBarColumn : sideBarColumn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
