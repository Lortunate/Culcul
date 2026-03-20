// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_guard_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveGuardListModel {

 LiveGuardInfo get info; List<LiveGuardItem> get top3; List<LiveGuardItem> get list;
/// Create a copy of LiveGuardListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGuardListModelCopyWith<LiveGuardListModel> get copyWith => _$LiveGuardListModelCopyWithImpl<LiveGuardListModel>(this as LiveGuardListModel, _$identity);

  /// Serializes this LiveGuardListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGuardListModel&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other.top3, top3)&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(top3),const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'LiveGuardListModel(info: $info, top3: $top3, list: $list)';
}


}

/// @nodoc
abstract mixin class $LiveGuardListModelCopyWith<$Res>  {
  factory $LiveGuardListModelCopyWith(LiveGuardListModel value, $Res Function(LiveGuardListModel) _then) = _$LiveGuardListModelCopyWithImpl;
@useResult
$Res call({
 LiveGuardInfo info, List<LiveGuardItem> top3, List<LiveGuardItem> list
});


$LiveGuardInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$LiveGuardListModelCopyWithImpl<$Res>
    implements $LiveGuardListModelCopyWith<$Res> {
  _$LiveGuardListModelCopyWithImpl(this._self, this._then);

  final LiveGuardListModel _self;
  final $Res Function(LiveGuardListModel) _then;

/// Create a copy of LiveGuardListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? top3 = null,Object? list = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as LiveGuardInfo,top3: null == top3 ? _self.top3 : top3 // ignore: cast_nullable_to_non_nullable
as List<LiveGuardItem>,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<LiveGuardItem>,
  ));
}
/// Create a copy of LiveGuardListModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardInfoCopyWith<$Res> get info {
  
  return $LiveGuardInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveGuardListModel].
extension LiveGuardListModelPatterns on LiveGuardListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGuardListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGuardListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGuardListModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveGuardListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGuardListModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGuardListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiveGuardInfo info,  List<LiveGuardItem> top3,  List<LiveGuardItem> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGuardListModel() when $default != null:
return $default(_that.info,_that.top3,_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiveGuardInfo info,  List<LiveGuardItem> top3,  List<LiveGuardItem> list)  $default,) {final _that = this;
switch (_that) {
case _LiveGuardListModel():
return $default(_that.info,_that.top3,_that.list);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiveGuardInfo info,  List<LiveGuardItem> top3,  List<LiveGuardItem> list)?  $default,) {final _that = this;
switch (_that) {
case _LiveGuardListModel() when $default != null:
return $default(_that.info,_that.top3,_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGuardListModel implements LiveGuardListModel {
  const _LiveGuardListModel({required this.info, final  List<LiveGuardItem> top3 = const [], final  List<LiveGuardItem> list = const []}): _top3 = top3,_list = list;
  factory _LiveGuardListModel.fromJson(Map<String, dynamic> json) => _$LiveGuardListModelFromJson(json);

@override final  LiveGuardInfo info;
 final  List<LiveGuardItem> _top3;
@override@JsonKey() List<LiveGuardItem> get top3 {
  if (_top3 is EqualUnmodifiableListView) return _top3;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_top3);
}

 final  List<LiveGuardItem> _list;
@override@JsonKey() List<LiveGuardItem> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of LiveGuardListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGuardListModelCopyWith<_LiveGuardListModel> get copyWith => __$LiveGuardListModelCopyWithImpl<_LiveGuardListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGuardListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGuardListModel&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other._top3, _top3)&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(_top3),const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'LiveGuardListModel(info: $info, top3: $top3, list: $list)';
}


}

/// @nodoc
abstract mixin class _$LiveGuardListModelCopyWith<$Res> implements $LiveGuardListModelCopyWith<$Res> {
  factory _$LiveGuardListModelCopyWith(_LiveGuardListModel value, $Res Function(_LiveGuardListModel) _then) = __$LiveGuardListModelCopyWithImpl;
@override @useResult
$Res call({
 LiveGuardInfo info, List<LiveGuardItem> top3, List<LiveGuardItem> list
});


@override $LiveGuardInfoCopyWith<$Res> get info;

}
/// @nodoc
class __$LiveGuardListModelCopyWithImpl<$Res>
    implements _$LiveGuardListModelCopyWith<$Res> {
  __$LiveGuardListModelCopyWithImpl(this._self, this._then);

  final _LiveGuardListModel _self;
  final $Res Function(_LiveGuardListModel) _then;

/// Create a copy of LiveGuardListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? top3 = null,Object? list = null,}) {
  return _then(_LiveGuardListModel(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as LiveGuardInfo,top3: null == top3 ? _self._top3 : top3 // ignore: cast_nullable_to_non_nullable
as List<LiveGuardItem>,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<LiveGuardItem>,
  ));
}

/// Create a copy of LiveGuardListModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardInfoCopyWith<$Res> get info {
  
  return $LiveGuardInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// @nodoc
mixin _$LiveGuardInfo {

 int get num; int get page; int get now;
/// Create a copy of LiveGuardInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGuardInfoCopyWith<LiveGuardInfo> get copyWith => _$LiveGuardInfoCopyWithImpl<LiveGuardInfo>(this as LiveGuardInfo, _$identity);

  /// Serializes this LiveGuardInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGuardInfo&&(identical(other.num, num) || other.num == num)&&(identical(other.page, page) || other.page == page)&&(identical(other.now, now) || other.now == now));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,num,page,now);

@override
String toString() {
  return 'LiveGuardInfo(num: $num, page: $page, now: $now)';
}


}

/// @nodoc
abstract mixin class $LiveGuardInfoCopyWith<$Res>  {
  factory $LiveGuardInfoCopyWith(LiveGuardInfo value, $Res Function(LiveGuardInfo) _then) = _$LiveGuardInfoCopyWithImpl;
@useResult
$Res call({
 int num, int page, int now
});




}
/// @nodoc
class _$LiveGuardInfoCopyWithImpl<$Res>
    implements $LiveGuardInfoCopyWith<$Res> {
  _$LiveGuardInfoCopyWithImpl(this._self, this._then);

  final LiveGuardInfo _self;
  final $Res Function(LiveGuardInfo) _then;

/// Create a copy of LiveGuardInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? num = null,Object? page = null,Object? now = null,}) {
  return _then(_self.copyWith(
num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveGuardInfo].
extension LiveGuardInfoPatterns on LiveGuardInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGuardInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGuardInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGuardInfo value)  $default,){
final _that = this;
switch (_that) {
case _LiveGuardInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGuardInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGuardInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int num,  int page,  int now)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGuardInfo() when $default != null:
return $default(_that.num,_that.page,_that.now);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int num,  int page,  int now)  $default,) {final _that = this;
switch (_that) {
case _LiveGuardInfo():
return $default(_that.num,_that.page,_that.now);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int num,  int page,  int now)?  $default,) {final _that = this;
switch (_that) {
case _LiveGuardInfo() when $default != null:
return $default(_that.num,_that.page,_that.now);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGuardInfo implements LiveGuardInfo {
  const _LiveGuardInfo({required this.num, required this.page, required this.now});
  factory _LiveGuardInfo.fromJson(Map<String, dynamic> json) => _$LiveGuardInfoFromJson(json);

@override final  int num;
@override final  int page;
@override final  int now;

/// Create a copy of LiveGuardInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGuardInfoCopyWith<_LiveGuardInfo> get copyWith => __$LiveGuardInfoCopyWithImpl<_LiveGuardInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGuardInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGuardInfo&&(identical(other.num, num) || other.num == num)&&(identical(other.page, page) || other.page == page)&&(identical(other.now, now) || other.now == now));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,num,page,now);

@override
String toString() {
  return 'LiveGuardInfo(num: $num, page: $page, now: $now)';
}


}

/// @nodoc
abstract mixin class _$LiveGuardInfoCopyWith<$Res> implements $LiveGuardInfoCopyWith<$Res> {
  factory _$LiveGuardInfoCopyWith(_LiveGuardInfo value, $Res Function(_LiveGuardInfo) _then) = __$LiveGuardInfoCopyWithImpl;
@override @useResult
$Res call({
 int num, int page, int now
});




}
/// @nodoc
class __$LiveGuardInfoCopyWithImpl<$Res>
    implements _$LiveGuardInfoCopyWith<$Res> {
  __$LiveGuardInfoCopyWithImpl(this._self, this._then);

  final _LiveGuardInfo _self;
  final $Res Function(_LiveGuardInfo) _then;

/// Create a copy of LiveGuardInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? num = null,Object? page = null,Object? now = null,}) {
  return _then(_LiveGuardInfo(
num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveGuardItem {

 int get ruid; int get rank;@JsonKey(name: 'uinfo') LiveGuardUserInfo get userInfo;@JsonKey(name: 'guard_level') int get guardLevel;
/// Create a copy of LiveGuardItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGuardItemCopyWith<LiveGuardItem> get copyWith => _$LiveGuardItemCopyWithImpl<LiveGuardItem>(this as LiveGuardItem, _$identity);

  /// Serializes this LiveGuardItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGuardItem&&(identical(other.ruid, ruid) || other.ruid == ruid)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.userInfo, userInfo) || other.userInfo == userInfo)&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruid,rank,userInfo,guardLevel);

@override
String toString() {
  return 'LiveGuardItem(ruid: $ruid, rank: $rank, userInfo: $userInfo, guardLevel: $guardLevel)';
}


}

/// @nodoc
abstract mixin class $LiveGuardItemCopyWith<$Res>  {
  factory $LiveGuardItemCopyWith(LiveGuardItem value, $Res Function(LiveGuardItem) _then) = _$LiveGuardItemCopyWithImpl;
@useResult
$Res call({
 int ruid, int rank,@JsonKey(name: 'uinfo') LiveGuardUserInfo userInfo,@JsonKey(name: 'guard_level') int guardLevel
});


$LiveGuardUserInfoCopyWith<$Res> get userInfo;

}
/// @nodoc
class _$LiveGuardItemCopyWithImpl<$Res>
    implements $LiveGuardItemCopyWith<$Res> {
  _$LiveGuardItemCopyWithImpl(this._self, this._then);

  final LiveGuardItem _self;
  final $Res Function(LiveGuardItem) _then;

/// Create a copy of LiveGuardItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ruid = null,Object? rank = null,Object? userInfo = null,Object? guardLevel = null,}) {
  return _then(_self.copyWith(
ruid: null == ruid ? _self.ruid : ruid // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,userInfo: null == userInfo ? _self.userInfo : userInfo // ignore: cast_nullable_to_non_nullable
as LiveGuardUserInfo,guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LiveGuardItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardUserInfoCopyWith<$Res> get userInfo {
  
  return $LiveGuardUserInfoCopyWith<$Res>(_self.userInfo, (value) {
    return _then(_self.copyWith(userInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveGuardItem].
extension LiveGuardItemPatterns on LiveGuardItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGuardItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGuardItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGuardItem value)  $default,){
final _that = this;
switch (_that) {
case _LiveGuardItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGuardItem value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGuardItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int ruid,  int rank, @JsonKey(name: 'uinfo')  LiveGuardUserInfo userInfo, @JsonKey(name: 'guard_level')  int guardLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGuardItem() when $default != null:
return $default(_that.ruid,_that.rank,_that.userInfo,_that.guardLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int ruid,  int rank, @JsonKey(name: 'uinfo')  LiveGuardUserInfo userInfo, @JsonKey(name: 'guard_level')  int guardLevel)  $default,) {final _that = this;
switch (_that) {
case _LiveGuardItem():
return $default(_that.ruid,_that.rank,_that.userInfo,_that.guardLevel);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int ruid,  int rank, @JsonKey(name: 'uinfo')  LiveGuardUserInfo userInfo, @JsonKey(name: 'guard_level')  int guardLevel)?  $default,) {final _that = this;
switch (_that) {
case _LiveGuardItem() when $default != null:
return $default(_that.ruid,_that.rank,_that.userInfo,_that.guardLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGuardItem implements LiveGuardItem {
  const _LiveGuardItem({required this.ruid, required this.rank, @JsonKey(name: 'uinfo') required this.userInfo, @JsonKey(name: 'guard_level') required this.guardLevel});
  factory _LiveGuardItem.fromJson(Map<String, dynamic> json) => _$LiveGuardItemFromJson(json);

@override final  int ruid;
@override final  int rank;
@override@JsonKey(name: 'uinfo') final  LiveGuardUserInfo userInfo;
@override@JsonKey(name: 'guard_level') final  int guardLevel;

/// Create a copy of LiveGuardItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGuardItemCopyWith<_LiveGuardItem> get copyWith => __$LiveGuardItemCopyWithImpl<_LiveGuardItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGuardItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGuardItem&&(identical(other.ruid, ruid) || other.ruid == ruid)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.userInfo, userInfo) || other.userInfo == userInfo)&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruid,rank,userInfo,guardLevel);

@override
String toString() {
  return 'LiveGuardItem(ruid: $ruid, rank: $rank, userInfo: $userInfo, guardLevel: $guardLevel)';
}


}

/// @nodoc
abstract mixin class _$LiveGuardItemCopyWith<$Res> implements $LiveGuardItemCopyWith<$Res> {
  factory _$LiveGuardItemCopyWith(_LiveGuardItem value, $Res Function(_LiveGuardItem) _then) = __$LiveGuardItemCopyWithImpl;
@override @useResult
$Res call({
 int ruid, int rank,@JsonKey(name: 'uinfo') LiveGuardUserInfo userInfo,@JsonKey(name: 'guard_level') int guardLevel
});


@override $LiveGuardUserInfoCopyWith<$Res> get userInfo;

}
/// @nodoc
class __$LiveGuardItemCopyWithImpl<$Res>
    implements _$LiveGuardItemCopyWith<$Res> {
  __$LiveGuardItemCopyWithImpl(this._self, this._then);

  final _LiveGuardItem _self;
  final $Res Function(_LiveGuardItem) _then;

/// Create a copy of LiveGuardItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ruid = null,Object? rank = null,Object? userInfo = null,Object? guardLevel = null,}) {
  return _then(_LiveGuardItem(
ruid: null == ruid ? _self.ruid : ruid // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,userInfo: null == userInfo ? _self.userInfo : userInfo // ignore: cast_nullable_to_non_nullable
as LiveGuardUserInfo,guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LiveGuardItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardUserInfoCopyWith<$Res> get userInfo {
  
  return $LiveGuardUserInfoCopyWith<$Res>(_self.userInfo, (value) {
    return _then(_self.copyWith(userInfo: value));
  });
}
}


/// @nodoc
mixin _$LiveGuardUserInfo {

 int get uid;@JsonKey(name: 'base') LiveGuardUserBase get base;
/// Create a copy of LiveGuardUserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGuardUserInfoCopyWith<LiveGuardUserInfo> get copyWith => _$LiveGuardUserInfoCopyWithImpl<LiveGuardUserInfo>(this as LiveGuardUserInfo, _$identity);

  /// Serializes this LiveGuardUserInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGuardUserInfo&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.base, base) || other.base == base));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,base);

@override
String toString() {
  return 'LiveGuardUserInfo(uid: $uid, base: $base)';
}


}

/// @nodoc
abstract mixin class $LiveGuardUserInfoCopyWith<$Res>  {
  factory $LiveGuardUserInfoCopyWith(LiveGuardUserInfo value, $Res Function(LiveGuardUserInfo) _then) = _$LiveGuardUserInfoCopyWithImpl;
@useResult
$Res call({
 int uid,@JsonKey(name: 'base') LiveGuardUserBase base
});


$LiveGuardUserBaseCopyWith<$Res> get base;

}
/// @nodoc
class _$LiveGuardUserInfoCopyWithImpl<$Res>
    implements $LiveGuardUserInfoCopyWith<$Res> {
  _$LiveGuardUserInfoCopyWithImpl(this._self, this._then);

  final LiveGuardUserInfo _self;
  final $Res Function(LiveGuardUserInfo) _then;

/// Create a copy of LiveGuardUserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? base = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as LiveGuardUserBase,
  ));
}
/// Create a copy of LiveGuardUserInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardUserBaseCopyWith<$Res> get base {
  
  return $LiveGuardUserBaseCopyWith<$Res>(_self.base, (value) {
    return _then(_self.copyWith(base: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveGuardUserInfo].
extension LiveGuardUserInfoPatterns on LiveGuardUserInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGuardUserInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGuardUserInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGuardUserInfo value)  $default,){
final _that = this;
switch (_that) {
case _LiveGuardUserInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGuardUserInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGuardUserInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int uid, @JsonKey(name: 'base')  LiveGuardUserBase base)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGuardUserInfo() when $default != null:
return $default(_that.uid,_that.base);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int uid, @JsonKey(name: 'base')  LiveGuardUserBase base)  $default,) {final _that = this;
switch (_that) {
case _LiveGuardUserInfo():
return $default(_that.uid,_that.base);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int uid, @JsonKey(name: 'base')  LiveGuardUserBase base)?  $default,) {final _that = this;
switch (_that) {
case _LiveGuardUserInfo() when $default != null:
return $default(_that.uid,_that.base);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGuardUserInfo implements LiveGuardUserInfo {
  const _LiveGuardUserInfo({required this.uid, @JsonKey(name: 'base') required this.base});
  factory _LiveGuardUserInfo.fromJson(Map<String, dynamic> json) => _$LiveGuardUserInfoFromJson(json);

@override final  int uid;
@override@JsonKey(name: 'base') final  LiveGuardUserBase base;

/// Create a copy of LiveGuardUserInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGuardUserInfoCopyWith<_LiveGuardUserInfo> get copyWith => __$LiveGuardUserInfoCopyWithImpl<_LiveGuardUserInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGuardUserInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGuardUserInfo&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.base, base) || other.base == base));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,base);

@override
String toString() {
  return 'LiveGuardUserInfo(uid: $uid, base: $base)';
}


}

/// @nodoc
abstract mixin class _$LiveGuardUserInfoCopyWith<$Res> implements $LiveGuardUserInfoCopyWith<$Res> {
  factory _$LiveGuardUserInfoCopyWith(_LiveGuardUserInfo value, $Res Function(_LiveGuardUserInfo) _then) = __$LiveGuardUserInfoCopyWithImpl;
@override @useResult
$Res call({
 int uid,@JsonKey(name: 'base') LiveGuardUserBase base
});


@override $LiveGuardUserBaseCopyWith<$Res> get base;

}
/// @nodoc
class __$LiveGuardUserInfoCopyWithImpl<$Res>
    implements _$LiveGuardUserInfoCopyWith<$Res> {
  __$LiveGuardUserInfoCopyWithImpl(this._self, this._then);

  final _LiveGuardUserInfo _self;
  final $Res Function(_LiveGuardUserInfo) _then;

/// Create a copy of LiveGuardUserInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? base = null,}) {
  return _then(_LiveGuardUserInfo(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as LiveGuardUserBase,
  ));
}

/// Create a copy of LiveGuardUserInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardUserBaseCopyWith<$Res> get base {
  
  return $LiveGuardUserBaseCopyWith<$Res>(_self.base, (value) {
    return _then(_self.copyWith(base: value));
  });
}
}


/// @nodoc
mixin _$LiveGuardUserBase {

 String get name; String get face;
/// Create a copy of LiveGuardUserBase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGuardUserBaseCopyWith<LiveGuardUserBase> get copyWith => _$LiveGuardUserBaseCopyWithImpl<LiveGuardUserBase>(this as LiveGuardUserBase, _$identity);

  /// Serializes this LiveGuardUserBase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGuardUserBase&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,face);

@override
String toString() {
  return 'LiveGuardUserBase(name: $name, face: $face)';
}


}

/// @nodoc
abstract mixin class $LiveGuardUserBaseCopyWith<$Res>  {
  factory $LiveGuardUserBaseCopyWith(LiveGuardUserBase value, $Res Function(LiveGuardUserBase) _then) = _$LiveGuardUserBaseCopyWithImpl;
@useResult
$Res call({
 String name, String face
});




}
/// @nodoc
class _$LiveGuardUserBaseCopyWithImpl<$Res>
    implements $LiveGuardUserBaseCopyWith<$Res> {
  _$LiveGuardUserBaseCopyWithImpl(this._self, this._then);

  final LiveGuardUserBase _self;
  final $Res Function(LiveGuardUserBase) _then;

/// Create a copy of LiveGuardUserBase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? face = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveGuardUserBase].
extension LiveGuardUserBasePatterns on LiveGuardUserBase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGuardUserBase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGuardUserBase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGuardUserBase value)  $default,){
final _that = this;
switch (_that) {
case _LiveGuardUserBase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGuardUserBase value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGuardUserBase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String face)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGuardUserBase() when $default != null:
return $default(_that.name,_that.face);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String face)  $default,) {final _that = this;
switch (_that) {
case _LiveGuardUserBase():
return $default(_that.name,_that.face);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String face)?  $default,) {final _that = this;
switch (_that) {
case _LiveGuardUserBase() when $default != null:
return $default(_that.name,_that.face);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGuardUserBase implements LiveGuardUserBase {
  const _LiveGuardUserBase({required this.name, required this.face});
  factory _LiveGuardUserBase.fromJson(Map<String, dynamic> json) => _$LiveGuardUserBaseFromJson(json);

@override final  String name;
@override final  String face;

/// Create a copy of LiveGuardUserBase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGuardUserBaseCopyWith<_LiveGuardUserBase> get copyWith => __$LiveGuardUserBaseCopyWithImpl<_LiveGuardUserBase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGuardUserBaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGuardUserBase&&(identical(other.name, name) || other.name == name)&&(identical(other.face, face) || other.face == face));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,face);

@override
String toString() {
  return 'LiveGuardUserBase(name: $name, face: $face)';
}


}

/// @nodoc
abstract mixin class _$LiveGuardUserBaseCopyWith<$Res> implements $LiveGuardUserBaseCopyWith<$Res> {
  factory _$LiveGuardUserBaseCopyWith(_LiveGuardUserBase value, $Res Function(_LiveGuardUserBase) _then) = __$LiveGuardUserBaseCopyWithImpl;
@override @useResult
$Res call({
 String name, String face
});




}
/// @nodoc
class __$LiveGuardUserBaseCopyWithImpl<$Res>
    implements _$LiveGuardUserBaseCopyWith<$Res> {
  __$LiveGuardUserBaseCopyWithImpl(this._self, this._then);

  final _LiveGuardUserBase _self;
  final $Res Function(_LiveGuardUserBase) _then;

/// Create a copy of LiveGuardUserBase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? face = null,}) {
  return _then(_LiveGuardUserBase(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
