// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trending_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrendingRankingResponse {

 int get code; String get message; int get ttl; TrendingRankingData get data;
/// Create a copy of TrendingRankingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingRankingResponseCopyWith<TrendingRankingResponse> get copyWith => _$TrendingRankingResponseCopyWithImpl<TrendingRankingResponse>(this as TrendingRankingResponse, _$identity);

  /// Serializes this TrendingRankingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingRankingResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,ttl,data);

@override
String toString() {
  return 'TrendingRankingResponse(code: $code, message: $message, ttl: $ttl, data: $data)';
}


}

/// @nodoc
abstract mixin class $TrendingRankingResponseCopyWith<$Res>  {
  factory $TrendingRankingResponseCopyWith(TrendingRankingResponse value, $Res Function(TrendingRankingResponse) _then) = _$TrendingRankingResponseCopyWithImpl;
@useResult
$Res call({
 int code, String message, int ttl, TrendingRankingData data
});


$TrendingRankingDataCopyWith<$Res> get data;

}
/// @nodoc
class _$TrendingRankingResponseCopyWithImpl<$Res>
    implements $TrendingRankingResponseCopyWith<$Res> {
  _$TrendingRankingResponseCopyWithImpl(this._self, this._then);

  final TrendingRankingResponse _self;
  final $Res Function(TrendingRankingResponse) _then;

/// Create a copy of TrendingRankingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? ttl = null,Object? data = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TrendingRankingData,
  ));
}
/// Create a copy of TrendingRankingResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrendingRankingDataCopyWith<$Res> get data {
  
  return $TrendingRankingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrendingRankingResponse].
extension TrendingRankingResponsePatterns on TrendingRankingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingRankingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingRankingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingRankingResponse value)  $default,){
final _that = this;
switch (_that) {
case _TrendingRankingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingRankingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingRankingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message,  int ttl,  TrendingRankingData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingRankingResponse() when $default != null:
return $default(_that.code,_that.message,_that.ttl,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message,  int ttl,  TrendingRankingData data)  $default,) {final _that = this;
switch (_that) {
case _TrendingRankingResponse():
return $default(_that.code,_that.message,_that.ttl,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message,  int ttl,  TrendingRankingData data)?  $default,) {final _that = this;
switch (_that) {
case _TrendingRankingResponse() when $default != null:
return $default(_that.code,_that.message,_that.ttl,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingRankingResponse implements TrendingRankingResponse {
  const _TrendingRankingResponse({required this.code, required this.message, required this.ttl, required this.data});
  factory _TrendingRankingResponse.fromJson(Map<String, dynamic> json) => _$TrendingRankingResponseFromJson(json);

@override final  int code;
@override final  String message;
@override final  int ttl;
@override final  TrendingRankingData data;

/// Create a copy of TrendingRankingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingRankingResponseCopyWith<_TrendingRankingResponse> get copyWith => __$TrendingRankingResponseCopyWithImpl<_TrendingRankingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingRankingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingRankingResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,ttl,data);

@override
String toString() {
  return 'TrendingRankingResponse(code: $code, message: $message, ttl: $ttl, data: $data)';
}


}

/// @nodoc
abstract mixin class _$TrendingRankingResponseCopyWith<$Res> implements $TrendingRankingResponseCopyWith<$Res> {
  factory _$TrendingRankingResponseCopyWith(_TrendingRankingResponse value, $Res Function(_TrendingRankingResponse) _then) = __$TrendingRankingResponseCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, int ttl, TrendingRankingData data
});


@override $TrendingRankingDataCopyWith<$Res> get data;

}
/// @nodoc
class __$TrendingRankingResponseCopyWithImpl<$Res>
    implements _$TrendingRankingResponseCopyWith<$Res> {
  __$TrendingRankingResponseCopyWithImpl(this._self, this._then);

  final _TrendingRankingResponse _self;
  final $Res Function(_TrendingRankingResponse) _then;

/// Create a copy of TrendingRankingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? ttl = null,Object? data = null,}) {
  return _then(_TrendingRankingResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TrendingRankingData,
  ));
}

/// Create a copy of TrendingRankingResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrendingRankingDataCopyWith<$Res> get data {
  
  return $TrendingRankingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$TrendingRankingData {

 String get trackid; List<TrendingItem> get list;@JsonKey(name: 'top_list') List<dynamic> get topList;@JsonKey(name: 'hotword_egg_info') String get hotwordEggInfo;
/// Create a copy of TrendingRankingData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingRankingDataCopyWith<TrendingRankingData> get copyWith => _$TrendingRankingDataCopyWithImpl<TrendingRankingData>(this as TrendingRankingData, _$identity);

  /// Serializes this TrendingRankingData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingRankingData&&(identical(other.trackid, trackid) || other.trackid == trackid)&&const DeepCollectionEquality().equals(other.list, list)&&const DeepCollectionEquality().equals(other.topList, topList)&&(identical(other.hotwordEggInfo, hotwordEggInfo) || other.hotwordEggInfo == hotwordEggInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trackid,const DeepCollectionEquality().hash(list),const DeepCollectionEquality().hash(topList),hotwordEggInfo);

@override
String toString() {
  return 'TrendingRankingData(trackid: $trackid, list: $list, topList: $topList, hotwordEggInfo: $hotwordEggInfo)';
}


}

/// @nodoc
abstract mixin class $TrendingRankingDataCopyWith<$Res>  {
  factory $TrendingRankingDataCopyWith(TrendingRankingData value, $Res Function(TrendingRankingData) _then) = _$TrendingRankingDataCopyWithImpl;
@useResult
$Res call({
 String trackid, List<TrendingItem> list,@JsonKey(name: 'top_list') List<dynamic> topList,@JsonKey(name: 'hotword_egg_info') String hotwordEggInfo
});




}
/// @nodoc
class _$TrendingRankingDataCopyWithImpl<$Res>
    implements $TrendingRankingDataCopyWith<$Res> {
  _$TrendingRankingDataCopyWithImpl(this._self, this._then);

  final TrendingRankingData _self;
  final $Res Function(TrendingRankingData) _then;

/// Create a copy of TrendingRankingData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trackid = null,Object? list = null,Object? topList = null,Object? hotwordEggInfo = null,}) {
  return _then(_self.copyWith(
trackid: null == trackid ? _self.trackid : trackid // ignore: cast_nullable_to_non_nullable
as String,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<TrendingItem>,topList: null == topList ? _self.topList : topList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,hotwordEggInfo: null == hotwordEggInfo ? _self.hotwordEggInfo : hotwordEggInfo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendingRankingData].
extension TrendingRankingDataPatterns on TrendingRankingData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingRankingData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingRankingData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingRankingData value)  $default,){
final _that = this;
switch (_that) {
case _TrendingRankingData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingRankingData value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingRankingData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String trackid,  List<TrendingItem> list, @JsonKey(name: 'top_list')  List<dynamic> topList, @JsonKey(name: 'hotword_egg_info')  String hotwordEggInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingRankingData() when $default != null:
return $default(_that.trackid,_that.list,_that.topList,_that.hotwordEggInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String trackid,  List<TrendingItem> list, @JsonKey(name: 'top_list')  List<dynamic> topList, @JsonKey(name: 'hotword_egg_info')  String hotwordEggInfo)  $default,) {final _that = this;
switch (_that) {
case _TrendingRankingData():
return $default(_that.trackid,_that.list,_that.topList,_that.hotwordEggInfo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String trackid,  List<TrendingItem> list, @JsonKey(name: 'top_list')  List<dynamic> topList, @JsonKey(name: 'hotword_egg_info')  String hotwordEggInfo)?  $default,) {final _that = this;
switch (_that) {
case _TrendingRankingData() when $default != null:
return $default(_that.trackid,_that.list,_that.topList,_that.hotwordEggInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingRankingData implements TrendingRankingData {
  const _TrendingRankingData({required this.trackid, required final  List<TrendingItem> list, @JsonKey(name: 'top_list') required final  List<dynamic> topList, @JsonKey(name: 'hotword_egg_info') required this.hotwordEggInfo}): _list = list,_topList = topList;
  factory _TrendingRankingData.fromJson(Map<String, dynamic> json) => _$TrendingRankingDataFromJson(json);

@override final  String trackid;
 final  List<TrendingItem> _list;
@override List<TrendingItem> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  List<dynamic> _topList;
@override@JsonKey(name: 'top_list') List<dynamic> get topList {
  if (_topList is EqualUnmodifiableListView) return _topList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topList);
}

@override@JsonKey(name: 'hotword_egg_info') final  String hotwordEggInfo;

/// Create a copy of TrendingRankingData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingRankingDataCopyWith<_TrendingRankingData> get copyWith => __$TrendingRankingDataCopyWithImpl<_TrendingRankingData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingRankingDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingRankingData&&(identical(other.trackid, trackid) || other.trackid == trackid)&&const DeepCollectionEquality().equals(other._list, _list)&&const DeepCollectionEquality().equals(other._topList, _topList)&&(identical(other.hotwordEggInfo, hotwordEggInfo) || other.hotwordEggInfo == hotwordEggInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trackid,const DeepCollectionEquality().hash(_list),const DeepCollectionEquality().hash(_topList),hotwordEggInfo);

@override
String toString() {
  return 'TrendingRankingData(trackid: $trackid, list: $list, topList: $topList, hotwordEggInfo: $hotwordEggInfo)';
}


}

/// @nodoc
abstract mixin class _$TrendingRankingDataCopyWith<$Res> implements $TrendingRankingDataCopyWith<$Res> {
  factory _$TrendingRankingDataCopyWith(_TrendingRankingData value, $Res Function(_TrendingRankingData) _then) = __$TrendingRankingDataCopyWithImpl;
@override @useResult
$Res call({
 String trackid, List<TrendingItem> list,@JsonKey(name: 'top_list') List<dynamic> topList,@JsonKey(name: 'hotword_egg_info') String hotwordEggInfo
});




}
/// @nodoc
class __$TrendingRankingDataCopyWithImpl<$Res>
    implements _$TrendingRankingDataCopyWith<$Res> {
  __$TrendingRankingDataCopyWithImpl(this._self, this._then);

  final _TrendingRankingData _self;
  final $Res Function(_TrendingRankingData) _then;

/// Create a copy of TrendingRankingData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trackid = null,Object? list = null,Object? topList = null,Object? hotwordEggInfo = null,}) {
  return _then(_TrendingRankingData(
trackid: null == trackid ? _self.trackid : trackid // ignore: cast_nullable_to_non_nullable
as String,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<TrendingItem>,topList: null == topList ? _self._topList : topList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,hotwordEggInfo: null == hotwordEggInfo ? _self.hotwordEggInfo : hotwordEggInfo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TrendingItem {

 int get position; String get keyword;@JsonKey(name: 'show_name') String get showName;@JsonKey(name: 'word_type') int get wordType; String? get icon;@JsonKey(name: 'hot_id') int get hotId;@JsonKey(name: 'is_commercial') String? get isCommercial;@JsonKey(name: 'resource_id') int? get resourceId;@JsonKey(name: 'show_live_icon') bool? get showLiveIcon;
/// Create a copy of TrendingItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingItemCopyWith<TrendingItem> get copyWith => _$TrendingItemCopyWithImpl<TrendingItem>(this as TrendingItem, _$identity);

  /// Serializes this TrendingItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingItem&&(identical(other.position, position) || other.position == position)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.showName, showName) || other.showName == showName)&&(identical(other.wordType, wordType) || other.wordType == wordType)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.hotId, hotId) || other.hotId == hotId)&&(identical(other.isCommercial, isCommercial) || other.isCommercial == isCommercial)&&(identical(other.resourceId, resourceId) || other.resourceId == resourceId)&&(identical(other.showLiveIcon, showLiveIcon) || other.showLiveIcon == showLiveIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,keyword,showName,wordType,icon,hotId,isCommercial,resourceId,showLiveIcon);

@override
String toString() {
  return 'TrendingItem(position: $position, keyword: $keyword, showName: $showName, wordType: $wordType, icon: $icon, hotId: $hotId, isCommercial: $isCommercial, resourceId: $resourceId, showLiveIcon: $showLiveIcon)';
}


}

/// @nodoc
abstract mixin class $TrendingItemCopyWith<$Res>  {
  factory $TrendingItemCopyWith(TrendingItem value, $Res Function(TrendingItem) _then) = _$TrendingItemCopyWithImpl;
@useResult
$Res call({
 int position, String keyword,@JsonKey(name: 'show_name') String showName,@JsonKey(name: 'word_type') int wordType, String? icon,@JsonKey(name: 'hot_id') int hotId,@JsonKey(name: 'is_commercial') String? isCommercial,@JsonKey(name: 'resource_id') int? resourceId,@JsonKey(name: 'show_live_icon') bool? showLiveIcon
});




}
/// @nodoc
class _$TrendingItemCopyWithImpl<$Res>
    implements $TrendingItemCopyWith<$Res> {
  _$TrendingItemCopyWithImpl(this._self, this._then);

  final TrendingItem _self;
  final $Res Function(TrendingItem) _then;

/// Create a copy of TrendingItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? keyword = null,Object? showName = null,Object? wordType = null,Object? icon = freezed,Object? hotId = null,Object? isCommercial = freezed,Object? resourceId = freezed,Object? showLiveIcon = freezed,}) {
  return _then(_self.copyWith(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,showName: null == showName ? _self.showName : showName // ignore: cast_nullable_to_non_nullable
as String,wordType: null == wordType ? _self.wordType : wordType // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,hotId: null == hotId ? _self.hotId : hotId // ignore: cast_nullable_to_non_nullable
as int,isCommercial: freezed == isCommercial ? _self.isCommercial : isCommercial // ignore: cast_nullable_to_non_nullable
as String?,resourceId: freezed == resourceId ? _self.resourceId : resourceId // ignore: cast_nullable_to_non_nullable
as int?,showLiveIcon: freezed == showLiveIcon ? _self.showLiveIcon : showLiveIcon // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendingItem].
extension TrendingItemPatterns on TrendingItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingItem value)  $default,){
final _that = this;
switch (_that) {
case _TrendingItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingItem value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int position,  String keyword, @JsonKey(name: 'show_name')  String showName, @JsonKey(name: 'word_type')  int wordType,  String? icon, @JsonKey(name: 'hot_id')  int hotId, @JsonKey(name: 'is_commercial')  String? isCommercial, @JsonKey(name: 'resource_id')  int? resourceId, @JsonKey(name: 'show_live_icon')  bool? showLiveIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingItem() when $default != null:
return $default(_that.position,_that.keyword,_that.showName,_that.wordType,_that.icon,_that.hotId,_that.isCommercial,_that.resourceId,_that.showLiveIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int position,  String keyword, @JsonKey(name: 'show_name')  String showName, @JsonKey(name: 'word_type')  int wordType,  String? icon, @JsonKey(name: 'hot_id')  int hotId, @JsonKey(name: 'is_commercial')  String? isCommercial, @JsonKey(name: 'resource_id')  int? resourceId, @JsonKey(name: 'show_live_icon')  bool? showLiveIcon)  $default,) {final _that = this;
switch (_that) {
case _TrendingItem():
return $default(_that.position,_that.keyword,_that.showName,_that.wordType,_that.icon,_that.hotId,_that.isCommercial,_that.resourceId,_that.showLiveIcon);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int position,  String keyword, @JsonKey(name: 'show_name')  String showName, @JsonKey(name: 'word_type')  int wordType,  String? icon, @JsonKey(name: 'hot_id')  int hotId, @JsonKey(name: 'is_commercial')  String? isCommercial, @JsonKey(name: 'resource_id')  int? resourceId, @JsonKey(name: 'show_live_icon')  bool? showLiveIcon)?  $default,) {final _that = this;
switch (_that) {
case _TrendingItem() when $default != null:
return $default(_that.position,_that.keyword,_that.showName,_that.wordType,_that.icon,_that.hotId,_that.isCommercial,_that.resourceId,_that.showLiveIcon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingItem implements TrendingItem {
  const _TrendingItem({required this.position, required this.keyword, @JsonKey(name: 'show_name') required this.showName, @JsonKey(name: 'word_type') required this.wordType, this.icon, @JsonKey(name: 'hot_id') required this.hotId, @JsonKey(name: 'is_commercial') this.isCommercial, @JsonKey(name: 'resource_id') this.resourceId, @JsonKey(name: 'show_live_icon') this.showLiveIcon});
  factory _TrendingItem.fromJson(Map<String, dynamic> json) => _$TrendingItemFromJson(json);

@override final  int position;
@override final  String keyword;
@override@JsonKey(name: 'show_name') final  String showName;
@override@JsonKey(name: 'word_type') final  int wordType;
@override final  String? icon;
@override@JsonKey(name: 'hot_id') final  int hotId;
@override@JsonKey(name: 'is_commercial') final  String? isCommercial;
@override@JsonKey(name: 'resource_id') final  int? resourceId;
@override@JsonKey(name: 'show_live_icon') final  bool? showLiveIcon;

/// Create a copy of TrendingItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingItemCopyWith<_TrendingItem> get copyWith => __$TrendingItemCopyWithImpl<_TrendingItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingItem&&(identical(other.position, position) || other.position == position)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.showName, showName) || other.showName == showName)&&(identical(other.wordType, wordType) || other.wordType == wordType)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.hotId, hotId) || other.hotId == hotId)&&(identical(other.isCommercial, isCommercial) || other.isCommercial == isCommercial)&&(identical(other.resourceId, resourceId) || other.resourceId == resourceId)&&(identical(other.showLiveIcon, showLiveIcon) || other.showLiveIcon == showLiveIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,keyword,showName,wordType,icon,hotId,isCommercial,resourceId,showLiveIcon);

@override
String toString() {
  return 'TrendingItem(position: $position, keyword: $keyword, showName: $showName, wordType: $wordType, icon: $icon, hotId: $hotId, isCommercial: $isCommercial, resourceId: $resourceId, showLiveIcon: $showLiveIcon)';
}


}

/// @nodoc
abstract mixin class _$TrendingItemCopyWith<$Res> implements $TrendingItemCopyWith<$Res> {
  factory _$TrendingItemCopyWith(_TrendingItem value, $Res Function(_TrendingItem) _then) = __$TrendingItemCopyWithImpl;
@override @useResult
$Res call({
 int position, String keyword,@JsonKey(name: 'show_name') String showName,@JsonKey(name: 'word_type') int wordType, String? icon,@JsonKey(name: 'hot_id') int hotId,@JsonKey(name: 'is_commercial') String? isCommercial,@JsonKey(name: 'resource_id') int? resourceId,@JsonKey(name: 'show_live_icon') bool? showLiveIcon
});




}
/// @nodoc
class __$TrendingItemCopyWithImpl<$Res>
    implements _$TrendingItemCopyWith<$Res> {
  __$TrendingItemCopyWithImpl(this._self, this._then);

  final _TrendingItem _self;
  final $Res Function(_TrendingItem) _then;

/// Create a copy of TrendingItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? keyword = null,Object? showName = null,Object? wordType = null,Object? icon = freezed,Object? hotId = null,Object? isCommercial = freezed,Object? resourceId = freezed,Object? showLiveIcon = freezed,}) {
  return _then(_TrendingItem(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,showName: null == showName ? _self.showName : showName // ignore: cast_nullable_to_non_nullable
as String,wordType: null == wordType ? _self.wordType : wordType // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,hotId: null == hotId ? _self.hotId : hotId // ignore: cast_nullable_to_non_nullable
as int,isCommercial: freezed == isCommercial ? _self.isCommercial : isCommercial // ignore: cast_nullable_to_non_nullable
as String?,resourceId: freezed == resourceId ? _self.resourceId : resourceId // ignore: cast_nullable_to_non_nullable
as int?,showLiveIcon: freezed == showLiveIcon ? _self.showLiveIcon : showLiveIcon // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
