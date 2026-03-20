// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchResultResponse {

 int get code; String get message; int get ttl; SearchResultData? get data;
/// Create a copy of SearchResultResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultResponseCopyWith<SearchResultResponse> get copyWith => _$SearchResultResponseCopyWithImpl<SearchResultResponse>(this as SearchResultResponse, _$identity);

  /// Serializes this SearchResultResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,ttl,data);

@override
String toString() {
  return 'SearchResultResponse(code: $code, message: $message, ttl: $ttl, data: $data)';
}


}

/// @nodoc
abstract mixin class $SearchResultResponseCopyWith<$Res>  {
  factory $SearchResultResponseCopyWith(SearchResultResponse value, $Res Function(SearchResultResponse) _then) = _$SearchResultResponseCopyWithImpl;
@useResult
$Res call({
 int code, String message, int ttl, SearchResultData? data
});


$SearchResultDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SearchResultResponseCopyWithImpl<$Res>
    implements $SearchResultResponseCopyWith<$Res> {
  _$SearchResultResponseCopyWithImpl(this._self, this._then);

  final SearchResultResponse _self;
  final $Res Function(SearchResultResponse) _then;

/// Create a copy of SearchResultResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? ttl = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SearchResultData?,
  ));
}
/// Create a copy of SearchResultResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchResultDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SearchResultDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchResultResponse].
extension SearchResultResponsePatterns on SearchResultResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultResponse value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message,  int ttl,  SearchResultData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message,  int ttl,  SearchResultData? data)  $default,) {final _that = this;
switch (_that) {
case _SearchResultResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message,  int ttl,  SearchResultData? data)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultResponse() when $default != null:
return $default(_that.code,_that.message,_that.ttl,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResultResponse implements SearchResultResponse {
  const _SearchResultResponse({required this.code, required this.message, required this.ttl, this.data});
  factory _SearchResultResponse.fromJson(Map<String, dynamic> json) => _$SearchResultResponseFromJson(json);

@override final  int code;
@override final  String message;
@override final  int ttl;
@override final  SearchResultData? data;

/// Create a copy of SearchResultResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultResponseCopyWith<_SearchResultResponse> get copyWith => __$SearchResultResponseCopyWithImpl<_SearchResultResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,ttl,data);

@override
String toString() {
  return 'SearchResultResponse(code: $code, message: $message, ttl: $ttl, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SearchResultResponseCopyWith<$Res> implements $SearchResultResponseCopyWith<$Res> {
  factory _$SearchResultResponseCopyWith(_SearchResultResponse value, $Res Function(_SearchResultResponse) _then) = __$SearchResultResponseCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, int ttl, SearchResultData? data
});


@override $SearchResultDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SearchResultResponseCopyWithImpl<$Res>
    implements _$SearchResultResponseCopyWith<$Res> {
  __$SearchResultResponseCopyWithImpl(this._self, this._then);

  final _SearchResultResponse _self;
  final $Res Function(_SearchResultResponse) _then;

/// Create a copy of SearchResultResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? ttl = null,Object? data = freezed,}) {
  return _then(_SearchResultResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SearchResultData?,
  ));
}

/// Create a copy of SearchResultResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchResultDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SearchResultDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SearchResultData {

@JsonKey(name: 'seid') String get seid;@JsonKey(name: 'page') int get page;@JsonKey(name: 'pagesize') int get pageSize;@JsonKey(name: 'numResults') int get numResults;@JsonKey(name: 'numPages') int get numPages;@JsonKey(name: 'result')@_SearchResultConverter() List<SearchResultItem> get result;
/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultDataCopyWith<SearchResultData> get copyWith => _$SearchResultDataCopyWithImpl<SearchResultData>(this as SearchResultData, _$identity);

  /// Serializes this SearchResultData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultData&&(identical(other.seid, seid) || other.seid == seid)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.numResults, numResults) || other.numResults == numResults)&&(identical(other.numPages, numPages) || other.numPages == numPages)&&const DeepCollectionEquality().equals(other.result, result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seid,page,pageSize,numResults,numPages,const DeepCollectionEquality().hash(result));

@override
String toString() {
  return 'SearchResultData(seid: $seid, page: $page, pageSize: $pageSize, numResults: $numResults, numPages: $numPages, result: $result)';
}


}

/// @nodoc
abstract mixin class $SearchResultDataCopyWith<$Res>  {
  factory $SearchResultDataCopyWith(SearchResultData value, $Res Function(SearchResultData) _then) = _$SearchResultDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'seid') String seid,@JsonKey(name: 'page') int page,@JsonKey(name: 'pagesize') int pageSize,@JsonKey(name: 'numResults') int numResults,@JsonKey(name: 'numPages') int numPages,@JsonKey(name: 'result')@_SearchResultConverter() List<SearchResultItem> result
});




}
/// @nodoc
class _$SearchResultDataCopyWithImpl<$Res>
    implements $SearchResultDataCopyWith<$Res> {
  _$SearchResultDataCopyWithImpl(this._self, this._then);

  final SearchResultData _self;
  final $Res Function(SearchResultData) _then;

/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seid = null,Object? page = null,Object? pageSize = null,Object? numResults = null,Object? numPages = null,Object? result = null,}) {
  return _then(_self.copyWith(
seid: null == seid ? _self.seid : seid // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,numResults: null == numResults ? _self.numResults : numResults // ignore: cast_nullable_to_non_nullable
as int,numPages: null == numPages ? _self.numPages : numPages // ignore: cast_nullable_to_non_nullable
as int,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as List<SearchResultItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResultData].
extension SearchResultDataPatterns on SearchResultData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultData value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultData value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'seid')  String seid, @JsonKey(name: 'page')  int page, @JsonKey(name: 'pagesize')  int pageSize, @JsonKey(name: 'numResults')  int numResults, @JsonKey(name: 'numPages')  int numPages, @JsonKey(name: 'result')@_SearchResultConverter()  List<SearchResultItem> result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
return $default(_that.seid,_that.page,_that.pageSize,_that.numResults,_that.numPages,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'seid')  String seid, @JsonKey(name: 'page')  int page, @JsonKey(name: 'pagesize')  int pageSize, @JsonKey(name: 'numResults')  int numResults, @JsonKey(name: 'numPages')  int numPages, @JsonKey(name: 'result')@_SearchResultConverter()  List<SearchResultItem> result)  $default,) {final _that = this;
switch (_that) {
case _SearchResultData():
return $default(_that.seid,_that.page,_that.pageSize,_that.numResults,_that.numPages,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'seid')  String seid, @JsonKey(name: 'page')  int page, @JsonKey(name: 'pagesize')  int pageSize, @JsonKey(name: 'numResults')  int numResults, @JsonKey(name: 'numPages')  int numPages, @JsonKey(name: 'result')@_SearchResultConverter()  List<SearchResultItem> result)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultData() when $default != null:
return $default(_that.seid,_that.page,_that.pageSize,_that.numResults,_that.numPages,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResultData implements SearchResultData {
  const _SearchResultData({@JsonKey(name: 'seid') required this.seid, @JsonKey(name: 'page') required this.page, @JsonKey(name: 'pagesize') required this.pageSize, @JsonKey(name: 'numResults') required this.numResults, @JsonKey(name: 'numPages') required this.numPages, @JsonKey(name: 'result')@_SearchResultConverter() final  List<SearchResultItem> result = const []}): _result = result;
  factory _SearchResultData.fromJson(Map<String, dynamic> json) => _$SearchResultDataFromJson(json);

@override@JsonKey(name: 'seid') final  String seid;
@override@JsonKey(name: 'page') final  int page;
@override@JsonKey(name: 'pagesize') final  int pageSize;
@override@JsonKey(name: 'numResults') final  int numResults;
@override@JsonKey(name: 'numPages') final  int numPages;
 final  List<SearchResultItem> _result;
@override@JsonKey(name: 'result')@_SearchResultConverter() List<SearchResultItem> get result {
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_result);
}


/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultDataCopyWith<_SearchResultData> get copyWith => __$SearchResultDataCopyWithImpl<_SearchResultData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultData&&(identical(other.seid, seid) || other.seid == seid)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.numResults, numResults) || other.numResults == numResults)&&(identical(other.numPages, numPages) || other.numPages == numPages)&&const DeepCollectionEquality().equals(other._result, _result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seid,page,pageSize,numResults,numPages,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'SearchResultData(seid: $seid, page: $page, pageSize: $pageSize, numResults: $numResults, numPages: $numPages, result: $result)';
}


}

/// @nodoc
abstract mixin class _$SearchResultDataCopyWith<$Res> implements $SearchResultDataCopyWith<$Res> {
  factory _$SearchResultDataCopyWith(_SearchResultData value, $Res Function(_SearchResultData) _then) = __$SearchResultDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'seid') String seid,@JsonKey(name: 'page') int page,@JsonKey(name: 'pagesize') int pageSize,@JsonKey(name: 'numResults') int numResults,@JsonKey(name: 'numPages') int numPages,@JsonKey(name: 'result')@_SearchResultConverter() List<SearchResultItem> result
});




}
/// @nodoc
class __$SearchResultDataCopyWithImpl<$Res>
    implements _$SearchResultDataCopyWith<$Res> {
  __$SearchResultDataCopyWithImpl(this._self, this._then);

  final _SearchResultData _self;
  final $Res Function(_SearchResultData) _then;

/// Create a copy of SearchResultData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seid = null,Object? page = null,Object? pageSize = null,Object? numResults = null,Object? numPages = null,Object? result = null,}) {
  return _then(_SearchResultData(
seid: null == seid ? _self.seid : seid // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,numResults: null == numResults ? _self.numResults : numResults // ignore: cast_nullable_to_non_nullable
as int,numPages: null == numPages ? _self.numPages : numPages // ignore: cast_nullable_to_non_nullable
as int,result: null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<SearchResultItem>,
  ));
}


}

SearchResultItem _$SearchResultItemFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'bili_user':
          return SearchUserModel.fromJson(
            json
          );
                case 'media_bangumi':
          return SearchBangumiModel.fromJson(
            json
          );
                case 'article':
          return SearchArticleModel.fromJson(
            json
          );
                case 'topic':
          return SearchTopicModel.fromJson(
            json
          );
        
          default:
            return SearchVideoModel.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$SearchResultItem {

 String? get type;
/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultItemCopyWith<SearchResultItem> get copyWith => _$SearchResultItemCopyWithImpl<SearchResultItem>(this as SearchResultItem, _$identity);

  /// Serializes this SearchResultItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultItem&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'SearchResultItem(type: $type)';
}


}

/// @nodoc
abstract mixin class $SearchResultItemCopyWith<$Res>  {
  factory $SearchResultItemCopyWith(SearchResultItem value, $Res Function(SearchResultItem) _then) = _$SearchResultItemCopyWithImpl;
@useResult
$Res call({
 String? type
});




}
/// @nodoc
class _$SearchResultItemCopyWithImpl<$Res>
    implements $SearchResultItemCopyWith<$Res> {
  _$SearchResultItemCopyWithImpl(this._self, this._then);

  final SearchResultItem _self;
  final $Res Function(SearchResultItem) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResultItem].
extension SearchResultItemPatterns on SearchResultItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchVideoModel value)?  video,TResult Function( SearchUserModel value)?  user,TResult Function( SearchBangumiModel value)?  bangumi,TResult Function( SearchArticleModel value)?  article,TResult Function( SearchTopicModel value)?  topic,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchVideoModel() when video != null:
return video(_that);case SearchUserModel() when user != null:
return user(_that);case SearchBangumiModel() when bangumi != null:
return bangumi(_that);case SearchArticleModel() when article != null:
return article(_that);case SearchTopicModel() when topic != null:
return topic(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchVideoModel value)  video,required TResult Function( SearchUserModel value)  user,required TResult Function( SearchBangumiModel value)  bangumi,required TResult Function( SearchArticleModel value)  article,required TResult Function( SearchTopicModel value)  topic,}){
final _that = this;
switch (_that) {
case SearchVideoModel():
return video(_that);case SearchUserModel():
return user(_that);case SearchBangumiModel():
return bangumi(_that);case SearchArticleModel():
return article(_that);case SearchTopicModel():
return topic(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchVideoModel value)?  video,TResult? Function( SearchUserModel value)?  user,TResult? Function( SearchBangumiModel value)?  bangumi,TResult? Function( SearchArticleModel value)?  article,TResult? Function( SearchTopicModel value)?  topic,}){
final _that = this;
switch (_that) {
case SearchVideoModel() when video != null:
return video(_that);case SearchUserModel() when user != null:
return user(_that);case SearchBangumiModel() when bangumi != null:
return bangumi(_that);case SearchArticleModel() when article != null:
return article(_that);case SearchTopicModel() when topic != null:
return topic(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? type,  String? title,  String? author,  String? pic,  String? bvid,  String? duration,  dynamic play,  dynamic view, @JsonKey(name: 'video_review')  int? videoReview,  int? danmaku,  int? favorites,  int? review,  int? pubdate,  String? typename,  String? arcurl)?  video,TResult Function( String? type,  String? uname,  String? upic, @JsonKey(name: 'upic_url')  String? upicUrl,  String? usign,  int? fans,  int? videos,  int? level,  int? mid)?  user,TResult Function( String? type,  String? title,  String? cover,  String? pic, @JsonKey(name: 'season_id')  int? seasonId, @JsonKey(name: 'pgc_season_id')  int? pgcSeasonId, @JsonKey(name: 'season_type_name')  String? seasonTypeName,  String? areas,  String? styles,  String? label, @JsonKey(name: 'goto_url')  String? gotoUrl)?  bangumi,TResult Function( String? type,  String? title, @JsonKey(name: 'image_urls')  List<String>? imageUrls,  String? author,  String? uname,  dynamic view,  int? review, @JsonKey(name: 'pub_time')  int? pubTime)?  article,TResult Function( String? type,  String? title,  String? description,  String? cover, @JsonKey(name: 'tp_id')  int? tpId, @JsonKey(name: 'arcurl')  String? arcurl,  String? author,  int? update)?  topic,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchVideoModel() when video != null:
return video(_that.type,_that.title,_that.author,_that.pic,_that.bvid,_that.duration,_that.play,_that.view,_that.videoReview,_that.danmaku,_that.favorites,_that.review,_that.pubdate,_that.typename,_that.arcurl);case SearchUserModel() when user != null:
return user(_that.type,_that.uname,_that.upic,_that.upicUrl,_that.usign,_that.fans,_that.videos,_that.level,_that.mid);case SearchBangumiModel() when bangumi != null:
return bangumi(_that.type,_that.title,_that.cover,_that.pic,_that.seasonId,_that.pgcSeasonId,_that.seasonTypeName,_that.areas,_that.styles,_that.label,_that.gotoUrl);case SearchArticleModel() when article != null:
return article(_that.type,_that.title,_that.imageUrls,_that.author,_that.uname,_that.view,_that.review,_that.pubTime);case SearchTopicModel() when topic != null:
return topic(_that.type,_that.title,_that.description,_that.cover,_that.tpId,_that.arcurl,_that.author,_that.update);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? type,  String? title,  String? author,  String? pic,  String? bvid,  String? duration,  dynamic play,  dynamic view, @JsonKey(name: 'video_review')  int? videoReview,  int? danmaku,  int? favorites,  int? review,  int? pubdate,  String? typename,  String? arcurl)  video,required TResult Function( String? type,  String? uname,  String? upic, @JsonKey(name: 'upic_url')  String? upicUrl,  String? usign,  int? fans,  int? videos,  int? level,  int? mid)  user,required TResult Function( String? type,  String? title,  String? cover,  String? pic, @JsonKey(name: 'season_id')  int? seasonId, @JsonKey(name: 'pgc_season_id')  int? pgcSeasonId, @JsonKey(name: 'season_type_name')  String? seasonTypeName,  String? areas,  String? styles,  String? label, @JsonKey(name: 'goto_url')  String? gotoUrl)  bangumi,required TResult Function( String? type,  String? title, @JsonKey(name: 'image_urls')  List<String>? imageUrls,  String? author,  String? uname,  dynamic view,  int? review, @JsonKey(name: 'pub_time')  int? pubTime)  article,required TResult Function( String? type,  String? title,  String? description,  String? cover, @JsonKey(name: 'tp_id')  int? tpId, @JsonKey(name: 'arcurl')  String? arcurl,  String? author,  int? update)  topic,}) {final _that = this;
switch (_that) {
case SearchVideoModel():
return video(_that.type,_that.title,_that.author,_that.pic,_that.bvid,_that.duration,_that.play,_that.view,_that.videoReview,_that.danmaku,_that.favorites,_that.review,_that.pubdate,_that.typename,_that.arcurl);case SearchUserModel():
return user(_that.type,_that.uname,_that.upic,_that.upicUrl,_that.usign,_that.fans,_that.videos,_that.level,_that.mid);case SearchBangumiModel():
return bangumi(_that.type,_that.title,_that.cover,_that.pic,_that.seasonId,_that.pgcSeasonId,_that.seasonTypeName,_that.areas,_that.styles,_that.label,_that.gotoUrl);case SearchArticleModel():
return article(_that.type,_that.title,_that.imageUrls,_that.author,_that.uname,_that.view,_that.review,_that.pubTime);case SearchTopicModel():
return topic(_that.type,_that.title,_that.description,_that.cover,_that.tpId,_that.arcurl,_that.author,_that.update);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? type,  String? title,  String? author,  String? pic,  String? bvid,  String? duration,  dynamic play,  dynamic view, @JsonKey(name: 'video_review')  int? videoReview,  int? danmaku,  int? favorites,  int? review,  int? pubdate,  String? typename,  String? arcurl)?  video,TResult? Function( String? type,  String? uname,  String? upic, @JsonKey(name: 'upic_url')  String? upicUrl,  String? usign,  int? fans,  int? videos,  int? level,  int? mid)?  user,TResult? Function( String? type,  String? title,  String? cover,  String? pic, @JsonKey(name: 'season_id')  int? seasonId, @JsonKey(name: 'pgc_season_id')  int? pgcSeasonId, @JsonKey(name: 'season_type_name')  String? seasonTypeName,  String? areas,  String? styles,  String? label, @JsonKey(name: 'goto_url')  String? gotoUrl)?  bangumi,TResult? Function( String? type,  String? title, @JsonKey(name: 'image_urls')  List<String>? imageUrls,  String? author,  String? uname,  dynamic view,  int? review, @JsonKey(name: 'pub_time')  int? pubTime)?  article,TResult? Function( String? type,  String? title,  String? description,  String? cover, @JsonKey(name: 'tp_id')  int? tpId, @JsonKey(name: 'arcurl')  String? arcurl,  String? author,  int? update)?  topic,}) {final _that = this;
switch (_that) {
case SearchVideoModel() when video != null:
return video(_that.type,_that.title,_that.author,_that.pic,_that.bvid,_that.duration,_that.play,_that.view,_that.videoReview,_that.danmaku,_that.favorites,_that.review,_that.pubdate,_that.typename,_that.arcurl);case SearchUserModel() when user != null:
return user(_that.type,_that.uname,_that.upic,_that.upicUrl,_that.usign,_that.fans,_that.videos,_that.level,_that.mid);case SearchBangumiModel() when bangumi != null:
return bangumi(_that.type,_that.title,_that.cover,_that.pic,_that.seasonId,_that.pgcSeasonId,_that.seasonTypeName,_that.areas,_that.styles,_that.label,_that.gotoUrl);case SearchArticleModel() when article != null:
return article(_that.type,_that.title,_that.imageUrls,_that.author,_that.uname,_that.view,_that.review,_that.pubTime);case SearchTopicModel() when topic != null:
return topic(_that.type,_that.title,_that.description,_that.cover,_that.tpId,_that.arcurl,_that.author,_that.update);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SearchVideoModel implements SearchResultItem {
  const SearchVideoModel({this.type, this.title, this.author, this.pic, this.bvid, this.duration, this.play, this.view, @JsonKey(name: 'video_review') this.videoReview, this.danmaku, this.favorites, this.review, this.pubdate, this.typename, this.arcurl});
  factory SearchVideoModel.fromJson(Map<String, dynamic> json) => _$SearchVideoModelFromJson(json);

@override final  String? type;
 final  String? title;
 final  String? author;
 final  String? pic;
 final  String? bvid;
 final  String? duration;
 final  dynamic play;
 final  dynamic view;
@JsonKey(name: 'video_review') final  int? videoReview;
 final  int? danmaku;
 final  int? favorites;
 final  int? review;
 final  int? pubdate;
 final  String? typename;
 final  String? arcurl;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchVideoModelCopyWith<SearchVideoModel> get copyWith => _$SearchVideoModelCopyWithImpl<SearchVideoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchVideoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchVideoModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.bvid, bvid) || other.bvid == bvid)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.play, play)&&const DeepCollectionEquality().equals(other.view, view)&&(identical(other.videoReview, videoReview) || other.videoReview == videoReview)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.review, review) || other.review == review)&&(identical(other.pubdate, pubdate) || other.pubdate == pubdate)&&(identical(other.typename, typename) || other.typename == typename)&&(identical(other.arcurl, arcurl) || other.arcurl == arcurl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,author,pic,bvid,duration,const DeepCollectionEquality().hash(play),const DeepCollectionEquality().hash(view),videoReview,danmaku,favorites,review,pubdate,typename,arcurl);

@override
String toString() {
  return 'SearchResultItem.video(type: $type, title: $title, author: $author, pic: $pic, bvid: $bvid, duration: $duration, play: $play, view: $view, videoReview: $videoReview, danmaku: $danmaku, favorites: $favorites, review: $review, pubdate: $pubdate, typename: $typename, arcurl: $arcurl)';
}


}

/// @nodoc
abstract mixin class $SearchVideoModelCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $SearchVideoModelCopyWith(SearchVideoModel value, $Res Function(SearchVideoModel) _then) = _$SearchVideoModelCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? title, String? author, String? pic, String? bvid, String? duration, dynamic play, dynamic view,@JsonKey(name: 'video_review') int? videoReview, int? danmaku, int? favorites, int? review, int? pubdate, String? typename, String? arcurl
});




}
/// @nodoc
class _$SearchVideoModelCopyWithImpl<$Res>
    implements $SearchVideoModelCopyWith<$Res> {
  _$SearchVideoModelCopyWithImpl(this._self, this._then);

  final SearchVideoModel _self;
  final $Res Function(SearchVideoModel) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = freezed,Object? author = freezed,Object? pic = freezed,Object? bvid = freezed,Object? duration = freezed,Object? play = freezed,Object? view = freezed,Object? videoReview = freezed,Object? danmaku = freezed,Object? favorites = freezed,Object? review = freezed,Object? pubdate = freezed,Object? typename = freezed,Object? arcurl = freezed,}) {
  return _then(SearchVideoModel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,pic: freezed == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String?,bvid: freezed == bvid ? _self.bvid : bvid // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,play: freezed == play ? _self.play : play // ignore: cast_nullable_to_non_nullable
as dynamic,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as dynamic,videoReview: freezed == videoReview ? _self.videoReview : videoReview // ignore: cast_nullable_to_non_nullable
as int?,danmaku: freezed == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as int?,favorites: freezed == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as int?,pubdate: freezed == pubdate ? _self.pubdate : pubdate // ignore: cast_nullable_to_non_nullable
as int?,typename: freezed == typename ? _self.typename : typename // ignore: cast_nullable_to_non_nullable
as String?,arcurl: freezed == arcurl ? _self.arcurl : arcurl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SearchUserModel implements SearchResultItem {
  const SearchUserModel({this.type, this.uname, this.upic, @JsonKey(name: 'upic_url') this.upicUrl, this.usign, this.fans, this.videos, this.level, this.mid});
  factory SearchUserModel.fromJson(Map<String, dynamic> json) => _$SearchUserModelFromJson(json);

@override final  String? type;
 final  String? uname;
 final  String? upic;
@JsonKey(name: 'upic_url') final  String? upicUrl;
 final  String? usign;
 final  int? fans;
 final  int? videos;
 final  int? level;
 final  int? mid;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchUserModelCopyWith<SearchUserModel> get copyWith => _$SearchUserModelCopyWithImpl<SearchUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchUserModel&&(identical(other.type, type) || other.type == type)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.upic, upic) || other.upic == upic)&&(identical(other.upicUrl, upicUrl) || other.upicUrl == upicUrl)&&(identical(other.usign, usign) || other.usign == usign)&&(identical(other.fans, fans) || other.fans == fans)&&(identical(other.videos, videos) || other.videos == videos)&&(identical(other.level, level) || other.level == level)&&(identical(other.mid, mid) || other.mid == mid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,uname,upic,upicUrl,usign,fans,videos,level,mid);

@override
String toString() {
  return 'SearchResultItem.user(type: $type, uname: $uname, upic: $upic, upicUrl: $upicUrl, usign: $usign, fans: $fans, videos: $videos, level: $level, mid: $mid)';
}


}

/// @nodoc
abstract mixin class $SearchUserModelCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $SearchUserModelCopyWith(SearchUserModel value, $Res Function(SearchUserModel) _then) = _$SearchUserModelCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? uname, String? upic,@JsonKey(name: 'upic_url') String? upicUrl, String? usign, int? fans, int? videos, int? level, int? mid
});




}
/// @nodoc
class _$SearchUserModelCopyWithImpl<$Res>
    implements $SearchUserModelCopyWith<$Res> {
  _$SearchUserModelCopyWithImpl(this._self, this._then);

  final SearchUserModel _self;
  final $Res Function(SearchUserModel) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? uname = freezed,Object? upic = freezed,Object? upicUrl = freezed,Object? usign = freezed,Object? fans = freezed,Object? videos = freezed,Object? level = freezed,Object? mid = freezed,}) {
  return _then(SearchUserModel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,uname: freezed == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String?,upic: freezed == upic ? _self.upic : upic // ignore: cast_nullable_to_non_nullable
as String?,upicUrl: freezed == upicUrl ? _self.upicUrl : upicUrl // ignore: cast_nullable_to_non_nullable
as String?,usign: freezed == usign ? _self.usign : usign // ignore: cast_nullable_to_non_nullable
as String?,fans: freezed == fans ? _self.fans : fans // ignore: cast_nullable_to_non_nullable
as int?,videos: freezed == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as int?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SearchBangumiModel implements SearchResultItem {
  const SearchBangumiModel({this.type, this.title, this.cover, this.pic, @JsonKey(name: 'season_id') this.seasonId, @JsonKey(name: 'pgc_season_id') this.pgcSeasonId, @JsonKey(name: 'season_type_name') this.seasonTypeName, this.areas, this.styles, this.label, @JsonKey(name: 'goto_url') this.gotoUrl});
  factory SearchBangumiModel.fromJson(Map<String, dynamic> json) => _$SearchBangumiModelFromJson(json);

@override final  String? type;
 final  String? title;
 final  String? cover;
 final  String? pic;
@JsonKey(name: 'season_id') final  int? seasonId;
@JsonKey(name: 'pgc_season_id') final  int? pgcSeasonId;
@JsonKey(name: 'season_type_name') final  String? seasonTypeName;
 final  String? areas;
 final  String? styles;
 final  String? label;
@JsonKey(name: 'goto_url') final  String? gotoUrl;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchBangumiModelCopyWith<SearchBangumiModel> get copyWith => _$SearchBangumiModelCopyWithImpl<SearchBangumiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchBangumiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchBangumiModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.pic, pic) || other.pic == pic)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.pgcSeasonId, pgcSeasonId) || other.pgcSeasonId == pgcSeasonId)&&(identical(other.seasonTypeName, seasonTypeName) || other.seasonTypeName == seasonTypeName)&&(identical(other.areas, areas) || other.areas == areas)&&(identical(other.styles, styles) || other.styles == styles)&&(identical(other.label, label) || other.label == label)&&(identical(other.gotoUrl, gotoUrl) || other.gotoUrl == gotoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,cover,pic,seasonId,pgcSeasonId,seasonTypeName,areas,styles,label,gotoUrl);

@override
String toString() {
  return 'SearchResultItem.bangumi(type: $type, title: $title, cover: $cover, pic: $pic, seasonId: $seasonId, pgcSeasonId: $pgcSeasonId, seasonTypeName: $seasonTypeName, areas: $areas, styles: $styles, label: $label, gotoUrl: $gotoUrl)';
}


}

/// @nodoc
abstract mixin class $SearchBangumiModelCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $SearchBangumiModelCopyWith(SearchBangumiModel value, $Res Function(SearchBangumiModel) _then) = _$SearchBangumiModelCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? title, String? cover, String? pic,@JsonKey(name: 'season_id') int? seasonId,@JsonKey(name: 'pgc_season_id') int? pgcSeasonId,@JsonKey(name: 'season_type_name') String? seasonTypeName, String? areas, String? styles, String? label,@JsonKey(name: 'goto_url') String? gotoUrl
});




}
/// @nodoc
class _$SearchBangumiModelCopyWithImpl<$Res>
    implements $SearchBangumiModelCopyWith<$Res> {
  _$SearchBangumiModelCopyWithImpl(this._self, this._then);

  final SearchBangumiModel _self;
  final $Res Function(SearchBangumiModel) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = freezed,Object? cover = freezed,Object? pic = freezed,Object? seasonId = freezed,Object? pgcSeasonId = freezed,Object? seasonTypeName = freezed,Object? areas = freezed,Object? styles = freezed,Object? label = freezed,Object? gotoUrl = freezed,}) {
  return _then(SearchBangumiModel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,pic: freezed == pic ? _self.pic : pic // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int?,pgcSeasonId: freezed == pgcSeasonId ? _self.pgcSeasonId : pgcSeasonId // ignore: cast_nullable_to_non_nullable
as int?,seasonTypeName: freezed == seasonTypeName ? _self.seasonTypeName : seasonTypeName // ignore: cast_nullable_to_non_nullable
as String?,areas: freezed == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as String?,styles: freezed == styles ? _self.styles : styles // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,gotoUrl: freezed == gotoUrl ? _self.gotoUrl : gotoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SearchArticleModel implements SearchResultItem {
  const SearchArticleModel({this.type, this.title, @JsonKey(name: 'image_urls') final  List<String>? imageUrls, this.author, this.uname, this.view, this.review, @JsonKey(name: 'pub_time') this.pubTime}): _imageUrls = imageUrls;
  factory SearchArticleModel.fromJson(Map<String, dynamic> json) => _$SearchArticleModelFromJson(json);

@override final  String? type;
 final  String? title;
 final  List<String>? _imageUrls;
@JsonKey(name: 'image_urls') List<String>? get imageUrls {
  final value = _imageUrls;
  if (value == null) return null;
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  String? author;
 final  String? uname;
 final  dynamic view;
 final  int? review;
@JsonKey(name: 'pub_time') final  int? pubTime;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchArticleModelCopyWith<SearchArticleModel> get copyWith => _$SearchArticleModelCopyWithImpl<SearchArticleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchArticleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchArticleModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.author, author) || other.author == author)&&(identical(other.uname, uname) || other.uname == uname)&&const DeepCollectionEquality().equals(other.view, view)&&(identical(other.review, review) || other.review == review)&&(identical(other.pubTime, pubTime) || other.pubTime == pubTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(_imageUrls),author,uname,const DeepCollectionEquality().hash(view),review,pubTime);

@override
String toString() {
  return 'SearchResultItem.article(type: $type, title: $title, imageUrls: $imageUrls, author: $author, uname: $uname, view: $view, review: $review, pubTime: $pubTime)';
}


}

/// @nodoc
abstract mixin class $SearchArticleModelCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $SearchArticleModelCopyWith(SearchArticleModel value, $Res Function(SearchArticleModel) _then) = _$SearchArticleModelCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? title,@JsonKey(name: 'image_urls') List<String>? imageUrls, String? author, String? uname, dynamic view, int? review,@JsonKey(name: 'pub_time') int? pubTime
});




}
/// @nodoc
class _$SearchArticleModelCopyWithImpl<$Res>
    implements $SearchArticleModelCopyWith<$Res> {
  _$SearchArticleModelCopyWithImpl(this._self, this._then);

  final SearchArticleModel _self;
  final $Res Function(SearchArticleModel) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = freezed,Object? imageUrls = freezed,Object? author = freezed,Object? uname = freezed,Object? view = freezed,Object? review = freezed,Object? pubTime = freezed,}) {
  return _then(SearchArticleModel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: freezed == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,uname: freezed == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as dynamic,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as int?,pubTime: freezed == pubTime ? _self.pubTime : pubTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SearchTopicModel implements SearchResultItem {
  const SearchTopicModel({this.type, this.title, this.description, this.cover, @JsonKey(name: 'tp_id') this.tpId, @JsonKey(name: 'arcurl') this.arcurl, this.author, this.update});
  factory SearchTopicModel.fromJson(Map<String, dynamic> json) => _$SearchTopicModelFromJson(json);

@override final  String? type;
 final  String? title;
 final  String? description;
 final  String? cover;
@JsonKey(name: 'tp_id') final  int? tpId;
@JsonKey(name: 'arcurl') final  String? arcurl;
 final  String? author;
 final  int? update;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchTopicModelCopyWith<SearchTopicModel> get copyWith => _$SearchTopicModelCopyWithImpl<SearchTopicModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchTopicModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchTopicModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.tpId, tpId) || other.tpId == tpId)&&(identical(other.arcurl, arcurl) || other.arcurl == arcurl)&&(identical(other.author, author) || other.author == author)&&(identical(other.update, update) || other.update == update));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,description,cover,tpId,arcurl,author,update);

@override
String toString() {
  return 'SearchResultItem.topic(type: $type, title: $title, description: $description, cover: $cover, tpId: $tpId, arcurl: $arcurl, author: $author, update: $update)';
}


}

/// @nodoc
abstract mixin class $SearchTopicModelCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $SearchTopicModelCopyWith(SearchTopicModel value, $Res Function(SearchTopicModel) _then) = _$SearchTopicModelCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? title, String? description, String? cover,@JsonKey(name: 'tp_id') int? tpId,@JsonKey(name: 'arcurl') String? arcurl, String? author, int? update
});




}
/// @nodoc
class _$SearchTopicModelCopyWithImpl<$Res>
    implements $SearchTopicModelCopyWith<$Res> {
  _$SearchTopicModelCopyWithImpl(this._self, this._then);

  final SearchTopicModel _self;
  final $Res Function(SearchTopicModel) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = freezed,Object? description = freezed,Object? cover = freezed,Object? tpId = freezed,Object? arcurl = freezed,Object? author = freezed,Object? update = freezed,}) {
  return _then(SearchTopicModel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,tpId: freezed == tpId ? _self.tpId : tpId // ignore: cast_nullable_to_non_nullable
as int?,arcurl: freezed == arcurl ? _self.arcurl : arcurl // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,update: freezed == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
