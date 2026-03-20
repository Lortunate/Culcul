// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DynamicDetailData {

 DynamicItem get item;
/// Create a copy of DynamicDetailData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicDetailDataCopyWith<DynamicDetailData> get copyWith => _$DynamicDetailDataCopyWithImpl<DynamicDetailData>(this as DynamicDetailData, _$identity);

  /// Serializes this DynamicDetailData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicDetailData&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'DynamicDetailData(item: $item)';
}


}

/// @nodoc
abstract mixin class $DynamicDetailDataCopyWith<$Res>  {
  factory $DynamicDetailDataCopyWith(DynamicDetailData value, $Res Function(DynamicDetailData) _then) = _$DynamicDetailDataCopyWithImpl;
@useResult
$Res call({
 DynamicItem item
});


$DynamicItemCopyWith<$Res> get item;

}
/// @nodoc
class _$DynamicDetailDataCopyWithImpl<$Res>
    implements $DynamicDetailDataCopyWith<$Res> {
  _$DynamicDetailDataCopyWithImpl(this._self, this._then);

  final DynamicDetailData _self;
  final $Res Function(DynamicDetailData) _then;

/// Create a copy of DynamicDetailData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as DynamicItem,
  ));
}
/// Create a copy of DynamicDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicItemCopyWith<$Res> get item {
  
  return $DynamicItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicDetailData].
extension DynamicDetailDataPatterns on DynamicDetailData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicDetailData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicDetailData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicDetailData value)  $default,){
final _that = this;
switch (_that) {
case _DynamicDetailData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicDetailData value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicDetailData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DynamicItem item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicDetailData() when $default != null:
return $default(_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DynamicItem item)  $default,) {final _that = this;
switch (_that) {
case _DynamicDetailData():
return $default(_that.item);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DynamicItem item)?  $default,) {final _that = this;
switch (_that) {
case _DynamicDetailData() when $default != null:
return $default(_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicDetailData implements DynamicDetailData {
  const _DynamicDetailData({required this.item});
  factory _DynamicDetailData.fromJson(Map<String, dynamic> json) => _$DynamicDetailDataFromJson(json);

@override final  DynamicItem item;

/// Create a copy of DynamicDetailData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicDetailDataCopyWith<_DynamicDetailData> get copyWith => __$DynamicDetailDataCopyWithImpl<_DynamicDetailData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicDetailDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicDetailData&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'DynamicDetailData(item: $item)';
}


}

/// @nodoc
abstract mixin class _$DynamicDetailDataCopyWith<$Res> implements $DynamicDetailDataCopyWith<$Res> {
  factory _$DynamicDetailDataCopyWith(_DynamicDetailData value, $Res Function(_DynamicDetailData) _then) = __$DynamicDetailDataCopyWithImpl;
@override @useResult
$Res call({
 DynamicItem item
});


@override $DynamicItemCopyWith<$Res> get item;

}
/// @nodoc
class __$DynamicDetailDataCopyWithImpl<$Res>
    implements _$DynamicDetailDataCopyWith<$Res> {
  __$DynamicDetailDataCopyWithImpl(this._self, this._then);

  final _DynamicDetailData _self;
  final $Res Function(_DynamicDetailData) _then;

/// Create a copy of DynamicDetailData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_DynamicDetailData(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as DynamicItem,
  ));
}

/// Create a copy of DynamicDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicItemCopyWith<$Res> get item {
  
  return $DynamicItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// @nodoc
mixin _$DynamicData {

@JsonKey(name: 'has_more') bool get hasMore; List<DynamicItem> get items; String get offset;@JsonKey(name: 'update_baseline') String get updateBaseline;@JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault) int get updateNum;
/// Create a copy of DynamicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicDataCopyWith<DynamicData> get copyWith => _$DynamicDataCopyWithImpl<DynamicData>(this as DynamicData, _$identity);

  /// Serializes this DynamicData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicData&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updateBaseline, updateBaseline) || other.updateBaseline == updateBaseline)&&(identical(other.updateNum, updateNum) || other.updateNum == updateNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasMore,const DeepCollectionEquality().hash(items),offset,updateBaseline,updateNum);

@override
String toString() {
  return 'DynamicData(hasMore: $hasMore, items: $items, offset: $offset, updateBaseline: $updateBaseline, updateNum: $updateNum)';
}


}

/// @nodoc
abstract mixin class $DynamicDataCopyWith<$Res>  {
  factory $DynamicDataCopyWith(DynamicData value, $Res Function(DynamicData) _then) = _$DynamicDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'has_more') bool hasMore, List<DynamicItem> items, String offset,@JsonKey(name: 'update_baseline') String updateBaseline,@JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault) int updateNum
});




}
/// @nodoc
class _$DynamicDataCopyWithImpl<$Res>
    implements $DynamicDataCopyWith<$Res> {
  _$DynamicDataCopyWithImpl(this._self, this._then);

  final DynamicData _self;
  final $Res Function(DynamicData) _then;

/// Create a copy of DynamicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasMore = null,Object? items = null,Object? offset = null,Object? updateBaseline = null,Object? updateNum = null,}) {
  return _then(_self.copyWith(
hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<DynamicItem>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as String,updateBaseline: null == updateBaseline ? _self.updateBaseline : updateBaseline // ignore: cast_nullable_to_non_nullable
as String,updateNum: null == updateNum ? _self.updateNum : updateNum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicData].
extension DynamicDataPatterns on DynamicData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicData value)  $default,){
final _that = this;
switch (_that) {
case _DynamicData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicData value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'has_more')  bool hasMore,  List<DynamicItem> items,  String offset, @JsonKey(name: 'update_baseline')  String updateBaseline, @JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault)  int updateNum)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicData() when $default != null:
return $default(_that.hasMore,_that.items,_that.offset,_that.updateBaseline,_that.updateNum);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'has_more')  bool hasMore,  List<DynamicItem> items,  String offset, @JsonKey(name: 'update_baseline')  String updateBaseline, @JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault)  int updateNum)  $default,) {final _that = this;
switch (_that) {
case _DynamicData():
return $default(_that.hasMore,_that.items,_that.offset,_that.updateBaseline,_that.updateNum);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'has_more')  bool hasMore,  List<DynamicItem> items,  String offset, @JsonKey(name: 'update_baseline')  String updateBaseline, @JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault)  int updateNum)?  $default,) {final _that = this;
switch (_that) {
case _DynamicData() when $default != null:
return $default(_that.hasMore,_that.items,_that.offset,_that.updateBaseline,_that.updateNum);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicData implements DynamicData {
  const _DynamicData({@JsonKey(name: 'has_more') required this.hasMore, required final  List<DynamicItem> items, required this.offset, @JsonKey(name: 'update_baseline') required this.updateBaseline, @JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault) required this.updateNum}): _items = items;
  factory _DynamicData.fromJson(Map<String, dynamic> json) => _$DynamicDataFromJson(json);

@override@JsonKey(name: 'has_more') final  bool hasMore;
 final  List<DynamicItem> _items;
@override List<DynamicItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String offset;
@override@JsonKey(name: 'update_baseline') final  String updateBaseline;
@override@JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault) final  int updateNum;

/// Create a copy of DynamicData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicDataCopyWith<_DynamicData> get copyWith => __$DynamicDataCopyWithImpl<_DynamicData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicData&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updateBaseline, updateBaseline) || other.updateBaseline == updateBaseline)&&(identical(other.updateNum, updateNum) || other.updateNum == updateNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasMore,const DeepCollectionEquality().hash(_items),offset,updateBaseline,updateNum);

@override
String toString() {
  return 'DynamicData(hasMore: $hasMore, items: $items, offset: $offset, updateBaseline: $updateBaseline, updateNum: $updateNum)';
}


}

/// @nodoc
abstract mixin class _$DynamicDataCopyWith<$Res> implements $DynamicDataCopyWith<$Res> {
  factory _$DynamicDataCopyWith(_DynamicData value, $Res Function(_DynamicData) _then) = __$DynamicDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'has_more') bool hasMore, List<DynamicItem> items, String offset,@JsonKey(name: 'update_baseline') String updateBaseline,@JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault) int updateNum
});




}
/// @nodoc
class __$DynamicDataCopyWithImpl<$Res>
    implements _$DynamicDataCopyWith<$Res> {
  __$DynamicDataCopyWithImpl(this._self, this._then);

  final _DynamicData _self;
  final $Res Function(_DynamicData) _then;

/// Create a copy of DynamicData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasMore = null,Object? items = null,Object? offset = null,Object? updateBaseline = null,Object? updateNum = null,}) {
  return _then(_DynamicData(
hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DynamicItem>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as String,updateBaseline: null == updateBaseline ? _self.updateBaseline : updateBaseline // ignore: cast_nullable_to_non_nullable
as String,updateNum: null == updateNum ? _self.updateNum : updateNum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DynamicItem {

@JsonKey(name: 'id_str') String get idStr; String get type; bool get visible; DynamicModules get modules; DynamicItem? get orig; DynamicBasic? get basic;
/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicItemCopyWith<DynamicItem> get copyWith => _$DynamicItemCopyWithImpl<DynamicItem>(this as DynamicItem, _$identity);

  /// Serializes this DynamicItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicItem&&(identical(other.idStr, idStr) || other.idStr == idStr)&&(identical(other.type, type) || other.type == type)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.modules, modules) || other.modules == modules)&&(identical(other.orig, orig) || other.orig == orig)&&(identical(other.basic, basic) || other.basic == basic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idStr,type,visible,modules,orig,basic);

@override
String toString() {
  return 'DynamicItem(idStr: $idStr, type: $type, visible: $visible, modules: $modules, orig: $orig, basic: $basic)';
}


}

/// @nodoc
abstract mixin class $DynamicItemCopyWith<$Res>  {
  factory $DynamicItemCopyWith(DynamicItem value, $Res Function(DynamicItem) _then) = _$DynamicItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_str') String idStr, String type, bool visible, DynamicModules modules, DynamicItem? orig, DynamicBasic? basic
});


$DynamicModulesCopyWith<$Res> get modules;$DynamicItemCopyWith<$Res>? get orig;$DynamicBasicCopyWith<$Res>? get basic;

}
/// @nodoc
class _$DynamicItemCopyWithImpl<$Res>
    implements $DynamicItemCopyWith<$Res> {
  _$DynamicItemCopyWithImpl(this._self, this._then);

  final DynamicItem _self;
  final $Res Function(DynamicItem) _then;

/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idStr = null,Object? type = null,Object? visible = null,Object? modules = null,Object? orig = freezed,Object? basic = freezed,}) {
  return _then(_self.copyWith(
idStr: null == idStr ? _self.idStr : idStr // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,modules: null == modules ? _self.modules : modules // ignore: cast_nullable_to_non_nullable
as DynamicModules,orig: freezed == orig ? _self.orig : orig // ignore: cast_nullable_to_non_nullable
as DynamicItem?,basic: freezed == basic ? _self.basic : basic // ignore: cast_nullable_to_non_nullable
as DynamicBasic?,
  ));
}
/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicModulesCopyWith<$Res> get modules {
  
  return $DynamicModulesCopyWith<$Res>(_self.modules, (value) {
    return _then(_self.copyWith(modules: value));
  });
}/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicItemCopyWith<$Res>? get orig {
    if (_self.orig == null) {
    return null;
  }

  return $DynamicItemCopyWith<$Res>(_self.orig!, (value) {
    return _then(_self.copyWith(orig: value));
  });
}/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicBasicCopyWith<$Res>? get basic {
    if (_self.basic == null) {
    return null;
  }

  return $DynamicBasicCopyWith<$Res>(_self.basic!, (value) {
    return _then(_self.copyWith(basic: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicItem].
extension DynamicItemPatterns on DynamicItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicItem value)  $default,){
final _that = this;
switch (_that) {
case _DynamicItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicItem value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_str')  String idStr,  String type,  bool visible,  DynamicModules modules,  DynamicItem? orig,  DynamicBasic? basic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicItem() when $default != null:
return $default(_that.idStr,_that.type,_that.visible,_that.modules,_that.orig,_that.basic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_str')  String idStr,  String type,  bool visible,  DynamicModules modules,  DynamicItem? orig,  DynamicBasic? basic)  $default,) {final _that = this;
switch (_that) {
case _DynamicItem():
return $default(_that.idStr,_that.type,_that.visible,_that.modules,_that.orig,_that.basic);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_str')  String idStr,  String type,  bool visible,  DynamicModules modules,  DynamicItem? orig,  DynamicBasic? basic)?  $default,) {final _that = this;
switch (_that) {
case _DynamicItem() when $default != null:
return $default(_that.idStr,_that.type,_that.visible,_that.modules,_that.orig,_that.basic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicItem implements DynamicItem {
  const _DynamicItem({@JsonKey(name: 'id_str') required this.idStr, required this.type, required this.visible, required this.modules, this.orig, this.basic});
  factory _DynamicItem.fromJson(Map<String, dynamic> json) => _$DynamicItemFromJson(json);

@override@JsonKey(name: 'id_str') final  String idStr;
@override final  String type;
@override final  bool visible;
@override final  DynamicModules modules;
@override final  DynamicItem? orig;
@override final  DynamicBasic? basic;

/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicItemCopyWith<_DynamicItem> get copyWith => __$DynamicItemCopyWithImpl<_DynamicItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicItem&&(identical(other.idStr, idStr) || other.idStr == idStr)&&(identical(other.type, type) || other.type == type)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.modules, modules) || other.modules == modules)&&(identical(other.orig, orig) || other.orig == orig)&&(identical(other.basic, basic) || other.basic == basic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idStr,type,visible,modules,orig,basic);

@override
String toString() {
  return 'DynamicItem(idStr: $idStr, type: $type, visible: $visible, modules: $modules, orig: $orig, basic: $basic)';
}


}

/// @nodoc
abstract mixin class _$DynamicItemCopyWith<$Res> implements $DynamicItemCopyWith<$Res> {
  factory _$DynamicItemCopyWith(_DynamicItem value, $Res Function(_DynamicItem) _then) = __$DynamicItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_str') String idStr, String type, bool visible, DynamicModules modules, DynamicItem? orig, DynamicBasic? basic
});


@override $DynamicModulesCopyWith<$Res> get modules;@override $DynamicItemCopyWith<$Res>? get orig;@override $DynamicBasicCopyWith<$Res>? get basic;

}
/// @nodoc
class __$DynamicItemCopyWithImpl<$Res>
    implements _$DynamicItemCopyWith<$Res> {
  __$DynamicItemCopyWithImpl(this._self, this._then);

  final _DynamicItem _self;
  final $Res Function(_DynamicItem) _then;

/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idStr = null,Object? type = null,Object? visible = null,Object? modules = null,Object? orig = freezed,Object? basic = freezed,}) {
  return _then(_DynamicItem(
idStr: null == idStr ? _self.idStr : idStr // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,modules: null == modules ? _self.modules : modules // ignore: cast_nullable_to_non_nullable
as DynamicModules,orig: freezed == orig ? _self.orig : orig // ignore: cast_nullable_to_non_nullable
as DynamicItem?,basic: freezed == basic ? _self.basic : basic // ignore: cast_nullable_to_non_nullable
as DynamicBasic?,
  ));
}

/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicModulesCopyWith<$Res> get modules {
  
  return $DynamicModulesCopyWith<$Res>(_self.modules, (value) {
    return _then(_self.copyWith(modules: value));
  });
}/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicItemCopyWith<$Res>? get orig {
    if (_self.orig == null) {
    return null;
  }

  return $DynamicItemCopyWith<$Res>(_self.orig!, (value) {
    return _then(_self.copyWith(orig: value));
  });
}/// Create a copy of DynamicItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicBasicCopyWith<$Res>? get basic {
    if (_self.basic == null) {
    return null;
  }

  return $DynamicBasicCopyWith<$Res>(_self.basic!, (value) {
    return _then(_self.copyWith(basic: value));
  });
}
}


/// @nodoc
mixin _$DynamicBasic {

@JsonKey(name: 'comment_id_str') String get commentIdStr;@JsonKey(name: 'comment_type') int get commentType;@JsonKey(name: 'rid_str') String get ridStr;
/// Create a copy of DynamicBasic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicBasicCopyWith<DynamicBasic> get copyWith => _$DynamicBasicCopyWithImpl<DynamicBasic>(this as DynamicBasic, _$identity);

  /// Serializes this DynamicBasic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicBasic&&(identical(other.commentIdStr, commentIdStr) || other.commentIdStr == commentIdStr)&&(identical(other.commentType, commentType) || other.commentType == commentType)&&(identical(other.ridStr, ridStr) || other.ridStr == ridStr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commentIdStr,commentType,ridStr);

@override
String toString() {
  return 'DynamicBasic(commentIdStr: $commentIdStr, commentType: $commentType, ridStr: $ridStr)';
}


}

/// @nodoc
abstract mixin class $DynamicBasicCopyWith<$Res>  {
  factory $DynamicBasicCopyWith(DynamicBasic value, $Res Function(DynamicBasic) _then) = _$DynamicBasicCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'comment_id_str') String commentIdStr,@JsonKey(name: 'comment_type') int commentType,@JsonKey(name: 'rid_str') String ridStr
});




}
/// @nodoc
class _$DynamicBasicCopyWithImpl<$Res>
    implements $DynamicBasicCopyWith<$Res> {
  _$DynamicBasicCopyWithImpl(this._self, this._then);

  final DynamicBasic _self;
  final $Res Function(DynamicBasic) _then;

/// Create a copy of DynamicBasic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commentIdStr = null,Object? commentType = null,Object? ridStr = null,}) {
  return _then(_self.copyWith(
commentIdStr: null == commentIdStr ? _self.commentIdStr : commentIdStr // ignore: cast_nullable_to_non_nullable
as String,commentType: null == commentType ? _self.commentType : commentType // ignore: cast_nullable_to_non_nullable
as int,ridStr: null == ridStr ? _self.ridStr : ridStr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicBasic].
extension DynamicBasicPatterns on DynamicBasic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicBasic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicBasic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicBasic value)  $default,){
final _that = this;
switch (_that) {
case _DynamicBasic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicBasic value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicBasic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'comment_id_str')  String commentIdStr, @JsonKey(name: 'comment_type')  int commentType, @JsonKey(name: 'rid_str')  String ridStr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicBasic() when $default != null:
return $default(_that.commentIdStr,_that.commentType,_that.ridStr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'comment_id_str')  String commentIdStr, @JsonKey(name: 'comment_type')  int commentType, @JsonKey(name: 'rid_str')  String ridStr)  $default,) {final _that = this;
switch (_that) {
case _DynamicBasic():
return $default(_that.commentIdStr,_that.commentType,_that.ridStr);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'comment_id_str')  String commentIdStr, @JsonKey(name: 'comment_type')  int commentType, @JsonKey(name: 'rid_str')  String ridStr)?  $default,) {final _that = this;
switch (_that) {
case _DynamicBasic() when $default != null:
return $default(_that.commentIdStr,_that.commentType,_that.ridStr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicBasic implements DynamicBasic {
  const _DynamicBasic({@JsonKey(name: 'comment_id_str') required this.commentIdStr, @JsonKey(name: 'comment_type') required this.commentType, @JsonKey(name: 'rid_str') required this.ridStr});
  factory _DynamicBasic.fromJson(Map<String, dynamic> json) => _$DynamicBasicFromJson(json);

@override@JsonKey(name: 'comment_id_str') final  String commentIdStr;
@override@JsonKey(name: 'comment_type') final  int commentType;
@override@JsonKey(name: 'rid_str') final  String ridStr;

/// Create a copy of DynamicBasic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicBasicCopyWith<_DynamicBasic> get copyWith => __$DynamicBasicCopyWithImpl<_DynamicBasic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicBasicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicBasic&&(identical(other.commentIdStr, commentIdStr) || other.commentIdStr == commentIdStr)&&(identical(other.commentType, commentType) || other.commentType == commentType)&&(identical(other.ridStr, ridStr) || other.ridStr == ridStr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commentIdStr,commentType,ridStr);

@override
String toString() {
  return 'DynamicBasic(commentIdStr: $commentIdStr, commentType: $commentType, ridStr: $ridStr)';
}


}

/// @nodoc
abstract mixin class _$DynamicBasicCopyWith<$Res> implements $DynamicBasicCopyWith<$Res> {
  factory _$DynamicBasicCopyWith(_DynamicBasic value, $Res Function(_DynamicBasic) _then) = __$DynamicBasicCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'comment_id_str') String commentIdStr,@JsonKey(name: 'comment_type') int commentType,@JsonKey(name: 'rid_str') String ridStr
});




}
/// @nodoc
class __$DynamicBasicCopyWithImpl<$Res>
    implements _$DynamicBasicCopyWith<$Res> {
  __$DynamicBasicCopyWithImpl(this._self, this._then);

  final _DynamicBasic _self;
  final $Res Function(_DynamicBasic) _then;

/// Create a copy of DynamicBasic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commentIdStr = null,Object? commentType = null,Object? ridStr = null,}) {
  return _then(_DynamicBasic(
commentIdStr: null == commentIdStr ? _self.commentIdStr : commentIdStr // ignore: cast_nullable_to_non_nullable
as String,commentType: null == commentType ? _self.commentType : commentType // ignore: cast_nullable_to_non_nullable
as int,ridStr: null == ridStr ? _self.ridStr : ridStr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DynamicModules {

@JsonKey(name: 'module_author') ModuleAuthor get moduleAuthor;@JsonKey(name: 'module_dynamic') ModuleDynamic get moduleDynamic;@JsonKey(name: 'module_stat') ModuleStat? get moduleStat;
/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicModulesCopyWith<DynamicModules> get copyWith => _$DynamicModulesCopyWithImpl<DynamicModules>(this as DynamicModules, _$identity);

  /// Serializes this DynamicModules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicModules&&(identical(other.moduleAuthor, moduleAuthor) || other.moduleAuthor == moduleAuthor)&&(identical(other.moduleDynamic, moduleDynamic) || other.moduleDynamic == moduleDynamic)&&(identical(other.moduleStat, moduleStat) || other.moduleStat == moduleStat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,moduleAuthor,moduleDynamic,moduleStat);

@override
String toString() {
  return 'DynamicModules(moduleAuthor: $moduleAuthor, moduleDynamic: $moduleDynamic, moduleStat: $moduleStat)';
}


}

/// @nodoc
abstract mixin class $DynamicModulesCopyWith<$Res>  {
  factory $DynamicModulesCopyWith(DynamicModules value, $Res Function(DynamicModules) _then) = _$DynamicModulesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'module_author') ModuleAuthor moduleAuthor,@JsonKey(name: 'module_dynamic') ModuleDynamic moduleDynamic,@JsonKey(name: 'module_stat') ModuleStat? moduleStat
});


$ModuleAuthorCopyWith<$Res> get moduleAuthor;$ModuleDynamicCopyWith<$Res> get moduleDynamic;$ModuleStatCopyWith<$Res>? get moduleStat;

}
/// @nodoc
class _$DynamicModulesCopyWithImpl<$Res>
    implements $DynamicModulesCopyWith<$Res> {
  _$DynamicModulesCopyWithImpl(this._self, this._then);

  final DynamicModules _self;
  final $Res Function(DynamicModules) _then;

/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moduleAuthor = null,Object? moduleDynamic = null,Object? moduleStat = freezed,}) {
  return _then(_self.copyWith(
moduleAuthor: null == moduleAuthor ? _self.moduleAuthor : moduleAuthor // ignore: cast_nullable_to_non_nullable
as ModuleAuthor,moduleDynamic: null == moduleDynamic ? _self.moduleDynamic : moduleDynamic // ignore: cast_nullable_to_non_nullable
as ModuleDynamic,moduleStat: freezed == moduleStat ? _self.moduleStat : moduleStat // ignore: cast_nullable_to_non_nullable
as ModuleStat?,
  ));
}
/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleAuthorCopyWith<$Res> get moduleAuthor {
  
  return $ModuleAuthorCopyWith<$Res>(_self.moduleAuthor, (value) {
    return _then(_self.copyWith(moduleAuthor: value));
  });
}/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleDynamicCopyWith<$Res> get moduleDynamic {
  
  return $ModuleDynamicCopyWith<$Res>(_self.moduleDynamic, (value) {
    return _then(_self.copyWith(moduleDynamic: value));
  });
}/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleStatCopyWith<$Res>? get moduleStat {
    if (_self.moduleStat == null) {
    return null;
  }

  return $ModuleStatCopyWith<$Res>(_self.moduleStat!, (value) {
    return _then(_self.copyWith(moduleStat: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicModules].
extension DynamicModulesPatterns on DynamicModules {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicModules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicModules() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicModules value)  $default,){
final _that = this;
switch (_that) {
case _DynamicModules():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicModules value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicModules() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'module_author')  ModuleAuthor moduleAuthor, @JsonKey(name: 'module_dynamic')  ModuleDynamic moduleDynamic, @JsonKey(name: 'module_stat')  ModuleStat? moduleStat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicModules() when $default != null:
return $default(_that.moduleAuthor,_that.moduleDynamic,_that.moduleStat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'module_author')  ModuleAuthor moduleAuthor, @JsonKey(name: 'module_dynamic')  ModuleDynamic moduleDynamic, @JsonKey(name: 'module_stat')  ModuleStat? moduleStat)  $default,) {final _that = this;
switch (_that) {
case _DynamicModules():
return $default(_that.moduleAuthor,_that.moduleDynamic,_that.moduleStat);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'module_author')  ModuleAuthor moduleAuthor, @JsonKey(name: 'module_dynamic')  ModuleDynamic moduleDynamic, @JsonKey(name: 'module_stat')  ModuleStat? moduleStat)?  $default,) {final _that = this;
switch (_that) {
case _DynamicModules() when $default != null:
return $default(_that.moduleAuthor,_that.moduleDynamic,_that.moduleStat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicModules implements DynamicModules {
  const _DynamicModules({@JsonKey(name: 'module_author') required this.moduleAuthor, @JsonKey(name: 'module_dynamic') required this.moduleDynamic, @JsonKey(name: 'module_stat') this.moduleStat});
  factory _DynamicModules.fromJson(Map<String, dynamic> json) => _$DynamicModulesFromJson(json);

@override@JsonKey(name: 'module_author') final  ModuleAuthor moduleAuthor;
@override@JsonKey(name: 'module_dynamic') final  ModuleDynamic moduleDynamic;
@override@JsonKey(name: 'module_stat') final  ModuleStat? moduleStat;

/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicModulesCopyWith<_DynamicModules> get copyWith => __$DynamicModulesCopyWithImpl<_DynamicModules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicModulesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicModules&&(identical(other.moduleAuthor, moduleAuthor) || other.moduleAuthor == moduleAuthor)&&(identical(other.moduleDynamic, moduleDynamic) || other.moduleDynamic == moduleDynamic)&&(identical(other.moduleStat, moduleStat) || other.moduleStat == moduleStat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,moduleAuthor,moduleDynamic,moduleStat);

@override
String toString() {
  return 'DynamicModules(moduleAuthor: $moduleAuthor, moduleDynamic: $moduleDynamic, moduleStat: $moduleStat)';
}


}

/// @nodoc
abstract mixin class _$DynamicModulesCopyWith<$Res> implements $DynamicModulesCopyWith<$Res> {
  factory _$DynamicModulesCopyWith(_DynamicModules value, $Res Function(_DynamicModules) _then) = __$DynamicModulesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'module_author') ModuleAuthor moduleAuthor,@JsonKey(name: 'module_dynamic') ModuleDynamic moduleDynamic,@JsonKey(name: 'module_stat') ModuleStat? moduleStat
});


@override $ModuleAuthorCopyWith<$Res> get moduleAuthor;@override $ModuleDynamicCopyWith<$Res> get moduleDynamic;@override $ModuleStatCopyWith<$Res>? get moduleStat;

}
/// @nodoc
class __$DynamicModulesCopyWithImpl<$Res>
    implements _$DynamicModulesCopyWith<$Res> {
  __$DynamicModulesCopyWithImpl(this._self, this._then);

  final _DynamicModules _self;
  final $Res Function(_DynamicModules) _then;

/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moduleAuthor = null,Object? moduleDynamic = null,Object? moduleStat = freezed,}) {
  return _then(_DynamicModules(
moduleAuthor: null == moduleAuthor ? _self.moduleAuthor : moduleAuthor // ignore: cast_nullable_to_non_nullable
as ModuleAuthor,moduleDynamic: null == moduleDynamic ? _self.moduleDynamic : moduleDynamic // ignore: cast_nullable_to_non_nullable
as ModuleDynamic,moduleStat: freezed == moduleStat ? _self.moduleStat : moduleStat // ignore: cast_nullable_to_non_nullable
as ModuleStat?,
  ));
}

/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleAuthorCopyWith<$Res> get moduleAuthor {
  
  return $ModuleAuthorCopyWith<$Res>(_self.moduleAuthor, (value) {
    return _then(_self.copyWith(moduleAuthor: value));
  });
}/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleDynamicCopyWith<$Res> get moduleDynamic {
  
  return $ModuleDynamicCopyWith<$Res>(_self.moduleDynamic, (value) {
    return _then(_self.copyWith(moduleDynamic: value));
  });
}/// Create a copy of DynamicModules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleStatCopyWith<$Res>? get moduleStat {
    if (_self.moduleStat == null) {
    return null;
  }

  return $ModuleStatCopyWith<$Res>(_self.moduleStat!, (value) {
    return _then(_self.copyWith(moduleStat: value));
  });
}
}


/// @nodoc
mixin _$ModuleAuthor {

 int get mid; String get name;@JsonKey(name: 'face') String get avatar;@JsonKey(name: 'pub_time') String get pubTime;@JsonKey(name: 'pub_action') String get pubAction;
/// Create a copy of ModuleAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleAuthorCopyWith<ModuleAuthor> get copyWith => _$ModuleAuthorCopyWithImpl<ModuleAuthor>(this as ModuleAuthor, _$identity);

  /// Serializes this ModuleAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleAuthor&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.pubTime, pubTime) || other.pubTime == pubTime)&&(identical(other.pubAction, pubAction) || other.pubAction == pubAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,avatar,pubTime,pubAction);

@override
String toString() {
  return 'ModuleAuthor(mid: $mid, name: $name, avatar: $avatar, pubTime: $pubTime, pubAction: $pubAction)';
}


}

/// @nodoc
abstract mixin class $ModuleAuthorCopyWith<$Res>  {
  factory $ModuleAuthorCopyWith(ModuleAuthor value, $Res Function(ModuleAuthor) _then) = _$ModuleAuthorCopyWithImpl;
@useResult
$Res call({
 int mid, String name,@JsonKey(name: 'face') String avatar,@JsonKey(name: 'pub_time') String pubTime,@JsonKey(name: 'pub_action') String pubAction
});




}
/// @nodoc
class _$ModuleAuthorCopyWithImpl<$Res>
    implements $ModuleAuthorCopyWith<$Res> {
  _$ModuleAuthorCopyWithImpl(this._self, this._then);

  final ModuleAuthor _self;
  final $Res Function(ModuleAuthor) _then;

/// Create a copy of ModuleAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? name = null,Object? avatar = null,Object? pubTime = null,Object? pubAction = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,pubTime: null == pubTime ? _self.pubTime : pubTime // ignore: cast_nullable_to_non_nullable
as String,pubAction: null == pubAction ? _self.pubAction : pubAction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleAuthor].
extension ModuleAuthorPatterns on ModuleAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleAuthor value)  $default,){
final _that = this;
switch (_that) {
case _ModuleAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mid,  String name, @JsonKey(name: 'face')  String avatar, @JsonKey(name: 'pub_time')  String pubTime, @JsonKey(name: 'pub_action')  String pubAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleAuthor() when $default != null:
return $default(_that.mid,_that.name,_that.avatar,_that.pubTime,_that.pubAction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mid,  String name, @JsonKey(name: 'face')  String avatar, @JsonKey(name: 'pub_time')  String pubTime, @JsonKey(name: 'pub_action')  String pubAction)  $default,) {final _that = this;
switch (_that) {
case _ModuleAuthor():
return $default(_that.mid,_that.name,_that.avatar,_that.pubTime,_that.pubAction);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mid,  String name, @JsonKey(name: 'face')  String avatar, @JsonKey(name: 'pub_time')  String pubTime, @JsonKey(name: 'pub_action')  String pubAction)?  $default,) {final _that = this;
switch (_that) {
case _ModuleAuthor() when $default != null:
return $default(_that.mid,_that.name,_that.avatar,_that.pubTime,_that.pubAction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleAuthor implements ModuleAuthor {
  const _ModuleAuthor({required this.mid, required this.name, @JsonKey(name: 'face') required this.avatar, @JsonKey(name: 'pub_time') required this.pubTime, @JsonKey(name: 'pub_action') required this.pubAction});
  factory _ModuleAuthor.fromJson(Map<String, dynamic> json) => _$ModuleAuthorFromJson(json);

@override final  int mid;
@override final  String name;
@override@JsonKey(name: 'face') final  String avatar;
@override@JsonKey(name: 'pub_time') final  String pubTime;
@override@JsonKey(name: 'pub_action') final  String pubAction;

/// Create a copy of ModuleAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleAuthorCopyWith<_ModuleAuthor> get copyWith => __$ModuleAuthorCopyWithImpl<_ModuleAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleAuthor&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.pubTime, pubTime) || other.pubTime == pubTime)&&(identical(other.pubAction, pubAction) || other.pubAction == pubAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,name,avatar,pubTime,pubAction);

@override
String toString() {
  return 'ModuleAuthor(mid: $mid, name: $name, avatar: $avatar, pubTime: $pubTime, pubAction: $pubAction)';
}


}

/// @nodoc
abstract mixin class _$ModuleAuthorCopyWith<$Res> implements $ModuleAuthorCopyWith<$Res> {
  factory _$ModuleAuthorCopyWith(_ModuleAuthor value, $Res Function(_ModuleAuthor) _then) = __$ModuleAuthorCopyWithImpl;
@override @useResult
$Res call({
 int mid, String name,@JsonKey(name: 'face') String avatar,@JsonKey(name: 'pub_time') String pubTime,@JsonKey(name: 'pub_action') String pubAction
});




}
/// @nodoc
class __$ModuleAuthorCopyWithImpl<$Res>
    implements _$ModuleAuthorCopyWith<$Res> {
  __$ModuleAuthorCopyWithImpl(this._self, this._then);

  final _ModuleAuthor _self;
  final $Res Function(_ModuleAuthor) _then;

/// Create a copy of ModuleAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? name = null,Object? avatar = null,Object? pubTime = null,Object? pubAction = null,}) {
  return _then(_ModuleAuthor(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,pubTime: null == pubTime ? _self.pubTime : pubTime // ignore: cast_nullable_to_non_nullable
as String,pubAction: null == pubAction ? _self.pubAction : pubAction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ModuleDynamic {

 ModuleDesc? get desc; ModuleMajor? get major; ModuleTopic? get topic; ModuleAdditional? get additional;
/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleDynamicCopyWith<ModuleDynamic> get copyWith => _$ModuleDynamicCopyWithImpl<ModuleDynamic>(this as ModuleDynamic, _$identity);

  /// Serializes this ModuleDynamic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleDynamic&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.major, major) || other.major == major)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.additional, additional) || other.additional == additional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,desc,major,topic,additional);

@override
String toString() {
  return 'ModuleDynamic(desc: $desc, major: $major, topic: $topic, additional: $additional)';
}


}

/// @nodoc
abstract mixin class $ModuleDynamicCopyWith<$Res>  {
  factory $ModuleDynamicCopyWith(ModuleDynamic value, $Res Function(ModuleDynamic) _then) = _$ModuleDynamicCopyWithImpl;
@useResult
$Res call({
 ModuleDesc? desc, ModuleMajor? major, ModuleTopic? topic, ModuleAdditional? additional
});


$ModuleDescCopyWith<$Res>? get desc;$ModuleMajorCopyWith<$Res>? get major;$ModuleTopicCopyWith<$Res>? get topic;$ModuleAdditionalCopyWith<$Res>? get additional;

}
/// @nodoc
class _$ModuleDynamicCopyWithImpl<$Res>
    implements $ModuleDynamicCopyWith<$Res> {
  _$ModuleDynamicCopyWithImpl(this._self, this._then);

  final ModuleDynamic _self;
  final $Res Function(ModuleDynamic) _then;

/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? desc = freezed,Object? major = freezed,Object? topic = freezed,Object? additional = freezed,}) {
  return _then(_self.copyWith(
desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as ModuleDesc?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as ModuleMajor?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as ModuleTopic?,additional: freezed == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as ModuleAdditional?,
  ));
}
/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleDescCopyWith<$Res>? get desc {
    if (_self.desc == null) {
    return null;
  }

  return $ModuleDescCopyWith<$Res>(_self.desc!, (value) {
    return _then(_self.copyWith(desc: value));
  });
}/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleMajorCopyWith<$Res>? get major {
    if (_self.major == null) {
    return null;
  }

  return $ModuleMajorCopyWith<$Res>(_self.major!, (value) {
    return _then(_self.copyWith(major: value));
  });
}/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleTopicCopyWith<$Res>? get topic {
    if (_self.topic == null) {
    return null;
  }

  return $ModuleTopicCopyWith<$Res>(_self.topic!, (value) {
    return _then(_self.copyWith(topic: value));
  });
}/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleAdditionalCopyWith<$Res>? get additional {
    if (_self.additional == null) {
    return null;
  }

  return $ModuleAdditionalCopyWith<$Res>(_self.additional!, (value) {
    return _then(_self.copyWith(additional: value));
  });
}
}


/// Adds pattern-matching-related methods to [ModuleDynamic].
extension ModuleDynamicPatterns on ModuleDynamic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleDynamic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleDynamic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleDynamic value)  $default,){
final _that = this;
switch (_that) {
case _ModuleDynamic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleDynamic value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleDynamic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ModuleDesc? desc,  ModuleMajor? major,  ModuleTopic? topic,  ModuleAdditional? additional)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleDynamic() when $default != null:
return $default(_that.desc,_that.major,_that.topic,_that.additional);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ModuleDesc? desc,  ModuleMajor? major,  ModuleTopic? topic,  ModuleAdditional? additional)  $default,) {final _that = this;
switch (_that) {
case _ModuleDynamic():
return $default(_that.desc,_that.major,_that.topic,_that.additional);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ModuleDesc? desc,  ModuleMajor? major,  ModuleTopic? topic,  ModuleAdditional? additional)?  $default,) {final _that = this;
switch (_that) {
case _ModuleDynamic() when $default != null:
return $default(_that.desc,_that.major,_that.topic,_that.additional);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleDynamic implements ModuleDynamic {
  const _ModuleDynamic({this.desc, this.major, this.topic, this.additional});
  factory _ModuleDynamic.fromJson(Map<String, dynamic> json) => _$ModuleDynamicFromJson(json);

@override final  ModuleDesc? desc;
@override final  ModuleMajor? major;
@override final  ModuleTopic? topic;
@override final  ModuleAdditional? additional;

/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleDynamicCopyWith<_ModuleDynamic> get copyWith => __$ModuleDynamicCopyWithImpl<_ModuleDynamic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleDynamicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleDynamic&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.major, major) || other.major == major)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.additional, additional) || other.additional == additional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,desc,major,topic,additional);

@override
String toString() {
  return 'ModuleDynamic(desc: $desc, major: $major, topic: $topic, additional: $additional)';
}


}

/// @nodoc
abstract mixin class _$ModuleDynamicCopyWith<$Res> implements $ModuleDynamicCopyWith<$Res> {
  factory _$ModuleDynamicCopyWith(_ModuleDynamic value, $Res Function(_ModuleDynamic) _then) = __$ModuleDynamicCopyWithImpl;
@override @useResult
$Res call({
 ModuleDesc? desc, ModuleMajor? major, ModuleTopic? topic, ModuleAdditional? additional
});


@override $ModuleDescCopyWith<$Res>? get desc;@override $ModuleMajorCopyWith<$Res>? get major;@override $ModuleTopicCopyWith<$Res>? get topic;@override $ModuleAdditionalCopyWith<$Res>? get additional;

}
/// @nodoc
class __$ModuleDynamicCopyWithImpl<$Res>
    implements _$ModuleDynamicCopyWith<$Res> {
  __$ModuleDynamicCopyWithImpl(this._self, this._then);

  final _ModuleDynamic _self;
  final $Res Function(_ModuleDynamic) _then;

/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? desc = freezed,Object? major = freezed,Object? topic = freezed,Object? additional = freezed,}) {
  return _then(_ModuleDynamic(
desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as ModuleDesc?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as ModuleMajor?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as ModuleTopic?,additional: freezed == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as ModuleAdditional?,
  ));
}

/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleDescCopyWith<$Res>? get desc {
    if (_self.desc == null) {
    return null;
  }

  return $ModuleDescCopyWith<$Res>(_self.desc!, (value) {
    return _then(_self.copyWith(desc: value));
  });
}/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleMajorCopyWith<$Res>? get major {
    if (_self.major == null) {
    return null;
  }

  return $ModuleMajorCopyWith<$Res>(_self.major!, (value) {
    return _then(_self.copyWith(major: value));
  });
}/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleTopicCopyWith<$Res>? get topic {
    if (_self.topic == null) {
    return null;
  }

  return $ModuleTopicCopyWith<$Res>(_self.topic!, (value) {
    return _then(_self.copyWith(topic: value));
  });
}/// Create a copy of ModuleDynamic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModuleAdditionalCopyWith<$Res>? get additional {
    if (_self.additional == null) {
    return null;
  }

  return $ModuleAdditionalCopyWith<$Res>(_self.additional!, (value) {
    return _then(_self.copyWith(additional: value));
  });
}
}


/// @nodoc
mixin _$ModuleAdditional {

 String get type; AdditionalCommon? get common; AdditionalReserve? get reserve; AdditionalGoods? get goods; AdditionalVote? get vote; AdditionalUgc? get ugc;
/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleAdditionalCopyWith<ModuleAdditional> get copyWith => _$ModuleAdditionalCopyWithImpl<ModuleAdditional>(this as ModuleAdditional, _$identity);

  /// Serializes this ModuleAdditional to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleAdditional&&(identical(other.type, type) || other.type == type)&&(identical(other.common, common) || other.common == common)&&(identical(other.reserve, reserve) || other.reserve == reserve)&&(identical(other.goods, goods) || other.goods == goods)&&(identical(other.vote, vote) || other.vote == vote)&&(identical(other.ugc, ugc) || other.ugc == ugc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,common,reserve,goods,vote,ugc);

@override
String toString() {
  return 'ModuleAdditional(type: $type, common: $common, reserve: $reserve, goods: $goods, vote: $vote, ugc: $ugc)';
}


}

/// @nodoc
abstract mixin class $ModuleAdditionalCopyWith<$Res>  {
  factory $ModuleAdditionalCopyWith(ModuleAdditional value, $Res Function(ModuleAdditional) _then) = _$ModuleAdditionalCopyWithImpl;
@useResult
$Res call({
 String type, AdditionalCommon? common, AdditionalReserve? reserve, AdditionalGoods? goods, AdditionalVote? vote, AdditionalUgc? ugc
});


$AdditionalCommonCopyWith<$Res>? get common;$AdditionalReserveCopyWith<$Res>? get reserve;$AdditionalGoodsCopyWith<$Res>? get goods;$AdditionalVoteCopyWith<$Res>? get vote;$AdditionalUgcCopyWith<$Res>? get ugc;

}
/// @nodoc
class _$ModuleAdditionalCopyWithImpl<$Res>
    implements $ModuleAdditionalCopyWith<$Res> {
  _$ModuleAdditionalCopyWithImpl(this._self, this._then);

  final ModuleAdditional _self;
  final $Res Function(ModuleAdditional) _then;

/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? common = freezed,Object? reserve = freezed,Object? goods = freezed,Object? vote = freezed,Object? ugc = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,common: freezed == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as AdditionalCommon?,reserve: freezed == reserve ? _self.reserve : reserve // ignore: cast_nullable_to_non_nullable
as AdditionalReserve?,goods: freezed == goods ? _self.goods : goods // ignore: cast_nullable_to_non_nullable
as AdditionalGoods?,vote: freezed == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as AdditionalVote?,ugc: freezed == ugc ? _self.ugc : ugc // ignore: cast_nullable_to_non_nullable
as AdditionalUgc?,
  ));
}
/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalCommonCopyWith<$Res>? get common {
    if (_self.common == null) {
    return null;
  }

  return $AdditionalCommonCopyWith<$Res>(_self.common!, (value) {
    return _then(_self.copyWith(common: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalReserveCopyWith<$Res>? get reserve {
    if (_self.reserve == null) {
    return null;
  }

  return $AdditionalReserveCopyWith<$Res>(_self.reserve!, (value) {
    return _then(_self.copyWith(reserve: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalGoodsCopyWith<$Res>? get goods {
    if (_self.goods == null) {
    return null;
  }

  return $AdditionalGoodsCopyWith<$Res>(_self.goods!, (value) {
    return _then(_self.copyWith(goods: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalVoteCopyWith<$Res>? get vote {
    if (_self.vote == null) {
    return null;
  }

  return $AdditionalVoteCopyWith<$Res>(_self.vote!, (value) {
    return _then(_self.copyWith(vote: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalUgcCopyWith<$Res>? get ugc {
    if (_self.ugc == null) {
    return null;
  }

  return $AdditionalUgcCopyWith<$Res>(_self.ugc!, (value) {
    return _then(_self.copyWith(ugc: value));
  });
}
}


/// Adds pattern-matching-related methods to [ModuleAdditional].
extension ModuleAdditionalPatterns on ModuleAdditional {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleAdditional value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleAdditional() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleAdditional value)  $default,){
final _that = this;
switch (_that) {
case _ModuleAdditional():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleAdditional value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleAdditional() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  AdditionalCommon? common,  AdditionalReserve? reserve,  AdditionalGoods? goods,  AdditionalVote? vote,  AdditionalUgc? ugc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleAdditional() when $default != null:
return $default(_that.type,_that.common,_that.reserve,_that.goods,_that.vote,_that.ugc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  AdditionalCommon? common,  AdditionalReserve? reserve,  AdditionalGoods? goods,  AdditionalVote? vote,  AdditionalUgc? ugc)  $default,) {final _that = this;
switch (_that) {
case _ModuleAdditional():
return $default(_that.type,_that.common,_that.reserve,_that.goods,_that.vote,_that.ugc);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  AdditionalCommon? common,  AdditionalReserve? reserve,  AdditionalGoods? goods,  AdditionalVote? vote,  AdditionalUgc? ugc)?  $default,) {final _that = this;
switch (_that) {
case _ModuleAdditional() when $default != null:
return $default(_that.type,_that.common,_that.reserve,_that.goods,_that.vote,_that.ugc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleAdditional implements ModuleAdditional {
  const _ModuleAdditional({required this.type, this.common, this.reserve, this.goods, this.vote, this.ugc});
  factory _ModuleAdditional.fromJson(Map<String, dynamic> json) => _$ModuleAdditionalFromJson(json);

@override final  String type;
@override final  AdditionalCommon? common;
@override final  AdditionalReserve? reserve;
@override final  AdditionalGoods? goods;
@override final  AdditionalVote? vote;
@override final  AdditionalUgc? ugc;

/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleAdditionalCopyWith<_ModuleAdditional> get copyWith => __$ModuleAdditionalCopyWithImpl<_ModuleAdditional>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleAdditionalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleAdditional&&(identical(other.type, type) || other.type == type)&&(identical(other.common, common) || other.common == common)&&(identical(other.reserve, reserve) || other.reserve == reserve)&&(identical(other.goods, goods) || other.goods == goods)&&(identical(other.vote, vote) || other.vote == vote)&&(identical(other.ugc, ugc) || other.ugc == ugc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,common,reserve,goods,vote,ugc);

@override
String toString() {
  return 'ModuleAdditional(type: $type, common: $common, reserve: $reserve, goods: $goods, vote: $vote, ugc: $ugc)';
}


}

/// @nodoc
abstract mixin class _$ModuleAdditionalCopyWith<$Res> implements $ModuleAdditionalCopyWith<$Res> {
  factory _$ModuleAdditionalCopyWith(_ModuleAdditional value, $Res Function(_ModuleAdditional) _then) = __$ModuleAdditionalCopyWithImpl;
@override @useResult
$Res call({
 String type, AdditionalCommon? common, AdditionalReserve? reserve, AdditionalGoods? goods, AdditionalVote? vote, AdditionalUgc? ugc
});


@override $AdditionalCommonCopyWith<$Res>? get common;@override $AdditionalReserveCopyWith<$Res>? get reserve;@override $AdditionalGoodsCopyWith<$Res>? get goods;@override $AdditionalVoteCopyWith<$Res>? get vote;@override $AdditionalUgcCopyWith<$Res>? get ugc;

}
/// @nodoc
class __$ModuleAdditionalCopyWithImpl<$Res>
    implements _$ModuleAdditionalCopyWith<$Res> {
  __$ModuleAdditionalCopyWithImpl(this._self, this._then);

  final _ModuleAdditional _self;
  final $Res Function(_ModuleAdditional) _then;

/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? common = freezed,Object? reserve = freezed,Object? goods = freezed,Object? vote = freezed,Object? ugc = freezed,}) {
  return _then(_ModuleAdditional(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,common: freezed == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as AdditionalCommon?,reserve: freezed == reserve ? _self.reserve : reserve // ignore: cast_nullable_to_non_nullable
as AdditionalReserve?,goods: freezed == goods ? _self.goods : goods // ignore: cast_nullable_to_non_nullable
as AdditionalGoods?,vote: freezed == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as AdditionalVote?,ugc: freezed == ugc ? _self.ugc : ugc // ignore: cast_nullable_to_non_nullable
as AdditionalUgc?,
  ));
}

/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalCommonCopyWith<$Res>? get common {
    if (_self.common == null) {
    return null;
  }

  return $AdditionalCommonCopyWith<$Res>(_self.common!, (value) {
    return _then(_self.copyWith(common: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalReserveCopyWith<$Res>? get reserve {
    if (_self.reserve == null) {
    return null;
  }

  return $AdditionalReserveCopyWith<$Res>(_self.reserve!, (value) {
    return _then(_self.copyWith(reserve: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalGoodsCopyWith<$Res>? get goods {
    if (_self.goods == null) {
    return null;
  }

  return $AdditionalGoodsCopyWith<$Res>(_self.goods!, (value) {
    return _then(_self.copyWith(goods: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalVoteCopyWith<$Res>? get vote {
    if (_self.vote == null) {
    return null;
  }

  return $AdditionalVoteCopyWith<$Res>(_self.vote!, (value) {
    return _then(_self.copyWith(vote: value));
  });
}/// Create a copy of ModuleAdditional
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdditionalUgcCopyWith<$Res>? get ugc {
    if (_self.ugc == null) {
    return null;
  }

  return $AdditionalUgcCopyWith<$Res>(_self.ugc!, (value) {
    return _then(_self.copyWith(ugc: value));
  });
}
}


/// @nodoc
mixin _$AdditionalCommon {

 String get title; String? get desc1; String? get desc2; String get cover;@JsonKey(name: 'jump_url') String get jumpUrl;@JsonKey(name: 'sub_type') String get subType;@JsonKey(name: 'head_text') String? get headText;
/// Create a copy of AdditionalCommon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalCommonCopyWith<AdditionalCommon> get copyWith => _$AdditionalCommonCopyWithImpl<AdditionalCommon>(this as AdditionalCommon, _$identity);

  /// Serializes this AdditionalCommon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalCommon&&(identical(other.title, title) || other.title == title)&&(identical(other.desc1, desc1) || other.desc1 == desc1)&&(identical(other.desc2, desc2) || other.desc2 == desc2)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.subType, subType) || other.subType == subType)&&(identical(other.headText, headText) || other.headText == headText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,desc1,desc2,cover,jumpUrl,subType,headText);

@override
String toString() {
  return 'AdditionalCommon(title: $title, desc1: $desc1, desc2: $desc2, cover: $cover, jumpUrl: $jumpUrl, subType: $subType, headText: $headText)';
}


}

/// @nodoc
abstract mixin class $AdditionalCommonCopyWith<$Res>  {
  factory $AdditionalCommonCopyWith(AdditionalCommon value, $Res Function(AdditionalCommon) _then) = _$AdditionalCommonCopyWithImpl;
@useResult
$Res call({
 String title, String? desc1, String? desc2, String cover,@JsonKey(name: 'jump_url') String jumpUrl,@JsonKey(name: 'sub_type') String subType,@JsonKey(name: 'head_text') String? headText
});




}
/// @nodoc
class _$AdditionalCommonCopyWithImpl<$Res>
    implements $AdditionalCommonCopyWith<$Res> {
  _$AdditionalCommonCopyWithImpl(this._self, this._then);

  final AdditionalCommon _self;
  final $Res Function(AdditionalCommon) _then;

/// Create a copy of AdditionalCommon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? desc1 = freezed,Object? desc2 = freezed,Object? cover = null,Object? jumpUrl = null,Object? subType = null,Object? headText = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc1: freezed == desc1 ? _self.desc1 : desc1 // ignore: cast_nullable_to_non_nullable
as String?,desc2: freezed == desc2 ? _self.desc2 : desc2 // ignore: cast_nullable_to_non_nullable
as String?,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,subType: null == subType ? _self.subType : subType // ignore: cast_nullable_to_non_nullable
as String,headText: freezed == headText ? _self.headText : headText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalCommon].
extension AdditionalCommonPatterns on AdditionalCommon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalCommon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalCommon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalCommon value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalCommon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalCommon value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalCommon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? desc1,  String? desc2,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'sub_type')  String subType, @JsonKey(name: 'head_text')  String? headText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalCommon() when $default != null:
return $default(_that.title,_that.desc1,_that.desc2,_that.cover,_that.jumpUrl,_that.subType,_that.headText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? desc1,  String? desc2,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'sub_type')  String subType, @JsonKey(name: 'head_text')  String? headText)  $default,) {final _that = this;
switch (_that) {
case _AdditionalCommon():
return $default(_that.title,_that.desc1,_that.desc2,_that.cover,_that.jumpUrl,_that.subType,_that.headText);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? desc1,  String? desc2,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'sub_type')  String subType, @JsonKey(name: 'head_text')  String? headText)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalCommon() when $default != null:
return $default(_that.title,_that.desc1,_that.desc2,_that.cover,_that.jumpUrl,_that.subType,_that.headText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalCommon implements AdditionalCommon {
  const _AdditionalCommon({required this.title, this.desc1, this.desc2, required this.cover, @JsonKey(name: 'jump_url') required this.jumpUrl, @JsonKey(name: 'sub_type') required this.subType, @JsonKey(name: 'head_text') this.headText});
  factory _AdditionalCommon.fromJson(Map<String, dynamic> json) => _$AdditionalCommonFromJson(json);

@override final  String title;
@override final  String? desc1;
@override final  String? desc2;
@override final  String cover;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override@JsonKey(name: 'sub_type') final  String subType;
@override@JsonKey(name: 'head_text') final  String? headText;

/// Create a copy of AdditionalCommon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalCommonCopyWith<_AdditionalCommon> get copyWith => __$AdditionalCommonCopyWithImpl<_AdditionalCommon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalCommonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalCommon&&(identical(other.title, title) || other.title == title)&&(identical(other.desc1, desc1) || other.desc1 == desc1)&&(identical(other.desc2, desc2) || other.desc2 == desc2)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.subType, subType) || other.subType == subType)&&(identical(other.headText, headText) || other.headText == headText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,desc1,desc2,cover,jumpUrl,subType,headText);

@override
String toString() {
  return 'AdditionalCommon(title: $title, desc1: $desc1, desc2: $desc2, cover: $cover, jumpUrl: $jumpUrl, subType: $subType, headText: $headText)';
}


}

/// @nodoc
abstract mixin class _$AdditionalCommonCopyWith<$Res> implements $AdditionalCommonCopyWith<$Res> {
  factory _$AdditionalCommonCopyWith(_AdditionalCommon value, $Res Function(_AdditionalCommon) _then) = __$AdditionalCommonCopyWithImpl;
@override @useResult
$Res call({
 String title, String? desc1, String? desc2, String cover,@JsonKey(name: 'jump_url') String jumpUrl,@JsonKey(name: 'sub_type') String subType,@JsonKey(name: 'head_text') String? headText
});




}
/// @nodoc
class __$AdditionalCommonCopyWithImpl<$Res>
    implements _$AdditionalCommonCopyWith<$Res> {
  __$AdditionalCommonCopyWithImpl(this._self, this._then);

  final _AdditionalCommon _self;
  final $Res Function(_AdditionalCommon) _then;

/// Create a copy of AdditionalCommon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? desc1 = freezed,Object? desc2 = freezed,Object? cover = null,Object? jumpUrl = null,Object? subType = null,Object? headText = freezed,}) {
  return _then(_AdditionalCommon(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc1: freezed == desc1 ? _self.desc1 : desc1 // ignore: cast_nullable_to_non_nullable
as String?,desc2: freezed == desc2 ? _self.desc2 : desc2 // ignore: cast_nullable_to_non_nullable
as String?,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,subType: null == subType ? _self.subType : subType // ignore: cast_nullable_to_non_nullable
as String,headText: freezed == headText ? _self.headText : headText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AdditionalReserve {

 String get title;@JsonKey(name: 'jump_url') String get jumpUrl;@JsonKey(name: 'reserve_total') int get reserveTotal; int get state; ReserveDesc? get desc1; ReserveDesc? get desc2;
/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalReserveCopyWith<AdditionalReserve> get copyWith => _$AdditionalReserveCopyWithImpl<AdditionalReserve>(this as AdditionalReserve, _$identity);

  /// Serializes this AdditionalReserve to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalReserve&&(identical(other.title, title) || other.title == title)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.reserveTotal, reserveTotal) || other.reserveTotal == reserveTotal)&&(identical(other.state, state) || other.state == state)&&(identical(other.desc1, desc1) || other.desc1 == desc1)&&(identical(other.desc2, desc2) || other.desc2 == desc2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,jumpUrl,reserveTotal,state,desc1,desc2);

@override
String toString() {
  return 'AdditionalReserve(title: $title, jumpUrl: $jumpUrl, reserveTotal: $reserveTotal, state: $state, desc1: $desc1, desc2: $desc2)';
}


}

/// @nodoc
abstract mixin class $AdditionalReserveCopyWith<$Res>  {
  factory $AdditionalReserveCopyWith(AdditionalReserve value, $Res Function(AdditionalReserve) _then) = _$AdditionalReserveCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(name: 'jump_url') String jumpUrl,@JsonKey(name: 'reserve_total') int reserveTotal, int state, ReserveDesc? desc1, ReserveDesc? desc2
});


$ReserveDescCopyWith<$Res>? get desc1;$ReserveDescCopyWith<$Res>? get desc2;

}
/// @nodoc
class _$AdditionalReserveCopyWithImpl<$Res>
    implements $AdditionalReserveCopyWith<$Res> {
  _$AdditionalReserveCopyWithImpl(this._self, this._then);

  final AdditionalReserve _self;
  final $Res Function(AdditionalReserve) _then;

/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? jumpUrl = null,Object? reserveTotal = null,Object? state = null,Object? desc1 = freezed,Object? desc2 = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,reserveTotal: null == reserveTotal ? _self.reserveTotal : reserveTotal // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,desc1: freezed == desc1 ? _self.desc1 : desc1 // ignore: cast_nullable_to_non_nullable
as ReserveDesc?,desc2: freezed == desc2 ? _self.desc2 : desc2 // ignore: cast_nullable_to_non_nullable
as ReserveDesc?,
  ));
}
/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReserveDescCopyWith<$Res>? get desc1 {
    if (_self.desc1 == null) {
    return null;
  }

  return $ReserveDescCopyWith<$Res>(_self.desc1!, (value) {
    return _then(_self.copyWith(desc1: value));
  });
}/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReserveDescCopyWith<$Res>? get desc2 {
    if (_self.desc2 == null) {
    return null;
  }

  return $ReserveDescCopyWith<$Res>(_self.desc2!, (value) {
    return _then(_self.copyWith(desc2: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdditionalReserve].
extension AdditionalReservePatterns on AdditionalReserve {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalReserve value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalReserve() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalReserve value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalReserve():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalReserve value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalReserve() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'reserve_total')  int reserveTotal,  int state,  ReserveDesc? desc1,  ReserveDesc? desc2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalReserve() when $default != null:
return $default(_that.title,_that.jumpUrl,_that.reserveTotal,_that.state,_that.desc1,_that.desc2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'reserve_total')  int reserveTotal,  int state,  ReserveDesc? desc1,  ReserveDesc? desc2)  $default,) {final _that = this;
switch (_that) {
case _AdditionalReserve():
return $default(_that.title,_that.jumpUrl,_that.reserveTotal,_that.state,_that.desc1,_that.desc2);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'reserve_total')  int reserveTotal,  int state,  ReserveDesc? desc1,  ReserveDesc? desc2)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalReserve() when $default != null:
return $default(_that.title,_that.jumpUrl,_that.reserveTotal,_that.state,_that.desc1,_that.desc2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalReserve implements AdditionalReserve {
  const _AdditionalReserve({required this.title, @JsonKey(name: 'jump_url') required this.jumpUrl, @JsonKey(name: 'reserve_total') required this.reserveTotal, required this.state, this.desc1, this.desc2});
  factory _AdditionalReserve.fromJson(Map<String, dynamic> json) => _$AdditionalReserveFromJson(json);

@override final  String title;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override@JsonKey(name: 'reserve_total') final  int reserveTotal;
@override final  int state;
@override final  ReserveDesc? desc1;
@override final  ReserveDesc? desc2;

/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalReserveCopyWith<_AdditionalReserve> get copyWith => __$AdditionalReserveCopyWithImpl<_AdditionalReserve>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalReserveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalReserve&&(identical(other.title, title) || other.title == title)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.reserveTotal, reserveTotal) || other.reserveTotal == reserveTotal)&&(identical(other.state, state) || other.state == state)&&(identical(other.desc1, desc1) || other.desc1 == desc1)&&(identical(other.desc2, desc2) || other.desc2 == desc2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,jumpUrl,reserveTotal,state,desc1,desc2);

@override
String toString() {
  return 'AdditionalReserve(title: $title, jumpUrl: $jumpUrl, reserveTotal: $reserveTotal, state: $state, desc1: $desc1, desc2: $desc2)';
}


}

/// @nodoc
abstract mixin class _$AdditionalReserveCopyWith<$Res> implements $AdditionalReserveCopyWith<$Res> {
  factory _$AdditionalReserveCopyWith(_AdditionalReserve value, $Res Function(_AdditionalReserve) _then) = __$AdditionalReserveCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(name: 'jump_url') String jumpUrl,@JsonKey(name: 'reserve_total') int reserveTotal, int state, ReserveDesc? desc1, ReserveDesc? desc2
});


@override $ReserveDescCopyWith<$Res>? get desc1;@override $ReserveDescCopyWith<$Res>? get desc2;

}
/// @nodoc
class __$AdditionalReserveCopyWithImpl<$Res>
    implements _$AdditionalReserveCopyWith<$Res> {
  __$AdditionalReserveCopyWithImpl(this._self, this._then);

  final _AdditionalReserve _self;
  final $Res Function(_AdditionalReserve) _then;

/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? jumpUrl = null,Object? reserveTotal = null,Object? state = null,Object? desc1 = freezed,Object? desc2 = freezed,}) {
  return _then(_AdditionalReserve(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,reserveTotal: null == reserveTotal ? _self.reserveTotal : reserveTotal // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,desc1: freezed == desc1 ? _self.desc1 : desc1 // ignore: cast_nullable_to_non_nullable
as ReserveDesc?,desc2: freezed == desc2 ? _self.desc2 : desc2 // ignore: cast_nullable_to_non_nullable
as ReserveDesc?,
  ));
}

/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReserveDescCopyWith<$Res>? get desc1 {
    if (_self.desc1 == null) {
    return null;
  }

  return $ReserveDescCopyWith<$Res>(_self.desc1!, (value) {
    return _then(_self.copyWith(desc1: value));
  });
}/// Create a copy of AdditionalReserve
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReserveDescCopyWith<$Res>? get desc2 {
    if (_self.desc2 == null) {
    return null;
  }

  return $ReserveDescCopyWith<$Res>(_self.desc2!, (value) {
    return _then(_self.copyWith(desc2: value));
  });
}
}


/// @nodoc
mixin _$ReserveDesc {

 String get text; int get style;
/// Create a copy of ReserveDesc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReserveDescCopyWith<ReserveDesc> get copyWith => _$ReserveDescCopyWithImpl<ReserveDesc>(this as ReserveDesc, _$identity);

  /// Serializes this ReserveDesc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReserveDesc&&(identical(other.text, text) || other.text == text)&&(identical(other.style, style) || other.style == style));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,style);

@override
String toString() {
  return 'ReserveDesc(text: $text, style: $style)';
}


}

/// @nodoc
abstract mixin class $ReserveDescCopyWith<$Res>  {
  factory $ReserveDescCopyWith(ReserveDesc value, $Res Function(ReserveDesc) _then) = _$ReserveDescCopyWithImpl;
@useResult
$Res call({
 String text, int style
});




}
/// @nodoc
class _$ReserveDescCopyWithImpl<$Res>
    implements $ReserveDescCopyWith<$Res> {
  _$ReserveDescCopyWithImpl(this._self, this._then);

  final ReserveDesc _self;
  final $Res Function(ReserveDesc) _then;

/// Create a copy of ReserveDesc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? style = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReserveDesc].
extension ReserveDescPatterns on ReserveDesc {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReserveDesc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReserveDesc() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReserveDesc value)  $default,){
final _that = this;
switch (_that) {
case _ReserveDesc():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReserveDesc value)?  $default,){
final _that = this;
switch (_that) {
case _ReserveDesc() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  int style)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReserveDesc() when $default != null:
return $default(_that.text,_that.style);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  int style)  $default,) {final _that = this;
switch (_that) {
case _ReserveDesc():
return $default(_that.text,_that.style);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  int style)?  $default,) {final _that = this;
switch (_that) {
case _ReserveDesc() when $default != null:
return $default(_that.text,_that.style);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReserveDesc implements ReserveDesc {
  const _ReserveDesc({required this.text, required this.style});
  factory _ReserveDesc.fromJson(Map<String, dynamic> json) => _$ReserveDescFromJson(json);

@override final  String text;
@override final  int style;

/// Create a copy of ReserveDesc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReserveDescCopyWith<_ReserveDesc> get copyWith => __$ReserveDescCopyWithImpl<_ReserveDesc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReserveDescToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReserveDesc&&(identical(other.text, text) || other.text == text)&&(identical(other.style, style) || other.style == style));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,style);

@override
String toString() {
  return 'ReserveDesc(text: $text, style: $style)';
}


}

/// @nodoc
abstract mixin class _$ReserveDescCopyWith<$Res> implements $ReserveDescCopyWith<$Res> {
  factory _$ReserveDescCopyWith(_ReserveDesc value, $Res Function(_ReserveDesc) _then) = __$ReserveDescCopyWithImpl;
@override @useResult
$Res call({
 String text, int style
});




}
/// @nodoc
class __$ReserveDescCopyWithImpl<$Res>
    implements _$ReserveDescCopyWith<$Res> {
  __$ReserveDescCopyWithImpl(this._self, this._then);

  final _ReserveDesc _self;
  final $Res Function(_ReserveDesc) _then;

/// Create a copy of ReserveDesc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? style = null,}) {
  return _then(_ReserveDesc(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AdditionalGoods {

@JsonKey(name: 'head_text') String get headText; List<GoodsItem> get items;@JsonKey(name: 'jump_url') String get jumpUrl;
/// Create a copy of AdditionalGoods
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalGoodsCopyWith<AdditionalGoods> get copyWith => _$AdditionalGoodsCopyWithImpl<AdditionalGoods>(this as AdditionalGoods, _$identity);

  /// Serializes this AdditionalGoods to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalGoods&&(identical(other.headText, headText) || other.headText == headText)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headText,const DeepCollectionEquality().hash(items),jumpUrl);

@override
String toString() {
  return 'AdditionalGoods(headText: $headText, items: $items, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $AdditionalGoodsCopyWith<$Res>  {
  factory $AdditionalGoodsCopyWith(AdditionalGoods value, $Res Function(AdditionalGoods) _then) = _$AdditionalGoodsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'head_text') String headText, List<GoodsItem> items,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class _$AdditionalGoodsCopyWithImpl<$Res>
    implements $AdditionalGoodsCopyWith<$Res> {
  _$AdditionalGoodsCopyWithImpl(this._self, this._then);

  final AdditionalGoods _self;
  final $Res Function(AdditionalGoods) _then;

/// Create a copy of AdditionalGoods
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headText = null,Object? items = null,Object? jumpUrl = null,}) {
  return _then(_self.copyWith(
headText: null == headText ? _self.headText : headText // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GoodsItem>,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalGoods].
extension AdditionalGoodsPatterns on AdditionalGoods {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalGoods value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalGoods() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalGoods value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalGoods():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalGoods value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalGoods() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'head_text')  String headText,  List<GoodsItem> items, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalGoods() when $default != null:
return $default(_that.headText,_that.items,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'head_text')  String headText,  List<GoodsItem> items, @JsonKey(name: 'jump_url')  String jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _AdditionalGoods():
return $default(_that.headText,_that.items,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'head_text')  String headText,  List<GoodsItem> items, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalGoods() when $default != null:
return $default(_that.headText,_that.items,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalGoods implements AdditionalGoods {
  const _AdditionalGoods({@JsonKey(name: 'head_text') required this.headText, required final  List<GoodsItem> items, @JsonKey(name: 'jump_url') required this.jumpUrl}): _items = items;
  factory _AdditionalGoods.fromJson(Map<String, dynamic> json) => _$AdditionalGoodsFromJson(json);

@override@JsonKey(name: 'head_text') final  String headText;
 final  List<GoodsItem> _items;
@override List<GoodsItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'jump_url') final  String jumpUrl;

/// Create a copy of AdditionalGoods
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalGoodsCopyWith<_AdditionalGoods> get copyWith => __$AdditionalGoodsCopyWithImpl<_AdditionalGoods>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalGoodsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalGoods&&(identical(other.headText, headText) || other.headText == headText)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headText,const DeepCollectionEquality().hash(_items),jumpUrl);

@override
String toString() {
  return 'AdditionalGoods(headText: $headText, items: $items, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$AdditionalGoodsCopyWith<$Res> implements $AdditionalGoodsCopyWith<$Res> {
  factory _$AdditionalGoodsCopyWith(_AdditionalGoods value, $Res Function(_AdditionalGoods) _then) = __$AdditionalGoodsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'head_text') String headText, List<GoodsItem> items,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class __$AdditionalGoodsCopyWithImpl<$Res>
    implements _$AdditionalGoodsCopyWith<$Res> {
  __$AdditionalGoodsCopyWithImpl(this._self, this._then);

  final _AdditionalGoods _self;
  final $Res Function(_AdditionalGoods) _then;

/// Create a copy of AdditionalGoods
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headText = null,Object? items = null,Object? jumpUrl = null,}) {
  return _then(_AdditionalGoods(
headText: null == headText ? _self.headText : headText // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GoodsItem>,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GoodsItem {

 String get name; String get price; String get cover;@JsonKey(name: 'jump_url') String get jumpUrl;
/// Create a copy of GoodsItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoodsItemCopyWith<GoodsItem> get copyWith => _$GoodsItemCopyWithImpl<GoodsItem>(this as GoodsItem, _$identity);

  /// Serializes this GoodsItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoodsItem&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,price,cover,jumpUrl);

@override
String toString() {
  return 'GoodsItem(name: $name, price: $price, cover: $cover, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $GoodsItemCopyWith<$Res>  {
  factory $GoodsItemCopyWith(GoodsItem value, $Res Function(GoodsItem) _then) = _$GoodsItemCopyWithImpl;
@useResult
$Res call({
 String name, String price, String cover,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class _$GoodsItemCopyWithImpl<$Res>
    implements $GoodsItemCopyWith<$Res> {
  _$GoodsItemCopyWithImpl(this._self, this._then);

  final GoodsItem _self;
  final $Res Function(GoodsItem) _then;

/// Create a copy of GoodsItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? price = null,Object? cover = null,Object? jumpUrl = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GoodsItem].
extension GoodsItemPatterns on GoodsItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoodsItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoodsItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoodsItem value)  $default,){
final _that = this;
switch (_that) {
case _GoodsItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoodsItem value)?  $default,){
final _that = this;
switch (_that) {
case _GoodsItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String price,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoodsItem() when $default != null:
return $default(_that.name,_that.price,_that.cover,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String price,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _GoodsItem():
return $default(_that.name,_that.price,_that.cover,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String price,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _GoodsItem() when $default != null:
return $default(_that.name,_that.price,_that.cover,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoodsItem implements GoodsItem {
  const _GoodsItem({required this.name, required this.price, required this.cover, @JsonKey(name: 'jump_url') required this.jumpUrl});
  factory _GoodsItem.fromJson(Map<String, dynamic> json) => _$GoodsItemFromJson(json);

@override final  String name;
@override final  String price;
@override final  String cover;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;

/// Create a copy of GoodsItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoodsItemCopyWith<_GoodsItem> get copyWith => __$GoodsItemCopyWithImpl<_GoodsItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoodsItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoodsItem&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,price,cover,jumpUrl);

@override
String toString() {
  return 'GoodsItem(name: $name, price: $price, cover: $cover, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$GoodsItemCopyWith<$Res> implements $GoodsItemCopyWith<$Res> {
  factory _$GoodsItemCopyWith(_GoodsItem value, $Res Function(_GoodsItem) _then) = __$GoodsItemCopyWithImpl;
@override @useResult
$Res call({
 String name, String price, String cover,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class __$GoodsItemCopyWithImpl<$Res>
    implements _$GoodsItemCopyWith<$Res> {
  __$GoodsItemCopyWithImpl(this._self, this._then);

  final _GoodsItem _self;
  final $Res Function(_GoodsItem) _then;

/// Create a copy of GoodsItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? price = null,Object? cover = null,Object? jumpUrl = null,}) {
  return _then(_GoodsItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AdditionalVote {

 String get desc;@JsonKey(name: 'end_time') int get endTime;@JsonKey(name: 'join_num') int get joinNum;@JsonKey(name: 'vote_id') int get voteId;@JsonKey(name: 'choice_cnt') int get choiceCnt; int get status;
/// Create a copy of AdditionalVote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalVoteCopyWith<AdditionalVote> get copyWith => _$AdditionalVoteCopyWithImpl<AdditionalVote>(this as AdditionalVote, _$identity);

  /// Serializes this AdditionalVote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalVote&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.joinNum, joinNum) || other.joinNum == joinNum)&&(identical(other.voteId, voteId) || other.voteId == voteId)&&(identical(other.choiceCnt, choiceCnt) || other.choiceCnt == choiceCnt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,desc,endTime,joinNum,voteId,choiceCnt,status);

@override
String toString() {
  return 'AdditionalVote(desc: $desc, endTime: $endTime, joinNum: $joinNum, voteId: $voteId, choiceCnt: $choiceCnt, status: $status)';
}


}

/// @nodoc
abstract mixin class $AdditionalVoteCopyWith<$Res>  {
  factory $AdditionalVoteCopyWith(AdditionalVote value, $Res Function(AdditionalVote) _then) = _$AdditionalVoteCopyWithImpl;
@useResult
$Res call({
 String desc,@JsonKey(name: 'end_time') int endTime,@JsonKey(name: 'join_num') int joinNum,@JsonKey(name: 'vote_id') int voteId,@JsonKey(name: 'choice_cnt') int choiceCnt, int status
});




}
/// @nodoc
class _$AdditionalVoteCopyWithImpl<$Res>
    implements $AdditionalVoteCopyWith<$Res> {
  _$AdditionalVoteCopyWithImpl(this._self, this._then);

  final AdditionalVote _self;
  final $Res Function(AdditionalVote) _then;

/// Create a copy of AdditionalVote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? desc = null,Object? endTime = null,Object? joinNum = null,Object? voteId = null,Object? choiceCnt = null,Object? status = null,}) {
  return _then(_self.copyWith(
desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as int,joinNum: null == joinNum ? _self.joinNum : joinNum // ignore: cast_nullable_to_non_nullable
as int,voteId: null == voteId ? _self.voteId : voteId // ignore: cast_nullable_to_non_nullable
as int,choiceCnt: null == choiceCnt ? _self.choiceCnt : choiceCnt // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalVote].
extension AdditionalVotePatterns on AdditionalVote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalVote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalVote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalVote value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalVote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalVote value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalVote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String desc, @JsonKey(name: 'end_time')  int endTime, @JsonKey(name: 'join_num')  int joinNum, @JsonKey(name: 'vote_id')  int voteId, @JsonKey(name: 'choice_cnt')  int choiceCnt,  int status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalVote() when $default != null:
return $default(_that.desc,_that.endTime,_that.joinNum,_that.voteId,_that.choiceCnt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String desc, @JsonKey(name: 'end_time')  int endTime, @JsonKey(name: 'join_num')  int joinNum, @JsonKey(name: 'vote_id')  int voteId, @JsonKey(name: 'choice_cnt')  int choiceCnt,  int status)  $default,) {final _that = this;
switch (_that) {
case _AdditionalVote():
return $default(_that.desc,_that.endTime,_that.joinNum,_that.voteId,_that.choiceCnt,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String desc, @JsonKey(name: 'end_time')  int endTime, @JsonKey(name: 'join_num')  int joinNum, @JsonKey(name: 'vote_id')  int voteId, @JsonKey(name: 'choice_cnt')  int choiceCnt,  int status)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalVote() when $default != null:
return $default(_that.desc,_that.endTime,_that.joinNum,_that.voteId,_that.choiceCnt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalVote implements AdditionalVote {
  const _AdditionalVote({required this.desc, @JsonKey(name: 'end_time') required this.endTime, @JsonKey(name: 'join_num') required this.joinNum, @JsonKey(name: 'vote_id') required this.voteId, @JsonKey(name: 'choice_cnt') required this.choiceCnt, required this.status});
  factory _AdditionalVote.fromJson(Map<String, dynamic> json) => _$AdditionalVoteFromJson(json);

@override final  String desc;
@override@JsonKey(name: 'end_time') final  int endTime;
@override@JsonKey(name: 'join_num') final  int joinNum;
@override@JsonKey(name: 'vote_id') final  int voteId;
@override@JsonKey(name: 'choice_cnt') final  int choiceCnt;
@override final  int status;

/// Create a copy of AdditionalVote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalVoteCopyWith<_AdditionalVote> get copyWith => __$AdditionalVoteCopyWithImpl<_AdditionalVote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalVoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalVote&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.joinNum, joinNum) || other.joinNum == joinNum)&&(identical(other.voteId, voteId) || other.voteId == voteId)&&(identical(other.choiceCnt, choiceCnt) || other.choiceCnt == choiceCnt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,desc,endTime,joinNum,voteId,choiceCnt,status);

@override
String toString() {
  return 'AdditionalVote(desc: $desc, endTime: $endTime, joinNum: $joinNum, voteId: $voteId, choiceCnt: $choiceCnt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AdditionalVoteCopyWith<$Res> implements $AdditionalVoteCopyWith<$Res> {
  factory _$AdditionalVoteCopyWith(_AdditionalVote value, $Res Function(_AdditionalVote) _then) = __$AdditionalVoteCopyWithImpl;
@override @useResult
$Res call({
 String desc,@JsonKey(name: 'end_time') int endTime,@JsonKey(name: 'join_num') int joinNum,@JsonKey(name: 'vote_id') int voteId,@JsonKey(name: 'choice_cnt') int choiceCnt, int status
});




}
/// @nodoc
class __$AdditionalVoteCopyWithImpl<$Res>
    implements _$AdditionalVoteCopyWith<$Res> {
  __$AdditionalVoteCopyWithImpl(this._self, this._then);

  final _AdditionalVote _self;
  final $Res Function(_AdditionalVote) _then;

/// Create a copy of AdditionalVote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? desc = null,Object? endTime = null,Object? joinNum = null,Object? voteId = null,Object? choiceCnt = null,Object? status = null,}) {
  return _then(_AdditionalVote(
desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as int,joinNum: null == joinNum ? _self.joinNum : joinNum // ignore: cast_nullable_to_non_nullable
as int,voteId: null == voteId ? _self.voteId : voteId // ignore: cast_nullable_to_non_nullable
as int,choiceCnt: null == choiceCnt ? _self.choiceCnt : choiceCnt // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AdditionalUgc {

 String get title; String get cover;@JsonKey(name: 'desc_second') String get descSecond; String get duration;@JsonKey(name: 'jump_url') String get jumpUrl;
/// Create a copy of AdditionalUgc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalUgcCopyWith<AdditionalUgc> get copyWith => _$AdditionalUgcCopyWithImpl<AdditionalUgc>(this as AdditionalUgc, _$identity);

  /// Serializes this AdditionalUgc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalUgc&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.descSecond, descSecond) || other.descSecond == descSecond)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,cover,descSecond,duration,jumpUrl);

@override
String toString() {
  return 'AdditionalUgc(title: $title, cover: $cover, descSecond: $descSecond, duration: $duration, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $AdditionalUgcCopyWith<$Res>  {
  factory $AdditionalUgcCopyWith(AdditionalUgc value, $Res Function(AdditionalUgc) _then) = _$AdditionalUgcCopyWithImpl;
@useResult
$Res call({
 String title, String cover,@JsonKey(name: 'desc_second') String descSecond, String duration,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class _$AdditionalUgcCopyWithImpl<$Res>
    implements $AdditionalUgcCopyWith<$Res> {
  _$AdditionalUgcCopyWithImpl(this._self, this._then);

  final AdditionalUgc _self;
  final $Res Function(AdditionalUgc) _then;

/// Create a copy of AdditionalUgc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? cover = null,Object? descSecond = null,Object? duration = null,Object? jumpUrl = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,descSecond: null == descSecond ? _self.descSecond : descSecond // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalUgc].
extension AdditionalUgcPatterns on AdditionalUgc {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalUgc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalUgc() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalUgc value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalUgc():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalUgc value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalUgc() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String cover, @JsonKey(name: 'desc_second')  String descSecond,  String duration, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalUgc() when $default != null:
return $default(_that.title,_that.cover,_that.descSecond,_that.duration,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String cover, @JsonKey(name: 'desc_second')  String descSecond,  String duration, @JsonKey(name: 'jump_url')  String jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _AdditionalUgc():
return $default(_that.title,_that.cover,_that.descSecond,_that.duration,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String cover, @JsonKey(name: 'desc_second')  String descSecond,  String duration, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalUgc() when $default != null:
return $default(_that.title,_that.cover,_that.descSecond,_that.duration,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalUgc implements AdditionalUgc {
  const _AdditionalUgc({required this.title, required this.cover, @JsonKey(name: 'desc_second') required this.descSecond, required this.duration, @JsonKey(name: 'jump_url') required this.jumpUrl});
  factory _AdditionalUgc.fromJson(Map<String, dynamic> json) => _$AdditionalUgcFromJson(json);

@override final  String title;
@override final  String cover;
@override@JsonKey(name: 'desc_second') final  String descSecond;
@override final  String duration;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;

/// Create a copy of AdditionalUgc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalUgcCopyWith<_AdditionalUgc> get copyWith => __$AdditionalUgcCopyWithImpl<_AdditionalUgc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalUgcToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalUgc&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.descSecond, descSecond) || other.descSecond == descSecond)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,cover,descSecond,duration,jumpUrl);

@override
String toString() {
  return 'AdditionalUgc(title: $title, cover: $cover, descSecond: $descSecond, duration: $duration, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$AdditionalUgcCopyWith<$Res> implements $AdditionalUgcCopyWith<$Res> {
  factory _$AdditionalUgcCopyWith(_AdditionalUgc value, $Res Function(_AdditionalUgc) _then) = __$AdditionalUgcCopyWithImpl;
@override @useResult
$Res call({
 String title, String cover,@JsonKey(name: 'desc_second') String descSecond, String duration,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class __$AdditionalUgcCopyWithImpl<$Res>
    implements _$AdditionalUgcCopyWith<$Res> {
  __$AdditionalUgcCopyWithImpl(this._self, this._then);

  final _AdditionalUgc _self;
  final $Res Function(_AdditionalUgc) _then;

/// Create a copy of AdditionalUgc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? cover = null,Object? descSecond = null,Object? duration = null,Object? jumpUrl = null,}) {
  return _then(_AdditionalUgc(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,descSecond: null == descSecond ? _self.descSecond : descSecond // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ModuleDesc {

 String get text;@JsonKey(name: 'rich_text_nodes') List<dynamic>? get richTextNodes;
/// Create a copy of ModuleDesc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleDescCopyWith<ModuleDesc> get copyWith => _$ModuleDescCopyWithImpl<ModuleDesc>(this as ModuleDesc, _$identity);

  /// Serializes this ModuleDesc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleDesc&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.richTextNodes, richTextNodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(richTextNodes));

@override
String toString() {
  return 'ModuleDesc(text: $text, richTextNodes: $richTextNodes)';
}


}

/// @nodoc
abstract mixin class $ModuleDescCopyWith<$Res>  {
  factory $ModuleDescCopyWith(ModuleDesc value, $Res Function(ModuleDesc) _then) = _$ModuleDescCopyWithImpl;
@useResult
$Res call({
 String text,@JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes
});




}
/// @nodoc
class _$ModuleDescCopyWithImpl<$Res>
    implements $ModuleDescCopyWith<$Res> {
  _$ModuleDescCopyWithImpl(this._self, this._then);

  final ModuleDesc _self;
  final $Res Function(ModuleDesc) _then;

/// Create a copy of ModuleDesc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? richTextNodes = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,richTextNodes: freezed == richTextNodes ? _self.richTextNodes : richTextNodes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleDesc].
extension ModuleDescPatterns on ModuleDesc {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleDesc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleDesc() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleDesc value)  $default,){
final _that = this;
switch (_that) {
case _ModuleDesc():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleDesc value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleDesc() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text, @JsonKey(name: 'rich_text_nodes')  List<dynamic>? richTextNodes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleDesc() when $default != null:
return $default(_that.text,_that.richTextNodes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text, @JsonKey(name: 'rich_text_nodes')  List<dynamic>? richTextNodes)  $default,) {final _that = this;
switch (_that) {
case _ModuleDesc():
return $default(_that.text,_that.richTextNodes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text, @JsonKey(name: 'rich_text_nodes')  List<dynamic>? richTextNodes)?  $default,) {final _that = this;
switch (_that) {
case _ModuleDesc() when $default != null:
return $default(_that.text,_that.richTextNodes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleDesc implements ModuleDesc {
  const _ModuleDesc({required this.text, @JsonKey(name: 'rich_text_nodes') final  List<dynamic>? richTextNodes}): _richTextNodes = richTextNodes;
  factory _ModuleDesc.fromJson(Map<String, dynamic> json) => _$ModuleDescFromJson(json);

@override final  String text;
 final  List<dynamic>? _richTextNodes;
@override@JsonKey(name: 'rich_text_nodes') List<dynamic>? get richTextNodes {
  final value = _richTextNodes;
  if (value == null) return null;
  if (_richTextNodes is EqualUnmodifiableListView) return _richTextNodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ModuleDesc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleDescCopyWith<_ModuleDesc> get copyWith => __$ModuleDescCopyWithImpl<_ModuleDesc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleDescToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleDesc&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._richTextNodes, _richTextNodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_richTextNodes));

@override
String toString() {
  return 'ModuleDesc(text: $text, richTextNodes: $richTextNodes)';
}


}

/// @nodoc
abstract mixin class _$ModuleDescCopyWith<$Res> implements $ModuleDescCopyWith<$Res> {
  factory _$ModuleDescCopyWith(_ModuleDesc value, $Res Function(_ModuleDesc) _then) = __$ModuleDescCopyWithImpl;
@override @useResult
$Res call({
 String text,@JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes
});




}
/// @nodoc
class __$ModuleDescCopyWithImpl<$Res>
    implements _$ModuleDescCopyWith<$Res> {
  __$ModuleDescCopyWithImpl(this._self, this._then);

  final _ModuleDesc _self;
  final $Res Function(_ModuleDesc) _then;

/// Create a copy of ModuleDesc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? richTextNodes = freezed,}) {
  return _then(_ModuleDesc(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,richTextNodes: freezed == richTextNodes ? _self._richTextNodes : richTextNodes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ModuleMajor {

 String get type; MajorArchive? get archive; MajorDraw? get draw;@JsonKey(name: 'ugc_season') MajorArchive? get ugcSeason; MajorArticle? get article; MajorCommon? get common; MajorPgc? get pgc; MajorCourses? get courses; MajorMusic? get music; MajorOpus? get opus; MajorLive? get live;@JsonKey(name: 'live_rcmd') MajorLiveRcmd? get liveRcmd;
/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleMajorCopyWith<ModuleMajor> get copyWith => _$ModuleMajorCopyWithImpl<ModuleMajor>(this as ModuleMajor, _$identity);

  /// Serializes this ModuleMajor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleMajor&&(identical(other.type, type) || other.type == type)&&(identical(other.archive, archive) || other.archive == archive)&&(identical(other.draw, draw) || other.draw == draw)&&(identical(other.ugcSeason, ugcSeason) || other.ugcSeason == ugcSeason)&&(identical(other.article, article) || other.article == article)&&(identical(other.common, common) || other.common == common)&&(identical(other.pgc, pgc) || other.pgc == pgc)&&(identical(other.courses, courses) || other.courses == courses)&&(identical(other.music, music) || other.music == music)&&(identical(other.opus, opus) || other.opus == opus)&&(identical(other.live, live) || other.live == live)&&(identical(other.liveRcmd, liveRcmd) || other.liveRcmd == liveRcmd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,archive,draw,ugcSeason,article,common,pgc,courses,music,opus,live,liveRcmd);

@override
String toString() {
  return 'ModuleMajor(type: $type, archive: $archive, draw: $draw, ugcSeason: $ugcSeason, article: $article, common: $common, pgc: $pgc, courses: $courses, music: $music, opus: $opus, live: $live, liveRcmd: $liveRcmd)';
}


}

/// @nodoc
abstract mixin class $ModuleMajorCopyWith<$Res>  {
  factory $ModuleMajorCopyWith(ModuleMajor value, $Res Function(ModuleMajor) _then) = _$ModuleMajorCopyWithImpl;
@useResult
$Res call({
 String type, MajorArchive? archive, MajorDraw? draw,@JsonKey(name: 'ugc_season') MajorArchive? ugcSeason, MajorArticle? article, MajorCommon? common, MajorPgc? pgc, MajorCourses? courses, MajorMusic? music, MajorOpus? opus, MajorLive? live,@JsonKey(name: 'live_rcmd') MajorLiveRcmd? liveRcmd
});


$MajorArchiveCopyWith<$Res>? get archive;$MajorDrawCopyWith<$Res>? get draw;$MajorArchiveCopyWith<$Res>? get ugcSeason;$MajorArticleCopyWith<$Res>? get article;$MajorCommonCopyWith<$Res>? get common;$MajorPgcCopyWith<$Res>? get pgc;$MajorCoursesCopyWith<$Res>? get courses;$MajorMusicCopyWith<$Res>? get music;$MajorOpusCopyWith<$Res>? get opus;$MajorLiveCopyWith<$Res>? get live;$MajorLiveRcmdCopyWith<$Res>? get liveRcmd;

}
/// @nodoc
class _$ModuleMajorCopyWithImpl<$Res>
    implements $ModuleMajorCopyWith<$Res> {
  _$ModuleMajorCopyWithImpl(this._self, this._then);

  final ModuleMajor _self;
  final $Res Function(ModuleMajor) _then;

/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? archive = freezed,Object? draw = freezed,Object? ugcSeason = freezed,Object? article = freezed,Object? common = freezed,Object? pgc = freezed,Object? courses = freezed,Object? music = freezed,Object? opus = freezed,Object? live = freezed,Object? liveRcmd = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,archive: freezed == archive ? _self.archive : archive // ignore: cast_nullable_to_non_nullable
as MajorArchive?,draw: freezed == draw ? _self.draw : draw // ignore: cast_nullable_to_non_nullable
as MajorDraw?,ugcSeason: freezed == ugcSeason ? _self.ugcSeason : ugcSeason // ignore: cast_nullable_to_non_nullable
as MajorArchive?,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as MajorArticle?,common: freezed == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as MajorCommon?,pgc: freezed == pgc ? _self.pgc : pgc // ignore: cast_nullable_to_non_nullable
as MajorPgc?,courses: freezed == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as MajorCourses?,music: freezed == music ? _self.music : music // ignore: cast_nullable_to_non_nullable
as MajorMusic?,opus: freezed == opus ? _self.opus : opus // ignore: cast_nullable_to_non_nullable
as MajorOpus?,live: freezed == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as MajorLive?,liveRcmd: freezed == liveRcmd ? _self.liveRcmd : liveRcmd // ignore: cast_nullable_to_non_nullable
as MajorLiveRcmd?,
  ));
}
/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorArchiveCopyWith<$Res>? get archive {
    if (_self.archive == null) {
    return null;
  }

  return $MajorArchiveCopyWith<$Res>(_self.archive!, (value) {
    return _then(_self.copyWith(archive: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorDrawCopyWith<$Res>? get draw {
    if (_self.draw == null) {
    return null;
  }

  return $MajorDrawCopyWith<$Res>(_self.draw!, (value) {
    return _then(_self.copyWith(draw: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorArchiveCopyWith<$Res>? get ugcSeason {
    if (_self.ugcSeason == null) {
    return null;
  }

  return $MajorArchiveCopyWith<$Res>(_self.ugcSeason!, (value) {
    return _then(_self.copyWith(ugcSeason: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorArticleCopyWith<$Res>? get article {
    if (_self.article == null) {
    return null;
  }

  return $MajorArticleCopyWith<$Res>(_self.article!, (value) {
    return _then(_self.copyWith(article: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorCommonCopyWith<$Res>? get common {
    if (_self.common == null) {
    return null;
  }

  return $MajorCommonCopyWith<$Res>(_self.common!, (value) {
    return _then(_self.copyWith(common: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorPgcCopyWith<$Res>? get pgc {
    if (_self.pgc == null) {
    return null;
  }

  return $MajorPgcCopyWith<$Res>(_self.pgc!, (value) {
    return _then(_self.copyWith(pgc: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorCoursesCopyWith<$Res>? get courses {
    if (_self.courses == null) {
    return null;
  }

  return $MajorCoursesCopyWith<$Res>(_self.courses!, (value) {
    return _then(_self.copyWith(courses: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorMusicCopyWith<$Res>? get music {
    if (_self.music == null) {
    return null;
  }

  return $MajorMusicCopyWith<$Res>(_self.music!, (value) {
    return _then(_self.copyWith(music: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorOpusCopyWith<$Res>? get opus {
    if (_self.opus == null) {
    return null;
  }

  return $MajorOpusCopyWith<$Res>(_self.opus!, (value) {
    return _then(_self.copyWith(opus: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorLiveCopyWith<$Res>? get live {
    if (_self.live == null) {
    return null;
  }

  return $MajorLiveCopyWith<$Res>(_self.live!, (value) {
    return _then(_self.copyWith(live: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorLiveRcmdCopyWith<$Res>? get liveRcmd {
    if (_self.liveRcmd == null) {
    return null;
  }

  return $MajorLiveRcmdCopyWith<$Res>(_self.liveRcmd!, (value) {
    return _then(_self.copyWith(liveRcmd: value));
  });
}
}


/// Adds pattern-matching-related methods to [ModuleMajor].
extension ModuleMajorPatterns on ModuleMajor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleMajor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleMajor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleMajor value)  $default,){
final _that = this;
switch (_that) {
case _ModuleMajor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleMajor value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleMajor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  MajorArchive? archive,  MajorDraw? draw, @JsonKey(name: 'ugc_season')  MajorArchive? ugcSeason,  MajorArticle? article,  MajorCommon? common,  MajorPgc? pgc,  MajorCourses? courses,  MajorMusic? music,  MajorOpus? opus,  MajorLive? live, @JsonKey(name: 'live_rcmd')  MajorLiveRcmd? liveRcmd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleMajor() when $default != null:
return $default(_that.type,_that.archive,_that.draw,_that.ugcSeason,_that.article,_that.common,_that.pgc,_that.courses,_that.music,_that.opus,_that.live,_that.liveRcmd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  MajorArchive? archive,  MajorDraw? draw, @JsonKey(name: 'ugc_season')  MajorArchive? ugcSeason,  MajorArticle? article,  MajorCommon? common,  MajorPgc? pgc,  MajorCourses? courses,  MajorMusic? music,  MajorOpus? opus,  MajorLive? live, @JsonKey(name: 'live_rcmd')  MajorLiveRcmd? liveRcmd)  $default,) {final _that = this;
switch (_that) {
case _ModuleMajor():
return $default(_that.type,_that.archive,_that.draw,_that.ugcSeason,_that.article,_that.common,_that.pgc,_that.courses,_that.music,_that.opus,_that.live,_that.liveRcmd);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  MajorArchive? archive,  MajorDraw? draw, @JsonKey(name: 'ugc_season')  MajorArchive? ugcSeason,  MajorArticle? article,  MajorCommon? common,  MajorPgc? pgc,  MajorCourses? courses,  MajorMusic? music,  MajorOpus? opus,  MajorLive? live, @JsonKey(name: 'live_rcmd')  MajorLiveRcmd? liveRcmd)?  $default,) {final _that = this;
switch (_that) {
case _ModuleMajor() when $default != null:
return $default(_that.type,_that.archive,_that.draw,_that.ugcSeason,_that.article,_that.common,_that.pgc,_that.courses,_that.music,_that.opus,_that.live,_that.liveRcmd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleMajor implements ModuleMajor {
  const _ModuleMajor({required this.type, this.archive, this.draw, @JsonKey(name: 'ugc_season') this.ugcSeason, this.article, this.common, this.pgc, this.courses, this.music, this.opus, this.live, @JsonKey(name: 'live_rcmd') this.liveRcmd});
  factory _ModuleMajor.fromJson(Map<String, dynamic> json) => _$ModuleMajorFromJson(json);

@override final  String type;
@override final  MajorArchive? archive;
@override final  MajorDraw? draw;
@override@JsonKey(name: 'ugc_season') final  MajorArchive? ugcSeason;
@override final  MajorArticle? article;
@override final  MajorCommon? common;
@override final  MajorPgc? pgc;
@override final  MajorCourses? courses;
@override final  MajorMusic? music;
@override final  MajorOpus? opus;
@override final  MajorLive? live;
@override@JsonKey(name: 'live_rcmd') final  MajorLiveRcmd? liveRcmd;

/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleMajorCopyWith<_ModuleMajor> get copyWith => __$ModuleMajorCopyWithImpl<_ModuleMajor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleMajorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleMajor&&(identical(other.type, type) || other.type == type)&&(identical(other.archive, archive) || other.archive == archive)&&(identical(other.draw, draw) || other.draw == draw)&&(identical(other.ugcSeason, ugcSeason) || other.ugcSeason == ugcSeason)&&(identical(other.article, article) || other.article == article)&&(identical(other.common, common) || other.common == common)&&(identical(other.pgc, pgc) || other.pgc == pgc)&&(identical(other.courses, courses) || other.courses == courses)&&(identical(other.music, music) || other.music == music)&&(identical(other.opus, opus) || other.opus == opus)&&(identical(other.live, live) || other.live == live)&&(identical(other.liveRcmd, liveRcmd) || other.liveRcmd == liveRcmd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,archive,draw,ugcSeason,article,common,pgc,courses,music,opus,live,liveRcmd);

@override
String toString() {
  return 'ModuleMajor(type: $type, archive: $archive, draw: $draw, ugcSeason: $ugcSeason, article: $article, common: $common, pgc: $pgc, courses: $courses, music: $music, opus: $opus, live: $live, liveRcmd: $liveRcmd)';
}


}

/// @nodoc
abstract mixin class _$ModuleMajorCopyWith<$Res> implements $ModuleMajorCopyWith<$Res> {
  factory _$ModuleMajorCopyWith(_ModuleMajor value, $Res Function(_ModuleMajor) _then) = __$ModuleMajorCopyWithImpl;
@override @useResult
$Res call({
 String type, MajorArchive? archive, MajorDraw? draw,@JsonKey(name: 'ugc_season') MajorArchive? ugcSeason, MajorArticle? article, MajorCommon? common, MajorPgc? pgc, MajorCourses? courses, MajorMusic? music, MajorOpus? opus, MajorLive? live,@JsonKey(name: 'live_rcmd') MajorLiveRcmd? liveRcmd
});


@override $MajorArchiveCopyWith<$Res>? get archive;@override $MajorDrawCopyWith<$Res>? get draw;@override $MajorArchiveCopyWith<$Res>? get ugcSeason;@override $MajorArticleCopyWith<$Res>? get article;@override $MajorCommonCopyWith<$Res>? get common;@override $MajorPgcCopyWith<$Res>? get pgc;@override $MajorCoursesCopyWith<$Res>? get courses;@override $MajorMusicCopyWith<$Res>? get music;@override $MajorOpusCopyWith<$Res>? get opus;@override $MajorLiveCopyWith<$Res>? get live;@override $MajorLiveRcmdCopyWith<$Res>? get liveRcmd;

}
/// @nodoc
class __$ModuleMajorCopyWithImpl<$Res>
    implements _$ModuleMajorCopyWith<$Res> {
  __$ModuleMajorCopyWithImpl(this._self, this._then);

  final _ModuleMajor _self;
  final $Res Function(_ModuleMajor) _then;

/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? archive = freezed,Object? draw = freezed,Object? ugcSeason = freezed,Object? article = freezed,Object? common = freezed,Object? pgc = freezed,Object? courses = freezed,Object? music = freezed,Object? opus = freezed,Object? live = freezed,Object? liveRcmd = freezed,}) {
  return _then(_ModuleMajor(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,archive: freezed == archive ? _self.archive : archive // ignore: cast_nullable_to_non_nullable
as MajorArchive?,draw: freezed == draw ? _self.draw : draw // ignore: cast_nullable_to_non_nullable
as MajorDraw?,ugcSeason: freezed == ugcSeason ? _self.ugcSeason : ugcSeason // ignore: cast_nullable_to_non_nullable
as MajorArchive?,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as MajorArticle?,common: freezed == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as MajorCommon?,pgc: freezed == pgc ? _self.pgc : pgc // ignore: cast_nullable_to_non_nullable
as MajorPgc?,courses: freezed == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as MajorCourses?,music: freezed == music ? _self.music : music // ignore: cast_nullable_to_non_nullable
as MajorMusic?,opus: freezed == opus ? _self.opus : opus // ignore: cast_nullable_to_non_nullable
as MajorOpus?,live: freezed == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as MajorLive?,liveRcmd: freezed == liveRcmd ? _self.liveRcmd : liveRcmd // ignore: cast_nullable_to_non_nullable
as MajorLiveRcmd?,
  ));
}

/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorArchiveCopyWith<$Res>? get archive {
    if (_self.archive == null) {
    return null;
  }

  return $MajorArchiveCopyWith<$Res>(_self.archive!, (value) {
    return _then(_self.copyWith(archive: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorDrawCopyWith<$Res>? get draw {
    if (_self.draw == null) {
    return null;
  }

  return $MajorDrawCopyWith<$Res>(_self.draw!, (value) {
    return _then(_self.copyWith(draw: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorArchiveCopyWith<$Res>? get ugcSeason {
    if (_self.ugcSeason == null) {
    return null;
  }

  return $MajorArchiveCopyWith<$Res>(_self.ugcSeason!, (value) {
    return _then(_self.copyWith(ugcSeason: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorArticleCopyWith<$Res>? get article {
    if (_self.article == null) {
    return null;
  }

  return $MajorArticleCopyWith<$Res>(_self.article!, (value) {
    return _then(_self.copyWith(article: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorCommonCopyWith<$Res>? get common {
    if (_self.common == null) {
    return null;
  }

  return $MajorCommonCopyWith<$Res>(_self.common!, (value) {
    return _then(_self.copyWith(common: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorPgcCopyWith<$Res>? get pgc {
    if (_self.pgc == null) {
    return null;
  }

  return $MajorPgcCopyWith<$Res>(_self.pgc!, (value) {
    return _then(_self.copyWith(pgc: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorCoursesCopyWith<$Res>? get courses {
    if (_self.courses == null) {
    return null;
  }

  return $MajorCoursesCopyWith<$Res>(_self.courses!, (value) {
    return _then(_self.copyWith(courses: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorMusicCopyWith<$Res>? get music {
    if (_self.music == null) {
    return null;
  }

  return $MajorMusicCopyWith<$Res>(_self.music!, (value) {
    return _then(_self.copyWith(music: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorOpusCopyWith<$Res>? get opus {
    if (_self.opus == null) {
    return null;
  }

  return $MajorOpusCopyWith<$Res>(_self.opus!, (value) {
    return _then(_self.copyWith(opus: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorLiveCopyWith<$Res>? get live {
    if (_self.live == null) {
    return null;
  }

  return $MajorLiveCopyWith<$Res>(_self.live!, (value) {
    return _then(_self.copyWith(live: value));
  });
}/// Create a copy of ModuleMajor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorLiveRcmdCopyWith<$Res>? get liveRcmd {
    if (_self.liveRcmd == null) {
    return null;
  }

  return $MajorLiveRcmdCopyWith<$Res>(_self.liveRcmd!, (value) {
    return _then(_self.copyWith(liveRcmd: value));
  });
}
}


/// @nodoc
mixin _$MajorArchive {

 String get cover; String get title; String get desc;@JsonKey(name: 'duration_text') String get durationText; MajorStat get stat; String get aid; String get bvid;@JsonKey(name: 'jump_url') String get jumpUrl;
/// Create a copy of MajorArchive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorArchiveCopyWith<MajorArchive> get copyWith => _$MajorArchiveCopyWithImpl<MajorArchive>(this as MajorArchive, _$identity);

  /// Serializes this MajorArchive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorArchive&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.durationText, durationText) || other.durationText == durationText)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,desc,durationText,stat,aid,bvid,jumpUrl);

@override
String toString() {
  return 'MajorArchive(cover: $cover, title: $title, desc: $desc, durationText: $durationText, stat: $stat, aid: $aid, bvid: $bvid, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $MajorArchiveCopyWith<$Res>  {
  factory $MajorArchiveCopyWith(MajorArchive value, $Res Function(MajorArchive) _then) = _$MajorArchiveCopyWithImpl;
@useResult
$Res call({
 String cover, String title, String desc,@JsonKey(name: 'duration_text') String durationText, MajorStat stat, String aid, String bvid,@JsonKey(name: 'jump_url') String jumpUrl
});


$MajorStatCopyWith<$Res> get stat;

}
/// @nodoc
class _$MajorArchiveCopyWithImpl<$Res>
    implements $MajorArchiveCopyWith<$Res> {
  _$MajorArchiveCopyWithImpl(this._self, this._then);

  final MajorArchive _self;
  final $Res Function(MajorArchive) _then;

/// Create a copy of MajorArchive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cover = null,Object? title = null,Object? desc = null,Object? durationText = null,Object? stat = null,Object? aid = null,Object? bvid = null,Object? jumpUrl = null,}) {
  return _then(_self.copyWith(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,durationText: null == durationText ? _self.durationText : durationText // ignore: cast_nullable_to_non_nullable
as String,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as MajorStat,aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of MajorArchive
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorStatCopyWith<$Res> get stat {
  
  return $MajorStatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [MajorArchive].
extension MajorArchivePatterns on MajorArchive {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorArchive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorArchive() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorArchive value)  $default,){
final _that = this;
switch (_that) {
case _MajorArchive():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorArchive value)?  $default,){
final _that = this;
switch (_that) {
case _MajorArchive() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cover,  String title,  String desc, @JsonKey(name: 'duration_text')  String durationText,  MajorStat stat,  String aid,  String bvid, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorArchive() when $default != null:
return $default(_that.cover,_that.title,_that.desc,_that.durationText,_that.stat,_that.aid,_that.bvid,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cover,  String title,  String desc, @JsonKey(name: 'duration_text')  String durationText,  MajorStat stat,  String aid,  String bvid, @JsonKey(name: 'jump_url')  String jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _MajorArchive():
return $default(_that.cover,_that.title,_that.desc,_that.durationText,_that.stat,_that.aid,_that.bvid,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cover,  String title,  String desc, @JsonKey(name: 'duration_text')  String durationText,  MajorStat stat,  String aid,  String bvid, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _MajorArchive() when $default != null:
return $default(_that.cover,_that.title,_that.desc,_that.durationText,_that.stat,_that.aid,_that.bvid,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorArchive implements MajorArchive {
  const _MajorArchive({required this.cover, required this.title, required this.desc, @JsonKey(name: 'duration_text') required this.durationText, required this.stat, required this.aid, required this.bvid, @JsonKey(name: 'jump_url') required this.jumpUrl});
  factory _MajorArchive.fromJson(Map<String, dynamic> json) => _$MajorArchiveFromJson(json);

@override final  String cover;
@override final  String title;
@override final  String desc;
@override@JsonKey(name: 'duration_text') final  String durationText;
@override final  MajorStat stat;
@override final  String aid;
@override final  String bvid;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;

/// Create a copy of MajorArchive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorArchiveCopyWith<_MajorArchive> get copyWith => __$MajorArchiveCopyWithImpl<_MajorArchive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorArchiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorArchive&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.durationText, durationText) || other.durationText == durationText)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,desc,durationText,stat,aid,bvid,jumpUrl);

@override
String toString() {
  return 'MajorArchive(cover: $cover, title: $title, desc: $desc, durationText: $durationText, stat: $stat, aid: $aid, bvid: $bvid, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$MajorArchiveCopyWith<$Res> implements $MajorArchiveCopyWith<$Res> {
  factory _$MajorArchiveCopyWith(_MajorArchive value, $Res Function(_MajorArchive) _then) = __$MajorArchiveCopyWithImpl;
@override @useResult
$Res call({
 String cover, String title, String desc,@JsonKey(name: 'duration_text') String durationText, MajorStat stat, String aid, String bvid,@JsonKey(name: 'jump_url') String jumpUrl
});


@override $MajorStatCopyWith<$Res> get stat;

}
/// @nodoc
class __$MajorArchiveCopyWithImpl<$Res>
    implements _$MajorArchiveCopyWith<$Res> {
  __$MajorArchiveCopyWithImpl(this._self, this._then);

  final _MajorArchive _self;
  final $Res Function(_MajorArchive) _then;

/// Create a copy of MajorArchive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cover = null,Object? title = null,Object? desc = null,Object? durationText = null,Object? stat = null,Object? aid = null,Object? bvid = null,Object? jumpUrl = null,}) {
  return _then(_MajorArchive(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,durationText: null == durationText ? _self.durationText : durationText // ignore: cast_nullable_to_non_nullable
as String,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as MajorStat,aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of MajorArchive
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorStatCopyWith<$Res> get stat {
  
  return $MajorStatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// @nodoc
mixin _$MajorDraw {

 int get id; List<DrawItem> get items;
/// Create a copy of MajorDraw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorDrawCopyWith<MajorDraw> get copyWith => _$MajorDrawCopyWithImpl<MajorDraw>(this as MajorDraw, _$identity);

  /// Serializes this MajorDraw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorDraw&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'MajorDraw(id: $id, items: $items)';
}


}

/// @nodoc
abstract mixin class $MajorDrawCopyWith<$Res>  {
  factory $MajorDrawCopyWith(MajorDraw value, $Res Function(MajorDraw) _then) = _$MajorDrawCopyWithImpl;
@useResult
$Res call({
 int id, List<DrawItem> items
});




}
/// @nodoc
class _$MajorDrawCopyWithImpl<$Res>
    implements $MajorDrawCopyWith<$Res> {
  _$MajorDrawCopyWithImpl(this._self, this._then);

  final MajorDraw _self;
  final $Res Function(MajorDraw) _then;

/// Create a copy of MajorDraw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<DrawItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorDraw].
extension MajorDrawPatterns on MajorDraw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorDraw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorDraw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorDraw value)  $default,){
final _that = this;
switch (_that) {
case _MajorDraw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorDraw value)?  $default,){
final _that = this;
switch (_that) {
case _MajorDraw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  List<DrawItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorDraw() when $default != null:
return $default(_that.id,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  List<DrawItem> items)  $default,) {final _that = this;
switch (_that) {
case _MajorDraw():
return $default(_that.id,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  List<DrawItem> items)?  $default,) {final _that = this;
switch (_that) {
case _MajorDraw() when $default != null:
return $default(_that.id,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorDraw implements MajorDraw {
  const _MajorDraw({required this.id, required final  List<DrawItem> items}): _items = items;
  factory _MajorDraw.fromJson(Map<String, dynamic> json) => _$MajorDrawFromJson(json);

@override final  int id;
 final  List<DrawItem> _items;
@override List<DrawItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MajorDraw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorDrawCopyWith<_MajorDraw> get copyWith => __$MajorDrawCopyWithImpl<_MajorDraw>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorDrawToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorDraw&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'MajorDraw(id: $id, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MajorDrawCopyWith<$Res> implements $MajorDrawCopyWith<$Res> {
  factory _$MajorDrawCopyWith(_MajorDraw value, $Res Function(_MajorDraw) _then) = __$MajorDrawCopyWithImpl;
@override @useResult
$Res call({
 int id, List<DrawItem> items
});




}
/// @nodoc
class __$MajorDrawCopyWithImpl<$Res>
    implements _$MajorDrawCopyWith<$Res> {
  __$MajorDrawCopyWithImpl(this._self, this._then);

  final _MajorDraw _self;
  final $Res Function(_MajorDraw) _then;

/// Create a copy of MajorDraw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? items = null,}) {
  return _then(_MajorDraw(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DrawItem>,
  ));
}


}


/// @nodoc
mixin _$DrawItem {

 String get src; int get width; int get height; int get size;
/// Create a copy of DrawItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrawItemCopyWith<DrawItem> get copyWith => _$DrawItemCopyWithImpl<DrawItem>(this as DrawItem, _$identity);

  /// Serializes this DrawItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrawItem&&(identical(other.src, src) || other.src == src)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,src,width,height,size);

@override
String toString() {
  return 'DrawItem(src: $src, width: $width, height: $height, size: $size)';
}


}

/// @nodoc
abstract mixin class $DrawItemCopyWith<$Res>  {
  factory $DrawItemCopyWith(DrawItem value, $Res Function(DrawItem) _then) = _$DrawItemCopyWithImpl;
@useResult
$Res call({
 String src, int width, int height, int size
});




}
/// @nodoc
class _$DrawItemCopyWithImpl<$Res>
    implements $DrawItemCopyWith<$Res> {
  _$DrawItemCopyWithImpl(this._self, this._then);

  final DrawItem _self;
  final $Res Function(DrawItem) _then;

/// Create a copy of DrawItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? src = null,Object? width = null,Object? height = null,Object? size = null,}) {
  return _then(_self.copyWith(
src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DrawItem].
extension DrawItemPatterns on DrawItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DrawItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DrawItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DrawItem value)  $default,){
final _that = this;
switch (_that) {
case _DrawItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DrawItem value)?  $default,){
final _that = this;
switch (_that) {
case _DrawItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String src,  int width,  int height,  int size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DrawItem() when $default != null:
return $default(_that.src,_that.width,_that.height,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String src,  int width,  int height,  int size)  $default,) {final _that = this;
switch (_that) {
case _DrawItem():
return $default(_that.src,_that.width,_that.height,_that.size);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String src,  int width,  int height,  int size)?  $default,) {final _that = this;
switch (_that) {
case _DrawItem() when $default != null:
return $default(_that.src,_that.width,_that.height,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DrawItem implements DrawItem {
  const _DrawItem({required this.src, required this.width, required this.height, required this.size});
  factory _DrawItem.fromJson(Map<String, dynamic> json) => _$DrawItemFromJson(json);

@override final  String src;
@override final  int width;
@override final  int height;
@override final  int size;

/// Create a copy of DrawItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrawItemCopyWith<_DrawItem> get copyWith => __$DrawItemCopyWithImpl<_DrawItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DrawItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DrawItem&&(identical(other.src, src) || other.src == src)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,src,width,height,size);

@override
String toString() {
  return 'DrawItem(src: $src, width: $width, height: $height, size: $size)';
}


}

/// @nodoc
abstract mixin class _$DrawItemCopyWith<$Res> implements $DrawItemCopyWith<$Res> {
  factory _$DrawItemCopyWith(_DrawItem value, $Res Function(_DrawItem) _then) = __$DrawItemCopyWithImpl;
@override @useResult
$Res call({
 String src, int width, int height, int size
});




}
/// @nodoc
class __$DrawItemCopyWithImpl<$Res>
    implements _$DrawItemCopyWith<$Res> {
  __$DrawItemCopyWithImpl(this._self, this._then);

  final _DrawItem _self;
  final $Res Function(_DrawItem) _then;

/// Create a copy of DrawItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? src = null,Object? width = null,Object? height = null,Object? size = null,}) {
  return _then(_DrawItem(
src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MajorArticle {

 int get id; String get title; String get desc; List<String> get covers; String get label;@JsonKey(name: 'jump_url') String get jumpUrl;
/// Create a copy of MajorArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorArticleCopyWith<MajorArticle> get copyWith => _$MajorArticleCopyWithImpl<MajorArticle>(this as MajorArticle, _$identity);

  /// Serializes this MajorArticle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorArticle&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&const DeepCollectionEquality().equals(other.covers, covers)&&(identical(other.label, label) || other.label == label)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,desc,const DeepCollectionEquality().hash(covers),label,jumpUrl);

@override
String toString() {
  return 'MajorArticle(id: $id, title: $title, desc: $desc, covers: $covers, label: $label, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $MajorArticleCopyWith<$Res>  {
  factory $MajorArticleCopyWith(MajorArticle value, $Res Function(MajorArticle) _then) = _$MajorArticleCopyWithImpl;
@useResult
$Res call({
 int id, String title, String desc, List<String> covers, String label,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class _$MajorArticleCopyWithImpl<$Res>
    implements $MajorArticleCopyWith<$Res> {
  _$MajorArticleCopyWithImpl(this._self, this._then);

  final MajorArticle _self;
  final $Res Function(MajorArticle) _then;

/// Create a copy of MajorArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? desc = null,Object? covers = null,Object? label = null,Object? jumpUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,covers: null == covers ? _self.covers : covers // ignore: cast_nullable_to_non_nullable
as List<String>,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorArticle].
extension MajorArticlePatterns on MajorArticle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorArticle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorArticle value)  $default,){
final _that = this;
switch (_that) {
case _MajorArticle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorArticle value)?  $default,){
final _that = this;
switch (_that) {
case _MajorArticle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String desc,  List<String> covers,  String label, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorArticle() when $default != null:
return $default(_that.id,_that.title,_that.desc,_that.covers,_that.label,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String desc,  List<String> covers,  String label, @JsonKey(name: 'jump_url')  String jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _MajorArticle():
return $default(_that.id,_that.title,_that.desc,_that.covers,_that.label,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String desc,  List<String> covers,  String label, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _MajorArticle() when $default != null:
return $default(_that.id,_that.title,_that.desc,_that.covers,_that.label,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorArticle implements MajorArticle {
  const _MajorArticle({required this.id, required this.title, required this.desc, required final  List<String> covers, required this.label, @JsonKey(name: 'jump_url') required this.jumpUrl}): _covers = covers;
  factory _MajorArticle.fromJson(Map<String, dynamic> json) => _$MajorArticleFromJson(json);

@override final  int id;
@override final  String title;
@override final  String desc;
 final  List<String> _covers;
@override List<String> get covers {
  if (_covers is EqualUnmodifiableListView) return _covers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_covers);
}

@override final  String label;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;

/// Create a copy of MajorArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorArticleCopyWith<_MajorArticle> get copyWith => __$MajorArticleCopyWithImpl<_MajorArticle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorArticle&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&const DeepCollectionEquality().equals(other._covers, _covers)&&(identical(other.label, label) || other.label == label)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,desc,const DeepCollectionEquality().hash(_covers),label,jumpUrl);

@override
String toString() {
  return 'MajorArticle(id: $id, title: $title, desc: $desc, covers: $covers, label: $label, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$MajorArticleCopyWith<$Res> implements $MajorArticleCopyWith<$Res> {
  factory _$MajorArticleCopyWith(_MajorArticle value, $Res Function(_MajorArticle) _then) = __$MajorArticleCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String desc, List<String> covers, String label,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class __$MajorArticleCopyWithImpl<$Res>
    implements _$MajorArticleCopyWith<$Res> {
  __$MajorArticleCopyWithImpl(this._self, this._then);

  final _MajorArticle _self;
  final $Res Function(_MajorArticle) _then;

/// Create a copy of MajorArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? desc = null,Object? covers = null,Object? label = null,Object? jumpUrl = null,}) {
  return _then(_MajorArticle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,covers: null == covers ? _self._covers : covers // ignore: cast_nullable_to_non_nullable
as List<String>,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MajorCommon {

 String get title; String get desc; String get cover;@JsonKey(name: 'jump_url') String get jumpUrl; String get label;
/// Create a copy of MajorCommon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorCommonCopyWith<MajorCommon> get copyWith => _$MajorCommonCopyWithImpl<MajorCommon>(this as MajorCommon, _$identity);

  /// Serializes this MajorCommon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorCommon&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,desc,cover,jumpUrl,label);

@override
String toString() {
  return 'MajorCommon(title: $title, desc: $desc, cover: $cover, jumpUrl: $jumpUrl, label: $label)';
}


}

/// @nodoc
abstract mixin class $MajorCommonCopyWith<$Res>  {
  factory $MajorCommonCopyWith(MajorCommon value, $Res Function(MajorCommon) _then) = _$MajorCommonCopyWithImpl;
@useResult
$Res call({
 String title, String desc, String cover,@JsonKey(name: 'jump_url') String jumpUrl, String label
});




}
/// @nodoc
class _$MajorCommonCopyWithImpl<$Res>
    implements $MajorCommonCopyWith<$Res> {
  _$MajorCommonCopyWithImpl(this._self, this._then);

  final MajorCommon _self;
  final $Res Function(MajorCommon) _then;

/// Create a copy of MajorCommon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? desc = null,Object? cover = null,Object? jumpUrl = null,Object? label = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorCommon].
extension MajorCommonPatterns on MajorCommon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorCommon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorCommon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorCommon value)  $default,){
final _that = this;
switch (_that) {
case _MajorCommon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorCommon value)?  $default,){
final _that = this;
switch (_that) {
case _MajorCommon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String desc,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorCommon() when $default != null:
return $default(_that.title,_that.desc,_that.cover,_that.jumpUrl,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String desc,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl,  String label)  $default,) {final _that = this;
switch (_that) {
case _MajorCommon():
return $default(_that.title,_that.desc,_that.cover,_that.jumpUrl,_that.label);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String desc,  String cover, @JsonKey(name: 'jump_url')  String jumpUrl,  String label)?  $default,) {final _that = this;
switch (_that) {
case _MajorCommon() when $default != null:
return $default(_that.title,_that.desc,_that.cover,_that.jumpUrl,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorCommon implements MajorCommon {
  const _MajorCommon({required this.title, required this.desc, required this.cover, @JsonKey(name: 'jump_url') required this.jumpUrl, required this.label});
  factory _MajorCommon.fromJson(Map<String, dynamic> json) => _$MajorCommonFromJson(json);

@override final  String title;
@override final  String desc;
@override final  String cover;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override final  String label;

/// Create a copy of MajorCommon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorCommonCopyWith<_MajorCommon> get copyWith => __$MajorCommonCopyWithImpl<_MajorCommon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorCommonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorCommon&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,desc,cover,jumpUrl,label);

@override
String toString() {
  return 'MajorCommon(title: $title, desc: $desc, cover: $cover, jumpUrl: $jumpUrl, label: $label)';
}


}

/// @nodoc
abstract mixin class _$MajorCommonCopyWith<$Res> implements $MajorCommonCopyWith<$Res> {
  factory _$MajorCommonCopyWith(_MajorCommon value, $Res Function(_MajorCommon) _then) = __$MajorCommonCopyWithImpl;
@override @useResult
$Res call({
 String title, String desc, String cover,@JsonKey(name: 'jump_url') String jumpUrl, String label
});




}
/// @nodoc
class __$MajorCommonCopyWithImpl<$Res>
    implements _$MajorCommonCopyWith<$Res> {
  __$MajorCommonCopyWithImpl(this._self, this._then);

  final _MajorCommon _self;
  final $Res Function(_MajorCommon) _then;

/// Create a copy of MajorCommon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? desc = null,Object? cover = null,Object? jumpUrl = null,Object? label = null,}) {
  return _then(_MajorCommon(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MajorStat {

 String get play; String get danmaku;
/// Create a copy of MajorStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorStatCopyWith<MajorStat> get copyWith => _$MajorStatCopyWithImpl<MajorStat>(this as MajorStat, _$identity);

  /// Serializes this MajorStat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorStat&&(identical(other.play, play) || other.play == play)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,play,danmaku);

@override
String toString() {
  return 'MajorStat(play: $play, danmaku: $danmaku)';
}


}

/// @nodoc
abstract mixin class $MajorStatCopyWith<$Res>  {
  factory $MajorStatCopyWith(MajorStat value, $Res Function(MajorStat) _then) = _$MajorStatCopyWithImpl;
@useResult
$Res call({
 String play, String danmaku
});




}
/// @nodoc
class _$MajorStatCopyWithImpl<$Res>
    implements $MajorStatCopyWith<$Res> {
  _$MajorStatCopyWithImpl(this._self, this._then);

  final MajorStat _self;
  final $Res Function(MajorStat) _then;

/// Create a copy of MajorStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? play = null,Object? danmaku = null,}) {
  return _then(_self.copyWith(
play: null == play ? _self.play : play // ignore: cast_nullable_to_non_nullable
as String,danmaku: null == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorStat].
extension MajorStatPatterns on MajorStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorStat value)  $default,){
final _that = this;
switch (_that) {
case _MajorStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorStat value)?  $default,){
final _that = this;
switch (_that) {
case _MajorStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String play,  String danmaku)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorStat() when $default != null:
return $default(_that.play,_that.danmaku);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String play,  String danmaku)  $default,) {final _that = this;
switch (_that) {
case _MajorStat():
return $default(_that.play,_that.danmaku);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String play,  String danmaku)?  $default,) {final _that = this;
switch (_that) {
case _MajorStat() when $default != null:
return $default(_that.play,_that.danmaku);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorStat implements MajorStat {
  const _MajorStat({required this.play, required this.danmaku});
  factory _MajorStat.fromJson(Map<String, dynamic> json) => _$MajorStatFromJson(json);

@override final  String play;
@override final  String danmaku;

/// Create a copy of MajorStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorStatCopyWith<_MajorStat> get copyWith => __$MajorStatCopyWithImpl<_MajorStat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorStatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorStat&&(identical(other.play, play) || other.play == play)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,play,danmaku);

@override
String toString() {
  return 'MajorStat(play: $play, danmaku: $danmaku)';
}


}

/// @nodoc
abstract mixin class _$MajorStatCopyWith<$Res> implements $MajorStatCopyWith<$Res> {
  factory _$MajorStatCopyWith(_MajorStat value, $Res Function(_MajorStat) _then) = __$MajorStatCopyWithImpl;
@override @useResult
$Res call({
 String play, String danmaku
});




}
/// @nodoc
class __$MajorStatCopyWithImpl<$Res>
    implements _$MajorStatCopyWith<$Res> {
  __$MajorStatCopyWithImpl(this._self, this._then);

  final _MajorStat _self;
  final $Res Function(_MajorStat) _then;

/// Create a copy of MajorStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? play = null,Object? danmaku = null,}) {
  return _then(_MajorStat(
play: null == play ? _self.play : play // ignore: cast_nullable_to_non_nullable
as String,danmaku: null == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ModuleStat {

 StatLike get like; StatCommon get comment; StatCommon get forward;
/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleStatCopyWith<ModuleStat> get copyWith => _$ModuleStatCopyWithImpl<ModuleStat>(this as ModuleStat, _$identity);

  /// Serializes this ModuleStat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleStat&&(identical(other.like, like) || other.like == like)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.forward, forward) || other.forward == forward));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,like,comment,forward);

@override
String toString() {
  return 'ModuleStat(like: $like, comment: $comment, forward: $forward)';
}


}

/// @nodoc
abstract mixin class $ModuleStatCopyWith<$Res>  {
  factory $ModuleStatCopyWith(ModuleStat value, $Res Function(ModuleStat) _then) = _$ModuleStatCopyWithImpl;
@useResult
$Res call({
 StatLike like, StatCommon comment, StatCommon forward
});


$StatLikeCopyWith<$Res> get like;$StatCommonCopyWith<$Res> get comment;$StatCommonCopyWith<$Res> get forward;

}
/// @nodoc
class _$ModuleStatCopyWithImpl<$Res>
    implements $ModuleStatCopyWith<$Res> {
  _$ModuleStatCopyWithImpl(this._self, this._then);

  final ModuleStat _self;
  final $Res Function(ModuleStat) _then;

/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? like = null,Object? comment = null,Object? forward = null,}) {
  return _then(_self.copyWith(
like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as StatLike,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as StatCommon,forward: null == forward ? _self.forward : forward // ignore: cast_nullable_to_non_nullable
as StatCommon,
  ));
}
/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatLikeCopyWith<$Res> get like {
  
  return $StatLikeCopyWith<$Res>(_self.like, (value) {
    return _then(_self.copyWith(like: value));
  });
}/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCommonCopyWith<$Res> get comment {
  
  return $StatCommonCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCommonCopyWith<$Res> get forward {
  
  return $StatCommonCopyWith<$Res>(_self.forward, (value) {
    return _then(_self.copyWith(forward: value));
  });
}
}


/// Adds pattern-matching-related methods to [ModuleStat].
extension ModuleStatPatterns on ModuleStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleStat value)  $default,){
final _that = this;
switch (_that) {
case _ModuleStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleStat value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StatLike like,  StatCommon comment,  StatCommon forward)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleStat() when $default != null:
return $default(_that.like,_that.comment,_that.forward);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StatLike like,  StatCommon comment,  StatCommon forward)  $default,) {final _that = this;
switch (_that) {
case _ModuleStat():
return $default(_that.like,_that.comment,_that.forward);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StatLike like,  StatCommon comment,  StatCommon forward)?  $default,) {final _that = this;
switch (_that) {
case _ModuleStat() when $default != null:
return $default(_that.like,_that.comment,_that.forward);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleStat implements ModuleStat {
  const _ModuleStat({required this.like, required this.comment, required this.forward});
  factory _ModuleStat.fromJson(Map<String, dynamic> json) => _$ModuleStatFromJson(json);

@override final  StatLike like;
@override final  StatCommon comment;
@override final  StatCommon forward;

/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleStatCopyWith<_ModuleStat> get copyWith => __$ModuleStatCopyWithImpl<_ModuleStat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleStatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleStat&&(identical(other.like, like) || other.like == like)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.forward, forward) || other.forward == forward));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,like,comment,forward);

@override
String toString() {
  return 'ModuleStat(like: $like, comment: $comment, forward: $forward)';
}


}

/// @nodoc
abstract mixin class _$ModuleStatCopyWith<$Res> implements $ModuleStatCopyWith<$Res> {
  factory _$ModuleStatCopyWith(_ModuleStat value, $Res Function(_ModuleStat) _then) = __$ModuleStatCopyWithImpl;
@override @useResult
$Res call({
 StatLike like, StatCommon comment, StatCommon forward
});


@override $StatLikeCopyWith<$Res> get like;@override $StatCommonCopyWith<$Res> get comment;@override $StatCommonCopyWith<$Res> get forward;

}
/// @nodoc
class __$ModuleStatCopyWithImpl<$Res>
    implements _$ModuleStatCopyWith<$Res> {
  __$ModuleStatCopyWithImpl(this._self, this._then);

  final _ModuleStat _self;
  final $Res Function(_ModuleStat) _then;

/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? like = null,Object? comment = null,Object? forward = null,}) {
  return _then(_ModuleStat(
like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as StatLike,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as StatCommon,forward: null == forward ? _self.forward : forward // ignore: cast_nullable_to_non_nullable
as StatCommon,
  ));
}

/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatLikeCopyWith<$Res> get like {
  
  return $StatLikeCopyWith<$Res>(_self.like, (value) {
    return _then(_self.copyWith(like: value));
  });
}/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCommonCopyWith<$Res> get comment {
  
  return $StatCommonCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}/// Create a copy of ModuleStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatCommonCopyWith<$Res> get forward {
  
  return $StatCommonCopyWith<$Res>(_self.forward, (value) {
    return _then(_self.copyWith(forward: value));
  });
}
}


/// @nodoc
mixin _$StatLike {

 int get count; bool get status;
/// Create a copy of StatLike
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatLikeCopyWith<StatLike> get copyWith => _$StatLikeCopyWithImpl<StatLike>(this as StatLike, _$identity);

  /// Serializes this StatLike to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatLike&&(identical(other.count, count) || other.count == count)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,status);

@override
String toString() {
  return 'StatLike(count: $count, status: $status)';
}


}

/// @nodoc
abstract mixin class $StatLikeCopyWith<$Res>  {
  factory $StatLikeCopyWith(StatLike value, $Res Function(StatLike) _then) = _$StatLikeCopyWithImpl;
@useResult
$Res call({
 int count, bool status
});




}
/// @nodoc
class _$StatLikeCopyWithImpl<$Res>
    implements $StatLikeCopyWith<$Res> {
  _$StatLikeCopyWithImpl(this._self, this._then);

  final StatLike _self;
  final $Res Function(StatLike) _then;

/// Create a copy of StatLike
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? status = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StatLike].
extension StatLikePatterns on StatLike {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatLike value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatLike() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatLike value)  $default,){
final _that = this;
switch (_that) {
case _StatLike():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatLike value)?  $default,){
final _that = this;
switch (_that) {
case _StatLike() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  bool status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatLike() when $default != null:
return $default(_that.count,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  bool status)  $default,) {final _that = this;
switch (_that) {
case _StatLike():
return $default(_that.count,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  bool status)?  $default,) {final _that = this;
switch (_that) {
case _StatLike() when $default != null:
return $default(_that.count,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatLike implements StatLike {
  const _StatLike({required this.count, required this.status});
  factory _StatLike.fromJson(Map<String, dynamic> json) => _$StatLikeFromJson(json);

@override final  int count;
@override final  bool status;

/// Create a copy of StatLike
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatLikeCopyWith<_StatLike> get copyWith => __$StatLikeCopyWithImpl<_StatLike>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatLikeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatLike&&(identical(other.count, count) || other.count == count)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,status);

@override
String toString() {
  return 'StatLike(count: $count, status: $status)';
}


}

/// @nodoc
abstract mixin class _$StatLikeCopyWith<$Res> implements $StatLikeCopyWith<$Res> {
  factory _$StatLikeCopyWith(_StatLike value, $Res Function(_StatLike) _then) = __$StatLikeCopyWithImpl;
@override @useResult
$Res call({
 int count, bool status
});




}
/// @nodoc
class __$StatLikeCopyWithImpl<$Res>
    implements _$StatLikeCopyWith<$Res> {
  __$StatLikeCopyWithImpl(this._self, this._then);

  final _StatLike _self;
  final $Res Function(_StatLike) _then;

/// Create a copy of StatLike
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? status = null,}) {
  return _then(_StatLike(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$StatCommon {

 int get count;
/// Create a copy of StatCommon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatCommonCopyWith<StatCommon> get copyWith => _$StatCommonCopyWithImpl<StatCommon>(this as StatCommon, _$identity);

  /// Serializes this StatCommon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatCommon&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'StatCommon(count: $count)';
}


}

/// @nodoc
abstract mixin class $StatCommonCopyWith<$Res>  {
  factory $StatCommonCopyWith(StatCommon value, $Res Function(StatCommon) _then) = _$StatCommonCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$StatCommonCopyWithImpl<$Res>
    implements $StatCommonCopyWith<$Res> {
  _$StatCommonCopyWithImpl(this._self, this._then);

  final StatCommon _self;
  final $Res Function(StatCommon) _then;

/// Create a copy of StatCommon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatCommon].
extension StatCommonPatterns on StatCommon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatCommon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatCommon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatCommon value)  $default,){
final _that = this;
switch (_that) {
case _StatCommon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatCommon value)?  $default,){
final _that = this;
switch (_that) {
case _StatCommon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatCommon() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _StatCommon():
return $default(_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _StatCommon() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatCommon implements StatCommon {
  const _StatCommon({required this.count});
  factory _StatCommon.fromJson(Map<String, dynamic> json) => _$StatCommonFromJson(json);

@override final  int count;

/// Create a copy of StatCommon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatCommonCopyWith<_StatCommon> get copyWith => __$StatCommonCopyWithImpl<_StatCommon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatCommonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatCommon&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'StatCommon(count: $count)';
}


}

/// @nodoc
abstract mixin class _$StatCommonCopyWith<$Res> implements $StatCommonCopyWith<$Res> {
  factory _$StatCommonCopyWith(_StatCommon value, $Res Function(_StatCommon) _then) = __$StatCommonCopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$StatCommonCopyWithImpl<$Res>
    implements _$StatCommonCopyWith<$Res> {
  __$StatCommonCopyWithImpl(this._self, this._then);

  final _StatCommon _self;
  final $Res Function(_StatCommon) _then;

/// Create a copy of StatCommon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_StatCommon(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ModuleTopic {

 String get name;@JsonKey(name: 'jump_url') String get jumpUrl;
/// Create a copy of ModuleTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleTopicCopyWith<ModuleTopic> get copyWith => _$ModuleTopicCopyWithImpl<ModuleTopic>(this as ModuleTopic, _$identity);

  /// Serializes this ModuleTopic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleTopic&&(identical(other.name, name) || other.name == name)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,jumpUrl);

@override
String toString() {
  return 'ModuleTopic(name: $name, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $ModuleTopicCopyWith<$Res>  {
  factory $ModuleTopicCopyWith(ModuleTopic value, $Res Function(ModuleTopic) _then) = _$ModuleTopicCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class _$ModuleTopicCopyWithImpl<$Res>
    implements $ModuleTopicCopyWith<$Res> {
  _$ModuleTopicCopyWithImpl(this._self, this._then);

  final ModuleTopic _self;
  final $Res Function(ModuleTopic) _then;

/// Create a copy of ModuleTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? jumpUrl = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleTopic].
extension ModuleTopicPatterns on ModuleTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleTopic value)  $default,){
final _that = this;
switch (_that) {
case _ModuleTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleTopic value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleTopic() when $default != null:
return $default(_that.name,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'jump_url')  String jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _ModuleTopic():
return $default(_that.name,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'jump_url')  String jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _ModuleTopic() when $default != null:
return $default(_that.name,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleTopic implements ModuleTopic {
  const _ModuleTopic({required this.name, @JsonKey(name: 'jump_url') required this.jumpUrl});
  factory _ModuleTopic.fromJson(Map<String, dynamic> json) => _$ModuleTopicFromJson(json);

@override final  String name;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;

/// Create a copy of ModuleTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleTopicCopyWith<_ModuleTopic> get copyWith => __$ModuleTopicCopyWithImpl<_ModuleTopic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleTopicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleTopic&&(identical(other.name, name) || other.name == name)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,jumpUrl);

@override
String toString() {
  return 'ModuleTopic(name: $name, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$ModuleTopicCopyWith<$Res> implements $ModuleTopicCopyWith<$Res> {
  factory _$ModuleTopicCopyWith(_ModuleTopic value, $Res Function(_ModuleTopic) _then) = __$ModuleTopicCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'jump_url') String jumpUrl
});




}
/// @nodoc
class __$ModuleTopicCopyWithImpl<$Res>
    implements _$ModuleTopicCopyWith<$Res> {
  __$ModuleTopicCopyWithImpl(this._self, this._then);

  final _ModuleTopic _self;
  final $Res Function(_ModuleTopic) _then;

/// Create a copy of ModuleTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? jumpUrl = null,}) {
  return _then(_ModuleTopic(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MajorPgc {

 String get cover; String get title;@JsonKey(name: 'jump_url') String get jumpUrl; MajorStat get stat;@JsonKey(name: 'season_id') int get seasonId;@JsonKey(name: 'epid') int get epid;@JsonKey(name: 'sub_type') int get subType; int get type;
/// Create a copy of MajorPgc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorPgcCopyWith<MajorPgc> get copyWith => _$MajorPgcCopyWithImpl<MajorPgc>(this as MajorPgc, _$identity);

  /// Serializes this MajorPgc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorPgc&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.epid, epid) || other.epid == epid)&&(identical(other.subType, subType) || other.subType == subType)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,jumpUrl,stat,seasonId,epid,subType,type);

@override
String toString() {
  return 'MajorPgc(cover: $cover, title: $title, jumpUrl: $jumpUrl, stat: $stat, seasonId: $seasonId, epid: $epid, subType: $subType, type: $type)';
}


}

/// @nodoc
abstract mixin class $MajorPgcCopyWith<$Res>  {
  factory $MajorPgcCopyWith(MajorPgc value, $Res Function(MajorPgc) _then) = _$MajorPgcCopyWithImpl;
@useResult
$Res call({
 String cover, String title,@JsonKey(name: 'jump_url') String jumpUrl, MajorStat stat,@JsonKey(name: 'season_id') int seasonId,@JsonKey(name: 'epid') int epid,@JsonKey(name: 'sub_type') int subType, int type
});


$MajorStatCopyWith<$Res> get stat;

}
/// @nodoc
class _$MajorPgcCopyWithImpl<$Res>
    implements $MajorPgcCopyWith<$Res> {
  _$MajorPgcCopyWithImpl(this._self, this._then);

  final MajorPgc _self;
  final $Res Function(MajorPgc) _then;

/// Create a copy of MajorPgc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cover = null,Object? title = null,Object? jumpUrl = null,Object? stat = null,Object? seasonId = null,Object? epid = null,Object? subType = null,Object? type = null,}) {
  return _then(_self.copyWith(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as MajorStat,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int,epid: null == epid ? _self.epid : epid // ignore: cast_nullable_to_non_nullable
as int,subType: null == subType ? _self.subType : subType // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MajorPgc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorStatCopyWith<$Res> get stat {
  
  return $MajorStatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [MajorPgc].
extension MajorPgcPatterns on MajorPgc {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorPgc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorPgc() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorPgc value)  $default,){
final _that = this;
switch (_that) {
case _MajorPgc():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorPgc value)?  $default,){
final _that = this;
switch (_that) {
case _MajorPgc() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cover,  String title, @JsonKey(name: 'jump_url')  String jumpUrl,  MajorStat stat, @JsonKey(name: 'season_id')  int seasonId, @JsonKey(name: 'epid')  int epid, @JsonKey(name: 'sub_type')  int subType,  int type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorPgc() when $default != null:
return $default(_that.cover,_that.title,_that.jumpUrl,_that.stat,_that.seasonId,_that.epid,_that.subType,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cover,  String title, @JsonKey(name: 'jump_url')  String jumpUrl,  MajorStat stat, @JsonKey(name: 'season_id')  int seasonId, @JsonKey(name: 'epid')  int epid, @JsonKey(name: 'sub_type')  int subType,  int type)  $default,) {final _that = this;
switch (_that) {
case _MajorPgc():
return $default(_that.cover,_that.title,_that.jumpUrl,_that.stat,_that.seasonId,_that.epid,_that.subType,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cover,  String title, @JsonKey(name: 'jump_url')  String jumpUrl,  MajorStat stat, @JsonKey(name: 'season_id')  int seasonId, @JsonKey(name: 'epid')  int epid, @JsonKey(name: 'sub_type')  int subType,  int type)?  $default,) {final _that = this;
switch (_that) {
case _MajorPgc() when $default != null:
return $default(_that.cover,_that.title,_that.jumpUrl,_that.stat,_that.seasonId,_that.epid,_that.subType,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorPgc implements MajorPgc {
  const _MajorPgc({required this.cover, required this.title, @JsonKey(name: 'jump_url') required this.jumpUrl, required this.stat, @JsonKey(name: 'season_id') required this.seasonId, @JsonKey(name: 'epid') required this.epid, @JsonKey(name: 'sub_type') required this.subType, required this.type});
  factory _MajorPgc.fromJson(Map<String, dynamic> json) => _$MajorPgcFromJson(json);

@override final  String cover;
@override final  String title;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override final  MajorStat stat;
@override@JsonKey(name: 'season_id') final  int seasonId;
@override@JsonKey(name: 'epid') final  int epid;
@override@JsonKey(name: 'sub_type') final  int subType;
@override final  int type;

/// Create a copy of MajorPgc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorPgcCopyWith<_MajorPgc> get copyWith => __$MajorPgcCopyWithImpl<_MajorPgc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorPgcToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorPgc&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.stat, stat) || other.stat == stat)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.epid, epid) || other.epid == epid)&&(identical(other.subType, subType) || other.subType == subType)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,jumpUrl,stat,seasonId,epid,subType,type);

@override
String toString() {
  return 'MajorPgc(cover: $cover, title: $title, jumpUrl: $jumpUrl, stat: $stat, seasonId: $seasonId, epid: $epid, subType: $subType, type: $type)';
}


}

/// @nodoc
abstract mixin class _$MajorPgcCopyWith<$Res> implements $MajorPgcCopyWith<$Res> {
  factory _$MajorPgcCopyWith(_MajorPgc value, $Res Function(_MajorPgc) _then) = __$MajorPgcCopyWithImpl;
@override @useResult
$Res call({
 String cover, String title,@JsonKey(name: 'jump_url') String jumpUrl, MajorStat stat,@JsonKey(name: 'season_id') int seasonId,@JsonKey(name: 'epid') int epid,@JsonKey(name: 'sub_type') int subType, int type
});


@override $MajorStatCopyWith<$Res> get stat;

}
/// @nodoc
class __$MajorPgcCopyWithImpl<$Res>
    implements _$MajorPgcCopyWith<$Res> {
  __$MajorPgcCopyWithImpl(this._self, this._then);

  final _MajorPgc _self;
  final $Res Function(_MajorPgc) _then;

/// Create a copy of MajorPgc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cover = null,Object? title = null,Object? jumpUrl = null,Object? stat = null,Object? seasonId = null,Object? epid = null,Object? subType = null,Object? type = null,}) {
  return _then(_MajorPgc(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,stat: null == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as MajorStat,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int,epid: null == epid ? _self.epid : epid // ignore: cast_nullable_to_non_nullable
as int,subType: null == subType ? _self.subType : subType // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MajorPgc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MajorStatCopyWith<$Res> get stat {
  
  return $MajorStatCopyWith<$Res>(_self.stat, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// @nodoc
mixin _$MajorCourses {

 String get cover; String get title;@JsonKey(name: 'sub_title') String get subTitle; String get desc;@JsonKey(name: 'jump_url') String get jumpUrl; int get id;
/// Create a copy of MajorCourses
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorCoursesCopyWith<MajorCourses> get copyWith => _$MajorCoursesCopyWithImpl<MajorCourses>(this as MajorCourses, _$identity);

  /// Serializes this MajorCourses to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorCourses&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,subTitle,desc,jumpUrl,id);

@override
String toString() {
  return 'MajorCourses(cover: $cover, title: $title, subTitle: $subTitle, desc: $desc, jumpUrl: $jumpUrl, id: $id)';
}


}

/// @nodoc
abstract mixin class $MajorCoursesCopyWith<$Res>  {
  factory $MajorCoursesCopyWith(MajorCourses value, $Res Function(MajorCourses) _then) = _$MajorCoursesCopyWithImpl;
@useResult
$Res call({
 String cover, String title,@JsonKey(name: 'sub_title') String subTitle, String desc,@JsonKey(name: 'jump_url') String jumpUrl, int id
});




}
/// @nodoc
class _$MajorCoursesCopyWithImpl<$Res>
    implements $MajorCoursesCopyWith<$Res> {
  _$MajorCoursesCopyWithImpl(this._self, this._then);

  final MajorCourses _self;
  final $Res Function(MajorCourses) _then;

/// Create a copy of MajorCourses
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cover = null,Object? title = null,Object? subTitle = null,Object? desc = null,Object? jumpUrl = null,Object? id = null,}) {
  return _then(_self.copyWith(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subTitle: null == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorCourses].
extension MajorCoursesPatterns on MajorCourses {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorCourses value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorCourses() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorCourses value)  $default,){
final _that = this;
switch (_that) {
case _MajorCourses():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorCourses value)?  $default,){
final _that = this;
switch (_that) {
case _MajorCourses() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cover,  String title, @JsonKey(name: 'sub_title')  String subTitle,  String desc, @JsonKey(name: 'jump_url')  String jumpUrl,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorCourses() when $default != null:
return $default(_that.cover,_that.title,_that.subTitle,_that.desc,_that.jumpUrl,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cover,  String title, @JsonKey(name: 'sub_title')  String subTitle,  String desc, @JsonKey(name: 'jump_url')  String jumpUrl,  int id)  $default,) {final _that = this;
switch (_that) {
case _MajorCourses():
return $default(_that.cover,_that.title,_that.subTitle,_that.desc,_that.jumpUrl,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cover,  String title, @JsonKey(name: 'sub_title')  String subTitle,  String desc, @JsonKey(name: 'jump_url')  String jumpUrl,  int id)?  $default,) {final _that = this;
switch (_that) {
case _MajorCourses() when $default != null:
return $default(_that.cover,_that.title,_that.subTitle,_that.desc,_that.jumpUrl,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorCourses implements MajorCourses {
  const _MajorCourses({required this.cover, required this.title, @JsonKey(name: 'sub_title') required this.subTitle, required this.desc, @JsonKey(name: 'jump_url') required this.jumpUrl, required this.id});
  factory _MajorCourses.fromJson(Map<String, dynamic> json) => _$MajorCoursesFromJson(json);

@override final  String cover;
@override final  String title;
@override@JsonKey(name: 'sub_title') final  String subTitle;
@override final  String desc;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override final  int id;

/// Create a copy of MajorCourses
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorCoursesCopyWith<_MajorCourses> get copyWith => __$MajorCoursesCopyWithImpl<_MajorCourses>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorCoursesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorCourses&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,subTitle,desc,jumpUrl,id);

@override
String toString() {
  return 'MajorCourses(cover: $cover, title: $title, subTitle: $subTitle, desc: $desc, jumpUrl: $jumpUrl, id: $id)';
}


}

/// @nodoc
abstract mixin class _$MajorCoursesCopyWith<$Res> implements $MajorCoursesCopyWith<$Res> {
  factory _$MajorCoursesCopyWith(_MajorCourses value, $Res Function(_MajorCourses) _then) = __$MajorCoursesCopyWithImpl;
@override @useResult
$Res call({
 String cover, String title,@JsonKey(name: 'sub_title') String subTitle, String desc,@JsonKey(name: 'jump_url') String jumpUrl, int id
});




}
/// @nodoc
class __$MajorCoursesCopyWithImpl<$Res>
    implements _$MajorCoursesCopyWith<$Res> {
  __$MajorCoursesCopyWithImpl(this._self, this._then);

  final _MajorCourses _self;
  final $Res Function(_MajorCourses) _then;

/// Create a copy of MajorCourses
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cover = null,Object? title = null,Object? subTitle = null,Object? desc = null,Object? jumpUrl = null,Object? id = null,}) {
  return _then(_MajorCourses(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subTitle: null == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MajorMusic {

 String get cover; String get title; String get label;@JsonKey(name: 'jump_url') String get jumpUrl; int get id;
/// Create a copy of MajorMusic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorMusicCopyWith<MajorMusic> get copyWith => _$MajorMusicCopyWithImpl<MajorMusic>(this as MajorMusic, _$identity);

  /// Serializes this MajorMusic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorMusic&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.label, label) || other.label == label)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,label,jumpUrl,id);

@override
String toString() {
  return 'MajorMusic(cover: $cover, title: $title, label: $label, jumpUrl: $jumpUrl, id: $id)';
}


}

/// @nodoc
abstract mixin class $MajorMusicCopyWith<$Res>  {
  factory $MajorMusicCopyWith(MajorMusic value, $Res Function(MajorMusic) _then) = _$MajorMusicCopyWithImpl;
@useResult
$Res call({
 String cover, String title, String label,@JsonKey(name: 'jump_url') String jumpUrl, int id
});




}
/// @nodoc
class _$MajorMusicCopyWithImpl<$Res>
    implements $MajorMusicCopyWith<$Res> {
  _$MajorMusicCopyWithImpl(this._self, this._then);

  final MajorMusic _self;
  final $Res Function(MajorMusic) _then;

/// Create a copy of MajorMusic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cover = null,Object? title = null,Object? label = null,Object? jumpUrl = null,Object? id = null,}) {
  return _then(_self.copyWith(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorMusic].
extension MajorMusicPatterns on MajorMusic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorMusic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorMusic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorMusic value)  $default,){
final _that = this;
switch (_that) {
case _MajorMusic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorMusic value)?  $default,){
final _that = this;
switch (_that) {
case _MajorMusic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cover,  String title,  String label, @JsonKey(name: 'jump_url')  String jumpUrl,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorMusic() when $default != null:
return $default(_that.cover,_that.title,_that.label,_that.jumpUrl,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cover,  String title,  String label, @JsonKey(name: 'jump_url')  String jumpUrl,  int id)  $default,) {final _that = this;
switch (_that) {
case _MajorMusic():
return $default(_that.cover,_that.title,_that.label,_that.jumpUrl,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cover,  String title,  String label, @JsonKey(name: 'jump_url')  String jumpUrl,  int id)?  $default,) {final _that = this;
switch (_that) {
case _MajorMusic() when $default != null:
return $default(_that.cover,_that.title,_that.label,_that.jumpUrl,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorMusic implements MajorMusic {
  const _MajorMusic({required this.cover, required this.title, required this.label, @JsonKey(name: 'jump_url') required this.jumpUrl, required this.id});
  factory _MajorMusic.fromJson(Map<String, dynamic> json) => _$MajorMusicFromJson(json);

@override final  String cover;
@override final  String title;
@override final  String label;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override final  int id;

/// Create a copy of MajorMusic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorMusicCopyWith<_MajorMusic> get copyWith => __$MajorMusicCopyWithImpl<_MajorMusic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorMusicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorMusic&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.label, label) || other.label == label)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,label,jumpUrl,id);

@override
String toString() {
  return 'MajorMusic(cover: $cover, title: $title, label: $label, jumpUrl: $jumpUrl, id: $id)';
}


}

/// @nodoc
abstract mixin class _$MajorMusicCopyWith<$Res> implements $MajorMusicCopyWith<$Res> {
  factory _$MajorMusicCopyWith(_MajorMusic value, $Res Function(_MajorMusic) _then) = __$MajorMusicCopyWithImpl;
@override @useResult
$Res call({
 String cover, String title, String label,@JsonKey(name: 'jump_url') String jumpUrl, int id
});




}
/// @nodoc
class __$MajorMusicCopyWithImpl<$Res>
    implements _$MajorMusicCopyWith<$Res> {
  __$MajorMusicCopyWithImpl(this._self, this._then);

  final _MajorMusic _self;
  final $Res Function(_MajorMusic) _then;

/// Create a copy of MajorMusic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cover = null,Object? title = null,Object? label = null,Object? jumpUrl = null,Object? id = null,}) {
  return _then(_MajorMusic(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MajorOpus {

 String? get title; OpusSummary? get summary; List<OpusPic>? get pics;@JsonKey(name: 'jump_url') String? get jumpUrl;
/// Create a copy of MajorOpus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorOpusCopyWith<MajorOpus> get copyWith => _$MajorOpusCopyWithImpl<MajorOpus>(this as MajorOpus, _$identity);

  /// Serializes this MajorOpus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorOpus&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.pics, pics)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,summary,const DeepCollectionEquality().hash(pics),jumpUrl);

@override
String toString() {
  return 'MajorOpus(title: $title, summary: $summary, pics: $pics, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class $MajorOpusCopyWith<$Res>  {
  factory $MajorOpusCopyWith(MajorOpus value, $Res Function(MajorOpus) _then) = _$MajorOpusCopyWithImpl;
@useResult
$Res call({
 String? title, OpusSummary? summary, List<OpusPic>? pics,@JsonKey(name: 'jump_url') String? jumpUrl
});


$OpusSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$MajorOpusCopyWithImpl<$Res>
    implements $MajorOpusCopyWith<$Res> {
  _$MajorOpusCopyWithImpl(this._self, this._then);

  final MajorOpus _self;
  final $Res Function(MajorOpus) _then;

/// Create a copy of MajorOpus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? summary = freezed,Object? pics = freezed,Object? jumpUrl = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as OpusSummary?,pics: freezed == pics ? _self.pics : pics // ignore: cast_nullable_to_non_nullable
as List<OpusPic>?,jumpUrl: freezed == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MajorOpus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpusSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $OpusSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [MajorOpus].
extension MajorOpusPatterns on MajorOpus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorOpus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorOpus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorOpus value)  $default,){
final _that = this;
switch (_that) {
case _MajorOpus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorOpus value)?  $default,){
final _that = this;
switch (_that) {
case _MajorOpus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  OpusSummary? summary,  List<OpusPic>? pics, @JsonKey(name: 'jump_url')  String? jumpUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorOpus() when $default != null:
return $default(_that.title,_that.summary,_that.pics,_that.jumpUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  OpusSummary? summary,  List<OpusPic>? pics, @JsonKey(name: 'jump_url')  String? jumpUrl)  $default,) {final _that = this;
switch (_that) {
case _MajorOpus():
return $default(_that.title,_that.summary,_that.pics,_that.jumpUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  OpusSummary? summary,  List<OpusPic>? pics, @JsonKey(name: 'jump_url')  String? jumpUrl)?  $default,) {final _that = this;
switch (_that) {
case _MajorOpus() when $default != null:
return $default(_that.title,_that.summary,_that.pics,_that.jumpUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorOpus implements MajorOpus {
  const _MajorOpus({this.title, this.summary, final  List<OpusPic>? pics, @JsonKey(name: 'jump_url') this.jumpUrl}): _pics = pics;
  factory _MajorOpus.fromJson(Map<String, dynamic> json) => _$MajorOpusFromJson(json);

@override final  String? title;
@override final  OpusSummary? summary;
 final  List<OpusPic>? _pics;
@override List<OpusPic>? get pics {
  final value = _pics;
  if (value == null) return null;
  if (_pics is EqualUnmodifiableListView) return _pics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'jump_url') final  String? jumpUrl;

/// Create a copy of MajorOpus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorOpusCopyWith<_MajorOpus> get copyWith => __$MajorOpusCopyWithImpl<_MajorOpus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorOpusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorOpus&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._pics, _pics)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,summary,const DeepCollectionEquality().hash(_pics),jumpUrl);

@override
String toString() {
  return 'MajorOpus(title: $title, summary: $summary, pics: $pics, jumpUrl: $jumpUrl)';
}


}

/// @nodoc
abstract mixin class _$MajorOpusCopyWith<$Res> implements $MajorOpusCopyWith<$Res> {
  factory _$MajorOpusCopyWith(_MajorOpus value, $Res Function(_MajorOpus) _then) = __$MajorOpusCopyWithImpl;
@override @useResult
$Res call({
 String? title, OpusSummary? summary, List<OpusPic>? pics,@JsonKey(name: 'jump_url') String? jumpUrl
});


@override $OpusSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$MajorOpusCopyWithImpl<$Res>
    implements _$MajorOpusCopyWith<$Res> {
  __$MajorOpusCopyWithImpl(this._self, this._then);

  final _MajorOpus _self;
  final $Res Function(_MajorOpus) _then;

/// Create a copy of MajorOpus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? summary = freezed,Object? pics = freezed,Object? jumpUrl = freezed,}) {
  return _then(_MajorOpus(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as OpusSummary?,pics: freezed == pics ? _self._pics : pics // ignore: cast_nullable_to_non_nullable
as List<OpusPic>?,jumpUrl: freezed == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MajorOpus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpusSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $OpusSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$OpusSummary {

 String? get text;@JsonKey(name: 'rich_text_nodes') List<dynamic>? get richTextNodes;
/// Create a copy of OpusSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpusSummaryCopyWith<OpusSummary> get copyWith => _$OpusSummaryCopyWithImpl<OpusSummary>(this as OpusSummary, _$identity);

  /// Serializes this OpusSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpusSummary&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.richTextNodes, richTextNodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(richTextNodes));

@override
String toString() {
  return 'OpusSummary(text: $text, richTextNodes: $richTextNodes)';
}


}

/// @nodoc
abstract mixin class $OpusSummaryCopyWith<$Res>  {
  factory $OpusSummaryCopyWith(OpusSummary value, $Res Function(OpusSummary) _then) = _$OpusSummaryCopyWithImpl;
@useResult
$Res call({
 String? text,@JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes
});




}
/// @nodoc
class _$OpusSummaryCopyWithImpl<$Res>
    implements $OpusSummaryCopyWith<$Res> {
  _$OpusSummaryCopyWithImpl(this._self, this._then);

  final OpusSummary _self;
  final $Res Function(OpusSummary) _then;

/// Create a copy of OpusSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? richTextNodes = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,richTextNodes: freezed == richTextNodes ? _self.richTextNodes : richTextNodes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpusSummary].
extension OpusSummaryPatterns on OpusSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpusSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpusSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpusSummary value)  $default,){
final _that = this;
switch (_that) {
case _OpusSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpusSummary value)?  $default,){
final _that = this;
switch (_that) {
case _OpusSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text, @JsonKey(name: 'rich_text_nodes')  List<dynamic>? richTextNodes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpusSummary() when $default != null:
return $default(_that.text,_that.richTextNodes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text, @JsonKey(name: 'rich_text_nodes')  List<dynamic>? richTextNodes)  $default,) {final _that = this;
switch (_that) {
case _OpusSummary():
return $default(_that.text,_that.richTextNodes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text, @JsonKey(name: 'rich_text_nodes')  List<dynamic>? richTextNodes)?  $default,) {final _that = this;
switch (_that) {
case _OpusSummary() when $default != null:
return $default(_that.text,_that.richTextNodes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpusSummary implements OpusSummary {
  const _OpusSummary({this.text, @JsonKey(name: 'rich_text_nodes') final  List<dynamic>? richTextNodes}): _richTextNodes = richTextNodes;
  factory _OpusSummary.fromJson(Map<String, dynamic> json) => _$OpusSummaryFromJson(json);

@override final  String? text;
 final  List<dynamic>? _richTextNodes;
@override@JsonKey(name: 'rich_text_nodes') List<dynamic>? get richTextNodes {
  final value = _richTextNodes;
  if (value == null) return null;
  if (_richTextNodes is EqualUnmodifiableListView) return _richTextNodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OpusSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpusSummaryCopyWith<_OpusSummary> get copyWith => __$OpusSummaryCopyWithImpl<_OpusSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpusSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpusSummary&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._richTextNodes, _richTextNodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_richTextNodes));

@override
String toString() {
  return 'OpusSummary(text: $text, richTextNodes: $richTextNodes)';
}


}

/// @nodoc
abstract mixin class _$OpusSummaryCopyWith<$Res> implements $OpusSummaryCopyWith<$Res> {
  factory _$OpusSummaryCopyWith(_OpusSummary value, $Res Function(_OpusSummary) _then) = __$OpusSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? text,@JsonKey(name: 'rich_text_nodes') List<dynamic>? richTextNodes
});




}
/// @nodoc
class __$OpusSummaryCopyWithImpl<$Res>
    implements _$OpusSummaryCopyWith<$Res> {
  __$OpusSummaryCopyWithImpl(this._self, this._then);

  final _OpusSummary _self;
  final $Res Function(_OpusSummary) _then;

/// Create a copy of OpusSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? richTextNodes = freezed,}) {
  return _then(_OpusSummary(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,richTextNodes: freezed == richTextNodes ? _self._richTextNodes : richTextNodes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$OpusPic {

 String? get url; int? get width; int? get height; int? get size;
/// Create a copy of OpusPic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpusPicCopyWith<OpusPic> get copyWith => _$OpusPicCopyWithImpl<OpusPic>(this as OpusPic, _$identity);

  /// Serializes this OpusPic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpusPic&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,width,height,size);

@override
String toString() {
  return 'OpusPic(url: $url, width: $width, height: $height, size: $size)';
}


}

/// @nodoc
abstract mixin class $OpusPicCopyWith<$Res>  {
  factory $OpusPicCopyWith(OpusPic value, $Res Function(OpusPic) _then) = _$OpusPicCopyWithImpl;
@useResult
$Res call({
 String? url, int? width, int? height, int? size
});




}
/// @nodoc
class _$OpusPicCopyWithImpl<$Res>
    implements $OpusPicCopyWith<$Res> {
  _$OpusPicCopyWithImpl(this._self, this._then);

  final OpusPic _self;
  final $Res Function(OpusPic) _then;

/// Create a copy of OpusPic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? width = freezed,Object? height = freezed,Object? size = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpusPic].
extension OpusPicPatterns on OpusPic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpusPic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpusPic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpusPic value)  $default,){
final _that = this;
switch (_that) {
case _OpusPic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpusPic value)?  $default,){
final _that = this;
switch (_that) {
case _OpusPic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  int? width,  int? height,  int? size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpusPic() when $default != null:
return $default(_that.url,_that.width,_that.height,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  int? width,  int? height,  int? size)  $default,) {final _that = this;
switch (_that) {
case _OpusPic():
return $default(_that.url,_that.width,_that.height,_that.size);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  int? width,  int? height,  int? size)?  $default,) {final _that = this;
switch (_that) {
case _OpusPic() when $default != null:
return $default(_that.url,_that.width,_that.height,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpusPic implements OpusPic {
  const _OpusPic({this.url, this.width, this.height, this.size});
  factory _OpusPic.fromJson(Map<String, dynamic> json) => _$OpusPicFromJson(json);

@override final  String? url;
@override final  int? width;
@override final  int? height;
@override final  int? size;

/// Create a copy of OpusPic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpusPicCopyWith<_OpusPic> get copyWith => __$OpusPicCopyWithImpl<_OpusPic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpusPicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpusPic&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,width,height,size);

@override
String toString() {
  return 'OpusPic(url: $url, width: $width, height: $height, size: $size)';
}


}

/// @nodoc
abstract mixin class _$OpusPicCopyWith<$Res> implements $OpusPicCopyWith<$Res> {
  factory _$OpusPicCopyWith(_OpusPic value, $Res Function(_OpusPic) _then) = __$OpusPicCopyWithImpl;
@override @useResult
$Res call({
 String? url, int? width, int? height, int? size
});




}
/// @nodoc
class __$OpusPicCopyWithImpl<$Res>
    implements _$OpusPicCopyWith<$Res> {
  __$OpusPicCopyWithImpl(this._self, this._then);

  final _OpusPic _self;
  final $Res Function(_OpusPic) _then;

/// Create a copy of OpusPic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? width = freezed,Object? height = freezed,Object? size = freezed,}) {
  return _then(_OpusPic(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MajorLive {

 String get cover; String get title;@JsonKey(name: 'live_state') int get liveState;@JsonKey(name: 'jump_url') String get jumpUrl;@JsonKey(name: 'desc_first') String get descFirst;@JsonKey(name: 'desc_second') String get descSecond;
/// Create a copy of MajorLive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorLiveCopyWith<MajorLive> get copyWith => _$MajorLiveCopyWithImpl<MajorLive>(this as MajorLive, _$identity);

  /// Serializes this MajorLive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorLive&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.liveState, liveState) || other.liveState == liveState)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.descFirst, descFirst) || other.descFirst == descFirst)&&(identical(other.descSecond, descSecond) || other.descSecond == descSecond));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,liveState,jumpUrl,descFirst,descSecond);

@override
String toString() {
  return 'MajorLive(cover: $cover, title: $title, liveState: $liveState, jumpUrl: $jumpUrl, descFirst: $descFirst, descSecond: $descSecond)';
}


}

/// @nodoc
abstract mixin class $MajorLiveCopyWith<$Res>  {
  factory $MajorLiveCopyWith(MajorLive value, $Res Function(MajorLive) _then) = _$MajorLiveCopyWithImpl;
@useResult
$Res call({
 String cover, String title,@JsonKey(name: 'live_state') int liveState,@JsonKey(name: 'jump_url') String jumpUrl,@JsonKey(name: 'desc_first') String descFirst,@JsonKey(name: 'desc_second') String descSecond
});




}
/// @nodoc
class _$MajorLiveCopyWithImpl<$Res>
    implements $MajorLiveCopyWith<$Res> {
  _$MajorLiveCopyWithImpl(this._self, this._then);

  final MajorLive _self;
  final $Res Function(MajorLive) _then;

/// Create a copy of MajorLive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cover = null,Object? title = null,Object? liveState = null,Object? jumpUrl = null,Object? descFirst = null,Object? descSecond = null,}) {
  return _then(_self.copyWith(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,liveState: null == liveState ? _self.liveState : liveState // ignore: cast_nullable_to_non_nullable
as int,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,descFirst: null == descFirst ? _self.descFirst : descFirst // ignore: cast_nullable_to_non_nullable
as String,descSecond: null == descSecond ? _self.descSecond : descSecond // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorLive].
extension MajorLivePatterns on MajorLive {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorLive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorLive() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorLive value)  $default,){
final _that = this;
switch (_that) {
case _MajorLive():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorLive value)?  $default,){
final _that = this;
switch (_that) {
case _MajorLive() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cover,  String title, @JsonKey(name: 'live_state')  int liveState, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'desc_first')  String descFirst, @JsonKey(name: 'desc_second')  String descSecond)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorLive() when $default != null:
return $default(_that.cover,_that.title,_that.liveState,_that.jumpUrl,_that.descFirst,_that.descSecond);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cover,  String title, @JsonKey(name: 'live_state')  int liveState, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'desc_first')  String descFirst, @JsonKey(name: 'desc_second')  String descSecond)  $default,) {final _that = this;
switch (_that) {
case _MajorLive():
return $default(_that.cover,_that.title,_that.liveState,_that.jumpUrl,_that.descFirst,_that.descSecond);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cover,  String title, @JsonKey(name: 'live_state')  int liveState, @JsonKey(name: 'jump_url')  String jumpUrl, @JsonKey(name: 'desc_first')  String descFirst, @JsonKey(name: 'desc_second')  String descSecond)?  $default,) {final _that = this;
switch (_that) {
case _MajorLive() when $default != null:
return $default(_that.cover,_that.title,_that.liveState,_that.jumpUrl,_that.descFirst,_that.descSecond);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorLive implements MajorLive {
  const _MajorLive({required this.cover, required this.title, @JsonKey(name: 'live_state') required this.liveState, @JsonKey(name: 'jump_url') required this.jumpUrl, @JsonKey(name: 'desc_first') required this.descFirst, @JsonKey(name: 'desc_second') required this.descSecond});
  factory _MajorLive.fromJson(Map<String, dynamic> json) => _$MajorLiveFromJson(json);

@override final  String cover;
@override final  String title;
@override@JsonKey(name: 'live_state') final  int liveState;
@override@JsonKey(name: 'jump_url') final  String jumpUrl;
@override@JsonKey(name: 'desc_first') final  String descFirst;
@override@JsonKey(name: 'desc_second') final  String descSecond;

/// Create a copy of MajorLive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorLiveCopyWith<_MajorLive> get copyWith => __$MajorLiveCopyWithImpl<_MajorLive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorLiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorLive&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.title, title) || other.title == title)&&(identical(other.liveState, liveState) || other.liveState == liveState)&&(identical(other.jumpUrl, jumpUrl) || other.jumpUrl == jumpUrl)&&(identical(other.descFirst, descFirst) || other.descFirst == descFirst)&&(identical(other.descSecond, descSecond) || other.descSecond == descSecond));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cover,title,liveState,jumpUrl,descFirst,descSecond);

@override
String toString() {
  return 'MajorLive(cover: $cover, title: $title, liveState: $liveState, jumpUrl: $jumpUrl, descFirst: $descFirst, descSecond: $descSecond)';
}


}

/// @nodoc
abstract mixin class _$MajorLiveCopyWith<$Res> implements $MajorLiveCopyWith<$Res> {
  factory _$MajorLiveCopyWith(_MajorLive value, $Res Function(_MajorLive) _then) = __$MajorLiveCopyWithImpl;
@override @useResult
$Res call({
 String cover, String title,@JsonKey(name: 'live_state') int liveState,@JsonKey(name: 'jump_url') String jumpUrl,@JsonKey(name: 'desc_first') String descFirst,@JsonKey(name: 'desc_second') String descSecond
});




}
/// @nodoc
class __$MajorLiveCopyWithImpl<$Res>
    implements _$MajorLiveCopyWith<$Res> {
  __$MajorLiveCopyWithImpl(this._self, this._then);

  final _MajorLive _self;
  final $Res Function(_MajorLive) _then;

/// Create a copy of MajorLive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cover = null,Object? title = null,Object? liveState = null,Object? jumpUrl = null,Object? descFirst = null,Object? descSecond = null,}) {
  return _then(_MajorLive(
cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,liveState: null == liveState ? _self.liveState : liveState // ignore: cast_nullable_to_non_nullable
as int,jumpUrl: null == jumpUrl ? _self.jumpUrl : jumpUrl // ignore: cast_nullable_to_non_nullable
as String,descFirst: null == descFirst ? _self.descFirst : descFirst // ignore: cast_nullable_to_non_nullable
as String,descSecond: null == descSecond ? _self.descSecond : descSecond // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MajorLiveRcmd {

 String get content;@JsonKey(name: 'reserve_type') int get reserveType;
/// Create a copy of MajorLiveRcmd
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MajorLiveRcmdCopyWith<MajorLiveRcmd> get copyWith => _$MajorLiveRcmdCopyWithImpl<MajorLiveRcmd>(this as MajorLiveRcmd, _$identity);

  /// Serializes this MajorLiveRcmd to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MajorLiveRcmd&&(identical(other.content, content) || other.content == content)&&(identical(other.reserveType, reserveType) || other.reserveType == reserveType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,reserveType);

@override
String toString() {
  return 'MajorLiveRcmd(content: $content, reserveType: $reserveType)';
}


}

/// @nodoc
abstract mixin class $MajorLiveRcmdCopyWith<$Res>  {
  factory $MajorLiveRcmdCopyWith(MajorLiveRcmd value, $Res Function(MajorLiveRcmd) _then) = _$MajorLiveRcmdCopyWithImpl;
@useResult
$Res call({
 String content,@JsonKey(name: 'reserve_type') int reserveType
});




}
/// @nodoc
class _$MajorLiveRcmdCopyWithImpl<$Res>
    implements $MajorLiveRcmdCopyWith<$Res> {
  _$MajorLiveRcmdCopyWithImpl(this._self, this._then);

  final MajorLiveRcmd _self;
  final $Res Function(MajorLiveRcmd) _then;

/// Create a copy of MajorLiveRcmd
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? reserveType = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,reserveType: null == reserveType ? _self.reserveType : reserveType // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MajorLiveRcmd].
extension MajorLiveRcmdPatterns on MajorLiveRcmd {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MajorLiveRcmd value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MajorLiveRcmd() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MajorLiveRcmd value)  $default,){
final _that = this;
switch (_that) {
case _MajorLiveRcmd():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MajorLiveRcmd value)?  $default,){
final _that = this;
switch (_that) {
case _MajorLiveRcmd() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content, @JsonKey(name: 'reserve_type')  int reserveType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MajorLiveRcmd() when $default != null:
return $default(_that.content,_that.reserveType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content, @JsonKey(name: 'reserve_type')  int reserveType)  $default,) {final _that = this;
switch (_that) {
case _MajorLiveRcmd():
return $default(_that.content,_that.reserveType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content, @JsonKey(name: 'reserve_type')  int reserveType)?  $default,) {final _that = this;
switch (_that) {
case _MajorLiveRcmd() when $default != null:
return $default(_that.content,_that.reserveType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MajorLiveRcmd implements MajorLiveRcmd {
  const _MajorLiveRcmd({required this.content, @JsonKey(name: 'reserve_type') required this.reserveType});
  factory _MajorLiveRcmd.fromJson(Map<String, dynamic> json) => _$MajorLiveRcmdFromJson(json);

@override final  String content;
@override@JsonKey(name: 'reserve_type') final  int reserveType;

/// Create a copy of MajorLiveRcmd
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MajorLiveRcmdCopyWith<_MajorLiveRcmd> get copyWith => __$MajorLiveRcmdCopyWithImpl<_MajorLiveRcmd>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MajorLiveRcmdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MajorLiveRcmd&&(identical(other.content, content) || other.content == content)&&(identical(other.reserveType, reserveType) || other.reserveType == reserveType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,reserveType);

@override
String toString() {
  return 'MajorLiveRcmd(content: $content, reserveType: $reserveType)';
}


}

/// @nodoc
abstract mixin class _$MajorLiveRcmdCopyWith<$Res> implements $MajorLiveRcmdCopyWith<$Res> {
  factory _$MajorLiveRcmdCopyWith(_MajorLiveRcmd value, $Res Function(_MajorLiveRcmd) _then) = __$MajorLiveRcmdCopyWithImpl;
@override @useResult
$Res call({
 String content,@JsonKey(name: 'reserve_type') int reserveType
});




}
/// @nodoc
class __$MajorLiveRcmdCopyWithImpl<$Res>
    implements _$MajorLiveRcmdCopyWith<$Res> {
  __$MajorLiveRcmdCopyWithImpl(this._self, this._then);

  final _MajorLiveRcmd _self;
  final $Res Function(_MajorLiveRcmd) _then;

/// Create a copy of MajorLiveRcmd
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? reserveType = null,}) {
  return _then(_MajorLiveRcmd(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,reserveType: null == reserveType ? _self.reserveType : reserveType // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DynamicPublishData {

@JsonKey(name: 'dyn_id_str') String get dynIdStr;
/// Create a copy of DynamicPublishData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicPublishDataCopyWith<DynamicPublishData> get copyWith => _$DynamicPublishDataCopyWithImpl<DynamicPublishData>(this as DynamicPublishData, _$identity);

  /// Serializes this DynamicPublishData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicPublishData&&(identical(other.dynIdStr, dynIdStr) || other.dynIdStr == dynIdStr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dynIdStr);

@override
String toString() {
  return 'DynamicPublishData(dynIdStr: $dynIdStr)';
}


}

/// @nodoc
abstract mixin class $DynamicPublishDataCopyWith<$Res>  {
  factory $DynamicPublishDataCopyWith(DynamicPublishData value, $Res Function(DynamicPublishData) _then) = _$DynamicPublishDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'dyn_id_str') String dynIdStr
});




}
/// @nodoc
class _$DynamicPublishDataCopyWithImpl<$Res>
    implements $DynamicPublishDataCopyWith<$Res> {
  _$DynamicPublishDataCopyWithImpl(this._self, this._then);

  final DynamicPublishData _self;
  final $Res Function(DynamicPublishData) _then;

/// Create a copy of DynamicPublishData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dynIdStr = null,}) {
  return _then(_self.copyWith(
dynIdStr: null == dynIdStr ? _self.dynIdStr : dynIdStr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicPublishData].
extension DynamicPublishDataPatterns on DynamicPublishData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicPublishData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicPublishData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicPublishData value)  $default,){
final _that = this;
switch (_that) {
case _DynamicPublishData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicPublishData value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicPublishData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'dyn_id_str')  String dynIdStr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicPublishData() when $default != null:
return $default(_that.dynIdStr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'dyn_id_str')  String dynIdStr)  $default,) {final _that = this;
switch (_that) {
case _DynamicPublishData():
return $default(_that.dynIdStr);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'dyn_id_str')  String dynIdStr)?  $default,) {final _that = this;
switch (_that) {
case _DynamicPublishData() when $default != null:
return $default(_that.dynIdStr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicPublishData implements DynamicPublishData {
  const _DynamicPublishData({@JsonKey(name: 'dyn_id_str') required this.dynIdStr});
  factory _DynamicPublishData.fromJson(Map<String, dynamic> json) => _$DynamicPublishDataFromJson(json);

@override@JsonKey(name: 'dyn_id_str') final  String dynIdStr;

/// Create a copy of DynamicPublishData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicPublishDataCopyWith<_DynamicPublishData> get copyWith => __$DynamicPublishDataCopyWithImpl<_DynamicPublishData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicPublishDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicPublishData&&(identical(other.dynIdStr, dynIdStr) || other.dynIdStr == dynIdStr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dynIdStr);

@override
String toString() {
  return 'DynamicPublishData(dynIdStr: $dynIdStr)';
}


}

/// @nodoc
abstract mixin class _$DynamicPublishDataCopyWith<$Res> implements $DynamicPublishDataCopyWith<$Res> {
  factory _$DynamicPublishDataCopyWith(_DynamicPublishData value, $Res Function(_DynamicPublishData) _then) = __$DynamicPublishDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'dyn_id_str') String dynIdStr
});




}
/// @nodoc
class __$DynamicPublishDataCopyWithImpl<$Res>
    implements _$DynamicPublishDataCopyWith<$Res> {
  __$DynamicPublishDataCopyWithImpl(this._self, this._then);

  final _DynamicPublishData _self;
  final $Res Function(_DynamicPublishData) _then;

/// Create a copy of DynamicPublishData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dynIdStr = null,}) {
  return _then(_DynamicPublishData(
dynIdStr: null == dynIdStr ? _self.dynIdStr : dynIdStr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DynamicUploadImageData {

@JsonKey(name: 'image_url') String get imageUrl;@JsonKey(name: 'image_width') int get width;@JsonKey(name: 'image_height') int get height;
/// Create a copy of DynamicUploadImageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicUploadImageDataCopyWith<DynamicUploadImageData> get copyWith => _$DynamicUploadImageDataCopyWithImpl<DynamicUploadImageData>(this as DynamicUploadImageData, _$identity);

  /// Serializes this DynamicUploadImageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicUploadImageData&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,width,height);

@override
String toString() {
  return 'DynamicUploadImageData(imageUrl: $imageUrl, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $DynamicUploadImageDataCopyWith<$Res>  {
  factory $DynamicUploadImageDataCopyWith(DynamicUploadImageData value, $Res Function(DynamicUploadImageData) _then) = _$DynamicUploadImageDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'image_width') int width,@JsonKey(name: 'image_height') int height
});




}
/// @nodoc
class _$DynamicUploadImageDataCopyWithImpl<$Res>
    implements $DynamicUploadImageDataCopyWith<$Res> {
  _$DynamicUploadImageDataCopyWithImpl(this._self, this._then);

  final DynamicUploadImageData _self;
  final $Res Function(DynamicUploadImageData) _then;

/// Create a copy of DynamicUploadImageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? width = null,Object? height = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicUploadImageData].
extension DynamicUploadImageDataPatterns on DynamicUploadImageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicUploadImageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicUploadImageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicUploadImageData value)  $default,){
final _that = this;
switch (_that) {
case _DynamicUploadImageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicUploadImageData value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicUploadImageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'image_width')  int width, @JsonKey(name: 'image_height')  int height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicUploadImageData() when $default != null:
return $default(_that.imageUrl,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'image_width')  int width, @JsonKey(name: 'image_height')  int height)  $default,) {final _that = this;
switch (_that) {
case _DynamicUploadImageData():
return $default(_that.imageUrl,_that.width,_that.height);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'image_width')  int width, @JsonKey(name: 'image_height')  int height)?  $default,) {final _that = this;
switch (_that) {
case _DynamicUploadImageData() when $default != null:
return $default(_that.imageUrl,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicUploadImageData implements DynamicUploadImageData {
  const _DynamicUploadImageData({@JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'image_width') required this.width, @JsonKey(name: 'image_height') required this.height});
  factory _DynamicUploadImageData.fromJson(Map<String, dynamic> json) => _$DynamicUploadImageDataFromJson(json);

@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@JsonKey(name: 'image_width') final  int width;
@override@JsonKey(name: 'image_height') final  int height;

/// Create a copy of DynamicUploadImageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicUploadImageDataCopyWith<_DynamicUploadImageData> get copyWith => __$DynamicUploadImageDataCopyWithImpl<_DynamicUploadImageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicUploadImageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicUploadImageData&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,width,height);

@override
String toString() {
  return 'DynamicUploadImageData(imageUrl: $imageUrl, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$DynamicUploadImageDataCopyWith<$Res> implements $DynamicUploadImageDataCopyWith<$Res> {
  factory _$DynamicUploadImageDataCopyWith(_DynamicUploadImageData value, $Res Function(_DynamicUploadImageData) _then) = __$DynamicUploadImageDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'image_width') int width,@JsonKey(name: 'image_height') int height
});




}
/// @nodoc
class __$DynamicUploadImageDataCopyWithImpl<$Res>
    implements _$DynamicUploadImageDataCopyWith<$Res> {
  __$DynamicUploadImageDataCopyWithImpl(this._self, this._then);

  final _DynamicUploadImageData _self;
  final $Res Function(_DynamicUploadImageData) _then;

/// Create a copy of DynamicUploadImageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? width = null,Object? height = null,}) {
  return _then(_DynamicUploadImageData(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
