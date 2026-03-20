// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchSuggestionResponse {

 int? get code;@JsonKey(name: 'exp_str') String? get expStr;@SearchSuggestionResultConverter() SearchSuggestionResult? get result;
/// Create a copy of SearchSuggestionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSuggestionResponseCopyWith<SearchSuggestionResponse> get copyWith => _$SearchSuggestionResponseCopyWithImpl<SearchSuggestionResponse>(this as SearchSuggestionResponse, _$identity);

  /// Serializes this SearchSuggestionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSuggestionResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.expStr, expStr) || other.expStr == expStr)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,expStr,result);

@override
String toString() {
  return 'SearchSuggestionResponse(code: $code, expStr: $expStr, result: $result)';
}


}

/// @nodoc
abstract mixin class $SearchSuggestionResponseCopyWith<$Res>  {
  factory $SearchSuggestionResponseCopyWith(SearchSuggestionResponse value, $Res Function(SearchSuggestionResponse) _then) = _$SearchSuggestionResponseCopyWithImpl;
@useResult
$Res call({
 int? code,@JsonKey(name: 'exp_str') String? expStr,@SearchSuggestionResultConverter() SearchSuggestionResult? result
});


$SearchSuggestionResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$SearchSuggestionResponseCopyWithImpl<$Res>
    implements $SearchSuggestionResponseCopyWith<$Res> {
  _$SearchSuggestionResponseCopyWithImpl(this._self, this._then);

  final SearchSuggestionResponse _self;
  final $Res Function(SearchSuggestionResponse) _then;

/// Create a copy of SearchSuggestionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? expStr = freezed,Object? result = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,expStr: freezed == expStr ? _self.expStr : expStr // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SearchSuggestionResult?,
  ));
}
/// Create a copy of SearchSuggestionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchSuggestionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $SearchSuggestionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchSuggestionResponse].
extension SearchSuggestionResponsePatterns on SearchSuggestionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchSuggestionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchSuggestionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchSuggestionResponse value)  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchSuggestionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code, @JsonKey(name: 'exp_str')  String? expStr, @SearchSuggestionResultConverter()  SearchSuggestionResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchSuggestionResponse() when $default != null:
return $default(_that.code,_that.expStr,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code, @JsonKey(name: 'exp_str')  String? expStr, @SearchSuggestionResultConverter()  SearchSuggestionResult? result)  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestionResponse():
return $default(_that.code,_that.expStr,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code, @JsonKey(name: 'exp_str')  String? expStr, @SearchSuggestionResultConverter()  SearchSuggestionResult? result)?  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestionResponse() when $default != null:
return $default(_that.code,_that.expStr,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchSuggestionResponse implements SearchSuggestionResponse {
  const _SearchSuggestionResponse({this.code, @JsonKey(name: 'exp_str') this.expStr, @SearchSuggestionResultConverter() this.result});
  factory _SearchSuggestionResponse.fromJson(Map<String, dynamic> json) => _$SearchSuggestionResponseFromJson(json);

@override final  int? code;
@override@JsonKey(name: 'exp_str') final  String? expStr;
@override@SearchSuggestionResultConverter() final  SearchSuggestionResult? result;

/// Create a copy of SearchSuggestionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSuggestionResponseCopyWith<_SearchSuggestionResponse> get copyWith => __$SearchSuggestionResponseCopyWithImpl<_SearchSuggestionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchSuggestionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSuggestionResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.expStr, expStr) || other.expStr == expStr)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,expStr,result);

@override
String toString() {
  return 'SearchSuggestionResponse(code: $code, expStr: $expStr, result: $result)';
}


}

/// @nodoc
abstract mixin class _$SearchSuggestionResponseCopyWith<$Res> implements $SearchSuggestionResponseCopyWith<$Res> {
  factory _$SearchSuggestionResponseCopyWith(_SearchSuggestionResponse value, $Res Function(_SearchSuggestionResponse) _then) = __$SearchSuggestionResponseCopyWithImpl;
@override @useResult
$Res call({
 int? code,@JsonKey(name: 'exp_str') String? expStr,@SearchSuggestionResultConverter() SearchSuggestionResult? result
});


@override $SearchSuggestionResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$SearchSuggestionResponseCopyWithImpl<$Res>
    implements _$SearchSuggestionResponseCopyWith<$Res> {
  __$SearchSuggestionResponseCopyWithImpl(this._self, this._then);

  final _SearchSuggestionResponse _self;
  final $Res Function(_SearchSuggestionResponse) _then;

/// Create a copy of SearchSuggestionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? expStr = freezed,Object? result = freezed,}) {
  return _then(_SearchSuggestionResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,expStr: freezed == expStr ? _self.expStr : expStr // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SearchSuggestionResult?,
  ));
}

/// Create a copy of SearchSuggestionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchSuggestionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $SearchSuggestionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$SearchSuggestionResult {

@JsonKey(name: 'tag') List<SearchSuggestionTag>? get tags;
/// Create a copy of SearchSuggestionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSuggestionResultCopyWith<SearchSuggestionResult> get copyWith => _$SearchSuggestionResultCopyWithImpl<SearchSuggestionResult>(this as SearchSuggestionResult, _$identity);

  /// Serializes this SearchSuggestionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSuggestionResult&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'SearchSuggestionResult(tags: $tags)';
}


}

/// @nodoc
abstract mixin class $SearchSuggestionResultCopyWith<$Res>  {
  factory $SearchSuggestionResultCopyWith(SearchSuggestionResult value, $Res Function(SearchSuggestionResult) _then) = _$SearchSuggestionResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tag') List<SearchSuggestionTag>? tags
});




}
/// @nodoc
class _$SearchSuggestionResultCopyWithImpl<$Res>
    implements $SearchSuggestionResultCopyWith<$Res> {
  _$SearchSuggestionResultCopyWithImpl(this._self, this._then);

  final SearchSuggestionResult _self;
  final $Res Function(SearchSuggestionResult) _then;

/// Create a copy of SearchSuggestionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tags = freezed,}) {
  return _then(_self.copyWith(
tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<SearchSuggestionTag>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchSuggestionResult].
extension SearchSuggestionResultPatterns on SearchSuggestionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchSuggestionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchSuggestionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchSuggestionResult value)  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchSuggestionResult value)?  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tag')  List<SearchSuggestionTag>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchSuggestionResult() when $default != null:
return $default(_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tag')  List<SearchSuggestionTag>? tags)  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestionResult():
return $default(_that.tags);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tag')  List<SearchSuggestionTag>? tags)?  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestionResult() when $default != null:
return $default(_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchSuggestionResult implements SearchSuggestionResult {
  const _SearchSuggestionResult({@JsonKey(name: 'tag') final  List<SearchSuggestionTag>? tags}): _tags = tags;
  factory _SearchSuggestionResult.fromJson(Map<String, dynamic> json) => _$SearchSuggestionResultFromJson(json);

 final  List<SearchSuggestionTag>? _tags;
@override@JsonKey(name: 'tag') List<SearchSuggestionTag>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SearchSuggestionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSuggestionResultCopyWith<_SearchSuggestionResult> get copyWith => __$SearchSuggestionResultCopyWithImpl<_SearchSuggestionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchSuggestionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSuggestionResult&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'SearchSuggestionResult(tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$SearchSuggestionResultCopyWith<$Res> implements $SearchSuggestionResultCopyWith<$Res> {
  factory _$SearchSuggestionResultCopyWith(_SearchSuggestionResult value, $Res Function(_SearchSuggestionResult) _then) = __$SearchSuggestionResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tag') List<SearchSuggestionTag>? tags
});




}
/// @nodoc
class __$SearchSuggestionResultCopyWithImpl<$Res>
    implements _$SearchSuggestionResultCopyWith<$Res> {
  __$SearchSuggestionResultCopyWithImpl(this._self, this._then);

  final _SearchSuggestionResult _self;
  final $Res Function(_SearchSuggestionResult) _then;

/// Create a copy of SearchSuggestionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tags = freezed,}) {
  return _then(_SearchSuggestionResult(
tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<SearchSuggestionTag>?,
  ));
}


}


/// @nodoc
mixin _$SearchSuggestionTag {

 String? get value; String? get term;@JsonKey(name: 'ref') dynamic get ref; String? get name;@JsonKey(name: 'spid') dynamic get spid; String? get type;
/// Create a copy of SearchSuggestionTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSuggestionTagCopyWith<SearchSuggestionTag> get copyWith => _$SearchSuggestionTagCopyWithImpl<SearchSuggestionTag>(this as SearchSuggestionTag, _$identity);

  /// Serializes this SearchSuggestionTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSuggestionTag&&(identical(other.value, value) || other.value == value)&&(identical(other.term, term) || other.term == term)&&const DeepCollectionEquality().equals(other.ref, ref)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.spid, spid)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,term,const DeepCollectionEquality().hash(ref),name,const DeepCollectionEquality().hash(spid),type);

@override
String toString() {
  return 'SearchSuggestionTag(value: $value, term: $term, ref: $ref, name: $name, spid: $spid, type: $type)';
}


}

/// @nodoc
abstract mixin class $SearchSuggestionTagCopyWith<$Res>  {
  factory $SearchSuggestionTagCopyWith(SearchSuggestionTag value, $Res Function(SearchSuggestionTag) _then) = _$SearchSuggestionTagCopyWithImpl;
@useResult
$Res call({
 String? value, String? term,@JsonKey(name: 'ref') dynamic ref, String? name,@JsonKey(name: 'spid') dynamic spid, String? type
});




}
/// @nodoc
class _$SearchSuggestionTagCopyWithImpl<$Res>
    implements $SearchSuggestionTagCopyWith<$Res> {
  _$SearchSuggestionTagCopyWithImpl(this._self, this._then);

  final SearchSuggestionTag _self;
  final $Res Function(SearchSuggestionTag) _then;

/// Create a copy of SearchSuggestionTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? term = freezed,Object? ref = freezed,Object? name = freezed,Object? spid = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,term: freezed == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String?,ref: freezed == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as dynamic,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,spid: freezed == spid ? _self.spid : spid // ignore: cast_nullable_to_non_nullable
as dynamic,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchSuggestionTag].
extension SearchSuggestionTagPatterns on SearchSuggestionTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchSuggestionTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchSuggestionTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchSuggestionTag value)  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestionTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchSuggestionTag value)?  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestionTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? value,  String? term, @JsonKey(name: 'ref')  dynamic ref,  String? name, @JsonKey(name: 'spid')  dynamic spid,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchSuggestionTag() when $default != null:
return $default(_that.value,_that.term,_that.ref,_that.name,_that.spid,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? value,  String? term, @JsonKey(name: 'ref')  dynamic ref,  String? name, @JsonKey(name: 'spid')  dynamic spid,  String? type)  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestionTag():
return $default(_that.value,_that.term,_that.ref,_that.name,_that.spid,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? value,  String? term, @JsonKey(name: 'ref')  dynamic ref,  String? name, @JsonKey(name: 'spid')  dynamic spid,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestionTag() when $default != null:
return $default(_that.value,_that.term,_that.ref,_that.name,_that.spid,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchSuggestionTag implements SearchSuggestionTag {
  const _SearchSuggestionTag({this.value, this.term, @JsonKey(name: 'ref') this.ref, this.name, @JsonKey(name: 'spid') this.spid, this.type});
  factory _SearchSuggestionTag.fromJson(Map<String, dynamic> json) => _$SearchSuggestionTagFromJson(json);

@override final  String? value;
@override final  String? term;
@override@JsonKey(name: 'ref') final  dynamic ref;
@override final  String? name;
@override@JsonKey(name: 'spid') final  dynamic spid;
@override final  String? type;

/// Create a copy of SearchSuggestionTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSuggestionTagCopyWith<_SearchSuggestionTag> get copyWith => __$SearchSuggestionTagCopyWithImpl<_SearchSuggestionTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchSuggestionTagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSuggestionTag&&(identical(other.value, value) || other.value == value)&&(identical(other.term, term) || other.term == term)&&const DeepCollectionEquality().equals(other.ref, ref)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.spid, spid)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,term,const DeepCollectionEquality().hash(ref),name,const DeepCollectionEquality().hash(spid),type);

@override
String toString() {
  return 'SearchSuggestionTag(value: $value, term: $term, ref: $ref, name: $name, spid: $spid, type: $type)';
}


}

/// @nodoc
abstract mixin class _$SearchSuggestionTagCopyWith<$Res> implements $SearchSuggestionTagCopyWith<$Res> {
  factory _$SearchSuggestionTagCopyWith(_SearchSuggestionTag value, $Res Function(_SearchSuggestionTag) _then) = __$SearchSuggestionTagCopyWithImpl;
@override @useResult
$Res call({
 String? value, String? term,@JsonKey(name: 'ref') dynamic ref, String? name,@JsonKey(name: 'spid') dynamic spid, String? type
});




}
/// @nodoc
class __$SearchSuggestionTagCopyWithImpl<$Res>
    implements _$SearchSuggestionTagCopyWith<$Res> {
  __$SearchSuggestionTagCopyWithImpl(this._self, this._then);

  final _SearchSuggestionTag _self;
  final $Res Function(_SearchSuggestionTag) _then;

/// Create a copy of SearchSuggestionTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? term = freezed,Object? ref = freezed,Object? name = freezed,Object? spid = freezed,Object? type = freezed,}) {
  return _then(_SearchSuggestionTag(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,term: freezed == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String?,ref: freezed == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as dynamic,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,spid: freezed == spid ? _self.spid : spid // ignore: cast_nullable_to_non_nullable
as dynamic,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
