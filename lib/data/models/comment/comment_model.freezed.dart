// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

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
return $default(_that.replies,_that.cursor,_that.page);case _:
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

 int get num; int get size; int get count; int get acount;
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
 int num, int size, int count, int acount
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int num,  int size,  int count,  int acount)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int num,  int size,  int count,  int acount)  $default,) {final _that = this;
switch (_that) {
case _CommentPage():
return $default(_that.num,_that.size,_that.count,_that.acount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int num,  int size,  int count,  int acount)?  $default,) {final _that = this;
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
  const _CommentPage({this.num = 0, this.size = 0, this.count = 0, this.acount = 0});
  factory _CommentPage.fromJson(Map<String, dynamic> json) => _$CommentPageFromJson(json);

@override@JsonKey() final  int num;
@override@JsonKey() final  int size;
@override@JsonKey() final  int count;
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
 int num, int size, int count, int acount
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

 int get all_count; bool get is_begin; bool get is_end; int get mode; String get name; int get next; int get prev;
/// Create a copy of CommentCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCursorCopyWith<CommentCursor> get copyWith => _$CommentCursorCopyWithImpl<CommentCursor>(this as CommentCursor, _$identity);

  /// Serializes this CommentCursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentCursor&&(identical(other.all_count, all_count) || other.all_count == all_count)&&(identical(other.is_begin, is_begin) || other.is_begin == is_begin)&&(identical(other.is_end, is_end) || other.is_end == is_end)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.name, name) || other.name == name)&&(identical(other.next, next) || other.next == next)&&(identical(other.prev, prev) || other.prev == prev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,all_count,is_begin,is_end,mode,name,next,prev);

@override
String toString() {
  return 'CommentCursor(all_count: $all_count, is_begin: $is_begin, is_end: $is_end, mode: $mode, name: $name, next: $next, prev: $prev)';
}


}

/// @nodoc
abstract mixin class $CommentCursorCopyWith<$Res>  {
  factory $CommentCursorCopyWith(CommentCursor value, $Res Function(CommentCursor) _then) = _$CommentCursorCopyWithImpl;
@useResult
$Res call({
 int all_count, bool is_begin, bool is_end, int mode, String name, int next, int prev
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
@pragma('vm:prefer-inline') @override $Res call({Object? all_count = null,Object? is_begin = null,Object? is_end = null,Object? mode = null,Object? name = null,Object? next = null,Object? prev = null,}) {
  return _then(_self.copyWith(
all_count: null == all_count ? _self.all_count : all_count // ignore: cast_nullable_to_non_nullable
as int,is_begin: null == is_begin ? _self.is_begin : is_begin // ignore: cast_nullable_to_non_nullable
as bool,is_end: null == is_end ? _self.is_end : is_end // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int all_count,  bool is_begin,  bool is_end,  int mode,  String name,  int next,  int prev)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentCursor() when $default != null:
return $default(_that.all_count,_that.is_begin,_that.is_end,_that.mode,_that.name,_that.next,_that.prev);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int all_count,  bool is_begin,  bool is_end,  int mode,  String name,  int next,  int prev)  $default,) {final _that = this;
switch (_that) {
case _CommentCursor():
return $default(_that.all_count,_that.is_begin,_that.is_end,_that.mode,_that.name,_that.next,_that.prev);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int all_count,  bool is_begin,  bool is_end,  int mode,  String name,  int next,  int prev)?  $default,) {final _that = this;
switch (_that) {
case _CommentCursor() when $default != null:
return $default(_that.all_count,_that.is_begin,_that.is_end,_that.mode,_that.name,_that.next,_that.prev);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentCursor implements CommentCursor {
  const _CommentCursor({this.all_count = 0, this.is_begin = false, this.is_end = false, this.mode = 0, required this.name, this.next = 0, this.prev = 0});
  factory _CommentCursor.fromJson(Map<String, dynamic> json) => _$CommentCursorFromJson(json);

@override@JsonKey() final  int all_count;
@override@JsonKey() final  bool is_begin;
@override@JsonKey() final  bool is_end;
@override@JsonKey() final  int mode;
@override final  String name;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentCursor&&(identical(other.all_count, all_count) || other.all_count == all_count)&&(identical(other.is_begin, is_begin) || other.is_begin == is_begin)&&(identical(other.is_end, is_end) || other.is_end == is_end)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.name, name) || other.name == name)&&(identical(other.next, next) || other.next == next)&&(identical(other.prev, prev) || other.prev == prev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,all_count,is_begin,is_end,mode,name,next,prev);

@override
String toString() {
  return 'CommentCursor(all_count: $all_count, is_begin: $is_begin, is_end: $is_end, mode: $mode, name: $name, next: $next, prev: $prev)';
}


}

/// @nodoc
abstract mixin class _$CommentCursorCopyWith<$Res> implements $CommentCursorCopyWith<$Res> {
  factory _$CommentCursorCopyWith(_CommentCursor value, $Res Function(_CommentCursor) _then) = __$CommentCursorCopyWithImpl;
@override @useResult
$Res call({
 int all_count, bool is_begin, bool is_end, int mode, String name, int next, int prev
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
@override @pragma('vm:prefer-inline') $Res call({Object? all_count = null,Object? is_begin = null,Object? is_end = null,Object? mode = null,Object? name = null,Object? next = null,Object? prev = null,}) {
  return _then(_CommentCursor(
all_count: null == all_count ? _self.all_count : all_count // ignore: cast_nullable_to_non_nullable
as int,is_begin: null == is_begin ? _self.is_begin : is_begin // ignore: cast_nullable_to_non_nullable
as bool,is_end: null == is_end ? _self.is_end : is_end // ignore: cast_nullable_to_non_nullable
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

 int get rpid; int get oid; int get type; int get mid; int get root; int get parent; int get dialog; int get count; int get rcount; int get floor; int get state; int get fansgrade; int get attr; int get ctime; String get rpid_str; String get root_str; String get parent_str; int get like; int get action; CommentMember get member; CommentContent get content; List<CommentItem> get replies; bool get show_follow; bool get invisible;
/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentItemCopyWith<CommentItem> get copyWith => _$CommentItemCopyWithImpl<CommentItem>(this as CommentItem, _$identity);

  /// Serializes this CommentItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentItem&&(identical(other.rpid, rpid) || other.rpid == rpid)&&(identical(other.oid, oid) || other.oid == oid)&&(identical(other.type, type) || other.type == type)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.root, root) || other.root == root)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.dialog, dialog) || other.dialog == dialog)&&(identical(other.count, count) || other.count == count)&&(identical(other.rcount, rcount) || other.rcount == rcount)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.state, state) || other.state == state)&&(identical(other.fansgrade, fansgrade) || other.fansgrade == fansgrade)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.rpid_str, rpid_str) || other.rpid_str == rpid_str)&&(identical(other.root_str, root_str) || other.root_str == root_str)&&(identical(other.parent_str, parent_str) || other.parent_str == parent_str)&&(identical(other.like, like) || other.like == like)&&(identical(other.action, action) || other.action == action)&&(identical(other.member, member) || other.member == member)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.show_follow, show_follow) || other.show_follow == show_follow)&&(identical(other.invisible, invisible) || other.invisible == invisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rpid,oid,type,mid,root,parent,dialog,count,rcount,floor,state,fansgrade,attr,ctime,rpid_str,root_str,parent_str,like,action,member,content,const DeepCollectionEquality().hash(replies),show_follow,invisible]);

@override
String toString() {
  return 'CommentItem(rpid: $rpid, oid: $oid, type: $type, mid: $mid, root: $root, parent: $parent, dialog: $dialog, count: $count, rcount: $rcount, floor: $floor, state: $state, fansgrade: $fansgrade, attr: $attr, ctime: $ctime, rpid_str: $rpid_str, root_str: $root_str, parent_str: $parent_str, like: $like, action: $action, member: $member, content: $content, replies: $replies, show_follow: $show_follow, invisible: $invisible)';
}


}

/// @nodoc
abstract mixin class $CommentItemCopyWith<$Res>  {
  factory $CommentItemCopyWith(CommentItem value, $Res Function(CommentItem) _then) = _$CommentItemCopyWithImpl;
@useResult
$Res call({
 int rpid, int oid, int type, int mid, int root, int parent, int dialog, int count, int rcount, int floor, int state, int fansgrade, int attr, int ctime, String rpid_str, String root_str, String parent_str, int like, int action, CommentMember member, CommentContent content, List<CommentItem> replies, bool show_follow, bool invisible
});


$CommentMemberCopyWith<$Res> get member;$CommentContentCopyWith<$Res> get content;

}
/// @nodoc
class _$CommentItemCopyWithImpl<$Res>
    implements $CommentItemCopyWith<$Res> {
  _$CommentItemCopyWithImpl(this._self, this._then);

  final CommentItem _self;
  final $Res Function(CommentItem) _then;

/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rpid = null,Object? oid = null,Object? type = null,Object? mid = null,Object? root = null,Object? parent = null,Object? dialog = null,Object? count = null,Object? rcount = null,Object? floor = null,Object? state = null,Object? fansgrade = null,Object? attr = null,Object? ctime = null,Object? rpid_str = null,Object? root_str = null,Object? parent_str = null,Object? like = null,Object? action = null,Object? member = null,Object? content = null,Object? replies = null,Object? show_follow = null,Object? invisible = null,}) {
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
as int,rpid_str: null == rpid_str ? _self.rpid_str : rpid_str // ignore: cast_nullable_to_non_nullable
as String,root_str: null == root_str ? _self.root_str : root_str // ignore: cast_nullable_to_non_nullable
as String,parent_str: null == parent_str ? _self.parent_str : parent_str // ignore: cast_nullable_to_non_nullable
as String,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as CommentMember,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CommentContent,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,show_follow: null == show_follow ? _self.show_follow : show_follow // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentContentCopyWith<$Res> get content {
  
  return $CommentContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rpid,  int oid,  int type,  int mid,  int root,  int parent,  int dialog,  int count,  int rcount,  int floor,  int state,  int fansgrade,  int attr,  int ctime,  String rpid_str,  String root_str,  String parent_str,  int like,  int action,  CommentMember member,  CommentContent content,  List<CommentItem> replies,  bool show_follow,  bool invisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentItem() when $default != null:
return $default(_that.rpid,_that.oid,_that.type,_that.mid,_that.root,_that.parent,_that.dialog,_that.count,_that.rcount,_that.floor,_that.state,_that.fansgrade,_that.attr,_that.ctime,_that.rpid_str,_that.root_str,_that.parent_str,_that.like,_that.action,_that.member,_that.content,_that.replies,_that.show_follow,_that.invisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rpid,  int oid,  int type,  int mid,  int root,  int parent,  int dialog,  int count,  int rcount,  int floor,  int state,  int fansgrade,  int attr,  int ctime,  String rpid_str,  String root_str,  String parent_str,  int like,  int action,  CommentMember member,  CommentContent content,  List<CommentItem> replies,  bool show_follow,  bool invisible)  $default,) {final _that = this;
switch (_that) {
case _CommentItem():
return $default(_that.rpid,_that.oid,_that.type,_that.mid,_that.root,_that.parent,_that.dialog,_that.count,_that.rcount,_that.floor,_that.state,_that.fansgrade,_that.attr,_that.ctime,_that.rpid_str,_that.root_str,_that.parent_str,_that.like,_that.action,_that.member,_that.content,_that.replies,_that.show_follow,_that.invisible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rpid,  int oid,  int type,  int mid,  int root,  int parent,  int dialog,  int count,  int rcount,  int floor,  int state,  int fansgrade,  int attr,  int ctime,  String rpid_str,  String root_str,  String parent_str,  int like,  int action,  CommentMember member,  CommentContent content,  List<CommentItem> replies,  bool show_follow,  bool invisible)?  $default,) {final _that = this;
switch (_that) {
case _CommentItem() when $default != null:
return $default(_that.rpid,_that.oid,_that.type,_that.mid,_that.root,_that.parent,_that.dialog,_that.count,_that.rcount,_that.floor,_that.state,_that.fansgrade,_that.attr,_that.ctime,_that.rpid_str,_that.root_str,_that.parent_str,_that.like,_that.action,_that.member,_that.content,_that.replies,_that.show_follow,_that.invisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentItem implements CommentItem {
  const _CommentItem({required this.rpid, required this.oid, required this.type, required this.mid, required this.root, required this.parent, this.dialog = 0, this.count = 0, this.rcount = 0, this.floor = 0, this.state = 0, this.fansgrade = 0, this.attr = 0, required this.ctime, this.rpid_str = '', this.root_str = '', this.parent_str = '', this.like = 0, this.action = 0, required this.member, required this.content, final  List<CommentItem> replies = const [], this.show_follow = false, this.invisible = false}): _replies = replies;
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
@override@JsonKey() final  String rpid_str;
@override@JsonKey() final  String root_str;
@override@JsonKey() final  String parent_str;
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

@override@JsonKey() final  bool show_follow;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentItem&&(identical(other.rpid, rpid) || other.rpid == rpid)&&(identical(other.oid, oid) || other.oid == oid)&&(identical(other.type, type) || other.type == type)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.root, root) || other.root == root)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.dialog, dialog) || other.dialog == dialog)&&(identical(other.count, count) || other.count == count)&&(identical(other.rcount, rcount) || other.rcount == rcount)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.state, state) || other.state == state)&&(identical(other.fansgrade, fansgrade) || other.fansgrade == fansgrade)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.ctime, ctime) || other.ctime == ctime)&&(identical(other.rpid_str, rpid_str) || other.rpid_str == rpid_str)&&(identical(other.root_str, root_str) || other.root_str == root_str)&&(identical(other.parent_str, parent_str) || other.parent_str == parent_str)&&(identical(other.like, like) || other.like == like)&&(identical(other.action, action) || other.action == action)&&(identical(other.member, member) || other.member == member)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.show_follow, show_follow) || other.show_follow == show_follow)&&(identical(other.invisible, invisible) || other.invisible == invisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,rpid,oid,type,mid,root,parent,dialog,count,rcount,floor,state,fansgrade,attr,ctime,rpid_str,root_str,parent_str,like,action,member,content,const DeepCollectionEquality().hash(_replies),show_follow,invisible]);

@override
String toString() {
  return 'CommentItem(rpid: $rpid, oid: $oid, type: $type, mid: $mid, root: $root, parent: $parent, dialog: $dialog, count: $count, rcount: $rcount, floor: $floor, state: $state, fansgrade: $fansgrade, attr: $attr, ctime: $ctime, rpid_str: $rpid_str, root_str: $root_str, parent_str: $parent_str, like: $like, action: $action, member: $member, content: $content, replies: $replies, show_follow: $show_follow, invisible: $invisible)';
}


}

/// @nodoc
abstract mixin class _$CommentItemCopyWith<$Res> implements $CommentItemCopyWith<$Res> {
  factory _$CommentItemCopyWith(_CommentItem value, $Res Function(_CommentItem) _then) = __$CommentItemCopyWithImpl;
@override @useResult
$Res call({
 int rpid, int oid, int type, int mid, int root, int parent, int dialog, int count, int rcount, int floor, int state, int fansgrade, int attr, int ctime, String rpid_str, String root_str, String parent_str, int like, int action, CommentMember member, CommentContent content, List<CommentItem> replies, bool show_follow, bool invisible
});


@override $CommentMemberCopyWith<$Res> get member;@override $CommentContentCopyWith<$Res> get content;

}
/// @nodoc
class __$CommentItemCopyWithImpl<$Res>
    implements _$CommentItemCopyWith<$Res> {
  __$CommentItemCopyWithImpl(this._self, this._then);

  final _CommentItem _self;
  final $Res Function(_CommentItem) _then;

/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rpid = null,Object? oid = null,Object? type = null,Object? mid = null,Object? root = null,Object? parent = null,Object? dialog = null,Object? count = null,Object? rcount = null,Object? floor = null,Object? state = null,Object? fansgrade = null,Object? attr = null,Object? ctime = null,Object? rpid_str = null,Object? root_str = null,Object? parent_str = null,Object? like = null,Object? action = null,Object? member = null,Object? content = null,Object? replies = null,Object? show_follow = null,Object? invisible = null,}) {
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
as int,rpid_str: null == rpid_str ? _self.rpid_str : rpid_str // ignore: cast_nullable_to_non_nullable
as String,root_str: null == root_str ? _self.root_str : root_str // ignore: cast_nullable_to_non_nullable
as String,parent_str: null == parent_str ? _self.parent_str : parent_str // ignore: cast_nullable_to_non_nullable
as String,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as CommentMember,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CommentContent,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,show_follow: null == show_follow ? _self.show_follow : show_follow // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of CommentItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentContentCopyWith<$Res> get content {
  
  return $CommentContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// @nodoc
mixin _$CommentMember {

 String get mid; String get uname; String get sex; String get sign; String get avatar; String get rank; int get DisplayRank; CommentLevelInfo get level_info; CommentPendant get pendant; CommentNameplate get nameplate; CommentOfficialVerify get official_verify; CommentVip get vip; dynamic get fans_detail; int get following; int get is_followed;
/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentMemberCopyWith<CommentMember> get copyWith => _$CommentMemberCopyWithImpl<CommentMember>(this as CommentMember, _$identity);

  /// Serializes this CommentMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentMember&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.DisplayRank, DisplayRank) || other.DisplayRank == DisplayRank)&&(identical(other.level_info, level_info) || other.level_info == level_info)&&(identical(other.pendant, pendant) || other.pendant == pendant)&&(identical(other.nameplate, nameplate) || other.nameplate == nameplate)&&(identical(other.official_verify, official_verify) || other.official_verify == official_verify)&&(identical(other.vip, vip) || other.vip == vip)&&const DeepCollectionEquality().equals(other.fans_detail, fans_detail)&&(identical(other.following, following) || other.following == following)&&(identical(other.is_followed, is_followed) || other.is_followed == is_followed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,uname,sex,sign,avatar,rank,DisplayRank,level_info,pendant,nameplate,official_verify,vip,const DeepCollectionEquality().hash(fans_detail),following,is_followed);

@override
String toString() {
  return 'CommentMember(mid: $mid, uname: $uname, sex: $sex, sign: $sign, avatar: $avatar, rank: $rank, DisplayRank: $DisplayRank, level_info: $level_info, pendant: $pendant, nameplate: $nameplate, official_verify: $official_verify, vip: $vip, fans_detail: $fans_detail, following: $following, is_followed: $is_followed)';
}


}

/// @nodoc
abstract mixin class $CommentMemberCopyWith<$Res>  {
  factory $CommentMemberCopyWith(CommentMember value, $Res Function(CommentMember) _then) = _$CommentMemberCopyWithImpl;
@useResult
$Res call({
 String mid, String uname, String sex, String sign, String avatar, String rank, int DisplayRank, CommentLevelInfo level_info, CommentPendant pendant, CommentNameplate nameplate, CommentOfficialVerify official_verify, CommentVip vip, dynamic fans_detail, int following, int is_followed
});


$CommentLevelInfoCopyWith<$Res> get level_info;$CommentPendantCopyWith<$Res> get pendant;$CommentNameplateCopyWith<$Res> get nameplate;$CommentOfficialVerifyCopyWith<$Res> get official_verify;$CommentVipCopyWith<$Res> get vip;

}
/// @nodoc
class _$CommentMemberCopyWithImpl<$Res>
    implements $CommentMemberCopyWith<$Res> {
  _$CommentMemberCopyWithImpl(this._self, this._then);

  final CommentMember _self;
  final $Res Function(CommentMember) _then;

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? uname = null,Object? sex = null,Object? sign = null,Object? avatar = null,Object? rank = null,Object? DisplayRank = null,Object? level_info = null,Object? pendant = null,Object? nameplate = null,Object? official_verify = null,Object? vip = null,Object? fans_detail = freezed,Object? following = null,Object? is_followed = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,DisplayRank: null == DisplayRank ? _self.DisplayRank : DisplayRank // ignore: cast_nullable_to_non_nullable
as int,level_info: null == level_info ? _self.level_info : level_info // ignore: cast_nullable_to_non_nullable
as CommentLevelInfo,pendant: null == pendant ? _self.pendant : pendant // ignore: cast_nullable_to_non_nullable
as CommentPendant,nameplate: null == nameplate ? _self.nameplate : nameplate // ignore: cast_nullable_to_non_nullable
as CommentNameplate,official_verify: null == official_verify ? _self.official_verify : official_verify // ignore: cast_nullable_to_non_nullable
as CommentOfficialVerify,vip: null == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as CommentVip,fans_detail: freezed == fans_detail ? _self.fans_detail : fans_detail // ignore: cast_nullable_to_non_nullable
as dynamic,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,is_followed: null == is_followed ? _self.is_followed : is_followed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentLevelInfoCopyWith<$Res> get level_info {
  
  return $CommentLevelInfoCopyWith<$Res>(_self.level_info, (value) {
    return _then(_self.copyWith(level_info: value));
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
$CommentOfficialVerifyCopyWith<$Res> get official_verify {
  
  return $CommentOfficialVerifyCopyWith<$Res>(_self.official_verify, (value) {
    return _then(_self.copyWith(official_verify: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mid,  String uname,  String sex,  String sign,  String avatar,  String rank,  int DisplayRank,  CommentLevelInfo level_info,  CommentPendant pendant,  CommentNameplate nameplate,  CommentOfficialVerify official_verify,  CommentVip vip,  dynamic fans_detail,  int following,  int is_followed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentMember() when $default != null:
return $default(_that.mid,_that.uname,_that.sex,_that.sign,_that.avatar,_that.rank,_that.DisplayRank,_that.level_info,_that.pendant,_that.nameplate,_that.official_verify,_that.vip,_that.fans_detail,_that.following,_that.is_followed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mid,  String uname,  String sex,  String sign,  String avatar,  String rank,  int DisplayRank,  CommentLevelInfo level_info,  CommentPendant pendant,  CommentNameplate nameplate,  CommentOfficialVerify official_verify,  CommentVip vip,  dynamic fans_detail,  int following,  int is_followed)  $default,) {final _that = this;
switch (_that) {
case _CommentMember():
return $default(_that.mid,_that.uname,_that.sex,_that.sign,_that.avatar,_that.rank,_that.DisplayRank,_that.level_info,_that.pendant,_that.nameplate,_that.official_verify,_that.vip,_that.fans_detail,_that.following,_that.is_followed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mid,  String uname,  String sex,  String sign,  String avatar,  String rank,  int DisplayRank,  CommentLevelInfo level_info,  CommentPendant pendant,  CommentNameplate nameplate,  CommentOfficialVerify official_verify,  CommentVip vip,  dynamic fans_detail,  int following,  int is_followed)?  $default,) {final _that = this;
switch (_that) {
case _CommentMember() when $default != null:
return $default(_that.mid,_that.uname,_that.sex,_that.sign,_that.avatar,_that.rank,_that.DisplayRank,_that.level_info,_that.pendant,_that.nameplate,_that.official_verify,_that.vip,_that.fans_detail,_that.following,_that.is_followed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentMember implements CommentMember {
  const _CommentMember({required this.mid, required this.uname, required this.sex, required this.sign, required this.avatar, required this.rank, this.DisplayRank = 0, required this.level_info, required this.pendant, required this.nameplate, required this.official_verify, required this.vip, this.fans_detail, this.following = 0, this.is_followed = 0});
  factory _CommentMember.fromJson(Map<String, dynamic> json) => _$CommentMemberFromJson(json);

@override final  String mid;
@override final  String uname;
@override final  String sex;
@override final  String sign;
@override final  String avatar;
@override final  String rank;
@override@JsonKey() final  int DisplayRank;
@override final  CommentLevelInfo level_info;
@override final  CommentPendant pendant;
@override final  CommentNameplate nameplate;
@override final  CommentOfficialVerify official_verify;
@override final  CommentVip vip;
@override final  dynamic fans_detail;
@override@JsonKey() final  int following;
@override@JsonKey() final  int is_followed;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentMember&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.DisplayRank, DisplayRank) || other.DisplayRank == DisplayRank)&&(identical(other.level_info, level_info) || other.level_info == level_info)&&(identical(other.pendant, pendant) || other.pendant == pendant)&&(identical(other.nameplate, nameplate) || other.nameplate == nameplate)&&(identical(other.official_verify, official_verify) || other.official_verify == official_verify)&&(identical(other.vip, vip) || other.vip == vip)&&const DeepCollectionEquality().equals(other.fans_detail, fans_detail)&&(identical(other.following, following) || other.following == following)&&(identical(other.is_followed, is_followed) || other.is_followed == is_followed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,uname,sex,sign,avatar,rank,DisplayRank,level_info,pendant,nameplate,official_verify,vip,const DeepCollectionEquality().hash(fans_detail),following,is_followed);

@override
String toString() {
  return 'CommentMember(mid: $mid, uname: $uname, sex: $sex, sign: $sign, avatar: $avatar, rank: $rank, DisplayRank: $DisplayRank, level_info: $level_info, pendant: $pendant, nameplate: $nameplate, official_verify: $official_verify, vip: $vip, fans_detail: $fans_detail, following: $following, is_followed: $is_followed)';
}


}

/// @nodoc
abstract mixin class _$CommentMemberCopyWith<$Res> implements $CommentMemberCopyWith<$Res> {
  factory _$CommentMemberCopyWith(_CommentMember value, $Res Function(_CommentMember) _then) = __$CommentMemberCopyWithImpl;
@override @useResult
$Res call({
 String mid, String uname, String sex, String sign, String avatar, String rank, int DisplayRank, CommentLevelInfo level_info, CommentPendant pendant, CommentNameplate nameplate, CommentOfficialVerify official_verify, CommentVip vip, dynamic fans_detail, int following, int is_followed
});


@override $CommentLevelInfoCopyWith<$Res> get level_info;@override $CommentPendantCopyWith<$Res> get pendant;@override $CommentNameplateCopyWith<$Res> get nameplate;@override $CommentOfficialVerifyCopyWith<$Res> get official_verify;@override $CommentVipCopyWith<$Res> get vip;

}
/// @nodoc
class __$CommentMemberCopyWithImpl<$Res>
    implements _$CommentMemberCopyWith<$Res> {
  __$CommentMemberCopyWithImpl(this._self, this._then);

  final _CommentMember _self;
  final $Res Function(_CommentMember) _then;

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? uname = null,Object? sex = null,Object? sign = null,Object? avatar = null,Object? rank = null,Object? DisplayRank = null,Object? level_info = null,Object? pendant = null,Object? nameplate = null,Object? official_verify = null,Object? vip = null,Object? fans_detail = freezed,Object? following = null,Object? is_followed = null,}) {
  return _then(_CommentMember(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,DisplayRank: null == DisplayRank ? _self.DisplayRank : DisplayRank // ignore: cast_nullable_to_non_nullable
as int,level_info: null == level_info ? _self.level_info : level_info // ignore: cast_nullable_to_non_nullable
as CommentLevelInfo,pendant: null == pendant ? _self.pendant : pendant // ignore: cast_nullable_to_non_nullable
as CommentPendant,nameplate: null == nameplate ? _self.nameplate : nameplate // ignore: cast_nullable_to_non_nullable
as CommentNameplate,official_verify: null == official_verify ? _self.official_verify : official_verify // ignore: cast_nullable_to_non_nullable
as CommentOfficialVerify,vip: null == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as CommentVip,fans_detail: freezed == fans_detail ? _self.fans_detail : fans_detail // ignore: cast_nullable_to_non_nullable
as dynamic,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,is_followed: null == is_followed ? _self.is_followed : is_followed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CommentMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentLevelInfoCopyWith<$Res> get level_info {
  
  return $CommentLevelInfoCopyWith<$Res>(_self.level_info, (value) {
    return _then(_self.copyWith(level_info: value));
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
$CommentOfficialVerifyCopyWith<$Res> get official_verify {
  
  return $CommentOfficialVerifyCopyWith<$Res>(_self.official_verify, (value) {
    return _then(_self.copyWith(official_verify: value));
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

 int get current_level; int get current_min; int get current_exp; int get next_exp;
/// Create a copy of CommentLevelInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentLevelInfoCopyWith<CommentLevelInfo> get copyWith => _$CommentLevelInfoCopyWithImpl<CommentLevelInfo>(this as CommentLevelInfo, _$identity);

  /// Serializes this CommentLevelInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentLevelInfo&&(identical(other.current_level, current_level) || other.current_level == current_level)&&(identical(other.current_min, current_min) || other.current_min == current_min)&&(identical(other.current_exp, current_exp) || other.current_exp == current_exp)&&(identical(other.next_exp, next_exp) || other.next_exp == next_exp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current_level,current_min,current_exp,next_exp);

@override
String toString() {
  return 'CommentLevelInfo(current_level: $current_level, current_min: $current_min, current_exp: $current_exp, next_exp: $next_exp)';
}


}

/// @nodoc
abstract mixin class $CommentLevelInfoCopyWith<$Res>  {
  factory $CommentLevelInfoCopyWith(CommentLevelInfo value, $Res Function(CommentLevelInfo) _then) = _$CommentLevelInfoCopyWithImpl;
@useResult
$Res call({
 int current_level, int current_min, int current_exp, int next_exp
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
@pragma('vm:prefer-inline') @override $Res call({Object? current_level = null,Object? current_min = null,Object? current_exp = null,Object? next_exp = null,}) {
  return _then(_self.copyWith(
current_level: null == current_level ? _self.current_level : current_level // ignore: cast_nullable_to_non_nullable
as int,current_min: null == current_min ? _self.current_min : current_min // ignore: cast_nullable_to_non_nullable
as int,current_exp: null == current_exp ? _self.current_exp : current_exp // ignore: cast_nullable_to_non_nullable
as int,next_exp: null == next_exp ? _self.next_exp : next_exp // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int current_level,  int current_min,  int current_exp,  int next_exp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentLevelInfo() when $default != null:
return $default(_that.current_level,_that.current_min,_that.current_exp,_that.next_exp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int current_level,  int current_min,  int current_exp,  int next_exp)  $default,) {final _that = this;
switch (_that) {
case _CommentLevelInfo():
return $default(_that.current_level,_that.current_min,_that.current_exp,_that.next_exp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int current_level,  int current_min,  int current_exp,  int next_exp)?  $default,) {final _that = this;
switch (_that) {
case _CommentLevelInfo() when $default != null:
return $default(_that.current_level,_that.current_min,_that.current_exp,_that.next_exp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentLevelInfo implements CommentLevelInfo {
  const _CommentLevelInfo({required this.current_level, required this.current_min, required this.current_exp, required this.next_exp});
  factory _CommentLevelInfo.fromJson(Map<String, dynamic> json) => _$CommentLevelInfoFromJson(json);

@override final  int current_level;
@override final  int current_min;
@override final  int current_exp;
@override final  int next_exp;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentLevelInfo&&(identical(other.current_level, current_level) || other.current_level == current_level)&&(identical(other.current_min, current_min) || other.current_min == current_min)&&(identical(other.current_exp, current_exp) || other.current_exp == current_exp)&&(identical(other.next_exp, next_exp) || other.next_exp == next_exp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current_level,current_min,current_exp,next_exp);

@override
String toString() {
  return 'CommentLevelInfo(current_level: $current_level, current_min: $current_min, current_exp: $current_exp, next_exp: $next_exp)';
}


}

/// @nodoc
abstract mixin class _$CommentLevelInfoCopyWith<$Res> implements $CommentLevelInfoCopyWith<$Res> {
  factory _$CommentLevelInfoCopyWith(_CommentLevelInfo value, $Res Function(_CommentLevelInfo) _then) = __$CommentLevelInfoCopyWithImpl;
@override @useResult
$Res call({
 int current_level, int current_min, int current_exp, int next_exp
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
@override @pragma('vm:prefer-inline') $Res call({Object? current_level = null,Object? current_min = null,Object? current_exp = null,Object? next_exp = null,}) {
  return _then(_CommentLevelInfo(
current_level: null == current_level ? _self.current_level : current_level // ignore: cast_nullable_to_non_nullable
as int,current_min: null == current_min ? _self.current_min : current_min // ignore: cast_nullable_to_non_nullable
as int,current_exp: null == current_exp ? _self.current_exp : current_exp // ignore: cast_nullable_to_non_nullable
as int,next_exp: null == next_exp ? _self.next_exp : next_exp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommentPendant {

 int get pid; String get name; String get image; int get expire; String get image_enhance; String get image_enhance_frame;
/// Create a copy of CommentPendant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentPendantCopyWith<CommentPendant> get copyWith => _$CommentPendantCopyWithImpl<CommentPendant>(this as CommentPendant, _$identity);

  /// Serializes this CommentPendant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentPendant&&(identical(other.pid, pid) || other.pid == pid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.expire, expire) || other.expire == expire)&&(identical(other.image_enhance, image_enhance) || other.image_enhance == image_enhance)&&(identical(other.image_enhance_frame, image_enhance_frame) || other.image_enhance_frame == image_enhance_frame));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pid,name,image,expire,image_enhance,image_enhance_frame);

@override
String toString() {
  return 'CommentPendant(pid: $pid, name: $name, image: $image, expire: $expire, image_enhance: $image_enhance, image_enhance_frame: $image_enhance_frame)';
}


}

/// @nodoc
abstract mixin class $CommentPendantCopyWith<$Res>  {
  factory $CommentPendantCopyWith(CommentPendant value, $Res Function(CommentPendant) _then) = _$CommentPendantCopyWithImpl;
@useResult
$Res call({
 int pid, String name, String image, int expire, String image_enhance, String image_enhance_frame
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
@pragma('vm:prefer-inline') @override $Res call({Object? pid = null,Object? name = null,Object? image = null,Object? expire = null,Object? image_enhance = null,Object? image_enhance_frame = null,}) {
  return _then(_self.copyWith(
pid: null == pid ? _self.pid : pid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,expire: null == expire ? _self.expire : expire // ignore: cast_nullable_to_non_nullable
as int,image_enhance: null == image_enhance ? _self.image_enhance : image_enhance // ignore: cast_nullable_to_non_nullable
as String,image_enhance_frame: null == image_enhance_frame ? _self.image_enhance_frame : image_enhance_frame // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pid,  String name,  String image,  int expire,  String image_enhance,  String image_enhance_frame)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentPendant() when $default != null:
return $default(_that.pid,_that.name,_that.image,_that.expire,_that.image_enhance,_that.image_enhance_frame);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pid,  String name,  String image,  int expire,  String image_enhance,  String image_enhance_frame)  $default,) {final _that = this;
switch (_that) {
case _CommentPendant():
return $default(_that.pid,_that.name,_that.image,_that.expire,_that.image_enhance,_that.image_enhance_frame);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pid,  String name,  String image,  int expire,  String image_enhance,  String image_enhance_frame)?  $default,) {final _that = this;
switch (_that) {
case _CommentPendant() when $default != null:
return $default(_that.pid,_that.name,_that.image,_that.expire,_that.image_enhance,_that.image_enhance_frame);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentPendant implements CommentPendant {
  const _CommentPendant({required this.pid, required this.name, required this.image, required this.expire, this.image_enhance = '', this.image_enhance_frame = ''});
  factory _CommentPendant.fromJson(Map<String, dynamic> json) => _$CommentPendantFromJson(json);

@override final  int pid;
@override final  String name;
@override final  String image;
@override final  int expire;
@override@JsonKey() final  String image_enhance;
@override@JsonKey() final  String image_enhance_frame;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentPendant&&(identical(other.pid, pid) || other.pid == pid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.expire, expire) || other.expire == expire)&&(identical(other.image_enhance, image_enhance) || other.image_enhance == image_enhance)&&(identical(other.image_enhance_frame, image_enhance_frame) || other.image_enhance_frame == image_enhance_frame));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pid,name,image,expire,image_enhance,image_enhance_frame);

@override
String toString() {
  return 'CommentPendant(pid: $pid, name: $name, image: $image, expire: $expire, image_enhance: $image_enhance, image_enhance_frame: $image_enhance_frame)';
}


}

/// @nodoc
abstract mixin class _$CommentPendantCopyWith<$Res> implements $CommentPendantCopyWith<$Res> {
  factory _$CommentPendantCopyWith(_CommentPendant value, $Res Function(_CommentPendant) _then) = __$CommentPendantCopyWithImpl;
@override @useResult
$Res call({
 int pid, String name, String image, int expire, String image_enhance, String image_enhance_frame
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
@override @pragma('vm:prefer-inline') $Res call({Object? pid = null,Object? name = null,Object? image = null,Object? expire = null,Object? image_enhance = null,Object? image_enhance_frame = null,}) {
  return _then(_CommentPendant(
pid: null == pid ? _self.pid : pid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,expire: null == expire ? _self.expire : expire // ignore: cast_nullable_to_non_nullable
as int,image_enhance: null == image_enhance ? _self.image_enhance : image_enhance // ignore: cast_nullable_to_non_nullable
as String,image_enhance_frame: null == image_enhance_frame ? _self.image_enhance_frame : image_enhance_frame // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommentNameplate {

 int get nid; String get name; String get image; String get image_small; String get level; String get condition;
/// Create a copy of CommentNameplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentNameplateCopyWith<CommentNameplate> get copyWith => _$CommentNameplateCopyWithImpl<CommentNameplate>(this as CommentNameplate, _$identity);

  /// Serializes this CommentNameplate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentNameplate&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.image_small, image_small) || other.image_small == image_small)&&(identical(other.level, level) || other.level == level)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nid,name,image,image_small,level,condition);

@override
String toString() {
  return 'CommentNameplate(nid: $nid, name: $name, image: $image, image_small: $image_small, level: $level, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $CommentNameplateCopyWith<$Res>  {
  factory $CommentNameplateCopyWith(CommentNameplate value, $Res Function(CommentNameplate) _then) = _$CommentNameplateCopyWithImpl;
@useResult
$Res call({
 int nid, String name, String image, String image_small, String level, String condition
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
@pragma('vm:prefer-inline') @override $Res call({Object? nid = null,Object? name = null,Object? image = null,Object? image_small = null,Object? level = null,Object? condition = null,}) {
  return _then(_self.copyWith(
nid: null == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,image_small: null == image_small ? _self.image_small : image_small // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int nid,  String name,  String image,  String image_small,  String level,  String condition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentNameplate() when $default != null:
return $default(_that.nid,_that.name,_that.image,_that.image_small,_that.level,_that.condition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int nid,  String name,  String image,  String image_small,  String level,  String condition)  $default,) {final _that = this;
switch (_that) {
case _CommentNameplate():
return $default(_that.nid,_that.name,_that.image,_that.image_small,_that.level,_that.condition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int nid,  String name,  String image,  String image_small,  String level,  String condition)?  $default,) {final _that = this;
switch (_that) {
case _CommentNameplate() when $default != null:
return $default(_that.nid,_that.name,_that.image,_that.image_small,_that.level,_that.condition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentNameplate implements CommentNameplate {
  const _CommentNameplate({required this.nid, required this.name, required this.image, required this.image_small, required this.level, required this.condition});
  factory _CommentNameplate.fromJson(Map<String, dynamic> json) => _$CommentNameplateFromJson(json);

@override final  int nid;
@override final  String name;
@override final  String image;
@override final  String image_small;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentNameplate&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.image_small, image_small) || other.image_small == image_small)&&(identical(other.level, level) || other.level == level)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nid,name,image,image_small,level,condition);

@override
String toString() {
  return 'CommentNameplate(nid: $nid, name: $name, image: $image, image_small: $image_small, level: $level, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$CommentNameplateCopyWith<$Res> implements $CommentNameplateCopyWith<$Res> {
  factory _$CommentNameplateCopyWith(_CommentNameplate value, $Res Function(_CommentNameplate) _then) = __$CommentNameplateCopyWithImpl;
@override @useResult
$Res call({
 int nid, String name, String image, String image_small, String level, String condition
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
@override @pragma('vm:prefer-inline') $Res call({Object? nid = null,Object? name = null,Object? image = null,Object? image_small = null,Object? level = null,Object? condition = null,}) {
  return _then(_CommentNameplate(
nid: null == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,image_small: null == image_small ? _self.image_small : image_small // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommentOfficialVerify {

 int get type; String get desc;
/// Create a copy of CommentOfficialVerify
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentOfficialVerifyCopyWith<CommentOfficialVerify> get copyWith => _$CommentOfficialVerifyCopyWithImpl<CommentOfficialVerify>(this as CommentOfficialVerify, _$identity);

  /// Serializes this CommentOfficialVerify to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentOfficialVerify&&(identical(other.type, type) || other.type == type)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,desc);

@override
String toString() {
  return 'CommentOfficialVerify(type: $type, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $CommentOfficialVerifyCopyWith<$Res>  {
  factory $CommentOfficialVerifyCopyWith(CommentOfficialVerify value, $Res Function(CommentOfficialVerify) _then) = _$CommentOfficialVerifyCopyWithImpl;
@useResult
$Res call({
 int type, String desc
});




}
/// @nodoc
class _$CommentOfficialVerifyCopyWithImpl<$Res>
    implements $CommentOfficialVerifyCopyWith<$Res> {
  _$CommentOfficialVerifyCopyWithImpl(this._self, this._then);

  final CommentOfficialVerify _self;
  final $Res Function(CommentOfficialVerify) _then;

/// Create a copy of CommentOfficialVerify
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? desc = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentOfficialVerify].
extension CommentOfficialVerifyPatterns on CommentOfficialVerify {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentOfficialVerify value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentOfficialVerify() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentOfficialVerify value)  $default,){
final _that = this;
switch (_that) {
case _CommentOfficialVerify():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentOfficialVerify value)?  $default,){
final _that = this;
switch (_that) {
case _CommentOfficialVerify() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int type,  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentOfficialVerify() when $default != null:
return $default(_that.type,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int type,  String desc)  $default,) {final _that = this;
switch (_that) {
case _CommentOfficialVerify():
return $default(_that.type,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int type,  String desc)?  $default,) {final _that = this;
switch (_that) {
case _CommentOfficialVerify() when $default != null:
return $default(_that.type,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentOfficialVerify implements CommentOfficialVerify {
  const _CommentOfficialVerify({this.type = -1, this.desc = ''});
  factory _CommentOfficialVerify.fromJson(Map<String, dynamic> json) => _$CommentOfficialVerifyFromJson(json);

@override@JsonKey() final  int type;
@override@JsonKey() final  String desc;

/// Create a copy of CommentOfficialVerify
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentOfficialVerifyCopyWith<_CommentOfficialVerify> get copyWith => __$CommentOfficialVerifyCopyWithImpl<_CommentOfficialVerify>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentOfficialVerifyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentOfficialVerify&&(identical(other.type, type) || other.type == type)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,desc);

@override
String toString() {
  return 'CommentOfficialVerify(type: $type, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$CommentOfficialVerifyCopyWith<$Res> implements $CommentOfficialVerifyCopyWith<$Res> {
  factory _$CommentOfficialVerifyCopyWith(_CommentOfficialVerify value, $Res Function(_CommentOfficialVerify) _then) = __$CommentOfficialVerifyCopyWithImpl;
@override @useResult
$Res call({
 int type, String desc
});




}
/// @nodoc
class __$CommentOfficialVerifyCopyWithImpl<$Res>
    implements _$CommentOfficialVerifyCopyWith<$Res> {
  __$CommentOfficialVerifyCopyWithImpl(this._self, this._then);

  final _CommentOfficialVerify _self;
  final $Res Function(_CommentOfficialVerify) _then;

/// Create a copy of CommentOfficialVerify
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? desc = null,}) {
  return _then(_CommentOfficialVerify(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
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
return $default(_that.vipType,_that.vipDueDate,_that.dueRemark,_that.accessStatus,_that.vipStatus,_that.vipStatusWarn,_that.themeType,_that.label);case _:
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


/// @nodoc
mixin _$CommentLabel {

 String get path; String get text; String get label_theme; String get text_color; int get bg_style; String get bg_color; String get border_color; bool get use_img_label; String get img_label_uri_hans; String get img_label_uri_hant; String get img_label_uri_hans_static; String get img_label_uri_hant_static;
/// Create a copy of CommentLabel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentLabelCopyWith<CommentLabel> get copyWith => _$CommentLabelCopyWithImpl<CommentLabel>(this as CommentLabel, _$identity);

  /// Serializes this CommentLabel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentLabel&&(identical(other.path, path) || other.path == path)&&(identical(other.text, text) || other.text == text)&&(identical(other.label_theme, label_theme) || other.label_theme == label_theme)&&(identical(other.text_color, text_color) || other.text_color == text_color)&&(identical(other.bg_style, bg_style) || other.bg_style == bg_style)&&(identical(other.bg_color, bg_color) || other.bg_color == bg_color)&&(identical(other.border_color, border_color) || other.border_color == border_color)&&(identical(other.use_img_label, use_img_label) || other.use_img_label == use_img_label)&&(identical(other.img_label_uri_hans, img_label_uri_hans) || other.img_label_uri_hans == img_label_uri_hans)&&(identical(other.img_label_uri_hant, img_label_uri_hant) || other.img_label_uri_hant == img_label_uri_hant)&&(identical(other.img_label_uri_hans_static, img_label_uri_hans_static) || other.img_label_uri_hans_static == img_label_uri_hans_static)&&(identical(other.img_label_uri_hant_static, img_label_uri_hant_static) || other.img_label_uri_hant_static == img_label_uri_hant_static));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,text,label_theme,text_color,bg_style,bg_color,border_color,use_img_label,img_label_uri_hans,img_label_uri_hant,img_label_uri_hans_static,img_label_uri_hant_static);

@override
String toString() {
  return 'CommentLabel(path: $path, text: $text, label_theme: $label_theme, text_color: $text_color, bg_style: $bg_style, bg_color: $bg_color, border_color: $border_color, use_img_label: $use_img_label, img_label_uri_hans: $img_label_uri_hans, img_label_uri_hant: $img_label_uri_hant, img_label_uri_hans_static: $img_label_uri_hans_static, img_label_uri_hant_static: $img_label_uri_hant_static)';
}


}

/// @nodoc
abstract mixin class $CommentLabelCopyWith<$Res>  {
  factory $CommentLabelCopyWith(CommentLabel value, $Res Function(CommentLabel) _then) = _$CommentLabelCopyWithImpl;
@useResult
$Res call({
 String path, String text, String label_theme, String text_color, int bg_style, String bg_color, String border_color, bool use_img_label, String img_label_uri_hans, String img_label_uri_hant, String img_label_uri_hans_static, String img_label_uri_hant_static
});




}
/// @nodoc
class _$CommentLabelCopyWithImpl<$Res>
    implements $CommentLabelCopyWith<$Res> {
  _$CommentLabelCopyWithImpl(this._self, this._then);

  final CommentLabel _self;
  final $Res Function(CommentLabel) _then;

/// Create a copy of CommentLabel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? text = null,Object? label_theme = null,Object? text_color = null,Object? bg_style = null,Object? bg_color = null,Object? border_color = null,Object? use_img_label = null,Object? img_label_uri_hans = null,Object? img_label_uri_hant = null,Object? img_label_uri_hans_static = null,Object? img_label_uri_hant_static = null,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,label_theme: null == label_theme ? _self.label_theme : label_theme // ignore: cast_nullable_to_non_nullable
as String,text_color: null == text_color ? _self.text_color : text_color // ignore: cast_nullable_to_non_nullable
as String,bg_style: null == bg_style ? _self.bg_style : bg_style // ignore: cast_nullable_to_non_nullable
as int,bg_color: null == bg_color ? _self.bg_color : bg_color // ignore: cast_nullable_to_non_nullable
as String,border_color: null == border_color ? _self.border_color : border_color // ignore: cast_nullable_to_non_nullable
as String,use_img_label: null == use_img_label ? _self.use_img_label : use_img_label // ignore: cast_nullable_to_non_nullable
as bool,img_label_uri_hans: null == img_label_uri_hans ? _self.img_label_uri_hans : img_label_uri_hans // ignore: cast_nullable_to_non_nullable
as String,img_label_uri_hant: null == img_label_uri_hant ? _self.img_label_uri_hant : img_label_uri_hant // ignore: cast_nullable_to_non_nullable
as String,img_label_uri_hans_static: null == img_label_uri_hans_static ? _self.img_label_uri_hans_static : img_label_uri_hans_static // ignore: cast_nullable_to_non_nullable
as String,img_label_uri_hant_static: null == img_label_uri_hant_static ? _self.img_label_uri_hant_static : img_label_uri_hant_static // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentLabel].
extension CommentLabelPatterns on CommentLabel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentLabel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentLabel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentLabel value)  $default,){
final _that = this;
switch (_that) {
case _CommentLabel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentLabel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentLabel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String text,  String label_theme,  String text_color,  int bg_style,  String bg_color,  String border_color,  bool use_img_label,  String img_label_uri_hans,  String img_label_uri_hant,  String img_label_uri_hans_static,  String img_label_uri_hant_static)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentLabel() when $default != null:
return $default(_that.path,_that.text,_that.label_theme,_that.text_color,_that.bg_style,_that.bg_color,_that.border_color,_that.use_img_label,_that.img_label_uri_hans,_that.img_label_uri_hant,_that.img_label_uri_hans_static,_that.img_label_uri_hant_static);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String text,  String label_theme,  String text_color,  int bg_style,  String bg_color,  String border_color,  bool use_img_label,  String img_label_uri_hans,  String img_label_uri_hant,  String img_label_uri_hans_static,  String img_label_uri_hant_static)  $default,) {final _that = this;
switch (_that) {
case _CommentLabel():
return $default(_that.path,_that.text,_that.label_theme,_that.text_color,_that.bg_style,_that.bg_color,_that.border_color,_that.use_img_label,_that.img_label_uri_hans,_that.img_label_uri_hant,_that.img_label_uri_hans_static,_that.img_label_uri_hant_static);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String text,  String label_theme,  String text_color,  int bg_style,  String bg_color,  String border_color,  bool use_img_label,  String img_label_uri_hans,  String img_label_uri_hant,  String img_label_uri_hans_static,  String img_label_uri_hant_static)?  $default,) {final _that = this;
switch (_that) {
case _CommentLabel() when $default != null:
return $default(_that.path,_that.text,_that.label_theme,_that.text_color,_that.bg_style,_that.bg_color,_that.border_color,_that.use_img_label,_that.img_label_uri_hans,_that.img_label_uri_hant,_that.img_label_uri_hans_static,_that.img_label_uri_hant_static);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentLabel implements CommentLabel {
  const _CommentLabel({required this.path, required this.text, required this.label_theme, this.text_color = '', this.bg_style = 0, this.bg_color = '', this.border_color = '', this.use_img_label = false, this.img_label_uri_hans = '', this.img_label_uri_hant = '', this.img_label_uri_hans_static = '', this.img_label_uri_hant_static = ''});
  factory _CommentLabel.fromJson(Map<String, dynamic> json) => _$CommentLabelFromJson(json);

@override final  String path;
@override final  String text;
@override final  String label_theme;
@override@JsonKey() final  String text_color;
@override@JsonKey() final  int bg_style;
@override@JsonKey() final  String bg_color;
@override@JsonKey() final  String border_color;
@override@JsonKey() final  bool use_img_label;
@override@JsonKey() final  String img_label_uri_hans;
@override@JsonKey() final  String img_label_uri_hant;
@override@JsonKey() final  String img_label_uri_hans_static;
@override@JsonKey() final  String img_label_uri_hant_static;

/// Create a copy of CommentLabel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentLabelCopyWith<_CommentLabel> get copyWith => __$CommentLabelCopyWithImpl<_CommentLabel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentLabelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentLabel&&(identical(other.path, path) || other.path == path)&&(identical(other.text, text) || other.text == text)&&(identical(other.label_theme, label_theme) || other.label_theme == label_theme)&&(identical(other.text_color, text_color) || other.text_color == text_color)&&(identical(other.bg_style, bg_style) || other.bg_style == bg_style)&&(identical(other.bg_color, bg_color) || other.bg_color == bg_color)&&(identical(other.border_color, border_color) || other.border_color == border_color)&&(identical(other.use_img_label, use_img_label) || other.use_img_label == use_img_label)&&(identical(other.img_label_uri_hans, img_label_uri_hans) || other.img_label_uri_hans == img_label_uri_hans)&&(identical(other.img_label_uri_hant, img_label_uri_hant) || other.img_label_uri_hant == img_label_uri_hant)&&(identical(other.img_label_uri_hans_static, img_label_uri_hans_static) || other.img_label_uri_hans_static == img_label_uri_hans_static)&&(identical(other.img_label_uri_hant_static, img_label_uri_hant_static) || other.img_label_uri_hant_static == img_label_uri_hant_static));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,text,label_theme,text_color,bg_style,bg_color,border_color,use_img_label,img_label_uri_hans,img_label_uri_hant,img_label_uri_hans_static,img_label_uri_hant_static);

@override
String toString() {
  return 'CommentLabel(path: $path, text: $text, label_theme: $label_theme, text_color: $text_color, bg_style: $bg_style, bg_color: $bg_color, border_color: $border_color, use_img_label: $use_img_label, img_label_uri_hans: $img_label_uri_hans, img_label_uri_hant: $img_label_uri_hant, img_label_uri_hans_static: $img_label_uri_hans_static, img_label_uri_hant_static: $img_label_uri_hant_static)';
}


}

/// @nodoc
abstract mixin class _$CommentLabelCopyWith<$Res> implements $CommentLabelCopyWith<$Res> {
  factory _$CommentLabelCopyWith(_CommentLabel value, $Res Function(_CommentLabel) _then) = __$CommentLabelCopyWithImpl;
@override @useResult
$Res call({
 String path, String text, String label_theme, String text_color, int bg_style, String bg_color, String border_color, bool use_img_label, String img_label_uri_hans, String img_label_uri_hant, String img_label_uri_hans_static, String img_label_uri_hant_static
});




}
/// @nodoc
class __$CommentLabelCopyWithImpl<$Res>
    implements _$CommentLabelCopyWith<$Res> {
  __$CommentLabelCopyWithImpl(this._self, this._then);

  final _CommentLabel _self;
  final $Res Function(_CommentLabel) _then;

/// Create a copy of CommentLabel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? text = null,Object? label_theme = null,Object? text_color = null,Object? bg_style = null,Object? bg_color = null,Object? border_color = null,Object? use_img_label = null,Object? img_label_uri_hans = null,Object? img_label_uri_hant = null,Object? img_label_uri_hans_static = null,Object? img_label_uri_hant_static = null,}) {
  return _then(_CommentLabel(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,label_theme: null == label_theme ? _self.label_theme : label_theme // ignore: cast_nullable_to_non_nullable
as String,text_color: null == text_color ? _self.text_color : text_color // ignore: cast_nullable_to_non_nullable
as String,bg_style: null == bg_style ? _self.bg_style : bg_style // ignore: cast_nullable_to_non_nullable
as int,bg_color: null == bg_color ? _self.bg_color : bg_color // ignore: cast_nullable_to_non_nullable
as String,border_color: null == border_color ? _self.border_color : border_color // ignore: cast_nullable_to_non_nullable
as String,use_img_label: null == use_img_label ? _self.use_img_label : use_img_label // ignore: cast_nullable_to_non_nullable
as bool,img_label_uri_hans: null == img_label_uri_hans ? _self.img_label_uri_hans : img_label_uri_hans // ignore: cast_nullable_to_non_nullable
as String,img_label_uri_hant: null == img_label_uri_hant ? _self.img_label_uri_hant : img_label_uri_hant // ignore: cast_nullable_to_non_nullable
as String,img_label_uri_hans_static: null == img_label_uri_hans_static ? _self.img_label_uri_hans_static : img_label_uri_hans_static // ignore: cast_nullable_to_non_nullable
as String,img_label_uri_hant_static: null == img_label_uri_hant_static ? _self.img_label_uri_hant_static : img_label_uri_hant_static // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommentContent {

 String get message; int get plat; String get device; List<CommentMember> get members; Map<String, CommentEmote>? get emote; List<CommentPicture> get pictures; Map<String, dynamic> get jump_url; int get max_line;
/// Create a copy of CommentContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentContentCopyWith<CommentContent> get copyWith => _$CommentContentCopyWithImpl<CommentContent>(this as CommentContent, _$identity);

  /// Serializes this CommentContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentContent&&(identical(other.message, message) || other.message == message)&&(identical(other.plat, plat) || other.plat == plat)&&(identical(other.device, device) || other.device == device)&&const DeepCollectionEquality().equals(other.members, members)&&const DeepCollectionEquality().equals(other.emote, emote)&&const DeepCollectionEquality().equals(other.pictures, pictures)&&const DeepCollectionEquality().equals(other.jump_url, jump_url)&&(identical(other.max_line, max_line) || other.max_line == max_line));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,plat,device,const DeepCollectionEquality().hash(members),const DeepCollectionEquality().hash(emote),const DeepCollectionEquality().hash(pictures),const DeepCollectionEquality().hash(jump_url),max_line);

@override
String toString() {
  return 'CommentContent(message: $message, plat: $plat, device: $device, members: $members, emote: $emote, pictures: $pictures, jump_url: $jump_url, max_line: $max_line)';
}


}

/// @nodoc
abstract mixin class $CommentContentCopyWith<$Res>  {
  factory $CommentContentCopyWith(CommentContent value, $Res Function(CommentContent) _then) = _$CommentContentCopyWithImpl;
@useResult
$Res call({
 String message, int plat, String device, List<CommentMember> members, Map<String, CommentEmote>? emote, List<CommentPicture> pictures, Map<String, dynamic> jump_url, int max_line
});




}
/// @nodoc
class _$CommentContentCopyWithImpl<$Res>
    implements $CommentContentCopyWith<$Res> {
  _$CommentContentCopyWithImpl(this._self, this._then);

  final CommentContent _self;
  final $Res Function(CommentContent) _then;

/// Create a copy of CommentContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? plat = null,Object? device = null,Object? members = null,Object? emote = freezed,Object? pictures = null,Object? jump_url = null,Object? max_line = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,plat: null == plat ? _self.plat : plat // ignore: cast_nullable_to_non_nullable
as int,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<CommentMember>,emote: freezed == emote ? _self.emote : emote // ignore: cast_nullable_to_non_nullable
as Map<String, CommentEmote>?,pictures: null == pictures ? _self.pictures : pictures // ignore: cast_nullable_to_non_nullable
as List<CommentPicture>,jump_url: null == jump_url ? _self.jump_url : jump_url // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,max_line: null == max_line ? _self.max_line : max_line // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentContent].
extension CommentContentPatterns on CommentContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentContent value)  $default,){
final _that = this;
switch (_that) {
case _CommentContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentContent value)?  $default,){
final _that = this;
switch (_that) {
case _CommentContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  int plat,  String device,  List<CommentMember> members,  Map<String, CommentEmote>? emote,  List<CommentPicture> pictures,  Map<String, dynamic> jump_url,  int max_line)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentContent() when $default != null:
return $default(_that.message,_that.plat,_that.device,_that.members,_that.emote,_that.pictures,_that.jump_url,_that.max_line);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  int plat,  String device,  List<CommentMember> members,  Map<String, CommentEmote>? emote,  List<CommentPicture> pictures,  Map<String, dynamic> jump_url,  int max_line)  $default,) {final _that = this;
switch (_that) {
case _CommentContent():
return $default(_that.message,_that.plat,_that.device,_that.members,_that.emote,_that.pictures,_that.jump_url,_that.max_line);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  int plat,  String device,  List<CommentMember> members,  Map<String, CommentEmote>? emote,  List<CommentPicture> pictures,  Map<String, dynamic> jump_url,  int max_line)?  $default,) {final _that = this;
switch (_that) {
case _CommentContent() when $default != null:
return $default(_that.message,_that.plat,_that.device,_that.members,_that.emote,_that.pictures,_that.jump_url,_that.max_line);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentContent implements CommentContent {
  const _CommentContent({required this.message, this.plat = 0, this.device = '', final  List<CommentMember> members = const [], final  Map<String, CommentEmote>? emote, final  List<CommentPicture> pictures = const [], final  Map<String, dynamic> jump_url = const {}, this.max_line = 0}): _members = members,_emote = emote,_pictures = pictures,_jump_url = jump_url;
  factory _CommentContent.fromJson(Map<String, dynamic> json) => _$CommentContentFromJson(json);

@override final  String message;
@override@JsonKey() final  int plat;
@override@JsonKey() final  String device;
 final  List<CommentMember> _members;
@override@JsonKey() List<CommentMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  Map<String, CommentEmote>? _emote;
@override Map<String, CommentEmote>? get emote {
  final value = _emote;
  if (value == null) return null;
  if (_emote is EqualUnmodifiableMapView) return _emote;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<CommentPicture> _pictures;
@override@JsonKey() List<CommentPicture> get pictures {
  if (_pictures is EqualUnmodifiableListView) return _pictures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pictures);
}

 final  Map<String, dynamic> _jump_url;
@override@JsonKey() Map<String, dynamic> get jump_url {
  if (_jump_url is EqualUnmodifiableMapView) return _jump_url;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_jump_url);
}

@override@JsonKey() final  int max_line;

/// Create a copy of CommentContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentContentCopyWith<_CommentContent> get copyWith => __$CommentContentCopyWithImpl<_CommentContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentContent&&(identical(other.message, message) || other.message == message)&&(identical(other.plat, plat) || other.plat == plat)&&(identical(other.device, device) || other.device == device)&&const DeepCollectionEquality().equals(other._members, _members)&&const DeepCollectionEquality().equals(other._emote, _emote)&&const DeepCollectionEquality().equals(other._pictures, _pictures)&&const DeepCollectionEquality().equals(other._jump_url, _jump_url)&&(identical(other.max_line, max_line) || other.max_line == max_line));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,plat,device,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_emote),const DeepCollectionEquality().hash(_pictures),const DeepCollectionEquality().hash(_jump_url),max_line);

@override
String toString() {
  return 'CommentContent(message: $message, plat: $plat, device: $device, members: $members, emote: $emote, pictures: $pictures, jump_url: $jump_url, max_line: $max_line)';
}


}

/// @nodoc
abstract mixin class _$CommentContentCopyWith<$Res> implements $CommentContentCopyWith<$Res> {
  factory _$CommentContentCopyWith(_CommentContent value, $Res Function(_CommentContent) _then) = __$CommentContentCopyWithImpl;
@override @useResult
$Res call({
 String message, int plat, String device, List<CommentMember> members, Map<String, CommentEmote>? emote, List<CommentPicture> pictures, Map<String, dynamic> jump_url, int max_line
});




}
/// @nodoc
class __$CommentContentCopyWithImpl<$Res>
    implements _$CommentContentCopyWith<$Res> {
  __$CommentContentCopyWithImpl(this._self, this._then);

  final _CommentContent _self;
  final $Res Function(_CommentContent) _then;

/// Create a copy of CommentContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? plat = null,Object? device = null,Object? members = null,Object? emote = freezed,Object? pictures = null,Object? jump_url = null,Object? max_line = null,}) {
  return _then(_CommentContent(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,plat: null == plat ? _self.plat : plat // ignore: cast_nullable_to_non_nullable
as int,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<CommentMember>,emote: freezed == emote ? _self._emote : emote // ignore: cast_nullable_to_non_nullable
as Map<String, CommentEmote>?,pictures: null == pictures ? _self._pictures : pictures // ignore: cast_nullable_to_non_nullable
as List<CommentPicture>,jump_url: null == jump_url ? _self._jump_url : jump_url // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,max_line: null == max_line ? _self.max_line : max_line // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommentPicture {

 String get img_src; double get img_width; double get img_height; double get img_size;
/// Create a copy of CommentPicture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentPictureCopyWith<CommentPicture> get copyWith => _$CommentPictureCopyWithImpl<CommentPicture>(this as CommentPicture, _$identity);

  /// Serializes this CommentPicture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentPicture&&(identical(other.img_src, img_src) || other.img_src == img_src)&&(identical(other.img_width, img_width) || other.img_width == img_width)&&(identical(other.img_height, img_height) || other.img_height == img_height)&&(identical(other.img_size, img_size) || other.img_size == img_size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,img_src,img_width,img_height,img_size);

@override
String toString() {
  return 'CommentPicture(img_src: $img_src, img_width: $img_width, img_height: $img_height, img_size: $img_size)';
}


}

/// @nodoc
abstract mixin class $CommentPictureCopyWith<$Res>  {
  factory $CommentPictureCopyWith(CommentPicture value, $Res Function(CommentPicture) _then) = _$CommentPictureCopyWithImpl;
@useResult
$Res call({
 String img_src, double img_width, double img_height, double img_size
});




}
/// @nodoc
class _$CommentPictureCopyWithImpl<$Res>
    implements $CommentPictureCopyWith<$Res> {
  _$CommentPictureCopyWithImpl(this._self, this._then);

  final CommentPicture _self;
  final $Res Function(CommentPicture) _then;

/// Create a copy of CommentPicture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? img_src = null,Object? img_width = null,Object? img_height = null,Object? img_size = null,}) {
  return _then(_self.copyWith(
img_src: null == img_src ? _self.img_src : img_src // ignore: cast_nullable_to_non_nullable
as String,img_width: null == img_width ? _self.img_width : img_width // ignore: cast_nullable_to_non_nullable
as double,img_height: null == img_height ? _self.img_height : img_height // ignore: cast_nullable_to_non_nullable
as double,img_size: null == img_size ? _self.img_size : img_size // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentPicture].
extension CommentPicturePatterns on CommentPicture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentPicture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentPicture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentPicture value)  $default,){
final _that = this;
switch (_that) {
case _CommentPicture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentPicture value)?  $default,){
final _that = this;
switch (_that) {
case _CommentPicture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String img_src,  double img_width,  double img_height,  double img_size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentPicture() when $default != null:
return $default(_that.img_src,_that.img_width,_that.img_height,_that.img_size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String img_src,  double img_width,  double img_height,  double img_size)  $default,) {final _that = this;
switch (_that) {
case _CommentPicture():
return $default(_that.img_src,_that.img_width,_that.img_height,_that.img_size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String img_src,  double img_width,  double img_height,  double img_size)?  $default,) {final _that = this;
switch (_that) {
case _CommentPicture() when $default != null:
return $default(_that.img_src,_that.img_width,_that.img_height,_that.img_size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentPicture implements CommentPicture {
  const _CommentPicture({required this.img_src, this.img_width = 0, this.img_height = 0, this.img_size = 0});
  factory _CommentPicture.fromJson(Map<String, dynamic> json) => _$CommentPictureFromJson(json);

@override final  String img_src;
@override@JsonKey() final  double img_width;
@override@JsonKey() final  double img_height;
@override@JsonKey() final  double img_size;

/// Create a copy of CommentPicture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentPictureCopyWith<_CommentPicture> get copyWith => __$CommentPictureCopyWithImpl<_CommentPicture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentPictureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentPicture&&(identical(other.img_src, img_src) || other.img_src == img_src)&&(identical(other.img_width, img_width) || other.img_width == img_width)&&(identical(other.img_height, img_height) || other.img_height == img_height)&&(identical(other.img_size, img_size) || other.img_size == img_size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,img_src,img_width,img_height,img_size);

@override
String toString() {
  return 'CommentPicture(img_src: $img_src, img_width: $img_width, img_height: $img_height, img_size: $img_size)';
}


}

/// @nodoc
abstract mixin class _$CommentPictureCopyWith<$Res> implements $CommentPictureCopyWith<$Res> {
  factory _$CommentPictureCopyWith(_CommentPicture value, $Res Function(_CommentPicture) _then) = __$CommentPictureCopyWithImpl;
@override @useResult
$Res call({
 String img_src, double img_width, double img_height, double img_size
});




}
/// @nodoc
class __$CommentPictureCopyWithImpl<$Res>
    implements _$CommentPictureCopyWith<$Res> {
  __$CommentPictureCopyWithImpl(this._self, this._then);

  final _CommentPicture _self;
  final $Res Function(_CommentPicture) _then;

/// Create a copy of CommentPicture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? img_src = null,Object? img_width = null,Object? img_height = null,Object? img_size = null,}) {
  return _then(_CommentPicture(
img_src: null == img_src ? _self.img_src : img_src // ignore: cast_nullable_to_non_nullable
as String,img_width: null == img_width ? _self.img_width : img_width // ignore: cast_nullable_to_non_nullable
as double,img_height: null == img_height ? _self.img_height : img_height // ignore: cast_nullable_to_non_nullable
as double,img_size: null == img_size ? _self.img_size : img_size // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CommentEmote {

 int get id; int get package_id; int get state; int get type; int get attr; String get text; String get url; int get mtime; String get jump_title;
/// Create a copy of CommentEmote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentEmoteCopyWith<CommentEmote> get copyWith => _$CommentEmoteCopyWithImpl<CommentEmote>(this as CommentEmote, _$identity);

  /// Serializes this CommentEmote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentEmote&&(identical(other.id, id) || other.id == id)&&(identical(other.package_id, package_id) || other.package_id == package_id)&&(identical(other.state, state) || other.state == state)&&(identical(other.type, type) || other.type == type)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.jump_title, jump_title) || other.jump_title == jump_title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,package_id,state,type,attr,text,url,mtime,jump_title);

@override
String toString() {
  return 'CommentEmote(id: $id, package_id: $package_id, state: $state, type: $type, attr: $attr, text: $text, url: $url, mtime: $mtime, jump_title: $jump_title)';
}


}

/// @nodoc
abstract mixin class $CommentEmoteCopyWith<$Res>  {
  factory $CommentEmoteCopyWith(CommentEmote value, $Res Function(CommentEmote) _then) = _$CommentEmoteCopyWithImpl;
@useResult
$Res call({
 int id, int package_id, int state, int type, int attr, String text, String url, int mtime, String jump_title
});




}
/// @nodoc
class _$CommentEmoteCopyWithImpl<$Res>
    implements $CommentEmoteCopyWith<$Res> {
  _$CommentEmoteCopyWithImpl(this._self, this._then);

  final CommentEmote _self;
  final $Res Function(CommentEmote) _then;

/// Create a copy of CommentEmote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? package_id = null,Object? state = null,Object? type = null,Object? attr = null,Object? text = null,Object? url = null,Object? mtime = null,Object? jump_title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,package_id: null == package_id ? _self.package_id : package_id // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mtime: null == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int,jump_title: null == jump_title ? _self.jump_title : jump_title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentEmote].
extension CommentEmotePatterns on CommentEmote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentEmote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentEmote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentEmote value)  $default,){
final _that = this;
switch (_that) {
case _CommentEmote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentEmote value)?  $default,){
final _that = this;
switch (_that) {
case _CommentEmote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int package_id,  int state,  int type,  int attr,  String text,  String url,  int mtime,  String jump_title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentEmote() when $default != null:
return $default(_that.id,_that.package_id,_that.state,_that.type,_that.attr,_that.text,_that.url,_that.mtime,_that.jump_title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int package_id,  int state,  int type,  int attr,  String text,  String url,  int mtime,  String jump_title)  $default,) {final _that = this;
switch (_that) {
case _CommentEmote():
return $default(_that.id,_that.package_id,_that.state,_that.type,_that.attr,_that.text,_that.url,_that.mtime,_that.jump_title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int package_id,  int state,  int type,  int attr,  String text,  String url,  int mtime,  String jump_title)?  $default,) {final _that = this;
switch (_that) {
case _CommentEmote() when $default != null:
return $default(_that.id,_that.package_id,_that.state,_that.type,_that.attr,_that.text,_that.url,_that.mtime,_that.jump_title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentEmote implements CommentEmote {
  const _CommentEmote({required this.id, this.package_id = 0, this.state = 0, this.type = 0, this.attr = 0, required this.text, required this.url, this.mtime = 0, this.jump_title = ''});
  factory _CommentEmote.fromJson(Map<String, dynamic> json) => _$CommentEmoteFromJson(json);

@override final  int id;
@override@JsonKey() final  int package_id;
@override@JsonKey() final  int state;
@override@JsonKey() final  int type;
@override@JsonKey() final  int attr;
@override final  String text;
@override final  String url;
@override@JsonKey() final  int mtime;
@override@JsonKey() final  String jump_title;

/// Create a copy of CommentEmote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentEmoteCopyWith<_CommentEmote> get copyWith => __$CommentEmoteCopyWithImpl<_CommentEmote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentEmoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentEmote&&(identical(other.id, id) || other.id == id)&&(identical(other.package_id, package_id) || other.package_id == package_id)&&(identical(other.state, state) || other.state == state)&&(identical(other.type, type) || other.type == type)&&(identical(other.attr, attr) || other.attr == attr)&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&(identical(other.mtime, mtime) || other.mtime == mtime)&&(identical(other.jump_title, jump_title) || other.jump_title == jump_title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,package_id,state,type,attr,text,url,mtime,jump_title);

@override
String toString() {
  return 'CommentEmote(id: $id, package_id: $package_id, state: $state, type: $type, attr: $attr, text: $text, url: $url, mtime: $mtime, jump_title: $jump_title)';
}


}

/// @nodoc
abstract mixin class _$CommentEmoteCopyWith<$Res> implements $CommentEmoteCopyWith<$Res> {
  factory _$CommentEmoteCopyWith(_CommentEmote value, $Res Function(_CommentEmote) _then) = __$CommentEmoteCopyWithImpl;
@override @useResult
$Res call({
 int id, int package_id, int state, int type, int attr, String text, String url, int mtime, String jump_title
});




}
/// @nodoc
class __$CommentEmoteCopyWithImpl<$Res>
    implements _$CommentEmoteCopyWith<$Res> {
  __$CommentEmoteCopyWithImpl(this._self, this._then);

  final _CommentEmote _self;
  final $Res Function(_CommentEmote) _then;

/// Create a copy of CommentEmote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? package_id = null,Object? state = null,Object? type = null,Object? attr = null,Object? text = null,Object? url = null,Object? mtime = null,Object? jump_title = null,}) {
  return _then(_CommentEmote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,package_id: null == package_id ? _self.package_id : package_id // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,attr: null == attr ? _self.attr : attr // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mtime: null == mtime ? _self.mtime : mtime // ignore: cast_nullable_to_non_nullable
as int,jump_title: null == jump_title ? _self.jump_title : jump_title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
