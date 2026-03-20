// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryResponseData {

 HistoryCursor get cursor; List<HistoryTab> get tab; List<HistoryItem> get list;
/// Create a copy of HistoryResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryResponseDataCopyWith<HistoryResponseData> get copyWith => _$HistoryResponseDataCopyWithImpl<HistoryResponseData>(this as HistoryResponseData, _$identity);

  /// Serializes this HistoryResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryResponseData&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other.tab, tab)&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(tab),const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'HistoryResponseData(cursor: $cursor, tab: $tab, list: $list)';
}


}

/// @nodoc
abstract mixin class $HistoryResponseDataCopyWith<$Res>  {
  factory $HistoryResponseDataCopyWith(HistoryResponseData value, $Res Function(HistoryResponseData) _then) = _$HistoryResponseDataCopyWithImpl;
@useResult
$Res call({
 HistoryCursor cursor, List<HistoryTab> tab, List<HistoryItem> list
});


$HistoryCursorCopyWith<$Res> get cursor;

}
/// @nodoc
class _$HistoryResponseDataCopyWithImpl<$Res>
    implements $HistoryResponseDataCopyWith<$Res> {
  _$HistoryResponseDataCopyWithImpl(this._self, this._then);

  final HistoryResponseData _self;
  final $Res Function(HistoryResponseData) _then;

/// Create a copy of HistoryResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursor = null,Object? tab = null,Object? list = null,}) {
  return _then(_self.copyWith(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as HistoryCursor,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as List<HistoryTab>,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<HistoryItem>,
  ));
}
/// Create a copy of HistoryResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryCursorCopyWith<$Res> get cursor {
  
  return $HistoryCursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}


/// Adds pattern-matching-related methods to [HistoryResponseData].
extension HistoryResponseDataPatterns on HistoryResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryResponseData value)  $default,){
final _that = this;
switch (_that) {
case _HistoryResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HistoryCursor cursor,  List<HistoryTab> tab,  List<HistoryItem> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryResponseData() when $default != null:
return $default(_that.cursor,_that.tab,_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HistoryCursor cursor,  List<HistoryTab> tab,  List<HistoryItem> list)  $default,) {final _that = this;
switch (_that) {
case _HistoryResponseData():
return $default(_that.cursor,_that.tab,_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HistoryCursor cursor,  List<HistoryTab> tab,  List<HistoryItem> list)?  $default,) {final _that = this;
switch (_that) {
case _HistoryResponseData() when $default != null:
return $default(_that.cursor,_that.tab,_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryResponseData implements HistoryResponseData {
  const _HistoryResponseData({required this.cursor, required final  List<HistoryTab> tab, required final  List<HistoryItem> list}): _tab = tab,_list = list;
  factory _HistoryResponseData.fromJson(Map<String, dynamic> json) => _$HistoryResponseDataFromJson(json);

@override final  HistoryCursor cursor;
 final  List<HistoryTab> _tab;
@override List<HistoryTab> get tab {
  if (_tab is EqualUnmodifiableListView) return _tab;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tab);
}

 final  List<HistoryItem> _list;
@override List<HistoryItem> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of HistoryResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryResponseDataCopyWith<_HistoryResponseData> get copyWith => __$HistoryResponseDataCopyWithImpl<_HistoryResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryResponseData&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other._tab, _tab)&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(_tab),const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'HistoryResponseData(cursor: $cursor, tab: $tab, list: $list)';
}


}

/// @nodoc
abstract mixin class _$HistoryResponseDataCopyWith<$Res> implements $HistoryResponseDataCopyWith<$Res> {
  factory _$HistoryResponseDataCopyWith(_HistoryResponseData value, $Res Function(_HistoryResponseData) _then) = __$HistoryResponseDataCopyWithImpl;
@override @useResult
$Res call({
 HistoryCursor cursor, List<HistoryTab> tab, List<HistoryItem> list
});


@override $HistoryCursorCopyWith<$Res> get cursor;

}
/// @nodoc
class __$HistoryResponseDataCopyWithImpl<$Res>
    implements _$HistoryResponseDataCopyWith<$Res> {
  __$HistoryResponseDataCopyWithImpl(this._self, this._then);

  final _HistoryResponseData _self;
  final $Res Function(_HistoryResponseData) _then;

/// Create a copy of HistoryResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cursor = null,Object? tab = null,Object? list = null,}) {
  return _then(_HistoryResponseData(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as HistoryCursor,tab: null == tab ? _self._tab : tab // ignore: cast_nullable_to_non_nullable
as List<HistoryTab>,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<HistoryItem>,
  ));
}

/// Create a copy of HistoryResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryCursorCopyWith<$Res> get cursor {
  
  return $HistoryCursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}


/// @nodoc
mixin _$HistoryCursor {

 int get max;@JsonKey(name: 'view_at') int get viewAt; String get business; int get ps;
/// Create a copy of HistoryCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryCursorCopyWith<HistoryCursor> get copyWith => _$HistoryCursorCopyWithImpl<HistoryCursor>(this as HistoryCursor, _$identity);

  /// Serializes this HistoryCursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryCursor&&(identical(other.max, max) || other.max == max)&&(identical(other.viewAt, viewAt) || other.viewAt == viewAt)&&(identical(other.business, business) || other.business == business)&&(identical(other.ps, ps) || other.ps == ps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,max,viewAt,business,ps);

@override
String toString() {
  return 'HistoryCursor(max: $max, viewAt: $viewAt, business: $business, ps: $ps)';
}


}

/// @nodoc
abstract mixin class $HistoryCursorCopyWith<$Res>  {
  factory $HistoryCursorCopyWith(HistoryCursor value, $Res Function(HistoryCursor) _then) = _$HistoryCursorCopyWithImpl;
@useResult
$Res call({
 int max,@JsonKey(name: 'view_at') int viewAt, String business, int ps
});




}
/// @nodoc
class _$HistoryCursorCopyWithImpl<$Res>
    implements $HistoryCursorCopyWith<$Res> {
  _$HistoryCursorCopyWithImpl(this._self, this._then);

  final HistoryCursor _self;
  final $Res Function(HistoryCursor) _then;

/// Create a copy of HistoryCursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? max = null,Object? viewAt = null,Object? business = null,Object? ps = null,}) {
  return _then(_self.copyWith(
max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,viewAt: null == viewAt ? _self.viewAt : viewAt // ignore: cast_nullable_to_non_nullable
as int,business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as String,ps: null == ps ? _self.ps : ps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryCursor].
extension HistoryCursorPatterns on HistoryCursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryCursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryCursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryCursor value)  $default,){
final _that = this;
switch (_that) {
case _HistoryCursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryCursor value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryCursor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int max, @JsonKey(name: 'view_at')  int viewAt,  String business,  int ps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryCursor() when $default != null:
return $default(_that.max,_that.viewAt,_that.business,_that.ps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int max, @JsonKey(name: 'view_at')  int viewAt,  String business,  int ps)  $default,) {final _that = this;
switch (_that) {
case _HistoryCursor():
return $default(_that.max,_that.viewAt,_that.business,_that.ps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int max, @JsonKey(name: 'view_at')  int viewAt,  String business,  int ps)?  $default,) {final _that = this;
switch (_that) {
case _HistoryCursor() when $default != null:
return $default(_that.max,_that.viewAt,_that.business,_that.ps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryCursor implements HistoryCursor {
  const _HistoryCursor({required this.max, @JsonKey(name: 'view_at') required this.viewAt, required this.business, required this.ps});
  factory _HistoryCursor.fromJson(Map<String, dynamic> json) => _$HistoryCursorFromJson(json);

@override final  int max;
@override@JsonKey(name: 'view_at') final  int viewAt;
@override final  String business;
@override final  int ps;

/// Create a copy of HistoryCursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryCursorCopyWith<_HistoryCursor> get copyWith => __$HistoryCursorCopyWithImpl<_HistoryCursor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryCursorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryCursor&&(identical(other.max, max) || other.max == max)&&(identical(other.viewAt, viewAt) || other.viewAt == viewAt)&&(identical(other.business, business) || other.business == business)&&(identical(other.ps, ps) || other.ps == ps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,max,viewAt,business,ps);

@override
String toString() {
  return 'HistoryCursor(max: $max, viewAt: $viewAt, business: $business, ps: $ps)';
}


}

/// @nodoc
abstract mixin class _$HistoryCursorCopyWith<$Res> implements $HistoryCursorCopyWith<$Res> {
  factory _$HistoryCursorCopyWith(_HistoryCursor value, $Res Function(_HistoryCursor) _then) = __$HistoryCursorCopyWithImpl;
@override @useResult
$Res call({
 int max,@JsonKey(name: 'view_at') int viewAt, String business, int ps
});




}
/// @nodoc
class __$HistoryCursorCopyWithImpl<$Res>
    implements _$HistoryCursorCopyWith<$Res> {
  __$HistoryCursorCopyWithImpl(this._self, this._then);

  final _HistoryCursor _self;
  final $Res Function(_HistoryCursor) _then;

/// Create a copy of HistoryCursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? max = null,Object? viewAt = null,Object? business = null,Object? ps = null,}) {
  return _then(_HistoryCursor(
max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,viewAt: null == viewAt ? _self.viewAt : viewAt // ignore: cast_nullable_to_non_nullable
as int,business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as String,ps: null == ps ? _self.ps : ps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HistoryTab {

 String get type; String get name;
/// Create a copy of HistoryTab
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryTabCopyWith<HistoryTab> get copyWith => _$HistoryTabCopyWithImpl<HistoryTab>(this as HistoryTab, _$identity);

  /// Serializes this HistoryTab to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryTab&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,name);

@override
String toString() {
  return 'HistoryTab(type: $type, name: $name)';
}


}

/// @nodoc
abstract mixin class $HistoryTabCopyWith<$Res>  {
  factory $HistoryTabCopyWith(HistoryTab value, $Res Function(HistoryTab) _then) = _$HistoryTabCopyWithImpl;
@useResult
$Res call({
 String type, String name
});




}
/// @nodoc
class _$HistoryTabCopyWithImpl<$Res>
    implements $HistoryTabCopyWith<$Res> {
  _$HistoryTabCopyWithImpl(this._self, this._then);

  final HistoryTab _self;
  final $Res Function(HistoryTab) _then;

/// Create a copy of HistoryTab
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? name = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryTab].
extension HistoryTabPatterns on HistoryTab {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryTab value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryTab() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryTab value)  $default,){
final _that = this;
switch (_that) {
case _HistoryTab():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryTab value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryTab() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryTab() when $default != null:
return $default(_that.type,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String name)  $default,) {final _that = this;
switch (_that) {
case _HistoryTab():
return $default(_that.type,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String name)?  $default,) {final _that = this;
switch (_that) {
case _HistoryTab() when $default != null:
return $default(_that.type,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryTab implements HistoryTab {
  const _HistoryTab({required this.type, required this.name});
  factory _HistoryTab.fromJson(Map<String, dynamic> json) => _$HistoryTabFromJson(json);

@override final  String type;
@override final  String name;

/// Create a copy of HistoryTab
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryTabCopyWith<_HistoryTab> get copyWith => __$HistoryTabCopyWithImpl<_HistoryTab>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryTabToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryTab&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,name);

@override
String toString() {
  return 'HistoryTab(type: $type, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HistoryTabCopyWith<$Res> implements $HistoryTabCopyWith<$Res> {
  factory _$HistoryTabCopyWith(_HistoryTab value, $Res Function(_HistoryTab) _then) = __$HistoryTabCopyWithImpl;
@override @useResult
$Res call({
 String type, String name
});




}
/// @nodoc
class __$HistoryTabCopyWithImpl<$Res>
    implements _$HistoryTabCopyWith<$Res> {
  __$HistoryTabCopyWithImpl(this._self, this._then);

  final _HistoryTab _self;
  final $Res Function(_HistoryTab) _then;

/// Create a copy of HistoryTab
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? name = null,}) {
  return _then(_HistoryTab(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HistoryItem {

 String get title;@JsonKey(name: 'long_title') String get longTitle; String get cover; List<String>? get covers; String get uri; HistoryDetail get history; int get videos;@JsonKey(name: 'author_name') String get authorName;@JsonKey(name: 'author_face') String get authorFace;@JsonKey(name: 'author_mid') int get authorMid;@JsonKey(name: 'view_at') int get viewAt; int get progress; String get badge;@JsonKey(name: 'show_title') String get showTitle; int get duration; String get current; int get total;@JsonKey(name: 'new_desc') String get newDesc;@JsonKey(name: 'is_finish') int get isFinish;@JsonKey(name: 'is_fav') int get isFav; int get kid;@JsonKey(name: 'tag_name') String get tagName;@JsonKey(name: 'live_status') int get liveStatus;
/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryItemCopyWith<HistoryItem> get copyWith => _$HistoryItemCopyWithImpl<HistoryItem>(this as HistoryItem, _$identity);

  /// Serializes this HistoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryItem&&(identical(other.title, title) || other.title == title)&&(identical(other.longTitle, longTitle) || other.longTitle == longTitle)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other.covers, covers)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.history, history) || other.history == history)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorFace, authorFace) || other.authorFace == authorFace)&&(identical(other.authorMid, authorMid) || other.authorMid == authorMid)&&(identical(other.viewAt, viewAt) || other.viewAt == viewAt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.showTitle, showTitle) || other.showTitle == showTitle)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.current, current) || other.current == current)&&(identical(other.total, total) || other.total == total)&&(identical(other.newDesc, newDesc) || other.newDesc == newDesc)&&(identical(other.isFinish, isFinish) || other.isFinish == isFinish)&&(identical(other.isFav, isFav) || other.isFav == isFav)&&(identical(other.kid, kid) || other.kid == kid)&&(identical(other.tagName, tagName) || other.tagName == tagName)&&(identical(other.liveStatus, liveStatus) || other.liveStatus == liveStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,title,longTitle,cover,const DeepCollectionEquality().hash(covers),uri,history,videos,authorName,authorFace,authorMid,viewAt,progress,badge,showTitle,duration,current,total,newDesc,isFinish,isFav,kid,tagName,liveStatus]);

@override
String toString() {
  return 'HistoryItem(title: $title, longTitle: $longTitle, cover: $cover, covers: $covers, uri: $uri, history: $history, videos: $videos, authorName: $authorName, authorFace: $authorFace, authorMid: $authorMid, viewAt: $viewAt, progress: $progress, badge: $badge, showTitle: $showTitle, duration: $duration, current: $current, total: $total, newDesc: $newDesc, isFinish: $isFinish, isFav: $isFav, kid: $kid, tagName: $tagName, liveStatus: $liveStatus)';
}


}

/// @nodoc
abstract mixin class $HistoryItemCopyWith<$Res>  {
  factory $HistoryItemCopyWith(HistoryItem value, $Res Function(HistoryItem) _then) = _$HistoryItemCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(name: 'long_title') String longTitle, String cover, List<String>? covers, String uri, HistoryDetail history, int videos,@JsonKey(name: 'author_name') String authorName,@JsonKey(name: 'author_face') String authorFace,@JsonKey(name: 'author_mid') int authorMid,@JsonKey(name: 'view_at') int viewAt, int progress, String badge,@JsonKey(name: 'show_title') String showTitle, int duration, String current, int total,@JsonKey(name: 'new_desc') String newDesc,@JsonKey(name: 'is_finish') int isFinish,@JsonKey(name: 'is_fav') int isFav, int kid,@JsonKey(name: 'tag_name') String tagName,@JsonKey(name: 'live_status') int liveStatus
});


$HistoryDetailCopyWith<$Res> get history;

}
/// @nodoc
class _$HistoryItemCopyWithImpl<$Res>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._self, this._then);

  final HistoryItem _self;
  final $Res Function(HistoryItem) _then;

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? longTitle = null,Object? cover = null,Object? covers = freezed,Object? uri = null,Object? history = null,Object? videos = null,Object? authorName = null,Object? authorFace = null,Object? authorMid = null,Object? viewAt = null,Object? progress = null,Object? badge = null,Object? showTitle = null,Object? duration = null,Object? current = null,Object? total = null,Object? newDesc = null,Object? isFinish = null,Object? isFav = null,Object? kid = null,Object? tagName = null,Object? liveStatus = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,longTitle: null == longTitle ? _self.longTitle : longTitle // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,covers: freezed == covers ? _self.covers : covers // ignore: cast_nullable_to_non_nullable
as List<String>?,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as HistoryDetail,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorFace: null == authorFace ? _self.authorFace : authorFace // ignore: cast_nullable_to_non_nullable
as String,authorMid: null == authorMid ? _self.authorMid : authorMid // ignore: cast_nullable_to_non_nullable
as int,viewAt: null == viewAt ? _self.viewAt : viewAt // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String,showTitle: null == showTitle ? _self.showTitle : showTitle // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,newDesc: null == newDesc ? _self.newDesc : newDesc // ignore: cast_nullable_to_non_nullable
as String,isFinish: null == isFinish ? _self.isFinish : isFinish // ignore: cast_nullable_to_non_nullable
as int,isFav: null == isFav ? _self.isFav : isFav // ignore: cast_nullable_to_non_nullable
as int,kid: null == kid ? _self.kid : kid // ignore: cast_nullable_to_non_nullable
as int,tagName: null == tagName ? _self.tagName : tagName // ignore: cast_nullable_to_non_nullable
as String,liveStatus: null == liveStatus ? _self.liveStatus : liveStatus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryDetailCopyWith<$Res> get history {
  
  return $HistoryDetailCopyWith<$Res>(_self.history, (value) {
    return _then(_self.copyWith(history: value));
  });
}
}


/// Adds pattern-matching-related methods to [HistoryItem].
extension HistoryItemPatterns on HistoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryItem value)  $default,){
final _that = this;
switch (_that) {
case _HistoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'long_title')  String longTitle,  String cover,  List<String>? covers,  String uri,  HistoryDetail history,  int videos, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'author_face')  String authorFace, @JsonKey(name: 'author_mid')  int authorMid, @JsonKey(name: 'view_at')  int viewAt,  int progress,  String badge, @JsonKey(name: 'show_title')  String showTitle,  int duration,  String current,  int total, @JsonKey(name: 'new_desc')  String newDesc, @JsonKey(name: 'is_finish')  int isFinish, @JsonKey(name: 'is_fav')  int isFav,  int kid, @JsonKey(name: 'tag_name')  String tagName, @JsonKey(name: 'live_status')  int liveStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
return $default(_that.title,_that.longTitle,_that.cover,_that.covers,_that.uri,_that.history,_that.videos,_that.authorName,_that.authorFace,_that.authorMid,_that.viewAt,_that.progress,_that.badge,_that.showTitle,_that.duration,_that.current,_that.total,_that.newDesc,_that.isFinish,_that.isFav,_that.kid,_that.tagName,_that.liveStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'long_title')  String longTitle,  String cover,  List<String>? covers,  String uri,  HistoryDetail history,  int videos, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'author_face')  String authorFace, @JsonKey(name: 'author_mid')  int authorMid, @JsonKey(name: 'view_at')  int viewAt,  int progress,  String badge, @JsonKey(name: 'show_title')  String showTitle,  int duration,  String current,  int total, @JsonKey(name: 'new_desc')  String newDesc, @JsonKey(name: 'is_finish')  int isFinish, @JsonKey(name: 'is_fav')  int isFav,  int kid, @JsonKey(name: 'tag_name')  String tagName, @JsonKey(name: 'live_status')  int liveStatus)  $default,) {final _that = this;
switch (_that) {
case _HistoryItem():
return $default(_that.title,_that.longTitle,_that.cover,_that.covers,_that.uri,_that.history,_that.videos,_that.authorName,_that.authorFace,_that.authorMid,_that.viewAt,_that.progress,_that.badge,_that.showTitle,_that.duration,_that.current,_that.total,_that.newDesc,_that.isFinish,_that.isFav,_that.kid,_that.tagName,_that.liveStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(name: 'long_title')  String longTitle,  String cover,  List<String>? covers,  String uri,  HistoryDetail history,  int videos, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'author_face')  String authorFace, @JsonKey(name: 'author_mid')  int authorMid, @JsonKey(name: 'view_at')  int viewAt,  int progress,  String badge, @JsonKey(name: 'show_title')  String showTitle,  int duration,  String current,  int total, @JsonKey(name: 'new_desc')  String newDesc, @JsonKey(name: 'is_finish')  int isFinish, @JsonKey(name: 'is_fav')  int isFav,  int kid, @JsonKey(name: 'tag_name')  String tagName, @JsonKey(name: 'live_status')  int liveStatus)?  $default,) {final _that = this;
switch (_that) {
case _HistoryItem() when $default != null:
return $default(_that.title,_that.longTitle,_that.cover,_that.covers,_that.uri,_that.history,_that.videos,_that.authorName,_that.authorFace,_that.authorMid,_that.viewAt,_that.progress,_that.badge,_that.showTitle,_that.duration,_that.current,_that.total,_that.newDesc,_that.isFinish,_that.isFav,_that.kid,_that.tagName,_that.liveStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryItem implements HistoryItem {
  const _HistoryItem({required this.title, @JsonKey(name: 'long_title') required this.longTitle, required this.cover, final  List<String>? covers, required this.uri, required this.history, required this.videos, @JsonKey(name: 'author_name') required this.authorName, @JsonKey(name: 'author_face') required this.authorFace, @JsonKey(name: 'author_mid') required this.authorMid, @JsonKey(name: 'view_at') required this.viewAt, required this.progress, required this.badge, @JsonKey(name: 'show_title') required this.showTitle, required this.duration, required this.current, required this.total, @JsonKey(name: 'new_desc') required this.newDesc, @JsonKey(name: 'is_finish') required this.isFinish, @JsonKey(name: 'is_fav') required this.isFav, required this.kid, @JsonKey(name: 'tag_name') required this.tagName, @JsonKey(name: 'live_status') required this.liveStatus}): _covers = covers;
  factory _HistoryItem.fromJson(Map<String, dynamic> json) => _$HistoryItemFromJson(json);

@override final  String title;
@override@JsonKey(name: 'long_title') final  String longTitle;
@override final  String cover;
 final  List<String>? _covers;
@override List<String>? get covers {
  final value = _covers;
  if (value == null) return null;
  if (_covers is EqualUnmodifiableListView) return _covers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String uri;
@override final  HistoryDetail history;
@override final  int videos;
@override@JsonKey(name: 'author_name') final  String authorName;
@override@JsonKey(name: 'author_face') final  String authorFace;
@override@JsonKey(name: 'author_mid') final  int authorMid;
@override@JsonKey(name: 'view_at') final  int viewAt;
@override final  int progress;
@override final  String badge;
@override@JsonKey(name: 'show_title') final  String showTitle;
@override final  int duration;
@override final  String current;
@override final  int total;
@override@JsonKey(name: 'new_desc') final  String newDesc;
@override@JsonKey(name: 'is_finish') final  int isFinish;
@override@JsonKey(name: 'is_fav') final  int isFav;
@override final  int kid;
@override@JsonKey(name: 'tag_name') final  String tagName;
@override@JsonKey(name: 'live_status') final  int liveStatus;

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryItemCopyWith<_HistoryItem> get copyWith => __$HistoryItemCopyWithImpl<_HistoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryItem&&(identical(other.title, title) || other.title == title)&&(identical(other.longTitle, longTitle) || other.longTitle == longTitle)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other._covers, _covers)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.history, history) || other.history == history)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorFace, authorFace) || other.authorFace == authorFace)&&(identical(other.authorMid, authorMid) || other.authorMid == authorMid)&&(identical(other.viewAt, viewAt) || other.viewAt == viewAt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.showTitle, showTitle) || other.showTitle == showTitle)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.current, current) || other.current == current)&&(identical(other.total, total) || other.total == total)&&(identical(other.newDesc, newDesc) || other.newDesc == newDesc)&&(identical(other.isFinish, isFinish) || other.isFinish == isFinish)&&(identical(other.isFav, isFav) || other.isFav == isFav)&&(identical(other.kid, kid) || other.kid == kid)&&(identical(other.tagName, tagName) || other.tagName == tagName)&&(identical(other.liveStatus, liveStatus) || other.liveStatus == liveStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,title,longTitle,cover,const DeepCollectionEquality().hash(_covers),uri,history,videos,authorName,authorFace,authorMid,viewAt,progress,badge,showTitle,duration,current,total,newDesc,isFinish,isFav,kid,tagName,liveStatus]);

@override
String toString() {
  return 'HistoryItem(title: $title, longTitle: $longTitle, cover: $cover, covers: $covers, uri: $uri, history: $history, videos: $videos, authorName: $authorName, authorFace: $authorFace, authorMid: $authorMid, viewAt: $viewAt, progress: $progress, badge: $badge, showTitle: $showTitle, duration: $duration, current: $current, total: $total, newDesc: $newDesc, isFinish: $isFinish, isFav: $isFav, kid: $kid, tagName: $tagName, liveStatus: $liveStatus)';
}


}

/// @nodoc
abstract mixin class _$HistoryItemCopyWith<$Res> implements $HistoryItemCopyWith<$Res> {
  factory _$HistoryItemCopyWith(_HistoryItem value, $Res Function(_HistoryItem) _then) = __$HistoryItemCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(name: 'long_title') String longTitle, String cover, List<String>? covers, String uri, HistoryDetail history, int videos,@JsonKey(name: 'author_name') String authorName,@JsonKey(name: 'author_face') String authorFace,@JsonKey(name: 'author_mid') int authorMid,@JsonKey(name: 'view_at') int viewAt, int progress, String badge,@JsonKey(name: 'show_title') String showTitle, int duration, String current, int total,@JsonKey(name: 'new_desc') String newDesc,@JsonKey(name: 'is_finish') int isFinish,@JsonKey(name: 'is_fav') int isFav, int kid,@JsonKey(name: 'tag_name') String tagName,@JsonKey(name: 'live_status') int liveStatus
});


@override $HistoryDetailCopyWith<$Res> get history;

}
/// @nodoc
class __$HistoryItemCopyWithImpl<$Res>
    implements _$HistoryItemCopyWith<$Res> {
  __$HistoryItemCopyWithImpl(this._self, this._then);

  final _HistoryItem _self;
  final $Res Function(_HistoryItem) _then;

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? longTitle = null,Object? cover = null,Object? covers = freezed,Object? uri = null,Object? history = null,Object? videos = null,Object? authorName = null,Object? authorFace = null,Object? authorMid = null,Object? viewAt = null,Object? progress = null,Object? badge = null,Object? showTitle = null,Object? duration = null,Object? current = null,Object? total = null,Object? newDesc = null,Object? isFinish = null,Object? isFav = null,Object? kid = null,Object? tagName = null,Object? liveStatus = null,}) {
  return _then(_HistoryItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,longTitle: null == longTitle ? _self.longTitle : longTitle // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,covers: freezed == covers ? _self._covers : covers // ignore: cast_nullable_to_non_nullable
as List<String>?,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as HistoryDetail,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorFace: null == authorFace ? _self.authorFace : authorFace // ignore: cast_nullable_to_non_nullable
as String,authorMid: null == authorMid ? _self.authorMid : authorMid // ignore: cast_nullable_to_non_nullable
as int,viewAt: null == viewAt ? _self.viewAt : viewAt // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String,showTitle: null == showTitle ? _self.showTitle : showTitle // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,newDesc: null == newDesc ? _self.newDesc : newDesc // ignore: cast_nullable_to_non_nullable
as String,isFinish: null == isFinish ? _self.isFinish : isFinish // ignore: cast_nullable_to_non_nullable
as int,isFav: null == isFav ? _self.isFav : isFav // ignore: cast_nullable_to_non_nullable
as int,kid: null == kid ? _self.kid : kid // ignore: cast_nullable_to_non_nullable
as int,tagName: null == tagName ? _self.tagName : tagName // ignore: cast_nullable_to_non_nullable
as String,liveStatus: null == liveStatus ? _self.liveStatus : liveStatus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HistoryItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryDetailCopyWith<$Res> get history {
  
  return $HistoryDetailCopyWith<$Res>(_self.history, (value) {
    return _then(_self.copyWith(history: value));
  });
}
}


/// @nodoc
mixin _$HistoryDetail {

 int get oid; int get epid; String get bvid; int get page; int get cid; String get part; String get business; int get dt;
/// Create a copy of HistoryDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryDetailCopyWith<HistoryDetail> get copyWith => _$HistoryDetailCopyWithImpl<HistoryDetail>(this as HistoryDetail, _$identity);

  /// Serializes this HistoryDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryDetail&&(identical(other.oid, oid) || other.oid == oid)&&(identical(other.epid, epid) || other.epid == epid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.page, page) || other.page == page)&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.part, part) || other.part == part)&&(identical(other.business, business) || other.business == business)&&(identical(other.dt, dt) || other.dt == dt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oid,epid,bvid,page,cid,part,business,dt);

@override
String toString() {
  return 'HistoryDetail(oid: $oid, epid: $epid, bvid: $bvid, page: $page, cid: $cid, part: $part, business: $business, dt: $dt)';
}


}

/// @nodoc
abstract mixin class $HistoryDetailCopyWith<$Res>  {
  factory $HistoryDetailCopyWith(HistoryDetail value, $Res Function(HistoryDetail) _then) = _$HistoryDetailCopyWithImpl;
@useResult
$Res call({
 int oid, int epid, String bvid, int page, int cid, String part, String business, int dt
});




}
/// @nodoc
class _$HistoryDetailCopyWithImpl<$Res>
    implements $HistoryDetailCopyWith<$Res> {
  _$HistoryDetailCopyWithImpl(this._self, this._then);

  final HistoryDetail _self;
  final $Res Function(HistoryDetail) _then;

/// Create a copy of HistoryDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oid = null,Object? epid = null,Object? bvid = null,Object? page = null,Object? cid = null,Object? part = null,Object? business = null,Object? dt = null,}) {
  return _then(_self.copyWith(
oid: null == oid ? _self.oid : oid // ignore: cast_nullable_to_non_nullable
as int,epid: null == epid ? _self.epid : epid // ignore: cast_nullable_to_non_nullable
as int,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int,part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as String,business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as String,dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryDetail].
extension HistoryDetailPatterns on HistoryDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryDetail value)  $default,){
final _that = this;
switch (_that) {
case _HistoryDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryDetail value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int oid,  int epid,  String bvid,  int page,  int cid,  String part,  String business,  int dt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryDetail() when $default != null:
return $default(_that.oid,_that.epid,_that.bvid,_that.page,_that.cid,_that.part,_that.business,_that.dt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int oid,  int epid,  String bvid,  int page,  int cid,  String part,  String business,  int dt)  $default,) {final _that = this;
switch (_that) {
case _HistoryDetail():
return $default(_that.oid,_that.epid,_that.bvid,_that.page,_that.cid,_that.part,_that.business,_that.dt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int oid,  int epid,  String bvid,  int page,  int cid,  String part,  String business,  int dt)?  $default,) {final _that = this;
switch (_that) {
case _HistoryDetail() when $default != null:
return $default(_that.oid,_that.epid,_that.bvid,_that.page,_that.cid,_that.part,_that.business,_that.dt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryDetail implements HistoryDetail {
  const _HistoryDetail({required this.oid, required this.epid, required this.bvid, required this.page, required this.cid, required this.part, required this.business, required this.dt});
  factory _HistoryDetail.fromJson(Map<String, dynamic> json) => _$HistoryDetailFromJson(json);

@override final  int oid;
@override final  int epid;
@override final  String bvid;
@override final  int page;
@override final  int cid;
@override final  String part;
@override final  String business;
@override final  int dt;

/// Create a copy of HistoryDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryDetailCopyWith<_HistoryDetail> get copyWith => __$HistoryDetailCopyWithImpl<_HistoryDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryDetail&&(identical(other.oid, oid) || other.oid == oid)&&(identical(other.epid, epid) || other.epid == epid)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.page, page) || other.page == page)&&(identical(other.cid, cid) || other.cid == cid)&&(identical(other.part, part) || other.part == part)&&(identical(other.business, business) || other.business == business)&&(identical(other.dt, dt) || other.dt == dt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oid,epid,bvid,page,cid,part,business,dt);

@override
String toString() {
  return 'HistoryDetail(oid: $oid, epid: $epid, bvid: $bvid, page: $page, cid: $cid, part: $part, business: $business, dt: $dt)';
}


}

/// @nodoc
abstract mixin class _$HistoryDetailCopyWith<$Res> implements $HistoryDetailCopyWith<$Res> {
  factory _$HistoryDetailCopyWith(_HistoryDetail value, $Res Function(_HistoryDetail) _then) = __$HistoryDetailCopyWithImpl;
@override @useResult
$Res call({
 int oid, int epid, String bvid, int page, int cid, String part, String business, int dt
});




}
/// @nodoc
class __$HistoryDetailCopyWithImpl<$Res>
    implements _$HistoryDetailCopyWith<$Res> {
  __$HistoryDetailCopyWithImpl(this._self, this._then);

  final _HistoryDetail _self;
  final $Res Function(_HistoryDetail) _then;

/// Create a copy of HistoryDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oid = null,Object? epid = null,Object? bvid = null,Object? page = null,Object? cid = null,Object? part = null,Object? business = null,Object? dt = null,}) {
  return _then(_HistoryDetail(
oid: null == oid ? _self.oid : oid // ignore: cast_nullable_to_non_nullable
as int,epid: null == epid ? _self.epid : epid // ignore: cast_nullable_to_non_nullable
as int,bvid: null == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as int,part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as String,business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as String,dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
