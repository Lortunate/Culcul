// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_contract.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentResponse {

 List<CommentItem> get replies; CommentCursor? get cursor; CommentPage? get page;
/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentResponseCopyWith<CommentResponse> get copyWith => _$CommentResponseCopyWithImpl<CommentResponse>(this as CommentResponse, _$identity);

  /// Serializes this CommentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentResponse&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(replies),cursor,page);

@override
String toString() {
  return 'CommentResponse(replies: $replies, cursor: $cursor, page: $page)';
}


}

/// @nodoc
abstract mixin class $CommentResponseCopyWith<$Res>  {
  factory $CommentResponseCopyWith(CommentResponse value, $Res Function(CommentResponse) _then) = _$CommentResponseCopyWithImpl;
@useResult
$Res call({
 List<CommentItem> replies, CommentCursor? cursor, CommentPage? page
});


$CommentCursorCopyWith<$Res>? get cursor;$CommentPageCopyWith<$Res>? get page;

}
/// @nodoc
class _$CommentResponseCopyWithImpl<$Res>
    implements $CommentResponseCopyWith<$Res> {
  _$CommentResponseCopyWithImpl(this._self, this._then);

  final CommentResponse _self;
  final $Res Function(CommentResponse) _then;

/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? replies = null,Object? cursor = freezed,Object? page = freezed,}) {
  return _then(_self.copyWith(
replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as CommentCursor?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as CommentPage?,
  ));
}
/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCursorCopyWith<$Res>? get cursor {
    if (_self.cursor == null) {
    return null;
  }

  return $CommentCursorCopyWith<$Res>(_self.cursor!, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentPageCopyWith<$Res>? get page {
    if (_self.page == null) {
    return null;
  }

  return $CommentPageCopyWith<$Res>(_self.page!, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentResponse].
extension CommentResponsePatterns on CommentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentResponse value)  $default,){
final _that = this;
switch (_that) {
case _CommentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CommentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommentItem> replies,  CommentCursor? cursor,  CommentPage? page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentResponse() when $default != null:
return $default(_that.replies,_that.cursor,_that.page);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommentItem> replies,  CommentCursor? cursor,  CommentPage? page)  $default,) {final _that = this;
switch (_that) {
case _CommentResponse():
return $default(_that.replies,_that.cursor,_that.page);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommentItem> replies,  CommentCursor? cursor,  CommentPage? page)?  $default,) {final _that = this;
switch (_that) {
case _CommentResponse() when $default != null:
return $default(_that.replies,_that.cursor,_that.page);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentResponse implements CommentResponse {
  const _CommentResponse({final  List<CommentItem> replies = const [], this.cursor, this.page}): _replies = replies;
  factory _CommentResponse.fromJson(Map<String, dynamic> json) => _$CommentResponseFromJson(json);

 final  List<CommentItem> _replies;
@override@JsonKey() List<CommentItem> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override final  CommentCursor? cursor;
@override final  CommentPage? page;

/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentResponseCopyWith<_CommentResponse> get copyWith => __$CommentResponseCopyWithImpl<_CommentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentResponse&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_replies),cursor,page);

@override
String toString() {
  return 'CommentResponse(replies: $replies, cursor: $cursor, page: $page)';
}


}

/// @nodoc
abstract mixin class _$CommentResponseCopyWith<$Res> implements $CommentResponseCopyWith<$Res> {
  factory _$CommentResponseCopyWith(_CommentResponse value, $Res Function(_CommentResponse) _then) = __$CommentResponseCopyWithImpl;
@override @useResult
$Res call({
 List<CommentItem> replies, CommentCursor? cursor, CommentPage? page
});


@override $CommentCursorCopyWith<$Res>? get cursor;@override $CommentPageCopyWith<$Res>? get page;

}
/// @nodoc
class __$CommentResponseCopyWithImpl<$Res>
    implements _$CommentResponseCopyWith<$Res> {
  __$CommentResponseCopyWithImpl(this._self, this._then);

  final _CommentResponse _self;
  final $Res Function(_CommentResponse) _then;

/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? replies = null,Object? cursor = freezed,Object? page = freezed,}) {
  return _then(_CommentResponse(
replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as CommentCursor?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as CommentPage?,
  ));
}

/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCursorCopyWith<$Res>? get cursor {
    if (_self.cursor == null) {
    return null;
  }

  return $CommentCursorCopyWith<$Res>(_self.cursor!, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}/// Create a copy of CommentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentPageCopyWith<$Res>? get page {
    if (_self.page == null) {
    return null;
  }

  return $CommentPageCopyWith<$Res>(_self.page!, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}


/// @nodoc
mixin _$CommentPage {

 int get num; int get size;@JsonKey(name: 'count') int get count; int get acount;
/// Create a copy of CommentPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentPageCopyWith<CommentPage> get copyWith => _$CommentPageCopyWithImpl<CommentPage>(this as CommentPage, _$identity);

  /// Serializes this CommentPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentPage&&(identical(other.num, num) || other.num == num)&&(identical(other.size, size) || other.size == size)&&(identical(other.count, count) || other.count == count)&&(identical(other.acount, acount) || other.acount == acount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,num,size,count,acount);

@override
String toString() {
  return 'CommentPage(num: $num, size: $size, count: $count, acount: $acount)';
}


}

/// @nodoc
abstract mixin class $CommentPageCopyWith<$Res>  {
  factory $CommentPageCopyWith(CommentPage value, $Res Function(CommentPage) _then) = _$CommentPageCopyWithImpl;
@useResult
$Res call({
 int num, int size,@JsonKey(name: 'count') int count, int acount
});




}
/// @nodoc
class _$CommentPageCopyWithImpl<$Res>
    implements $CommentPageCopyWith<$Res> {
  _$CommentPageCopyWithImpl(this._self, this._then);

  final CommentPage _self;
  final $Res Function(CommentPage) _then;

/// Create a copy of CommentPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? num = null,Object? size = null,Object? count = null,Object? acount = null,}) {
  return _then(_self.copyWith(
num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,acount: null == acount ? _self.acount : acount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentPage].
extension CommentPagePatterns on CommentPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentPage value)  $default,){
final _that = this;
switch (_that) {
case _CommentPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentPage value)?  $default,){
final _that = this;
switch (_that) {
case _CommentPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int num,  int size, @JsonKey(name: 'count')  int count,  int acount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentPage() when $default != null:
return $default(_that.num,_that.size,_that.count,_that.acount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int num,  int size, @JsonKey(name: 'count')  int count,  int acount)  $default,) {final _that = this;
switch (_that) {
case _CommentPage():
return $default(_that.num,_that.size,_that.count,_that.acount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int num,  int size, @JsonKey(name: 'count')  int count,  int acount)?  $default,) {final _that = this;
switch (_that) {
case _CommentPage() when $default != null:
return $default(_that.num,_that.size,_that.count,_that.acount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentPage implements CommentPage {
  const _CommentPage({this.num = 0, this.size = 0, @JsonKey(name: 'count') this.count = 0, this.acount = 0});
  factory _CommentPage.fromJson(Map<String, dynamic> json) => _$CommentPageFromJson(json);

@override@JsonKey() final  int num;
@override@JsonKey() final  int size;
@override@JsonKey(name: 'count') final  int count;
@override@JsonKey() final  int acount;

/// Create a copy of CommentPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentPageCopyWith<_CommentPage> get copyWith => __$CommentPageCopyWithImpl<_CommentPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentPage&&(identical(other.num, num) || other.num == num)&&(identical(other.size, size) || other.size == size)&&(identical(other.count, count) || other.count == count)&&(identical(other.acount, acount) || other.acount == acount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,num,size,count,acount);

@override
String toString() {
  return 'CommentPage(num: $num, size: $size, count: $count, acount: $acount)';
}


}

/// @nodoc
abstract mixin class _$CommentPageCopyWith<$Res> implements $CommentPageCopyWith<$Res> {
  factory _$CommentPageCopyWith(_CommentPage value, $Res Function(_CommentPage) _then) = __$CommentPageCopyWithImpl;
@override @useResult
$Res call({
 int num, int size,@JsonKey(name: 'count') int count, int acount
});




}
/// @nodoc
class __$CommentPageCopyWithImpl<$Res>
    implements _$CommentPageCopyWith<$Res> {
  __$CommentPageCopyWithImpl(this._self, this._then);

  final _CommentPage _self;
  final $Res Function(_CommentPage) _then;

/// Create a copy of CommentPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? num = null,Object? size = null,Object? count = null,Object? acount = null,}) {
  return _then(_CommentPage(
num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,acount: null == acount ? _self.acount : acount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommentCursor {

@JsonKey(name: 'all_count') int get allCount;@JsonKey(name: 'is_begin') bool get isBegin;@JsonKey(name: 'is_end') bool get isEnd; int get mode; String get name; int get next; int get prev;
/// Create a copy of CommentCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCursorCopyWith<CommentCursor> get copyWith => _$CommentCursorCopyWithImpl<CommentCursor>(this as CommentCursor, _$identity);

  /// Serializes this CommentCursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentCursor&&(identical(other.allCount, allCount) || other.allCount == allCount)&&(identical(other.isBegin, isBegin) || other.isBegin == isBegin)&&(identical(other.isEnd, isEnd) || other.isEnd == isEnd)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.name, name) || other.name == name)&&(identical(other.next, next) || other.next == next)&&(identical(other.prev, prev) || other.prev == prev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allCount,isBegin,isEnd,mode,name,next,prev);

@override
String toString() {
  return 'CommentCursor(allCount: $allCount, isBegin: $isBegin, isEnd: $isEnd, mode: $mode, name: $name, next: $next, prev: $prev)';
}


}

/// @nodoc
abstract mixin class $CommentCursorCopyWith<$Res>  {
  factory $CommentCursorCopyWith(CommentCursor value, $Res Function(CommentCursor) _then) = _$CommentCursorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'all_count') int allCount,@JsonKey(name: 'is_begin') bool isBegin,@JsonKey(name: 'is_end') bool isEnd, int mode, String name, int next, int prev
});




}
/// @nodoc
class _$CommentCursorCopyWithImpl<$Res>
    implements $CommentCursorCopyWith<$Res> {
  _$CommentCursorCopyWithImpl(this._self, this._then);

  final CommentCursor _self;
  final $Res Function(CommentCursor) _then;

/// Create a copy of CommentCursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allCount = null,Object? isBegin = null,Object? isEnd = null,Object? mode = null,Object? name = null,Object? next = null,Object? prev = null,}) {
  return _then(_self.copyWith(
allCount: null == allCount ? _self.allCount : allCount // ignore: cast_nullable_to_non_nullable
as int,isBegin: null == isBegin ? _self.isBegin : isBegin // ignore: cast_nullable_to_non_nullable
as bool,isEnd: null == isEnd ? _self.isEnd : isEnd // ignore: cast_nullable_to_non_nullable
as bool,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as int,prev: null == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentCursor].
extension CommentCursorPatterns on CommentCursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentCursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentCursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentCursor value)  $default,){
final _that = this;
switch (_that) {
case _CommentCursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentCursor value)?  $default,){
final _that = this;
switch (_that) {
case _CommentCursor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'all_count')  int allCount, @JsonKey(name: 'is_begin')  bool isBegin, @JsonKey(name: 'is_end')  bool isEnd,  int mode,  String name,  int next,  int prev)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentCursor() when $default != null:
return $default(_that.allCount,_that.isBegin,_that.isEnd,_that.mode,_that.name,_that.next,_that.prev);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'all_count')  int allCount, @JsonKey(name: 'is_begin')  bool isBegin, @JsonKey(name: 'is_end')  bool isEnd,  int mode,  String name,  int next,  int prev)  $default,) {final _that = this;
switch (_that) {
case _CommentCursor():
return $default(_that.allCount,_that.isBegin,_that.isEnd,_that.mode,_that.name,_that.next,_that.prev);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'all_count')  int allCount, @JsonKey(name: 'is_begin')  bool isBegin, @JsonKey(name: 'is_end')  bool isEnd,  int mode,  String name,  int next,  int prev)?  $default,) {final _that = this;
switch (_that) {
case _CommentCursor() when $default != null:
return $default(_that.allCount,_that.isBegin,_that.isEnd,_that.mode,_that.name,_that.next,_that.prev);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentCursor implements CommentCursor {
  const _CommentCursor({@JsonKey(name: 'all_count') this.allCount = 0, @JsonKey(name: 'is_begin') this.isBegin = false, @JsonKey(name: 'is_end') this.isEnd = false, this.mode = 0, this.name = '', this.next = 0, this.prev = 0});
  factory _CommentCursor.fromJson(Map<String, dynamic> json) => _$CommentCursorFromJson(json);

@override@JsonKey(name: 'all_count') final  int allCount;
@override@JsonKey(name: 'is_begin') final  bool isBegin;
@override@JsonKey(name: 'is_end') final  bool isEnd;
@override@JsonKey() final  int mode;
@override@JsonKey() final  String name;
@override@JsonKey() final  int next;
@override@JsonKey() final  int prev;

/// Create a copy of CommentCursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentCursorCopyWith<_CommentCursor> get copyWith => __$CommentCursorCopyWithImpl<_CommentCursor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentCursorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentCursor&&(identical(other.allCount, allCount) || other.allCount == allCount)&&(identical(other.isBegin, isBegin) || other.isBegin == isBegin)&&(identical(other.isEnd, isEnd) || other.isEnd == isEnd)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.name, name) || other.name == name)&&(identical(other.next, next) || other.next == next)&&(identical(other.prev, prev) || other.prev == prev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allCount,isBegin,isEnd,mode,name,next,prev);

@override
String toString() {
  return 'CommentCursor(allCount: $allCount, isBegin: $isBegin, isEnd: $isEnd, mode: $mode, name: $name, next: $next, prev: $prev)';
}


}

/// @nodoc
abstract mixin class _$CommentCursorCopyWith<$Res> implements $CommentCursorCopyWith<$Res> {
  factory _$CommentCursorCopyWith(_CommentCursor value, $Res Function(_CommentCursor) _then) = __$CommentCursorCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'all_count') int allCount,@JsonKey(name: 'is_begin') bool isBegin,@JsonKey(name: 'is_end') bool isEnd, int mode, String name, int next, int prev
});




}
/// @nodoc
class __$CommentCursorCopyWithImpl<$Res>
    implements _$CommentCursorCopyWith<$Res> {
  __$CommentCursorCopyWithImpl(this._self, this._then);

  final _CommentCursor _self;
  final $Res Function(_CommentCursor) _then;

/// Create a copy of CommentCursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allCount = null,Object? isBegin = null,Object? isEnd = null,Object? mode = null,Object? name = null,Object? next = null,Object? prev = null,}) {
  return _then(_CommentCursor(
allCount: null == allCount ? _self.allCount : allCount // ignore: cast_nullable_to_non_nullable
as int,isBegin: null == isBegin ? _self.isBegin : isBegin // ignore: cast_nullable_to_non_nullable
as bool,isEnd: null == isEnd ? _self.isEnd : isEnd // ignore: cast_nullable_to_non_nullable
as bool,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as int,prev: null == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommentItem {

 int get rpid; int get oid; int get type; int get mid; int get root; int get parent; int get dialog; int get count; int get rcount; int get floor; int get state; int get fansgrade; int get attr; int get ctime;@JsonKey(name: 'rpid_str') String get rpidStr;@JsonKey(name: 'root_str') String get rootStr;@JsonKey(name: 'parent_str') String get parentStr; int get like; int get action; CommentMember get member; CommentContent get content; List<CommentItem> get replies;@JsonKey(name: 'show_follow') bool get showFollow; bool get invisible;
/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentItemCopyWith<CommentItem> get copyWith => _$CommentItemCopyWithImpl<CommentItem>(this as CommentItem, _$identity);

  /// Serializes this CommentItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentItem&&(identical(other.rpid, rpid) || other.rpid == rpid)&&(identical(other.oid, oid) || other.oid == oid)&&(identical(other.type, type) || other.type == type)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.root, root) || other.root == root)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.dialog, dialog) || other.dialog == dialog)&&(identical(other.count, count) || other.count == count)&&(identical(other.rcount, rcount) || other.rcount == rcount)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.state, state) || other.state == state)&&(identical(other.fansgrade, fansgrade) || other.fansgrade == fansgrade)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.rpidStr, rpidStr) || other.rpidStr == rpidStr)&&(identical(other.rootStr, rootStr) || other.rootStr == rootStr)&&(identical(other.parentStr, parentStr) || other.parentStr == parentStr)&&(identical(other.like, like) || other.like == like)&&(identical(other.action, action) || other.action == action)&&(identical(other.member, member) || other.member == member)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.showFollow, showFollow) || other.showFollow == showFollow)&&(identical(other.invisible, invisible) || other.invisible == invisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rpid,oid,type,mid,root,parent,dialog,count,rcount,floor,state,fansgrade,attr,ctime,rpidStr,rootStr,parentStr,like,action,member,content,const DeepCollectionEquality().hash(replies),showFollow,invisible]);

@override
String toString() {
  return 'CommentItem(rpid: $rpid, oid: $oid, type: $type, mid: $mid, root: $root, parent: $parent, dialog: $dialog, count: $count, rcount: $rcount, floor: $floor, state: $state, fansgrade: $fansgrade, attr: $attr, ctime: $ctime, rpidStr: $rpidStr, rootStr: $rootStr, parentStr: $parentStr, like: $like, action: $action, member: $member, content: $content, replies: $replies, showFollow: $showFollow, invisible: $invisible)';
}


}

/// @nodoc
abstract mixin class $CommentItemCopyWith<$Res>  {
  factory $CommentItemCopyWith(CommentItem value, $Res Function(CommentItem) _then) = _$CommentItemCopyWithImpl;
@useResult
$Res call({
 int rpid, int oid, int type, int mid, int root, int parent, int dialog, int count, int rcount, int floor, int state, int fansgrade, int attr, int ctime,@JsonKey(name: 'rpid_str') String rpidStr,@JsonKey(name: 'root_str') String rootStr,@JsonKey(name: 'parent_str') String parentStr, int like, int action, CommentMember member, CommentContent content, List<CommentItem> replies,@JsonKey(name: 'show_follow') bool showFollow, bool invisible
});


$CommentMemberCopyWith<$Res> get member;

}
/// @nodoc
class _$CommentItemCopyWithImpl<$Res>
    implements $CommentItemCopyWith<$Res> {
  _$CommentItemCopyWithImpl(this._self, this._then);

  final CommentItem _self;
  final $Res Function(CommentItem) _then;

/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rpid = null,Object? oid = null,Object? type = null,Object? mid = null,Object? root = null,Object? parent = null,Object? dialog = null,Object? count = null,Object? rcount = null,Object? floor = null,Object? state = null,Object? fansgrade = null,Object? attr = null,Object? ctime = null,Object? rpidStr = null,Object? rootStr = null,Object? parentStr = null,Object? like = null,Object? action = null,Object? member = null,Object? content = null,Object? replies = null,Object? showFollow = null,Object? invisible = null,}) {
  return _then(_self.copyWith(
rpid: null == rpid ? _self.rpid : rpid // ignore: cast_nullable_to_non_nullable
as int,oid: null == oid ? _self.oid : oid // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as int,parent: null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int,dialog: null == dialog ? _self.dialog : dialog // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,rcount: null == rcount ? _self.rcount : rcount // ignore: cast_nullable_to_non_nullable
as int,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,fansgrade: null == fansgrade ? _self.fansgrade : fansgrade // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,rpidStr: null == rpidStr ? _self.rpidStr : rpidStr // ignore: cast_nullable_to_non_nullable
as String,rootStr: null == rootStr ? _self.rootStr : rootStr // ignore: cast_nullable_to_non_nullable
as String,parentStr: null == parentStr ? _self.parentStr : parentStr // ignore: cast_nullable_to_non_nullable
as String,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as CommentMember,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CommentContent,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,showFollow: null == showFollow ? _self.showFollow : showFollow // ignore: cast_nullable_to_non_nullable
as bool,invisible: null == invisible ? _self.invisible : invisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentMemberCopyWith<$Res> get member {
  
  return $CommentMemberCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentItem].
extension CommentItemPatterns on CommentItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentItem value)  $default,){
final _that = this;
switch (_that) {
case _CommentItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentItem value)?  $default,){
final _that = this;
switch (_that) {
case _CommentItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rpid,  int oid,  int type,  int mid,  int root,  int parent,  int dialog,  int count,  int rcount,  int floor,  int state,  int fansgrade,  int attr,  int ctime, @JsonKey(name: 'rpid_str')  String rpidStr, @JsonKey(name: 'root_str')  String rootStr, @JsonKey(name: 'parent_str')  String parentStr,  int like,  int action,  CommentMember member,  CommentContent content,  List<CommentItem> replies, @JsonKey(name: 'show_follow')  bool showFollow,  bool invisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentItem() when $default != null:
return $default(_that.rpid,_that.oid,_that.type,_that.mid,_that.root,_that.parent,_that.dialog,_that.count,_that.rcount,_that.floor,_that.state,_that.fansgrade,_that.attr,_that.ctime,_that.rpidStr,_that.rootStr,_that.parentStr,_that.like,_that.action,_that.member,_that.content,_that.replies,_that.showFollow,_that.invisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rpid,  int oid,  int type,  int mid,  int root,  int parent,  int dialog,  int count,  int rcount,  int floor,  int state,  int fansgrade,  int attr,  int ctime, @JsonKey(name: 'rpid_str')  String rpidStr, @JsonKey(name: 'root_str')  String rootStr, @JsonKey(name: 'parent_str')  String parentStr,  int like,  int action,  CommentMember member,  CommentContent content,  List<CommentItem> replies, @JsonKey(name: 'show_follow')  bool showFollow,  bool invisible)  $default,) {final _that = this;
switch (_that) {
case _CommentItem():
return $default(_that.rpid,_that.oid,_that.type,_that.mid,_that.root,_that.parent,_that.dialog,_that.count,_that.rcount,_that.floor,_that.state,_that.fansgrade,_that.attr,_that.ctime,_that.rpidStr,_that.rootStr,_that.parentStr,_that.like,_that.action,_that.member,_that.content,_that.replies,_that.showFollow,_that.invisible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rpid,  int oid,  int type,  int mid,  int root,  int parent,  int dialog,  int count,  int rcount,  int floor,  int state,  int fansgrade,  int attr,  int ctime, @JsonKey(name: 'rpid_str')  String rpidStr, @JsonKey(name: 'root_str')  String rootStr, @JsonKey(name: 'parent_str')  String parentStr,  int like,  int action,  CommentMember member,  CommentContent content,  List<CommentItem> replies, @JsonKey(name: 'show_follow')  bool showFollow,  bool invisible)?  $default,) {final _that = this;
switch (_that) {
case _CommentItem() when $default != null:
return $default(_that.rpid,_that.oid,_that.type,_that.mid,_that.root,_that.parent,_that.dialog,_that.count,_that.rcount,_that.floor,_that.state,_that.fansgrade,_that.attr,_that.ctime,_that.rpidStr,_that.rootStr,_that.parentStr,_that.like,_that.action,_that.member,_that.content,_that.replies,_that.showFollow,_that.invisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentItem implements CommentItem {
  const _CommentItem({required this.rpid, required this.oid, required this.type, required this.mid, required this.root, required this.parent, this.dialog = 0, this.count = 0, this.rcount = 0, this.floor = 0, this.state = 0, this.fansgrade = 0, this.attr = 0, required this.ctime, @JsonKey(name: 'rpid_str') this.rpidStr = '', @JsonKey(name: 'root_str') this.rootStr = '', @JsonKey(name: 'parent_str') this.parentStr = '', this.like = 0, this.action = 0, required this.member, required this.content, final  List<CommentItem> replies = const [], @JsonKey(name: 'show_follow') this.showFollow = false, this.invisible = false}): _replies = replies;
  factory _CommentItem.fromJson(Map<String, dynamic> json) => _$CommentItemFromJson(json);

@override final  int rpid;
@override final  int oid;
@override final  int type;
@override final  int mid;
@override final  int root;
@override final  int parent;
@override@JsonKey() final  int dialog;
@override@JsonKey() final  int count;
@override@JsonKey() final  int rcount;
@override@JsonKey() final  int floor;
@override@JsonKey() final  int state;
@override@JsonKey() final  int fansgrade;
@override@JsonKey() final  int attr;
@override final  int ctime;
@override@JsonKey(name: 'rpid_str') final  String rpidStr;
@override@JsonKey(name: 'root_str') final  String rootStr;
@override@JsonKey(name: 'parent_str') final  String parentStr;
@override@JsonKey() final  int like;
@override@JsonKey() final  int action;
@override final  CommentMember member;
@override final  CommentContent content;
 final  List<CommentItem> _replies;
@override@JsonKey() List<CommentItem> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override@JsonKey(name: 'show_follow') final  bool showFollow;
@override@JsonKey() final  bool invisible;

/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentItemCopyWith<_CommentItem> get copyWith => __$CommentItemCopyWithImpl<_CommentItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentItem&&(identical(other.rpid, rpid) || other.rpid == rpid)&&(identical(other.oid, oid) || other.oid == oid)&&(identical(other.type, type) || other.type == type)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.root, root) || other.root == root)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.dialog, dialog) || other.dialog == dialog)&&(identical(other.count, count) || other.count == count)&&(identical(other.rcount, rcount) || other.rcount == rcount)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.state, state) || other.state == state)&&(identical(other.fansgrade, fansgrade) || other.fansgrade == fansgrade)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.rpidStr, rpidStr) || other.rpidStr == rpidStr)&&(identical(other.rootStr, rootStr) || other.rootStr == rootStr)&&(identical(other.parentStr, parentStr) || other.parentStr == parentStr)&&(identical(other.like, like) || other.like == like)&&(identical(other.action, action) || other.action == action)&&(identical(other.member, member) || other.member == member)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.showFollow, showFollow) || other.showFollow == showFollow)&&(identical(other.invisible, invisible) || other.invisible == invisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rpid,oid,type,mid,root,parent,dialog,count,rcount,floor,state,fansgrade,attr,ctime,rpidStr,rootStr,parentStr,like,action,member,content,const DeepCollectionEquality().hash(_replies),showFollow,invisible]);

@override
String toString() {
  return 'CommentItem(rpid: $rpid, oid: $oid, type: $type, mid: $mid, root: $root, parent: $parent, dialog: $dialog, count: $count, rcount: $rcount, floor: $floor, state: $state, fansgrade: $fansgrade, attr: $attr, ctime: $ctime, rpidStr: $rpidStr, rootStr: $rootStr, parentStr: $parentStr, like: $like, action: $action, member: $member, content: $content, replies: $replies, showFollow: $showFollow, invisible: $invisible)';
}


}

/// @nodoc
abstract mixin class _$CommentItemCopyWith<$Res> implements $CommentItemCopyWith<$Res> {
  factory _$CommentItemCopyWith(_CommentItem value, $Res Function(_CommentItem) _then) = __$CommentItemCopyWithImpl;
@override @useResult
$Res call({
 int rpid, int oid, int type, int mid, int root, int parent, int dialog, int count, int rcount, int floor, int state, int fansgrade, int attr, int ctime,@JsonKey(name: 'rpid_str') String rpidStr,@JsonKey(name: 'root_str') String rootStr,@JsonKey(name: 'parent_str') String parentStr, int like, int action, CommentMember member, CommentContent content, List<CommentItem> replies,@JsonKey(name: 'show_follow') bool showFollow, bool invisible
});


@override $CommentMemberCopyWith<$Res> get member;

}
/// @nodoc
class __$CommentItemCopyWithImpl<$Res>
    implements _$CommentItemCopyWith<$Res> {
  __$CommentItemCopyWithImpl(this._self, this._then);

  final _CommentItem _self;
  final $Res Function(_CommentItem) _then;

/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rpid = null,Object? oid = null,Object? type = null,Object? mid = null,Object? root = null,Object? parent = null,Object? dialog = null,Object? count = null,Object? rcount = null,Object? floor = null,Object? state = null,Object? fansgrade = null,Object? attr = null,Object? ctime = null,Object? rpidStr = null,Object? rootStr = null,Object? parentStr = null,Object? like = null,Object? action = null,Object? member = null,Object? content = null,Object? replies = null,Object? showFollow = null,Object? invisible = null,}) {
  return _then(_CommentItem(
rpid: null == rpid ? _self.rpid : rpid // ignore: cast_nullable_to_non_nullable
as int,oid: null == oid ? _self.oid : oid // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as int,parent: null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int,dialog: null == dialog ? _self.dialog : dialog // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,rcount: null == rcount ? _self.rcount : rcount // ignore: cast_nullable_to_non_nullable
as int,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,fansgrade: null == fansgrade ? _self.fansgrade : fansgrade // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,ctime: null == ctime ? _self.ctime : ctime // ignore: cast_nullable_to_non_nullable
as int,rpidStr: null == rpidStr ? _self.rpidStr : rpidStr // ignore: cast_nullable_to_non_nullable
as String,rootStr: null == rootStr ? _self.rootStr : rootStr // ignore: cast_nullable_to_non_nullable
as String,parentStr: null == parentStr ? _self.parentStr : parentStr // ignore: cast_nullable_to_non_nullable
as String,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as CommentMember,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CommentContent,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,showFollow: null == showFollow ? _self.showFollow : showFollow // ignore: cast_nullable_to_non_nullable
as bool,invisible: null == invisible ? _self.invisible : invisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentMemberCopyWith<$Res> get member {
  
  return $CommentMemberCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// @nodoc
mixin _$CommentMember {

 String get mid; String get uname; String get sex; String get sign; String get avatar; String get rank;@JsonKey(name: 'DisplayRank') int get displayRank;@JsonKey(name: 'level_info') CommentLevelInfo get levelInfo; CommentPendant get pendant; CommentNameplate get nameplate;@JsonKey(name: 'official_verify') OfficialVerify get officialVerify; CommentVip get vip;@JsonKey(name: 'fans_detail') dynamic get fansDetail; int get following;@JsonKey(name: 'is_followed') int get isFollowed;
/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentMemberCopyWith<CommentMember> get copyWith => _$CommentMemberCopyWithImpl<CommentMember>(this as CommentMember, _$identity);

  /// Serializes this CommentMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentMember&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.displayRank, displayRank) || other.displayRank == displayRank)&&(identical(other.levelInfo, levelInfo) || other.levelInfo == levelInfo)&&(identical(other.pendant, pendant) || other.pendant == pendant)&&(identical(other.nameplate, nameplate) || other.nameplate == nameplate)&&(identical(other.officialVerify, officialVerify) || other.officialVerify == officialVerify)&&(identical(other.vip, vip) || other.vip == vip)&&const DeepCollectionEquality().equals(other.fansDetail, fansDetail)&&(identical(other.following, following) || other.following == following)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,uname,sex,sign,avatar,rank,displayRank,levelInfo,pendant,nameplate,officialVerify,vip,const DeepCollectionEquality().hash(fansDetail),following,isFollowed);

@override
String toString() {
  return 'CommentMember(mid: $mid, uname: $uname, sex: $sex, sign: $sign, avatar: $avatar, rank: $rank, displayRank: $displayRank, levelInfo: $levelInfo, pendant: $pendant, nameplate: $nameplate, officialVerify: $officialVerify, vip: $vip, fansDetail: $fansDetail, following: $following, isFollowed: $isFollowed)';
}


}

/// @nodoc
abstract mixin class $CommentMemberCopyWith<$Res>  {
  factory $CommentMemberCopyWith(CommentMember value, $Res Function(CommentMember) _then) = _$CommentMemberCopyWithImpl;
@useResult
$Res call({
 String mid, String uname, String sex, String sign, String avatar, String rank,@JsonKey(name: 'DisplayRank') int displayRank,@JsonKey(name: 'level_info') CommentLevelInfo levelInfo, CommentPendant pendant, CommentNameplate nameplate,@JsonKey(name: 'official_verify') OfficialVerify officialVerify, CommentVip vip,@JsonKey(name: 'fans_detail') dynamic fansDetail, int following,@JsonKey(name: 'is_followed') int isFollowed
});


$CommentLevelInfoCopyWith<$Res> get levelInfo;$CommentPendantCopyWith<$Res> get pendant;$CommentNameplateCopyWith<$Res> get nameplate;$CommentVipCopyWith<$Res> get vip;

}
/// @nodoc
class _$CommentMemberCopyWithImpl<$Res>
    implements $CommentMemberCopyWith<$Res> {
  _$CommentMemberCopyWithImpl(this._self, this._then);

  final CommentMember _self;
  final $Res Function(CommentMember) _then;

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? uname = null,Object? sex = null,Object? sign = null,Object? avatar = null,Object? rank = null,Object? displayRank = null,Object? levelInfo = null,Object? pendant = null,Object? nameplate = null,Object? officialVerify = null,Object? vip = null,Object? fansDetail = freezed,Object? following = null,Object? isFollowed = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,displayRank: null == displayRank ? _self.displayRank : displayRank // ignore: cast_nullable_to_non_nullable
as int,levelInfo: null == levelInfo ? _self.levelInfo : levelInfo // ignore: cast_nullable_to_non_nullable
as CommentLevelInfo,pendant: null == pendant ? _self.pendant : pendant // ignore: cast_nullable_to_non_nullable
as CommentPendant,nameplate: null == nameplate ? _self.nameplate : nameplate // ignore: cast_nullable_to_non_nullable
as CommentNameplate,officialVerify: null == officialVerify ? _self.officialVerify : officialVerify // ignore: cast_nullable_to_non_nullable
as OfficialVerify,vip: null == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as CommentVip,fansDetail: freezed == fansDetail ? _self.fansDetail : fansDetail // ignore: cast_nullable_to_non_nullable
as dynamic,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentLevelInfoCopyWith<$Res> get levelInfo {
  
  return $CommentLevelInfoCopyWith<$Res>(_self.levelInfo, (value) {
    return _then(_self.copyWith(levelInfo: value));
  });
}/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentPendantCopyWith<$Res> get pendant {
  
  return $CommentPendantCopyWith<$Res>(_self.pendant, (value) {
    return _then(_self.copyWith(pendant: value));
  });
}/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentNameplateCopyWith<$Res> get nameplate {
  
  return $CommentNameplateCopyWith<$Res>(_self.nameplate, (value) {
    return _then(_self.copyWith(nameplate: value));
  });
}/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentVipCopyWith<$Res> get vip {
  
  return $CommentVipCopyWith<$Res>(_self.vip, (value) {
    return _then(_self.copyWith(vip: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentMember].
extension CommentMemberPatterns on CommentMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentMember value)  $default,){
final _that = this;
switch (_that) {
case _CommentMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentMember value)?  $default,){
final _that = this;
switch (_that) {
case _CommentMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mid,  String uname,  String sex,  String sign,  String avatar,  String rank, @JsonKey(name: 'DisplayRank')  int displayRank, @JsonKey(name: 'level_info')  CommentLevelInfo levelInfo,  CommentPendant pendant,  CommentNameplate nameplate, @JsonKey(name: 'official_verify')  OfficialVerify officialVerify,  CommentVip vip, @JsonKey(name: 'fans_detail')  dynamic fansDetail,  int following, @JsonKey(name: 'is_followed')  int isFollowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentMember() when $default != null:
return $default(_that.mid,_that.uname,_that.sex,_that.sign,_that.avatar,_that.rank,_that.displayRank,_that.levelInfo,_that.pendant,_that.nameplate,_that.officialVerify,_that.vip,_that.fansDetail,_that.following,_that.isFollowed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mid,  String uname,  String sex,  String sign,  String avatar,  String rank, @JsonKey(name: 'DisplayRank')  int displayRank, @JsonKey(name: 'level_info')  CommentLevelInfo levelInfo,  CommentPendant pendant,  CommentNameplate nameplate, @JsonKey(name: 'official_verify')  OfficialVerify officialVerify,  CommentVip vip, @JsonKey(name: 'fans_detail')  dynamic fansDetail,  int following, @JsonKey(name: 'is_followed')  int isFollowed)  $default,) {final _that = this;
switch (_that) {
case _CommentMember():
return $default(_that.mid,_that.uname,_that.sex,_that.sign,_that.avatar,_that.rank,_that.displayRank,_that.levelInfo,_that.pendant,_that.nameplate,_that.officialVerify,_that.vip,_that.fansDetail,_that.following,_that.isFollowed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mid,  String uname,  String sex,  String sign,  String avatar,  String rank, @JsonKey(name: 'DisplayRank')  int displayRank, @JsonKey(name: 'level_info')  CommentLevelInfo levelInfo,  CommentPendant pendant,  CommentNameplate nameplate, @JsonKey(name: 'official_verify')  OfficialVerify officialVerify,  CommentVip vip, @JsonKey(name: 'fans_detail')  dynamic fansDetail,  int following, @JsonKey(name: 'is_followed')  int isFollowed)?  $default,) {final _that = this;
switch (_that) {
case _CommentMember() when $default != null:
return $default(_that.mid,_that.uname,_that.sex,_that.sign,_that.avatar,_that.rank,_that.displayRank,_that.levelInfo,_that.pendant,_that.nameplate,_that.officialVerify,_that.vip,_that.fansDetail,_that.following,_that.isFollowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentMember implements CommentMember {
  const _CommentMember({required this.mid, required this.uname, required this.sex, required this.sign, required this.avatar, required this.rank, @JsonKey(name: 'DisplayRank') this.displayRank = 0, @JsonKey(name: 'level_info') required this.levelInfo, required this.pendant, required this.nameplate, @JsonKey(name: 'official_verify') required this.officialVerify, required this.vip, @JsonKey(name: 'fans_detail') this.fansDetail, this.following = 0, @JsonKey(name: 'is_followed') this.isFollowed = 0});
  factory _CommentMember.fromJson(Map<String, dynamic> json) => _$CommentMemberFromJson(json);

@override final  String mid;
@override final  String uname;
@override final  String sex;
@override final  String sign;
@override final  String avatar;
@override final  String rank;
@override@JsonKey(name: 'DisplayRank') final  int displayRank;
@override@JsonKey(name: 'level_info') final  CommentLevelInfo levelInfo;
@override final  CommentPendant pendant;
@override final  CommentNameplate nameplate;
@override@JsonKey(name: 'official_verify') final  OfficialVerify officialVerify;
@override final  CommentVip vip;
@override@JsonKey(name: 'fans_detail') final  dynamic fansDetail;
@override@JsonKey() final  int following;
@override@JsonKey(name: 'is_followed') final  int isFollowed;

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentMemberCopyWith<_CommentMember> get copyWith => __$CommentMemberCopyWithImpl<_CommentMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentMember&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.displayRank, displayRank) || other.displayRank == displayRank)&&(identical(other.levelInfo, levelInfo) || other.levelInfo == levelInfo)&&(identical(other.pendant, pendant) || other.pendant == pendant)&&(identical(other.nameplate, nameplate) || other.nameplate == nameplate)&&(identical(other.officialVerify, officialVerify) || other.officialVerify == officialVerify)&&(identical(other.vip, vip) || other.vip == vip)&&const DeepCollectionEquality().equals(other.fansDetail, fansDetail)&&(identical(other.following, following) || other.following == following)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,uname,sex,sign,avatar,rank,displayRank,levelInfo,pendant,nameplate,officialVerify,vip,const DeepCollectionEquality().hash(fansDetail),following,isFollowed);

@override
String toString() {
  return 'CommentMember(mid: $mid, uname: $uname, sex: $sex, sign: $sign, avatar: $avatar, rank: $rank, displayRank: $displayRank, levelInfo: $levelInfo, pendant: $pendant, nameplate: $nameplate, officialVerify: $officialVerify, vip: $vip, fansDetail: $fansDetail, following: $following, isFollowed: $isFollowed)';
}


}

/// @nodoc
abstract mixin class _$CommentMemberCopyWith<$Res> implements $CommentMemberCopyWith<$Res> {
  factory _$CommentMemberCopyWith(_CommentMember value, $Res Function(_CommentMember) _then) = __$CommentMemberCopyWithImpl;
@override @useResult
$Res call({
 String mid, String uname, String sex, String sign, String avatar, String rank,@JsonKey(name: 'DisplayRank') int displayRank,@JsonKey(name: 'level_info') CommentLevelInfo levelInfo, CommentPendant pendant, CommentNameplate nameplate,@JsonKey(name: 'official_verify') OfficialVerify officialVerify, CommentVip vip,@JsonKey(name: 'fans_detail') dynamic fansDetail, int following,@JsonKey(name: 'is_followed') int isFollowed
});


@override $CommentLevelInfoCopyWith<$Res> get levelInfo;@override $CommentPendantCopyWith<$Res> get pendant;@override $CommentNameplateCopyWith<$Res> get nameplate;@override $CommentVipCopyWith<$Res> get vip;

}
/// @nodoc
class __$CommentMemberCopyWithImpl<$Res>
    implements _$CommentMemberCopyWith<$Res> {
  __$CommentMemberCopyWithImpl(this._self, this._then);

  final _CommentMember _self;
  final $Res Function(_CommentMember) _then;

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? uname = null,Object? sex = null,Object? sign = null,Object? avatar = null,Object? rank = null,Object? displayRank = null,Object? levelInfo = null,Object? pendant = null,Object? nameplate = null,Object? officialVerify = null,Object? vip = null,Object? fansDetail = freezed,Object? following = null,Object? isFollowed = null,}) {
  return _then(_CommentMember(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,displayRank: null == displayRank ? _self.displayRank : displayRank // ignore: cast_nullable_to_non_nullable
as int,levelInfo: null == levelInfo ? _self.levelInfo : levelInfo // ignore: cast_nullable_to_non_nullable
as CommentLevelInfo,pendant: null == pendant ? _self.pendant : pendant // ignore: cast_nullable_to_non_nullable
as CommentPendant,nameplate: null == nameplate ? _self.nameplate : nameplate // ignore: cast_nullable_to_non_nullable
as CommentNameplate,officialVerify: null == officialVerify ? _self.officialVerify : officialVerify // ignore: cast_nullable_to_non_nullable
as OfficialVerify,vip: null == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as CommentVip,fansDetail: freezed == fansDetail ? _self.fansDetail : fansDetail // ignore: cast_nullable_to_non_nullable
as dynamic,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentLevelInfoCopyWith<$Res> get levelInfo {
  
  return $CommentLevelInfoCopyWith<$Res>(_self.levelInfo, (value) {
    return _then(_self.copyWith(levelInfo: value));
  });
}/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentPendantCopyWith<$Res> get pendant {
  
  return $CommentPendantCopyWith<$Res>(_self.pendant, (value) {
    return _then(_self.copyWith(pendant: value));
  });
}/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentNameplateCopyWith<$Res> get nameplate {
  
  return $CommentNameplateCopyWith<$Res>(_self.nameplate, (value) {
    return _then(_self.copyWith(nameplate: value));
  });
}/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentVipCopyWith<$Res> get vip {
  
  return $CommentVipCopyWith<$Res>(_self.vip, (value) {
    return _then(_self.copyWith(vip: value));
  });
}
}


/// @nodoc
mixin _$CommentLevelInfo {

@JsonKey(name: 'current_level') int get currentLevel;@JsonKey(name: 'current_min') int get currentMin;@JsonKey(name: 'current_exp') int get currentExp;@JsonKey(name: 'next_exp') int get nextExp;
/// Create a copy of CommentLevelInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentLevelInfoCopyWith<CommentLevelInfo> get copyWith => _$CommentLevelInfoCopyWithImpl<CommentLevelInfo>(this as CommentLevelInfo, _$identity);

  /// Serializes this CommentLevelInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentLevelInfo&&(identical(other.currentLevel, currentLevel) || other.currentLevel == currentLevel)&&(identical(other.currentMin, currentMin) || other.currentMin == currentMin)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.nextExp, nextExp) || other.nextExp == nextExp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentLevel,currentMin,currentExp,nextExp);

@override
String toString() {
  return 'CommentLevelInfo(currentLevel: $currentLevel, currentMin: $currentMin, currentExp: $currentExp, nextExp: $nextExp)';
}


}

/// @nodoc
abstract mixin class $CommentLevelInfoCopyWith<$Res>  {
  factory $CommentLevelInfoCopyWith(CommentLevelInfo value, $Res Function(CommentLevelInfo) _then) = _$CommentLevelInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'current_level') int currentLevel,@JsonKey(name: 'current_min') int currentMin,@JsonKey(name: 'current_exp') int currentExp,@JsonKey(name: 'next_exp') int nextExp
});




}
/// @nodoc
class _$CommentLevelInfoCopyWithImpl<$Res>
    implements $CommentLevelInfoCopyWith<$Res> {
  _$CommentLevelInfoCopyWithImpl(this._self, this._then);

  final CommentLevelInfo _self;
  final $Res Function(CommentLevelInfo) _then;

/// Create a copy of CommentLevelInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentLevel = null,Object? currentMin = null,Object? currentExp = null,Object? nextExp = null,}) {
  return _then(_self.copyWith(
currentLevel: null == currentLevel ? _self.currentLevel : currentLevel // ignore: cast_nullable_to_non_nullable
as int,currentMin: null == currentMin ? _self.currentMin : currentMin // ignore: cast_nullable_to_non_nullable
as int,currentExp: null == currentExp ? _self.currentExp : currentExp // ignore: cast_nullable_to_non_nullable
as int,nextExp: null == nextExp ? _self.nextExp : nextExp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentLevelInfo].
extension CommentLevelInfoPatterns on CommentLevelInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentLevelInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentLevelInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentLevelInfo value)  $default,){
final _that = this;
switch (_that) {
case _CommentLevelInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentLevelInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CommentLevelInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_level')  int currentLevel, @JsonKey(name: 'current_min')  int currentMin, @JsonKey(name: 'current_exp')  int currentExp, @JsonKey(name: 'next_exp')  int nextExp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentLevelInfo() when $default != null:
return $default(_that.currentLevel,_that.currentMin,_that.currentExp,_that.nextExp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_level')  int currentLevel, @JsonKey(name: 'current_min')  int currentMin, @JsonKey(name: 'current_exp')  int currentExp, @JsonKey(name: 'next_exp')  int nextExp)  $default,) {final _that = this;
switch (_that) {
case _CommentLevelInfo():
return $default(_that.currentLevel,_that.currentMin,_that.currentExp,_that.nextExp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'current_level')  int currentLevel, @JsonKey(name: 'current_min')  int currentMin, @JsonKey(name: 'current_exp')  int currentExp, @JsonKey(name: 'next_exp')  int nextExp)?  $default,) {final _that = this;
switch (_that) {
case _CommentLevelInfo() when $default != null:
return $default(_that.currentLevel,_that.currentMin,_that.currentExp,_that.nextExp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentLevelInfo implements CommentLevelInfo {
  const _CommentLevelInfo({@JsonKey(name: 'current_level') required this.currentLevel, @JsonKey(name: 'current_min') required this.currentMin, @JsonKey(name: 'current_exp') required this.currentExp, @JsonKey(name: 'next_exp') required this.nextExp});
  factory _CommentLevelInfo.fromJson(Map<String, dynamic> json) => _$CommentLevelInfoFromJson(json);

@override@JsonKey(name: 'current_level') final  int currentLevel;
@override@JsonKey(name: 'current_min') final  int currentMin;
@override@JsonKey(name: 'current_exp') final  int currentExp;
@override@JsonKey(name: 'next_exp') final  int nextExp;

/// Create a copy of CommentLevelInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentLevelInfoCopyWith<_CommentLevelInfo> get copyWith => __$CommentLevelInfoCopyWithImpl<_CommentLevelInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentLevelInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentLevelInfo&&(identical(other.currentLevel, currentLevel) || other.currentLevel == currentLevel)&&(identical(other.currentMin, currentMin) || other.currentMin == currentMin)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.nextExp, nextExp) || other.nextExp == nextExp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentLevel,currentMin,currentExp,nextExp);

@override
String toString() {
  return 'CommentLevelInfo(currentLevel: $currentLevel, currentMin: $currentMin, currentExp: $currentExp, nextExp: $nextExp)';
}


}

/// @nodoc
abstract mixin class _$CommentLevelInfoCopyWith<$Res> implements $CommentLevelInfoCopyWith<$Res> {
  factory _$CommentLevelInfoCopyWith(_CommentLevelInfo value, $Res Function(_CommentLevelInfo) _then) = __$CommentLevelInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'current_level') int currentLevel,@JsonKey(name: 'current_min') int currentMin,@JsonKey(name: 'current_exp') int currentExp,@JsonKey(name: 'next_exp') int nextExp
});




}
/// @nodoc
class __$CommentLevelInfoCopyWithImpl<$Res>
    implements _$CommentLevelInfoCopyWith<$Res> {
  __$CommentLevelInfoCopyWithImpl(this._self, this._then);

  final _CommentLevelInfo _self;
  final $Res Function(_CommentLevelInfo) _then;

/// Create a copy of CommentLevelInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentLevel = null,Object? currentMin = null,Object? currentExp = null,Object? nextExp = null,}) {
  return _then(_CommentLevelInfo(
currentLevel: null == currentLevel ? _self.currentLevel : currentLevel // ignore: cast_nullable_to_non_nullable
as int,currentMin: null == currentMin ? _self.currentMin : currentMin // ignore: cast_nullable_to_non_nullable
as int,currentExp: null == currentExp ? _self.currentExp : currentExp // ignore: cast_nullable_to_non_nullable
as int,nextExp: null == nextExp ? _self.nextExp : nextExp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommentPendant {

 int get pid; String get name; String get image; int get expire;@JsonKey(name: 'image_enhance') String get imageEnhance;@JsonKey(name: 'image_enhance_frame') String get imageEnhanceFrame;
/// Create a copy of CommentPendant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentPendantCopyWith<CommentPendant> get copyWith => _$CommentPendantCopyWithImpl<CommentPendant>(this as CommentPendant, _$identity);

  /// Serializes this CommentPendant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentPendant&&(identical(other.pid, pid) || other.pid == pid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.expire, expire) || other.expire == expire)&&(identical(other.imageEnhance, imageEnhance) || other.imageEnhance == imageEnhance)&&(identical(other.imageEnhanceFrame, imageEnhanceFrame) || other.imageEnhanceFrame == imageEnhanceFrame));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pid,name,image,expire,imageEnhance,imageEnhanceFrame);

@override
String toString() {
  return 'CommentPendant(pid: $pid, name: $name, image: $image, expire: $expire, imageEnhance: $imageEnhance, imageEnhanceFrame: $imageEnhanceFrame)';
}


}

/// @nodoc
abstract mixin class $CommentPendantCopyWith<$Res>  {
  factory $CommentPendantCopyWith(CommentPendant value, $Res Function(CommentPendant) _then) = _$CommentPendantCopyWithImpl;
@useResult
$Res call({
 int pid, String name, String image, int expire,@JsonKey(name: 'image_enhance') String imageEnhance,@JsonKey(name: 'image_enhance_frame') String imageEnhanceFrame
});




}
/// @nodoc
class _$CommentPendantCopyWithImpl<$Res>
    implements $CommentPendantCopyWith<$Res> {
  _$CommentPendantCopyWithImpl(this._self, this._then);

  final CommentPendant _self;
  final $Res Function(CommentPendant) _then;

/// Create a copy of CommentPendant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pid = null,Object? name = null,Object? image = null,Object? expire = null,Object? imageEnhance = null,Object? imageEnhanceFrame = null,}) {
  return _then(_self.copyWith(
pid: null == pid ? _self.pid : pid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,expire: null == expire ? _self.expire : expire // ignore: cast_nullable_to_non_nullable
as int,imageEnhance: null == imageEnhance ? _self.imageEnhance : imageEnhance // ignore: cast_nullable_to_non_nullable
as String,imageEnhanceFrame: null == imageEnhanceFrame ? _self.imageEnhanceFrame : imageEnhanceFrame // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentPendant].
extension CommentPendantPatterns on CommentPendant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentPendant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentPendant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentPendant value)  $default,){
final _that = this;
switch (_that) {
case _CommentPendant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentPendant value)?  $default,){
final _that = this;
switch (_that) {
case _CommentPendant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pid,  String name,  String image,  int expire, @JsonKey(name: 'image_enhance')  String imageEnhance, @JsonKey(name: 'image_enhance_frame')  String imageEnhanceFrame)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentPendant() when $default != null:
return $default(_that.pid,_that.name,_that.image,_that.expire,_that.imageEnhance,_that.imageEnhanceFrame);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pid,  String name,  String image,  int expire, @JsonKey(name: 'image_enhance')  String imageEnhance, @JsonKey(name: 'image_enhance_frame')  String imageEnhanceFrame)  $default,) {final _that = this;
switch (_that) {
case _CommentPendant():
return $default(_that.pid,_that.name,_that.image,_that.expire,_that.imageEnhance,_that.imageEnhanceFrame);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pid,  String name,  String image,  int expire, @JsonKey(name: 'image_enhance')  String imageEnhance, @JsonKey(name: 'image_enhance_frame')  String imageEnhanceFrame)?  $default,) {final _that = this;
switch (_that) {
case _CommentPendant() when $default != null:
return $default(_that.pid,_that.name,_that.image,_that.expire,_that.imageEnhance,_that.imageEnhanceFrame);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentPendant implements CommentPendant {
  const _CommentPendant({required this.pid, required this.name, required this.image, required this.expire, @JsonKey(name: 'image_enhance') this.imageEnhance = '', @JsonKey(name: 'image_enhance_frame') this.imageEnhanceFrame = ''});
  factory _CommentPendant.fromJson(Map<String, dynamic> json) => _$CommentPendantFromJson(json);

@override final  int pid;
@override final  String name;
@override final  String image;
@override final  int expire;
@override@JsonKey(name: 'image_enhance') final  String imageEnhance;
@override@JsonKey(name: 'image_enhance_frame') final  String imageEnhanceFrame;

/// Create a copy of CommentPendant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentPendantCopyWith<_CommentPendant> get copyWith => __$CommentPendantCopyWithImpl<_CommentPendant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentPendantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentPendant&&(identical(other.pid, pid) || other.pid == pid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.expire, expire) || other.expire == expire)&&(identical(other.imageEnhance, imageEnhance) || other.imageEnhance == imageEnhance)&&(identical(other.imageEnhanceFrame, imageEnhanceFrame) || other.imageEnhanceFrame == imageEnhanceFrame));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pid,name,image,expire,imageEnhance,imageEnhanceFrame);

@override
String toString() {
  return 'CommentPendant(pid: $pid, name: $name, image: $image, expire: $expire, imageEnhance: $imageEnhance, imageEnhanceFrame: $imageEnhanceFrame)';
}


}

/// @nodoc
abstract mixin class _$CommentPendantCopyWith<$Res> implements $CommentPendantCopyWith<$Res> {
  factory _$CommentPendantCopyWith(_CommentPendant value, $Res Function(_CommentPendant) _then) = __$CommentPendantCopyWithImpl;
@override @useResult
$Res call({
 int pid, String name, String image, int expire,@JsonKey(name: 'image_enhance') String imageEnhance,@JsonKey(name: 'image_enhance_frame') String imageEnhanceFrame
});




}
/// @nodoc
class __$CommentPendantCopyWithImpl<$Res>
    implements _$CommentPendantCopyWith<$Res> {
  __$CommentPendantCopyWithImpl(this._self, this._then);

  final _CommentPendant _self;
  final $Res Function(_CommentPendant) _then;

/// Create a copy of CommentPendant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pid = null,Object? name = null,Object? image = null,Object? expire = null,Object? imageEnhance = null,Object? imageEnhanceFrame = null,}) {
  return _then(_CommentPendant(
pid: null == pid ? _self.pid : pid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,expire: null == expire ? _self.expire : expire // ignore: cast_nullable_to_non_nullable
as int,imageEnhance: null == imageEnhance ? _self.imageEnhance : imageEnhance // ignore: cast_nullable_to_non_nullable
as String,imageEnhanceFrame: null == imageEnhanceFrame ? _self.imageEnhanceFrame : imageEnhanceFrame // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommentNameplate {

 int get nid; String get name; String get image;@JsonKey(name: 'image_small') String get imageSmall; String get level; String get condition;
/// Create a copy of CommentNameplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentNameplateCopyWith<CommentNameplate> get copyWith => _$CommentNameplateCopyWithImpl<CommentNameplate>(this as CommentNameplate, _$identity);

  /// Serializes this CommentNameplate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentNameplate&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.imageSmall, imageSmall) || other.imageSmall == imageSmall)&&(identical(other.level, level) || other.level == level)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nid,name,image,imageSmall,level,condition);

@override
String toString() {
  return 'CommentNameplate(nid: $nid, name: $name, image: $image, imageSmall: $imageSmall, level: $level, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $CommentNameplateCopyWith<$Res>  {
  factory $CommentNameplateCopyWith(CommentNameplate value, $Res Function(CommentNameplate) _then) = _$CommentNameplateCopyWithImpl;
@useResult
$Res call({
 int nid, String name, String image,@JsonKey(name: 'image_small') String imageSmall, String level, String condition
});




}
/// @nodoc
class _$CommentNameplateCopyWithImpl<$Res>
    implements $CommentNameplateCopyWith<$Res> {
  _$CommentNameplateCopyWithImpl(this._self, this._then);

  final CommentNameplate _self;
  final $Res Function(CommentNameplate) _then;

/// Create a copy of CommentNameplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nid = null,Object? name = null,Object? image = null,Object? imageSmall = null,Object? level = null,Object? condition = null,}) {
  return _then(_self.copyWith(
nid: null == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,imageSmall: null == imageSmall ? _self.imageSmall : imageSmall // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentNameplate].
extension CommentNameplatePatterns on CommentNameplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentNameplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentNameplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentNameplate value)  $default,){
final _that = this;
switch (_that) {
case _CommentNameplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentNameplate value)?  $default,){
final _that = this;
switch (_that) {
case _CommentNameplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int nid,  String name,  String image, @JsonKey(name: 'image_small')  String imageSmall,  String level,  String condition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentNameplate() when $default != null:
return $default(_that.nid,_that.name,_that.image,_that.imageSmall,_that.level,_that.condition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int nid,  String name,  String image, @JsonKey(name: 'image_small')  String imageSmall,  String level,  String condition)  $default,) {final _that = this;
switch (_that) {
case _CommentNameplate():
return $default(_that.nid,_that.name,_that.image,_that.imageSmall,_that.level,_that.condition);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int nid,  String name,  String image, @JsonKey(name: 'image_small')  String imageSmall,  String level,  String condition)?  $default,) {final _that = this;
switch (_that) {
case _CommentNameplate() when $default != null:
return $default(_that.nid,_that.name,_that.image,_that.imageSmall,_that.level,_that.condition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentNameplate implements CommentNameplate {
  const _CommentNameplate({required this.nid, required this.name, required this.image, @JsonKey(name: 'image_small') required this.imageSmall, required this.level, required this.condition});
  factory _CommentNameplate.fromJson(Map<String, dynamic> json) => _$CommentNameplateFromJson(json);

@override final  int nid;
@override final  String name;
@override final  String image;
@override@JsonKey(name: 'image_small') final  String imageSmall;
@override final  String level;
@override final  String condition;

/// Create a copy of CommentNameplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentNameplateCopyWith<_CommentNameplate> get copyWith => __$CommentNameplateCopyWithImpl<_CommentNameplate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentNameplateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentNameplate&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.imageSmall, imageSmall) || other.imageSmall == imageSmall)&&(identical(other.level, level) || other.level == level)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nid,name,image,imageSmall,level,condition);

@override
String toString() {
  return 'CommentNameplate(nid: $nid, name: $name, image: $image, imageSmall: $imageSmall, level: $level, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$CommentNameplateCopyWith<$Res> implements $CommentNameplateCopyWith<$Res> {
  factory _$CommentNameplateCopyWith(_CommentNameplate value, $Res Function(_CommentNameplate) _then) = __$CommentNameplateCopyWithImpl;
@override @useResult
$Res call({
 int nid, String name, String image,@JsonKey(name: 'image_small') String imageSmall, String level, String condition
});




}
/// @nodoc
class __$CommentNameplateCopyWithImpl<$Res>
    implements _$CommentNameplateCopyWith<$Res> {
  __$CommentNameplateCopyWithImpl(this._self, this._then);

  final _CommentNameplate _self;
  final $Res Function(_CommentNameplate) _then;

/// Create a copy of CommentNameplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nid = null,Object? name = null,Object? image = null,Object? imageSmall = null,Object? level = null,Object? condition = null,}) {
  return _then(_CommentNameplate(
nid: null == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,imageSmall: null == imageSmall ? _self.imageSmall : imageSmall // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommentVip {

 int get vipType; int get vipDueDate; String get dueRemark; int get accessStatus; int get vipStatus; String get vipStatusWarn; int get themeType; dynamic get label;
/// Create a copy of CommentVip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentVipCopyWith<CommentVip> get copyWith => _$CommentVipCopyWithImpl<CommentVip>(this as CommentVip, _$identity);

  /// Serializes this CommentVip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentVip&&(identical(other.vipType, vipType) || other.vipType == vipType)&&(identical(other.vipDueDate, vipDueDate) || other.vipDueDate == vipDueDate)&&(identical(other.dueRemark, dueRemark) || other.dueRemark == dueRemark)&&(identical(other.accessStatus, accessStatus) || other.accessStatus == accessStatus)&&(identical(other.vipStatus, vipStatus) || other.vipStatus == vipStatus)&&(identical(other.vipStatusWarn, vipStatusWarn) || other.vipStatusWarn == vipStatusWarn)&&(identical(other.themeType, themeType) || other.themeType == themeType)&&const DeepCollectionEquality().equals(other.label, label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vipType,vipDueDate,dueRemark,accessStatus,vipStatus,vipStatusWarn,themeType,const DeepCollectionEquality().hash(label));

@override
String toString() {
  return 'CommentVip(vipType: $vipType, vipDueDate: $vipDueDate, dueRemark: $dueRemark, accessStatus: $accessStatus, vipStatus: $vipStatus, vipStatusWarn: $vipStatusWarn, themeType: $themeType, label: $label)';
}


}

/// @nodoc
abstract mixin class $CommentVipCopyWith<$Res>  {
  factory $CommentVipCopyWith(CommentVip value, $Res Function(CommentVip) _then) = _$CommentVipCopyWithImpl;
@useResult
$Res call({
 int vipType, int vipDueDate, String dueRemark, int accessStatus, int vipStatus, String vipStatusWarn, int themeType, dynamic label
});




}
/// @nodoc
class _$CommentVipCopyWithImpl<$Res>
    implements $CommentVipCopyWith<$Res> {
  _$CommentVipCopyWithImpl(this._self, this._then);

  final CommentVip _self;
  final $Res Function(CommentVip) _then;

/// Create a copy of CommentVip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vipType = null,Object? vipDueDate = null,Object? dueRemark = null,Object? accessStatus = null,Object? vipStatus = null,Object? vipStatusWarn = null,Object? themeType = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
vipType: null == vipType ? _self.vipType : vipType // ignore: cast_nullable_to_non_nullable
as int,vipDueDate: null == vipDueDate ? _self.vipDueDate : vipDueDate // ignore: cast_nullable_to_non_nullable
as int,dueRemark: null == dueRemark ? _self.dueRemark : dueRemark // ignore: cast_nullable_to_non_nullable
as String,accessStatus: null == accessStatus ? _self.accessStatus : accessStatus // ignore: cast_nullable_to_non_nullable
as int,vipStatus: null == vipStatus ? _self.vipStatus : vipStatus // ignore: cast_nullable_to_non_nullable
as int,vipStatusWarn: null == vipStatusWarn ? _self.vipStatusWarn : vipStatusWarn // ignore: cast_nullable_to_non_nullable
as String,themeType: null == themeType ? _self.themeType : themeType // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentVip].
extension CommentVipPatterns on CommentVip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentVip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentVip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentVip value)  $default,){
final _that = this;
switch (_that) {
case _CommentVip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentVip value)?  $default,){
final _that = this;
switch (_that) {
case _CommentVip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int vipType,  int vipDueDate,  String dueRemark,  int accessStatus,  int vipStatus,  String vipStatusWarn,  int themeType,  dynamic label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentVip() when $default != null:
return $default(_that.vipType,_that.vipDueDate,_that.dueRemark,_that.accessStatus,_that.vipStatus,_that.vipStatusWarn,_that.themeType,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int vipType,  int vipDueDate,  String dueRemark,  int accessStatus,  int vipStatus,  String vipStatusWarn,  int themeType,  dynamic label)  $default,) {final _that = this;
switch (_that) {
case _CommentVip():
return $default(_that.vipType,_that.vipDueDate,_that.dueRemark,_that.accessStatus,_that.vipStatus,_that.vipStatusWarn,_that.themeType,_that.label);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int vipType,  int vipDueDate,  String dueRemark,  int accessStatus,  int vipStatus,  String vipStatusWarn,  int themeType,  dynamic label)?  $default,) {final _that = this;
switch (_that) {
case _CommentVip() when $default != null:
return $default(_that.vipType,_that.vipDueDate,_that.dueRemark,_that.accessStatus,_that.vipStatus,_that.vipStatusWarn,_that.themeType,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentVip implements CommentVip {
  const _CommentVip({this.vipType = 0, this.vipDueDate = 0, this.dueRemark = '', this.accessStatus = 0, this.vipStatus = 0, this.vipStatusWarn = '', this.themeType = 0, this.label});
  factory _CommentVip.fromJson(Map<String, dynamic> json) => _$CommentVipFromJson(json);

@override@JsonKey() final  int vipType;
@override@JsonKey() final  int vipDueDate;
@override@JsonKey() final  String dueRemark;
@override@JsonKey() final  int accessStatus;
@override@JsonKey() final  int vipStatus;
@override@JsonKey() final  String vipStatusWarn;
@override@JsonKey() final  int themeType;
@override final  dynamic label;

/// Create a copy of CommentVip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentVipCopyWith<_CommentVip> get copyWith => __$CommentVipCopyWithImpl<_CommentVip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentVipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentVip&&(identical(other.vipType, vipType) || other.vipType == vipType)&&(identical(other.vipDueDate, vipDueDate) || other.vipDueDate == vipDueDate)&&(identical(other.dueRemark, dueRemark) || other.dueRemark == dueRemark)&&(identical(other.accessStatus, accessStatus) || other.accessStatus == accessStatus)&&(identical(other.vipStatus, vipStatus) || other.vipStatus == vipStatus)&&(identical(other.vipStatusWarn, vipStatusWarn) || other.vipStatusWarn == vipStatusWarn)&&(identical(other.themeType, themeType) || other.themeType == themeType)&&const DeepCollectionEquality().equals(other.label, label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vipType,vipDueDate,dueRemark,accessStatus,vipStatus,vipStatusWarn,themeType,const DeepCollectionEquality().hash(label));

@override
String toString() {
  return 'CommentVip(vipType: $vipType, vipDueDate: $vipDueDate, dueRemark: $dueRemark, accessStatus: $accessStatus, vipStatus: $vipStatus, vipStatusWarn: $vipStatusWarn, themeType: $themeType, label: $label)';
}


}

/// @nodoc
abstract mixin class _$CommentVipCopyWith<$Res> implements $CommentVipCopyWith<$Res> {
  factory _$CommentVipCopyWith(_CommentVip value, $Res Function(_CommentVip) _then) = __$CommentVipCopyWithImpl;
@override @useResult
$Res call({
 int vipType, int vipDueDate, String dueRemark, int accessStatus, int vipStatus, String vipStatusWarn, int themeType, dynamic label
});




}
/// @nodoc
class __$CommentVipCopyWithImpl<$Res>
    implements _$CommentVipCopyWith<$Res> {
  __$CommentVipCopyWithImpl(this._self, this._then);

  final _CommentVip _self;
  final $Res Function(_CommentVip) _then;

/// Create a copy of CommentVip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vipType = null,Object? vipDueDate = null,Object? dueRemark = null,Object? accessStatus = null,Object? vipStatus = null,Object? vipStatusWarn = null,Object? themeType = null,Object? label = freezed,}) {
  return _then(_CommentVip(
vipType: null == vipType ? _self.vipType : vipType // ignore: cast_nullable_to_non_nullable
as int,vipDueDate: null == vipDueDate ? _self.vipDueDate : vipDueDate // ignore: cast_nullable_to_non_nullable
as int,dueRemark: null == dueRemark ? _self.dueRemark : dueRemark // ignore: cast_nullable_to_non_nullable
as String,accessStatus: null == accessStatus ? _self.accessStatus : accessStatus // ignore: cast_nullable_to_non_nullable
as int,vipStatus: null == vipStatus ? _self.vipStatus : vipStatus // ignore: cast_nullable_to_non_nullable
as int,vipStatusWarn: null == vipStatusWarn ? _self.vipStatusWarn : vipStatusWarn // ignore: cast_nullable_to_non_nullable
as String,themeType: null == themeType ? _self.themeType : themeType // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
