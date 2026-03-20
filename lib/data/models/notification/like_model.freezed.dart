// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LikeResponse {

 LikeLatest get latest; LikeTotal get total;
/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeResponseCopyWith<LikeResponse> get copyWith => _$LikeResponseCopyWithImpl<LikeResponse>(this as LikeResponse, _$identity);

  /// Serializes this LikeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeResponse&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latest,total);

@override
String toString() {
  return 'LikeResponse(latest: $latest, total: $total)';
}


}

/// @nodoc
abstract mixin class $LikeResponseCopyWith<$Res>  {
  factory $LikeResponseCopyWith(LikeResponse value, $Res Function(LikeResponse) _then) = _$LikeResponseCopyWithImpl;
@useResult
$Res call({
 LikeLatest latest, LikeTotal total
});


$LikeLatestCopyWith<$Res> get latest;$LikeTotalCopyWith<$Res> get total;

}
/// @nodoc
class _$LikeResponseCopyWithImpl<$Res>
    implements $LikeResponseCopyWith<$Res> {
  _$LikeResponseCopyWithImpl(this._self, this._then);

  final LikeResponse _self;
  final $Res Function(LikeResponse) _then;

/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latest = null,Object? total = null,}) {
  return _then(_self.copyWith(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as LikeLatest,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as LikeTotal,
  ));
}
/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LikeLatestCopyWith<$Res> get latest {
  
  return $LikeLatestCopyWith<$Res>(_self.latest, (value) {
    return _then(_self.copyWith(latest: value));
  });
}/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LikeTotalCopyWith<$Res> get total {
  
  return $LikeTotalCopyWith<$Res>(_self.total, (value) {
    return _then(_self.copyWith(total: value));
  });
}
}


/// Adds pattern-matching-related methods to [LikeResponse].
extension LikeResponsePatterns on LikeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LikeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LikeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LikeResponse value)  $default,){
final _that = this;
switch (_that) {
case _LikeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LikeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LikeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LikeLatest latest,  LikeTotal total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LikeResponse() when $default != null:
return $default(_that.latest,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LikeLatest latest,  LikeTotal total)  $default,) {final _that = this;
switch (_that) {
case _LikeResponse():
return $default(_that.latest,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LikeLatest latest,  LikeTotal total)?  $default,) {final _that = this;
switch (_that) {
case _LikeResponse() when $default != null:
return $default(_that.latest,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LikeResponse implements LikeResponse {
  const _LikeResponse({required this.latest, required this.total});
  factory _LikeResponse.fromJson(Map<String, dynamic> json) => _$LikeResponseFromJson(json);

@override final  LikeLatest latest;
@override final  LikeTotal total;

/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeResponseCopyWith<_LikeResponse> get copyWith => __$LikeResponseCopyWithImpl<_LikeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LikeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeResponse&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latest,total);

@override
String toString() {
  return 'LikeResponse(latest: $latest, total: $total)';
}


}

/// @nodoc
abstract mixin class _$LikeResponseCopyWith<$Res> implements $LikeResponseCopyWith<$Res> {
  factory _$LikeResponseCopyWith(_LikeResponse value, $Res Function(_LikeResponse) _then) = __$LikeResponseCopyWithImpl;
@override @useResult
$Res call({
 LikeLatest latest, LikeTotal total
});


@override $LikeLatestCopyWith<$Res> get latest;@override $LikeTotalCopyWith<$Res> get total;

}
/// @nodoc
class __$LikeResponseCopyWithImpl<$Res>
    implements _$LikeResponseCopyWith<$Res> {
  __$LikeResponseCopyWithImpl(this._self, this._then);

  final _LikeResponse _self;
  final $Res Function(_LikeResponse) _then;

/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latest = null,Object? total = null,}) {
  return _then(_LikeResponse(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as LikeLatest,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as LikeTotal,
  ));
}

/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LikeLatestCopyWith<$Res> get latest {
  
  return $LikeLatestCopyWith<$Res>(_self.latest, (value) {
    return _then(_self.copyWith(latest: value));
  });
}/// Create a copy of LikeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LikeTotalCopyWith<$Res> get total {
  
  return $LikeTotalCopyWith<$Res>(_self.total, (value) {
    return _then(_self.copyWith(total: value));
  });
}
}


/// @nodoc
mixin _$LikeLatest {

 List<ReplyItem> get items;@JsonKey(name: 'last_view_at') int get lastViewAt;
/// Create a copy of LikeLatest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeLatestCopyWith<LikeLatest> get copyWith => _$LikeLatestCopyWithImpl<LikeLatest>(this as LikeLatest, _$identity);

  /// Serializes this LikeLatest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeLatest&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.lastViewAt, lastViewAt) || other.lastViewAt == lastViewAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),lastViewAt);

@override
String toString() {
  return 'LikeLatest(items: $items, lastViewAt: $lastViewAt)';
}


}

/// @nodoc
abstract mixin class $LikeLatestCopyWith<$Res>  {
  factory $LikeLatestCopyWith(LikeLatest value, $Res Function(LikeLatest) _then) = _$LikeLatestCopyWithImpl;
@useResult
$Res call({
 List<ReplyItem> items,@JsonKey(name: 'last_view_at') int lastViewAt
});




}
/// @nodoc
class _$LikeLatestCopyWithImpl<$Res>
    implements $LikeLatestCopyWith<$Res> {
  _$LikeLatestCopyWithImpl(this._self, this._then);

  final LikeLatest _self;
  final $Res Function(LikeLatest) _then;

/// Create a copy of LikeLatest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? lastViewAt = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReplyItem>,lastViewAt: null == lastViewAt ? _self.lastViewAt : lastViewAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LikeLatest].
extension LikeLatestPatterns on LikeLatest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LikeLatest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LikeLatest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LikeLatest value)  $default,){
final _that = this;
switch (_that) {
case _LikeLatest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LikeLatest value)?  $default,){
final _that = this;
switch (_that) {
case _LikeLatest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReplyItem> items, @JsonKey(name: 'last_view_at')  int lastViewAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LikeLatest() when $default != null:
return $default(_that.items,_that.lastViewAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReplyItem> items, @JsonKey(name: 'last_view_at')  int lastViewAt)  $default,) {final _that = this;
switch (_that) {
case _LikeLatest():
return $default(_that.items,_that.lastViewAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReplyItem> items, @JsonKey(name: 'last_view_at')  int lastViewAt)?  $default,) {final _that = this;
switch (_that) {
case _LikeLatest() when $default != null:
return $default(_that.items,_that.lastViewAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LikeLatest implements LikeLatest {
  const _LikeLatest({final  List<ReplyItem> items = const [], @JsonKey(name: 'last_view_at') required this.lastViewAt}): _items = items;
  factory _LikeLatest.fromJson(Map<String, dynamic> json) => _$LikeLatestFromJson(json);

 final  List<ReplyItem> _items;
@override@JsonKey() List<ReplyItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'last_view_at') final  int lastViewAt;

/// Create a copy of LikeLatest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeLatestCopyWith<_LikeLatest> get copyWith => __$LikeLatestCopyWithImpl<_LikeLatest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LikeLatestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeLatest&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.lastViewAt, lastViewAt) || other.lastViewAt == lastViewAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),lastViewAt);

@override
String toString() {
  return 'LikeLatest(items: $items, lastViewAt: $lastViewAt)';
}


}

/// @nodoc
abstract mixin class _$LikeLatestCopyWith<$Res> implements $LikeLatestCopyWith<$Res> {
  factory _$LikeLatestCopyWith(_LikeLatest value, $Res Function(_LikeLatest) _then) = __$LikeLatestCopyWithImpl;
@override @useResult
$Res call({
 List<ReplyItem> items,@JsonKey(name: 'last_view_at') int lastViewAt
});




}
/// @nodoc
class __$LikeLatestCopyWithImpl<$Res>
    implements _$LikeLatestCopyWith<$Res> {
  __$LikeLatestCopyWithImpl(this._self, this._then);

  final _LikeLatest _self;
  final $Res Function(_LikeLatest) _then;

/// Create a copy of LikeLatest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? lastViewAt = null,}) {
  return _then(_LikeLatest(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReplyItem>,lastViewAt: null == lastViewAt ? _self.lastViewAt : lastViewAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LikeTotal {

 ReplyCursor get cursor; List<ReplyItem> get items;
/// Create a copy of LikeTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeTotalCopyWith<LikeTotal> get copyWith => _$LikeTotalCopyWithImpl<LikeTotal>(this as LikeTotal, _$identity);

  /// Serializes this LikeTotal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeTotal&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'LikeTotal(cursor: $cursor, items: $items)';
}


}

/// @nodoc
abstract mixin class $LikeTotalCopyWith<$Res>  {
  factory $LikeTotalCopyWith(LikeTotal value, $Res Function(LikeTotal) _then) = _$LikeTotalCopyWithImpl;
@useResult
$Res call({
 ReplyCursor cursor, List<ReplyItem> items
});


$ReplyCursorCopyWith<$Res> get cursor;

}
/// @nodoc
class _$LikeTotalCopyWithImpl<$Res>
    implements $LikeTotalCopyWith<$Res> {
  _$LikeTotalCopyWithImpl(this._self, this._then);

  final LikeTotal _self;
  final $Res Function(LikeTotal) _then;

/// Create a copy of LikeTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursor = null,Object? items = null,}) {
  return _then(_self.copyWith(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as ReplyCursor,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReplyItem>,
  ));
}
/// Create a copy of LikeTotal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyCursorCopyWith<$Res> get cursor {
  
  return $ReplyCursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}


/// Adds pattern-matching-related methods to [LikeTotal].
extension LikeTotalPatterns on LikeTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LikeTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LikeTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LikeTotal value)  $default,){
final _that = this;
switch (_that) {
case _LikeTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LikeTotal value)?  $default,){
final _that = this;
switch (_that) {
case _LikeTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReplyCursor cursor,  List<ReplyItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LikeTotal() when $default != null:
return $default(_that.cursor,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReplyCursor cursor,  List<ReplyItem> items)  $default,) {final _that = this;
switch (_that) {
case _LikeTotal():
return $default(_that.cursor,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReplyCursor cursor,  List<ReplyItem> items)?  $default,) {final _that = this;
switch (_that) {
case _LikeTotal() when $default != null:
return $default(_that.cursor,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LikeTotal implements LikeTotal {
  const _LikeTotal({required this.cursor, final  List<ReplyItem> items = const []}): _items = items;
  factory _LikeTotal.fromJson(Map<String, dynamic> json) => _$LikeTotalFromJson(json);

@override final  ReplyCursor cursor;
 final  List<ReplyItem> _items;
@override@JsonKey() List<ReplyItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of LikeTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeTotalCopyWith<_LikeTotal> get copyWith => __$LikeTotalCopyWithImpl<_LikeTotal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LikeTotalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeTotal&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'LikeTotal(cursor: $cursor, items: $items)';
}


}

/// @nodoc
abstract mixin class _$LikeTotalCopyWith<$Res> implements $LikeTotalCopyWith<$Res> {
  factory _$LikeTotalCopyWith(_LikeTotal value, $Res Function(_LikeTotal) _then) = __$LikeTotalCopyWithImpl;
@override @useResult
$Res call({
 ReplyCursor cursor, List<ReplyItem> items
});


@override $ReplyCursorCopyWith<$Res> get cursor;

}
/// @nodoc
class __$LikeTotalCopyWithImpl<$Res>
    implements _$LikeTotalCopyWith<$Res> {
  __$LikeTotalCopyWithImpl(this._self, this._then);

  final _LikeTotal _self;
  final $Res Function(_LikeTotal) _then;

/// Create a copy of LikeTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cursor = null,Object? items = null,}) {
  return _then(_LikeTotal(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as ReplyCursor,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReplyItem>,
  ));
}

/// Create a copy of LikeTotal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyCursorCopyWith<$Res> get cursor {
  
  return $ReplyCursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}

// dart format on
