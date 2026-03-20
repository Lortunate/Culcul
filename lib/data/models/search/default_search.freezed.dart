// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'default_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DefaultSearch {

@JsonKey(name: 'show_name') String get showName; String get name; int get type;@JsonKey(name: 'search_type') String get searchType;@JsonKey(name: 'id') int get id;
/// Create a copy of DefaultSearch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultSearchCopyWith<DefaultSearch> get copyWith => _$DefaultSearchCopyWithImpl<DefaultSearch>(this as DefaultSearch, _$identity);

  /// Serializes this DefaultSearch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultSearch&&(identical(other.showName, showName) || other.showName == showName)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showName,name,type,searchType,id);

@override
String toString() {
  return 'DefaultSearch(showName: $showName, name: $name, type: $type, searchType: $searchType, id: $id)';
}


}

/// @nodoc
abstract mixin class $DefaultSearchCopyWith<$Res>  {
  factory $DefaultSearchCopyWith(DefaultSearch value, $Res Function(DefaultSearch) _then) = _$DefaultSearchCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'show_name') String showName, String name, int type,@JsonKey(name: 'search_type') String searchType,@JsonKey(name: 'id') int id
});




}
/// @nodoc
class _$DefaultSearchCopyWithImpl<$Res>
    implements $DefaultSearchCopyWith<$Res> {
  _$DefaultSearchCopyWithImpl(this._self, this._then);

  final DefaultSearch _self;
  final $Res Function(DefaultSearch) _then;

/// Create a copy of DefaultSearch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showName = null,Object? name = null,Object? type = null,Object? searchType = null,Object? id = null,}) {
  return _then(_self.copyWith(
showName: null == showName ? _self.showName : showName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,searchType: null == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DefaultSearch].
extension DefaultSearchPatterns on DefaultSearch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DefaultSearch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DefaultSearch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DefaultSearch value)  $default,){
final _that = this;
switch (_that) {
case _DefaultSearch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DefaultSearch value)?  $default,){
final _that = this;
switch (_that) {
case _DefaultSearch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'show_name')  String showName,  String name,  int type, @JsonKey(name: 'search_type')  String searchType, @JsonKey(name: 'id')  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DefaultSearch() when $default != null:
return $default(_that.showName,_that.name,_that.type,_that.searchType,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'show_name')  String showName,  String name,  int type, @JsonKey(name: 'search_type')  String searchType, @JsonKey(name: 'id')  int id)  $default,) {final _that = this;
switch (_that) {
case _DefaultSearch():
return $default(_that.showName,_that.name,_that.type,_that.searchType,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'show_name')  String showName,  String name,  int type, @JsonKey(name: 'search_type')  String searchType, @JsonKey(name: 'id')  int id)?  $default,) {final _that = this;
switch (_that) {
case _DefaultSearch() when $default != null:
return $default(_that.showName,_that.name,_that.type,_that.searchType,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DefaultSearch implements DefaultSearch {
  const _DefaultSearch({@JsonKey(name: 'show_name') required this.showName, required this.name, required this.type, @JsonKey(name: 'search_type') required this.searchType, @JsonKey(name: 'id') required this.id});
  factory _DefaultSearch.fromJson(Map<String, dynamic> json) => _$DefaultSearchFromJson(json);

@override@JsonKey(name: 'show_name') final  String showName;
@override final  String name;
@override final  int type;
@override@JsonKey(name: 'search_type') final  String searchType;
@override@JsonKey(name: 'id') final  int id;

/// Create a copy of DefaultSearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DefaultSearchCopyWith<_DefaultSearch> get copyWith => __$DefaultSearchCopyWithImpl<_DefaultSearch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DefaultSearchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DefaultSearch&&(identical(other.showName, showName) || other.showName == showName)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showName,name,type,searchType,id);

@override
String toString() {
  return 'DefaultSearch(showName: $showName, name: $name, type: $type, searchType: $searchType, id: $id)';
}


}

/// @nodoc
abstract mixin class _$DefaultSearchCopyWith<$Res> implements $DefaultSearchCopyWith<$Res> {
  factory _$DefaultSearchCopyWith(_DefaultSearch value, $Res Function(_DefaultSearch) _then) = __$DefaultSearchCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'show_name') String showName, String name, int type,@JsonKey(name: 'search_type') String searchType,@JsonKey(name: 'id') int id
});




}
/// @nodoc
class __$DefaultSearchCopyWithImpl<$Res>
    implements _$DefaultSearchCopyWith<$Res> {
  __$DefaultSearchCopyWithImpl(this._self, this._then);

  final _DefaultSearch _self;
  final $Res Function(_DefaultSearch) _then;

/// Create a copy of DefaultSearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showName = null,Object? name = null,Object? type = null,Object? searchType = null,Object? id = null,}) {
  return _then(_DefaultSearch(
showName: null == showName ? _self.showName : showName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,searchType: null == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DefaultSearchData {

@JsonKey(name: 'show_name') String get showName; String get name;@JsonKey(name: 'id') int get id; String get url; String get seid; int get type;@JsonKey(name: 'goto_type') int get gotoType;@JsonKey(name: 'goto_value') String get gotoValue;
/// Create a copy of DefaultSearchData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultSearchDataCopyWith<DefaultSearchData> get copyWith => _$DefaultSearchDataCopyWithImpl<DefaultSearchData>(this as DefaultSearchData, _$identity);

  /// Serializes this DefaultSearchData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultSearchData&&(identical(other.showName, showName) || other.showName == showName)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.seid, seid) || other.seid == seid)&&(identical(other.type, type) || other.type == type)&&(identical(other.gotoType, gotoType) || other.gotoType == gotoType)&&(identical(other.gotoValue, gotoValue) || other.gotoValue == gotoValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showName,name,id,url,seid,type,gotoType,gotoValue);

@override
String toString() {
  return 'DefaultSearchData(showName: $showName, name: $name, id: $id, url: $url, seid: $seid, type: $type, gotoType: $gotoType, gotoValue: $gotoValue)';
}


}

/// @nodoc
abstract mixin class $DefaultSearchDataCopyWith<$Res>  {
  factory $DefaultSearchDataCopyWith(DefaultSearchData value, $Res Function(DefaultSearchData) _then) = _$DefaultSearchDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'show_name') String showName, String name,@JsonKey(name: 'id') int id, String url, String seid, int type,@JsonKey(name: 'goto_type') int gotoType,@JsonKey(name: 'goto_value') String gotoValue
});




}
/// @nodoc
class _$DefaultSearchDataCopyWithImpl<$Res>
    implements $DefaultSearchDataCopyWith<$Res> {
  _$DefaultSearchDataCopyWithImpl(this._self, this._then);

  final DefaultSearchData _self;
  final $Res Function(DefaultSearchData) _then;

/// Create a copy of DefaultSearchData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showName = null,Object? name = null,Object? id = null,Object? url = null,Object? seid = null,Object? type = null,Object? gotoType = null,Object? gotoValue = null,}) {
  return _then(_self.copyWith(
showName: null == showName ? _self.showName : showName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,seid: null == seid ? _self.seid : seid // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,gotoType: null == gotoType ? _self.gotoType : gotoType // ignore: cast_nullable_to_non_nullable
as int,gotoValue: null == gotoValue ? _self.gotoValue : gotoValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DefaultSearchData].
extension DefaultSearchDataPatterns on DefaultSearchData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DefaultSearchData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DefaultSearchData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DefaultSearchData value)  $default,){
final _that = this;
switch (_that) {
case _DefaultSearchData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DefaultSearchData value)?  $default,){
final _that = this;
switch (_that) {
case _DefaultSearchData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'show_name')  String showName,  String name, @JsonKey(name: 'id')  int id,  String url,  String seid,  int type, @JsonKey(name: 'goto_type')  int gotoType, @JsonKey(name: 'goto_value')  String gotoValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DefaultSearchData() when $default != null:
return $default(_that.showName,_that.name,_that.id,_that.url,_that.seid,_that.type,_that.gotoType,_that.gotoValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'show_name')  String showName,  String name, @JsonKey(name: 'id')  int id,  String url,  String seid,  int type, @JsonKey(name: 'goto_type')  int gotoType, @JsonKey(name: 'goto_value')  String gotoValue)  $default,) {final _that = this;
switch (_that) {
case _DefaultSearchData():
return $default(_that.showName,_that.name,_that.id,_that.url,_that.seid,_that.type,_that.gotoType,_that.gotoValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'show_name')  String showName,  String name, @JsonKey(name: 'id')  int id,  String url,  String seid,  int type, @JsonKey(name: 'goto_type')  int gotoType, @JsonKey(name: 'goto_value')  String gotoValue)?  $default,) {final _that = this;
switch (_that) {
case _DefaultSearchData() when $default != null:
return $default(_that.showName,_that.name,_that.id,_that.url,_that.seid,_that.type,_that.gotoType,_that.gotoValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DefaultSearchData implements DefaultSearchData {
  const _DefaultSearchData({@JsonKey(name: 'show_name') required this.showName, required this.name, @JsonKey(name: 'id') required this.id, this.url = '', this.seid = '', this.type = 0, @JsonKey(name: 'goto_type') this.gotoType = 0, @JsonKey(name: 'goto_value') this.gotoValue = ''});
  factory _DefaultSearchData.fromJson(Map<String, dynamic> json) => _$DefaultSearchDataFromJson(json);

@override@JsonKey(name: 'show_name') final  String showName;
@override final  String name;
@override@JsonKey(name: 'id') final  int id;
@override@JsonKey() final  String url;
@override@JsonKey() final  String seid;
@override@JsonKey() final  int type;
@override@JsonKey(name: 'goto_type') final  int gotoType;
@override@JsonKey(name: 'goto_value') final  String gotoValue;

/// Create a copy of DefaultSearchData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DefaultSearchDataCopyWith<_DefaultSearchData> get copyWith => __$DefaultSearchDataCopyWithImpl<_DefaultSearchData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DefaultSearchDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DefaultSearchData&&(identical(other.showName, showName) || other.showName == showName)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.seid, seid) || other.seid == seid)&&(identical(other.type, type) || other.type == type)&&(identical(other.gotoType, gotoType) || other.gotoType == gotoType)&&(identical(other.gotoValue, gotoValue) || other.gotoValue == gotoValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showName,name,id,url,seid,type,gotoType,gotoValue);

@override
String toString() {
  return 'DefaultSearchData(showName: $showName, name: $name, id: $id, url: $url, seid: $seid, type: $type, gotoType: $gotoType, gotoValue: $gotoValue)';
}


}

/// @nodoc
abstract mixin class _$DefaultSearchDataCopyWith<$Res> implements $DefaultSearchDataCopyWith<$Res> {
  factory _$DefaultSearchDataCopyWith(_DefaultSearchData value, $Res Function(_DefaultSearchData) _then) = __$DefaultSearchDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'show_name') String showName, String name,@JsonKey(name: 'id') int id, String url, String seid, int type,@JsonKey(name: 'goto_type') int gotoType,@JsonKey(name: 'goto_value') String gotoValue
});




}
/// @nodoc
class __$DefaultSearchDataCopyWithImpl<$Res>
    implements _$DefaultSearchDataCopyWith<$Res> {
  __$DefaultSearchDataCopyWithImpl(this._self, this._then);

  final _DefaultSearchData _self;
  final $Res Function(_DefaultSearchData) _then;

/// Create a copy of DefaultSearchData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showName = null,Object? name = null,Object? id = null,Object? url = null,Object? seid = null,Object? type = null,Object? gotoType = null,Object? gotoValue = null,}) {
  return _then(_DefaultSearchData(
showName: null == showName ? _self.showName : showName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,seid: null == seid ? _self.seid : seid // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,gotoType: null == gotoType ? _self.gotoType : gotoType // ignore: cast_nullable_to_non_nullable
as int,gotoValue: null == gotoValue ? _self.gotoValue : gotoValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
