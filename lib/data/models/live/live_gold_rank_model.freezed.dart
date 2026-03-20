// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_gold_rank_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveGoldRankModel {

@JsonKey(name: 'onlineNum') int get onlineNum;@JsonKey(name: 'OnlineRankItem') List<LiveRankItem> get list;
/// Create a copy of LiveGoldRankModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGoldRankModelCopyWith<LiveGoldRankModel> get copyWith => _$LiveGoldRankModelCopyWithImpl<LiveGoldRankModel>(this as LiveGoldRankModel, _$identity);

  /// Serializes this LiveGoldRankModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGoldRankModel&&(identical(other.onlineNum, onlineNum) || other.onlineNum == onlineNum)&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,onlineNum,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'LiveGoldRankModel(onlineNum: $onlineNum, list: $list)';
}


}

/// @nodoc
abstract mixin class $LiveGoldRankModelCopyWith<$Res>  {
  factory $LiveGoldRankModelCopyWith(LiveGoldRankModel value, $Res Function(LiveGoldRankModel) _then) = _$LiveGoldRankModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'onlineNum') int onlineNum,@JsonKey(name: 'OnlineRankItem') List<LiveRankItem> list
});




}
/// @nodoc
class _$LiveGoldRankModelCopyWithImpl<$Res>
    implements $LiveGoldRankModelCopyWith<$Res> {
  _$LiveGoldRankModelCopyWithImpl(this._self, this._then);

  final LiveGoldRankModel _self;
  final $Res Function(LiveGoldRankModel) _then;

/// Create a copy of LiveGoldRankModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onlineNum = null,Object? list = null,}) {
  return _then(_self.copyWith(
onlineNum: null == onlineNum ? _self.onlineNum : onlineNum // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<LiveRankItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveGoldRankModel].
extension LiveGoldRankModelPatterns on LiveGoldRankModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGoldRankModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGoldRankModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGoldRankModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveGoldRankModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGoldRankModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGoldRankModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'onlineNum')  int onlineNum, @JsonKey(name: 'OnlineRankItem')  List<LiveRankItem> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGoldRankModel() when $default != null:
return $default(_that.onlineNum,_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'onlineNum')  int onlineNum, @JsonKey(name: 'OnlineRankItem')  List<LiveRankItem> list)  $default,) {final _that = this;
switch (_that) {
case _LiveGoldRankModel():
return $default(_that.onlineNum,_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'onlineNum')  int onlineNum, @JsonKey(name: 'OnlineRankItem')  List<LiveRankItem> list)?  $default,) {final _that = this;
switch (_that) {
case _LiveGoldRankModel() when $default != null:
return $default(_that.onlineNum,_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGoldRankModel implements LiveGoldRankModel {
  const _LiveGoldRankModel({@JsonKey(name: 'onlineNum') required this.onlineNum, @JsonKey(name: 'OnlineRankItem') required final  List<LiveRankItem> list}): _list = list;
  factory _LiveGoldRankModel.fromJson(Map<String, dynamic> json) => _$LiveGoldRankModelFromJson(json);

@override@JsonKey(name: 'onlineNum') final  int onlineNum;
 final  List<LiveRankItem> _list;
@override@JsonKey(name: 'OnlineRankItem') List<LiveRankItem> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of LiveGoldRankModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGoldRankModelCopyWith<_LiveGoldRankModel> get copyWith => __$LiveGoldRankModelCopyWithImpl<_LiveGoldRankModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGoldRankModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGoldRankModel&&(identical(other.onlineNum, onlineNum) || other.onlineNum == onlineNum)&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,onlineNum,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'LiveGoldRankModel(onlineNum: $onlineNum, list: $list)';
}


}

/// @nodoc
abstract mixin class _$LiveGoldRankModelCopyWith<$Res> implements $LiveGoldRankModelCopyWith<$Res> {
  factory _$LiveGoldRankModelCopyWith(_LiveGoldRankModel value, $Res Function(_LiveGoldRankModel) _then) = __$LiveGoldRankModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'onlineNum') int onlineNum,@JsonKey(name: 'OnlineRankItem') List<LiveRankItem> list
});




}
/// @nodoc
class __$LiveGoldRankModelCopyWithImpl<$Res>
    implements _$LiveGoldRankModelCopyWith<$Res> {
  __$LiveGoldRankModelCopyWithImpl(this._self, this._then);

  final _LiveGoldRankModel _self;
  final $Res Function(_LiveGoldRankModel) _then;

/// Create a copy of LiveGoldRankModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onlineNum = null,Object? list = null,}) {
  return _then(_LiveGoldRankModel(
onlineNum: null == onlineNum ? _self.onlineNum : onlineNum // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<LiveRankItem>,
  ));
}


}


/// @nodoc
mixin _$LiveRankItem {

 int get userRank; int get uid; String get name; String get face; int get score; LiveRankMedalInfo get medalInfo;@JsonKey(name: 'guard_level') int get guardLevel;@JsonKey(name: 'wealth_level') int get wealthLevel;
/// Create a copy of LiveRankItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRankItemCopyWith<LiveRankItem> get copyWith => _$LiveRankItemCopyWithImpl<LiveRankItem>(this as LiveRankItem, _$identity);

  /// Serializes this LiveRankItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRankItem&&(identical(other.userRank, userRank) || other.userRank == userRank)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face)&&(identical(other.score, score) || other.score == score)&&(identical(other.medalInfo, medalInfo) || other.medalInfo == medalInfo)&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel)&&(identical(other.wealthLevel, wealthLevel) || other.wealthLevel == wealthLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userRank,uid,name,face,score,medalInfo,guardLevel,wealthLevel);

@override
String toString() {
  return 'LiveRankItem(userRank: $userRank, uid: $uid, name: $name, face: $face, score: $score, medalInfo: $medalInfo, guardLevel: $guardLevel, wealthLevel: $wealthLevel)';
}


}

/// @nodoc
abstract mixin class $LiveRankItemCopyWith<$Res>  {
  factory $LiveRankItemCopyWith(LiveRankItem value, $Res Function(LiveRankItem) _then) = _$LiveRankItemCopyWithImpl;
@useResult
$Res call({
 int userRank, int uid, String name, String face, int score, LiveRankMedalInfo medalInfo,@JsonKey(name: 'guard_level') int guardLevel,@JsonKey(name: 'wealth_level') int wealthLevel
});


$LiveRankMedalInfoCopyWith<$Res> get medalInfo;

}
/// @nodoc
class _$LiveRankItemCopyWithImpl<$Res>
    implements $LiveRankItemCopyWith<$Res> {
  _$LiveRankItemCopyWithImpl(this._self, this._then);

  final LiveRankItem _self;
  final $Res Function(LiveRankItem) _then;

/// Create a copy of LiveRankItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userRank = null,Object? uid = null,Object? name = null,Object? face = null,Object? score = null,Object? medalInfo = null,Object? guardLevel = null,Object? wealthLevel = null,}) {
  return _then(_self.copyWith(
userRank: null == userRank ? _self.userRank : userRank // ignore: cast_nullable_to_non_nullable
as int,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,medalInfo: null == medalInfo ? _self.medalInfo : medalInfo // ignore: cast_nullable_to_non_nullable
as LiveRankMedalInfo,guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,wealthLevel: null == wealthLevel ? _self.wealthLevel : wealthLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LiveRankItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveRankMedalInfoCopyWith<$Res> get medalInfo {
  
  return $LiveRankMedalInfoCopyWith<$Res>(_self.medalInfo, (value) {
    return _then(_self.copyWith(medalInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveRankItem].
extension LiveRankItemPatterns on LiveRankItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRankItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRankItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRankItem value)  $default,){
final _that = this;
switch (_that) {
case _LiveRankItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRankItem value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRankItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userRank,  int uid,  String name,  String face,  int score,  LiveRankMedalInfo medalInfo, @JsonKey(name: 'guard_level')  int guardLevel, @JsonKey(name: 'wealth_level')  int wealthLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRankItem() when $default != null:
return $default(_that.userRank,_that.uid,_that.name,_that.face,_that.score,_that.medalInfo,_that.guardLevel,_that.wealthLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userRank,  int uid,  String name,  String face,  int score,  LiveRankMedalInfo medalInfo, @JsonKey(name: 'guard_level')  int guardLevel, @JsonKey(name: 'wealth_level')  int wealthLevel)  $default,) {final _that = this;
switch (_that) {
case _LiveRankItem():
return $default(_that.userRank,_that.uid,_that.name,_that.face,_that.score,_that.medalInfo,_that.guardLevel,_that.wealthLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userRank,  int uid,  String name,  String face,  int score,  LiveRankMedalInfo medalInfo, @JsonKey(name: 'guard_level')  int guardLevel, @JsonKey(name: 'wealth_level')  int wealthLevel)?  $default,) {final _that = this;
switch (_that) {
case _LiveRankItem() when $default != null:
return $default(_that.userRank,_that.uid,_that.name,_that.face,_that.score,_that.medalInfo,_that.guardLevel,_that.wealthLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveRankItem implements LiveRankItem {
  const _LiveRankItem({required this.userRank, required this.uid, required this.name, required this.face, required this.score, required this.medalInfo, @JsonKey(name: 'guard_level') required this.guardLevel, @JsonKey(name: 'wealth_level') required this.wealthLevel});
  factory _LiveRankItem.fromJson(Map<String, dynamic> json) => _$LiveRankItemFromJson(json);

@override final  int userRank;
@override final  int uid;
@override final  String name;
@override final  String face;
@override final  int score;
@override final  LiveRankMedalInfo medalInfo;
@override@JsonKey(name: 'guard_level') final  int guardLevel;
@override@JsonKey(name: 'wealth_level') final  int wealthLevel;

/// Create a copy of LiveRankItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRankItemCopyWith<_LiveRankItem> get copyWith => __$LiveRankItemCopyWithImpl<_LiveRankItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveRankItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRankItem&&(identical(other.userRank, userRank) || other.userRank == userRank)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face)&&(identical(other.score, score) || other.score == score)&&(identical(other.medalInfo, medalInfo) || other.medalInfo == medalInfo)&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel)&&(identical(other.wealthLevel, wealthLevel) || other.wealthLevel == wealthLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userRank,uid,name,face,score,medalInfo,guardLevel,wealthLevel);

@override
String toString() {
  return 'LiveRankItem(userRank: $userRank, uid: $uid, name: $name, face: $face, score: $score, medalInfo: $medalInfo, guardLevel: $guardLevel, wealthLevel: $wealthLevel)';
}


}

/// @nodoc
abstract mixin class _$LiveRankItemCopyWith<$Res> implements $LiveRankItemCopyWith<$Res> {
  factory _$LiveRankItemCopyWith(_LiveRankItem value, $Res Function(_LiveRankItem) _then) = __$LiveRankItemCopyWithImpl;
@override @useResult
$Res call({
 int userRank, int uid, String name, String face, int score, LiveRankMedalInfo medalInfo,@JsonKey(name: 'guard_level') int guardLevel,@JsonKey(name: 'wealth_level') int wealthLevel
});


@override $LiveRankMedalInfoCopyWith<$Res> get medalInfo;

}
/// @nodoc
class __$LiveRankItemCopyWithImpl<$Res>
    implements _$LiveRankItemCopyWith<$Res> {
  __$LiveRankItemCopyWithImpl(this._self, this._then);

  final _LiveRankItem _self;
  final $Res Function(_LiveRankItem) _then;

/// Create a copy of LiveRankItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userRank = null,Object? uid = null,Object? name = null,Object? face = null,Object? score = null,Object? medalInfo = null,Object? guardLevel = null,Object? wealthLevel = null,}) {
  return _then(_LiveRankItem(
userRank: null == userRank ? _self.userRank : userRank // ignore: cast_nullable_to_non_nullable
as int,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,medalInfo: null == medalInfo ? _self.medalInfo : medalInfo // ignore: cast_nullable_to_non_nullable
as LiveRankMedalInfo,guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,wealthLevel: null == wealthLevel ? _self.wealthLevel : wealthLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LiveRankItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveRankMedalInfoCopyWith<$Res> get medalInfo {
  
  return $LiveRankMedalInfoCopyWith<$Res>(_self.medalInfo, (value) {
    return _then(_self.copyWith(medalInfo: value));
  });
}
}


/// @nodoc
mixin _$LiveRankMedalInfo {

 int get guardLevel; int get medalColorStart; int get medalColorEnd; int get medalColorBorder; String get medalName; int get level; int get targetId; int get isLight;
/// Create a copy of LiveRankMedalInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRankMedalInfoCopyWith<LiveRankMedalInfo> get copyWith => _$LiveRankMedalInfoCopyWithImpl<LiveRankMedalInfo>(this as LiveRankMedalInfo, _$identity);

  /// Serializes this LiveRankMedalInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRankMedalInfo&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel)&&(identical(other.medalColorStart, medalColorStart) || other.medalColorStart == medalColorStart)&&(identical(other.medalColorEnd, medalColorEnd) || other.medalColorEnd == medalColorEnd)&&(identical(other.medalColorBorder, medalColorBorder) || other.medalColorBorder == medalColorBorder)&&(identical(other.medalName, medalName) || other.medalName == medalName)&&(identical(other.level, level) || other.level == level)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.isLight, isLight) || other.isLight == isLight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,guardLevel,medalColorStart,medalColorEnd,medalColorBorder,medalName,level,targetId,isLight);

@override
String toString() {
  return 'LiveRankMedalInfo(guardLevel: $guardLevel, medalColorStart: $medalColorStart, medalColorEnd: $medalColorEnd, medalColorBorder: $medalColorBorder, medalName: $medalName, level: $level, targetId: $targetId, isLight: $isLight)';
}


}

/// @nodoc
abstract mixin class $LiveRankMedalInfoCopyWith<$Res>  {
  factory $LiveRankMedalInfoCopyWith(LiveRankMedalInfo value, $Res Function(LiveRankMedalInfo) _then) = _$LiveRankMedalInfoCopyWithImpl;
@useResult
$Res call({
 int guardLevel, int medalColorStart, int medalColorEnd, int medalColorBorder, String medalName, int level, int targetId, int isLight
});




}
/// @nodoc
class _$LiveRankMedalInfoCopyWithImpl<$Res>
    implements $LiveRankMedalInfoCopyWith<$Res> {
  _$LiveRankMedalInfoCopyWithImpl(this._self, this._then);

  final LiveRankMedalInfo _self;
  final $Res Function(LiveRankMedalInfo) _then;

/// Create a copy of LiveRankMedalInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? guardLevel = null,Object? medalColorStart = null,Object? medalColorEnd = null,Object? medalColorBorder = null,Object? medalName = null,Object? level = null,Object? targetId = null,Object? isLight = null,}) {
  return _then(_self.copyWith(
guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,medalColorStart: null == medalColorStart ? _self.medalColorStart : medalColorStart // ignore: cast_nullable_to_non_nullable
as int,medalColorEnd: null == medalColorEnd ? _self.medalColorEnd : medalColorEnd // ignore: cast_nullable_to_non_nullable
as int,medalColorBorder: null == medalColorBorder ? _self.medalColorBorder : medalColorBorder // ignore: cast_nullable_to_non_nullable
as int,medalName: null == medalName ? _self.medalName : medalName // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as int,isLight: null == isLight ? _self.isLight : isLight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveRankMedalInfo].
extension LiveRankMedalInfoPatterns on LiveRankMedalInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRankMedalInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRankMedalInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRankMedalInfo value)  $default,){
final _that = this;
switch (_that) {
case _LiveRankMedalInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRankMedalInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRankMedalInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int guardLevel,  int medalColorStart,  int medalColorEnd,  int medalColorBorder,  String medalName,  int level,  int targetId,  int isLight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRankMedalInfo() when $default != null:
return $default(_that.guardLevel,_that.medalColorStart,_that.medalColorEnd,_that.medalColorBorder,_that.medalName,_that.level,_that.targetId,_that.isLight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int guardLevel,  int medalColorStart,  int medalColorEnd,  int medalColorBorder,  String medalName,  int level,  int targetId,  int isLight)  $default,) {final _that = this;
switch (_that) {
case _LiveRankMedalInfo():
return $default(_that.guardLevel,_that.medalColorStart,_that.medalColorEnd,_that.medalColorBorder,_that.medalName,_that.level,_that.targetId,_that.isLight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int guardLevel,  int medalColorStart,  int medalColorEnd,  int medalColorBorder,  String medalName,  int level,  int targetId,  int isLight)?  $default,) {final _that = this;
switch (_that) {
case _LiveRankMedalInfo() when $default != null:
return $default(_that.guardLevel,_that.medalColorStart,_that.medalColorEnd,_that.medalColorBorder,_that.medalName,_that.level,_that.targetId,_that.isLight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveRankMedalInfo implements LiveRankMedalInfo {
  const _LiveRankMedalInfo({required this.guardLevel, required this.medalColorStart, required this.medalColorEnd, required this.medalColorBorder, required this.medalName, required this.level, required this.targetId, required this.isLight});
  factory _LiveRankMedalInfo.fromJson(Map<String, dynamic> json) => _$LiveRankMedalInfoFromJson(json);

@override final  int guardLevel;
@override final  int medalColorStart;
@override final  int medalColorEnd;
@override final  int medalColorBorder;
@override final  String medalName;
@override final  int level;
@override final  int targetId;
@override final  int isLight;

/// Create a copy of LiveRankMedalInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRankMedalInfoCopyWith<_LiveRankMedalInfo> get copyWith => __$LiveRankMedalInfoCopyWithImpl<_LiveRankMedalInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveRankMedalInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRankMedalInfo&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel)&&(identical(other.medalColorStart, medalColorStart) || other.medalColorStart == medalColorStart)&&(identical(other.medalColorEnd, medalColorEnd) || other.medalColorEnd == medalColorEnd)&&(identical(other.medalColorBorder, medalColorBorder) || other.medalColorBorder == medalColorBorder)&&(identical(other.medalName, medalName) || other.medalName == medalName)&&(identical(other.level, level) || other.level == level)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.isLight, isLight) || other.isLight == isLight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,guardLevel,medalColorStart,medalColorEnd,medalColorBorder,medalName,level,targetId,isLight);

@override
String toString() {
  return 'LiveRankMedalInfo(guardLevel: $guardLevel, medalColorStart: $medalColorStart, medalColorEnd: $medalColorEnd, medalColorBorder: $medalColorBorder, medalName: $medalName, level: $level, targetId: $targetId, isLight: $isLight)';
}


}

/// @nodoc
abstract mixin class _$LiveRankMedalInfoCopyWith<$Res> implements $LiveRankMedalInfoCopyWith<$Res> {
  factory _$LiveRankMedalInfoCopyWith(_LiveRankMedalInfo value, $Res Function(_LiveRankMedalInfo) _then) = __$LiveRankMedalInfoCopyWithImpl;
@override @useResult
$Res call({
 int guardLevel, int medalColorStart, int medalColorEnd, int medalColorBorder, String medalName, int level, int targetId, int isLight
});




}
/// @nodoc
class __$LiveRankMedalInfoCopyWithImpl<$Res>
    implements _$LiveRankMedalInfoCopyWith<$Res> {
  __$LiveRankMedalInfoCopyWithImpl(this._self, this._then);

  final _LiveRankMedalInfo _self;
  final $Res Function(_LiveRankMedalInfo) _then;

/// Create a copy of LiveRankMedalInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? guardLevel = null,Object? medalColorStart = null,Object? medalColorEnd = null,Object? medalColorBorder = null,Object? medalName = null,Object? level = null,Object? targetId = null,Object? isLight = null,}) {
  return _then(_LiveRankMedalInfo(
guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,medalColorStart: null == medalColorStart ? _self.medalColorStart : medalColorStart // ignore: cast_nullable_to_non_nullable
as int,medalColorEnd: null == medalColorEnd ? _self.medalColorEnd : medalColorEnd // ignore: cast_nullable_to_non_nullable
as int,medalColorBorder: null == medalColorBorder ? _self.medalColorBorder : medalColorBorder // ignore: cast_nullable_to_non_nullable
as int,medalName: null == medalName ? _self.medalName : medalName // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as int,isLight: null == isLight ? _self.isLight : isLight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
