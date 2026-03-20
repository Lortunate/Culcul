// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplyResponse {

 ReplyCursor get cursor; List<ReplyItem> get items;@JsonKey(name: 'last_view_at') int get lastViewAt;
/// Create a copy of ReplyResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyResponseCopyWith<ReplyResponse> get copyWith => _$ReplyResponseCopyWithImpl<ReplyResponse>(this as ReplyResponse, _$identity);

  /// Serializes this ReplyResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyResponse&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.lastViewAt, lastViewAt) || other.lastViewAt == lastViewAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(items),lastViewAt);

@override
String toString() {
  return 'ReplyResponse(cursor: $cursor, items: $items, lastViewAt: $lastViewAt)';
}


}

/// @nodoc
abstract mixin class $ReplyResponseCopyWith<$Res>  {
  factory $ReplyResponseCopyWith(ReplyResponse value, $Res Function(ReplyResponse) _then) = _$ReplyResponseCopyWithImpl;
@useResult
$Res call({
 ReplyCursor cursor, List<ReplyItem> items,@JsonKey(name: 'last_view_at') int lastViewAt
});


$ReplyCursorCopyWith<$Res> get cursor;

}
/// @nodoc
class _$ReplyResponseCopyWithImpl<$Res>
    implements $ReplyResponseCopyWith<$Res> {
  _$ReplyResponseCopyWithImpl(this._self, this._then);

  final ReplyResponse _self;
  final $Res Function(ReplyResponse) _then;

/// Create a copy of ReplyResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursor = null,Object? items = null,Object? lastViewAt = null,}) {
  return _then(_self.copyWith(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as ReplyCursor,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReplyItem>,lastViewAt: null == lastViewAt ? _self.lastViewAt : lastViewAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ReplyResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyCursorCopyWith<$Res> get cursor {
  
  return $ReplyCursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReplyResponse].
extension ReplyResponsePatterns on ReplyResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyResponse value)  $default,){
final _that = this;
switch (_that) {
case _ReplyResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReplyCursor cursor,  List<ReplyItem> items, @JsonKey(name: 'last_view_at')  int lastViewAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyResponse() when $default != null:
return $default(_that.cursor,_that.items,_that.lastViewAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReplyCursor cursor,  List<ReplyItem> items, @JsonKey(name: 'last_view_at')  int lastViewAt)  $default,) {final _that = this;
switch (_that) {
case _ReplyResponse():
return $default(_that.cursor,_that.items,_that.lastViewAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReplyCursor cursor,  List<ReplyItem> items, @JsonKey(name: 'last_view_at')  int lastViewAt)?  $default,) {final _that = this;
switch (_that) {
case _ReplyResponse() when $default != null:
return $default(_that.cursor,_that.items,_that.lastViewAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyResponse implements ReplyResponse {
  const _ReplyResponse({required this.cursor, final  List<ReplyItem> items = const [], @JsonKey(name: 'last_view_at') this.lastViewAt = 0}): _items = items;
  factory _ReplyResponse.fromJson(Map<String, dynamic> json) => _$ReplyResponseFromJson(json);

@override final  ReplyCursor cursor;
 final  List<ReplyItem> _items;
@override@JsonKey() List<ReplyItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'last_view_at') final  int lastViewAt;

/// Create a copy of ReplyResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyResponseCopyWith<_ReplyResponse> get copyWith => __$ReplyResponseCopyWithImpl<_ReplyResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyResponse&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.lastViewAt, lastViewAt) || other.lastViewAt == lastViewAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(_items),lastViewAt);

@override
String toString() {
  return 'ReplyResponse(cursor: $cursor, items: $items, lastViewAt: $lastViewAt)';
}


}

/// @nodoc
abstract mixin class _$ReplyResponseCopyWith<$Res> implements $ReplyResponseCopyWith<$Res> {
  factory _$ReplyResponseCopyWith(_ReplyResponse value, $Res Function(_ReplyResponse) _then) = __$ReplyResponseCopyWithImpl;
@override @useResult
$Res call({
 ReplyCursor cursor, List<ReplyItem> items,@JsonKey(name: 'last_view_at') int lastViewAt
});


@override $ReplyCursorCopyWith<$Res> get cursor;

}
/// @nodoc
class __$ReplyResponseCopyWithImpl<$Res>
    implements _$ReplyResponseCopyWith<$Res> {
  __$ReplyResponseCopyWithImpl(this._self, this._then);

  final _ReplyResponse _self;
  final $Res Function(_ReplyResponse) _then;

/// Create a copy of ReplyResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cursor = null,Object? items = null,Object? lastViewAt = null,}) {
  return _then(_ReplyResponse(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as ReplyCursor,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReplyItem>,lastViewAt: null == lastViewAt ? _self.lastViewAt : lastViewAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ReplyResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyCursorCopyWith<$Res> get cursor {
  
  return $ReplyCursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}


/// @nodoc
mixin _$ReplyCursor {

@JsonKey(name: 'is_end') bool get isEnd; int get id; int get time;
/// Create a copy of ReplyCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyCursorCopyWith<ReplyCursor> get copyWith => _$ReplyCursorCopyWithImpl<ReplyCursor>(this as ReplyCursor, _$identity);

  /// Serializes this ReplyCursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyCursor&&(identical(other.isEnd, isEnd) || other.isEnd == isEnd)&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isEnd,id,time);

@override
String toString() {
  return 'ReplyCursor(isEnd: $isEnd, id: $id, time: $time)';
}


}

/// @nodoc
abstract mixin class $ReplyCursorCopyWith<$Res>  {
  factory $ReplyCursorCopyWith(ReplyCursor value, $Res Function(ReplyCursor) _then) = _$ReplyCursorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_end') bool isEnd, int id, int time
});




}
/// @nodoc
class _$ReplyCursorCopyWithImpl<$Res>
    implements $ReplyCursorCopyWith<$Res> {
  _$ReplyCursorCopyWithImpl(this._self, this._then);

  final ReplyCursor _self;
  final $Res Function(ReplyCursor) _then;

/// Create a copy of ReplyCursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnd = null,Object? id = null,Object? time = null,}) {
  return _then(_self.copyWith(
isEnd: null == isEnd ? _self.isEnd : isEnd // ignore: cast_nullable_to_non_nullable
as bool,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyCursor].
extension ReplyCursorPatterns on ReplyCursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyCursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyCursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyCursor value)  $default,){
final _that = this;
switch (_that) {
case _ReplyCursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyCursor value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyCursor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_end')  bool isEnd,  int id,  int time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyCursor() when $default != null:
return $default(_that.isEnd,_that.id,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_end')  bool isEnd,  int id,  int time)  $default,) {final _that = this;
switch (_that) {
case _ReplyCursor():
return $default(_that.isEnd,_that.id,_that.time);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_end')  bool isEnd,  int id,  int time)?  $default,) {final _that = this;
switch (_that) {
case _ReplyCursor() when $default != null:
return $default(_that.isEnd,_that.id,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyCursor implements ReplyCursor {
  const _ReplyCursor({@JsonKey(name: 'is_end') required this.isEnd, required this.id, required this.time});
  factory _ReplyCursor.fromJson(Map<String, dynamic> json) => _$ReplyCursorFromJson(json);

@override@JsonKey(name: 'is_end') final  bool isEnd;
@override final  int id;
@override final  int time;

/// Create a copy of ReplyCursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyCursorCopyWith<_ReplyCursor> get copyWith => __$ReplyCursorCopyWithImpl<_ReplyCursor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyCursorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyCursor&&(identical(other.isEnd, isEnd) || other.isEnd == isEnd)&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isEnd,id,time);

@override
String toString() {
  return 'ReplyCursor(isEnd: $isEnd, id: $id, time: $time)';
}


}

/// @nodoc
abstract mixin class _$ReplyCursorCopyWith<$Res> implements $ReplyCursorCopyWith<$Res> {
  factory _$ReplyCursorCopyWith(_ReplyCursor value, $Res Function(_ReplyCursor) _then) = __$ReplyCursorCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_end') bool isEnd, int id, int time
});




}
/// @nodoc
class __$ReplyCursorCopyWithImpl<$Res>
    implements _$ReplyCursorCopyWith<$Res> {
  __$ReplyCursorCopyWithImpl(this._self, this._then);

  final _ReplyCursor _self;
  final $Res Function(_ReplyCursor) _then;

/// Create a copy of ReplyCursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnd = null,Object? id = null,Object? time = null,}) {
  return _then(_ReplyCursor(
isEnd: null == isEnd ? _self.isEnd : isEnd // ignore: cast_nullable_to_non_nullable
as bool,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReplyItem {

 int get id;@JsonKey(name: 'users') List<ReplyUser>? get users;// Like API returns 'users' array
@JsonKey(name: 'user') ReplyUser? get user;// Reply/At API returns single 'user'
 ReplyItemDetail get item; int get counts;@JsonKey(name: 'is_multi') int get isMulti;@JsonKey(name: 'reply_time') int? get replyTime;// Reply/At API has this
@JsonKey(name: 'like_time') int? get likeTime;
/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyItemCopyWith<ReplyItem> get copyWith => _$ReplyItemCopyWithImpl<ReplyItem>(this as ReplyItem, _$identity);

  /// Serializes this ReplyItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.user, user) || other.user == user)&&(identical(other.item, item) || other.item == item)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.isMulti, isMulti) || other.isMulti == isMulti)&&(identical(other.replyTime, replyTime) || other.replyTime == replyTime)&&(identical(other.likeTime, likeTime) || other.likeTime == likeTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(users),user,item,counts,isMulti,replyTime,likeTime);

@override
String toString() {
  return 'ReplyItem(id: $id, users: $users, user: $user, item: $item, counts: $counts, isMulti: $isMulti, replyTime: $replyTime, likeTime: $likeTime)';
}


}

/// @nodoc
abstract mixin class $ReplyItemCopyWith<$Res>  {
  factory $ReplyItemCopyWith(ReplyItem value, $Res Function(ReplyItem) _then) = _$ReplyItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'users') List<ReplyUser>? users,@JsonKey(name: 'user') ReplyUser? user, ReplyItemDetail item, int counts,@JsonKey(name: 'is_multi') int isMulti,@JsonKey(name: 'reply_time') int? replyTime,@JsonKey(name: 'like_time') int? likeTime
});


$ReplyUserCopyWith<$Res>? get user;$ReplyItemDetailCopyWith<$Res> get item;

}
/// @nodoc
class _$ReplyItemCopyWithImpl<$Res>
    implements $ReplyItemCopyWith<$Res> {
  _$ReplyItemCopyWithImpl(this._self, this._then);

  final ReplyItem _self;
  final $Res Function(ReplyItem) _then;

/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? users = freezed,Object? user = freezed,Object? item = null,Object? counts = null,Object? isMulti = null,Object? replyTime = freezed,Object? likeTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,users: freezed == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<ReplyUser>?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ReplyUser?,item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ReplyItemDetail,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as int,isMulti: null == isMulti ? _self.isMulti : isMulti // ignore: cast_nullable_to_non_nullable
as int,replyTime: freezed == replyTime ? _self.replyTime : replyTime // ignore: cast_nullable_to_non_nullable
as int?,likeTime: freezed == likeTime ? _self.likeTime : likeTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ReplyUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyItemDetailCopyWith<$Res> get item {
  
  return $ReplyItemDetailCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReplyItem].
extension ReplyItemPatterns on ReplyItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyItem value)  $default,){
final _that = this;
switch (_that) {
case _ReplyItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyItem value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'users')  List<ReplyUser>? users, @JsonKey(name: 'user')  ReplyUser? user,  ReplyItemDetail item,  int counts, @JsonKey(name: 'is_multi')  int isMulti, @JsonKey(name: 'reply_time')  int? replyTime, @JsonKey(name: 'like_time')  int? likeTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyItem() when $default != null:
return $default(_that.id,_that.users,_that.user,_that.item,_that.counts,_that.isMulti,_that.replyTime,_that.likeTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'users')  List<ReplyUser>? users, @JsonKey(name: 'user')  ReplyUser? user,  ReplyItemDetail item,  int counts, @JsonKey(name: 'is_multi')  int isMulti, @JsonKey(name: 'reply_time')  int? replyTime, @JsonKey(name: 'like_time')  int? likeTime)  $default,) {final _that = this;
switch (_that) {
case _ReplyItem():
return $default(_that.id,_that.users,_that.user,_that.item,_that.counts,_that.isMulti,_that.replyTime,_that.likeTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'users')  List<ReplyUser>? users, @JsonKey(name: 'user')  ReplyUser? user,  ReplyItemDetail item,  int counts, @JsonKey(name: 'is_multi')  int isMulti, @JsonKey(name: 'reply_time')  int? replyTime, @JsonKey(name: 'like_time')  int? likeTime)?  $default,) {final _that = this;
switch (_that) {
case _ReplyItem() when $default != null:
return $default(_that.id,_that.users,_that.user,_that.item,_that.counts,_that.isMulti,_that.replyTime,_that.likeTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyItem implements ReplyItem {
  const _ReplyItem({required this.id, @JsonKey(name: 'users') final  List<ReplyUser>? users, @JsonKey(name: 'user') this.user, required this.item, this.counts = 1, @JsonKey(name: 'is_multi') this.isMulti = 0, @JsonKey(name: 'reply_time') this.replyTime, @JsonKey(name: 'like_time') this.likeTime}): _users = users;
  factory _ReplyItem.fromJson(Map<String, dynamic> json) => _$ReplyItemFromJson(json);

@override final  int id;
 final  List<ReplyUser>? _users;
@override@JsonKey(name: 'users') List<ReplyUser>? get users {
  final value = _users;
  if (value == null) return null;
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// Like API returns 'users' array
@override@JsonKey(name: 'user') final  ReplyUser? user;
// Reply/At API returns single 'user'
@override final  ReplyItemDetail item;
@override@JsonKey() final  int counts;
@override@JsonKey(name: 'is_multi') final  int isMulti;
@override@JsonKey(name: 'reply_time') final  int? replyTime;
// Reply/At API has this
@override@JsonKey(name: 'like_time') final  int? likeTime;

/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyItemCopyWith<_ReplyItem> get copyWith => __$ReplyItemCopyWithImpl<_ReplyItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.user, user) || other.user == user)&&(identical(other.item, item) || other.item == item)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.isMulti, isMulti) || other.isMulti == isMulti)&&(identical(other.replyTime, replyTime) || other.replyTime == replyTime)&&(identical(other.likeTime, likeTime) || other.likeTime == likeTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_users),user,item,counts,isMulti,replyTime,likeTime);

@override
String toString() {
  return 'ReplyItem(id: $id, users: $users, user: $user, item: $item, counts: $counts, isMulti: $isMulti, replyTime: $replyTime, likeTime: $likeTime)';
}


}

/// @nodoc
abstract mixin class _$ReplyItemCopyWith<$Res> implements $ReplyItemCopyWith<$Res> {
  factory _$ReplyItemCopyWith(_ReplyItem value, $Res Function(_ReplyItem) _then) = __$ReplyItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'users') List<ReplyUser>? users,@JsonKey(name: 'user') ReplyUser? user, ReplyItemDetail item, int counts,@JsonKey(name: 'is_multi') int isMulti,@JsonKey(name: 'reply_time') int? replyTime,@JsonKey(name: 'like_time') int? likeTime
});


@override $ReplyUserCopyWith<$Res>? get user;@override $ReplyItemDetailCopyWith<$Res> get item;

}
/// @nodoc
class __$ReplyItemCopyWithImpl<$Res>
    implements _$ReplyItemCopyWith<$Res> {
  __$ReplyItemCopyWithImpl(this._self, this._then);

  final _ReplyItem _self;
  final $Res Function(_ReplyItem) _then;

/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? users = freezed,Object? user = freezed,Object? item = null,Object? counts = null,Object? isMulti = null,Object? replyTime = freezed,Object? likeTime = freezed,}) {
  return _then(_ReplyItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,users: freezed == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<ReplyUser>?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ReplyUser?,item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ReplyItemDetail,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as int,isMulti: null == isMulti ? _self.isMulti : isMulti // ignore: cast_nullable_to_non_nullable
as int,replyTime: freezed == replyTime ? _self.replyTime : replyTime // ignore: cast_nullable_to_non_nullable
as int?,likeTime: freezed == likeTime ? _self.likeTime : likeTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ReplyUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of ReplyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyItemDetailCopyWith<$Res> get item {
  
  return $ReplyItemDetailCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// @nodoc
mixin _$ReplyUser {

 int get mid; int get fans; String get nickname; String get avatar;@JsonKey(name: 'mid_link') String get midLink; bool get follow;
/// Create a copy of ReplyUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyUserCopyWith<ReplyUser> get copyWith => _$ReplyUserCopyWithImpl<ReplyUser>(this as ReplyUser, _$identity);

  /// Serializes this ReplyUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyUser&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.fans, fans) || other.fans == fans)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.midLink, midLink) || other.midLink == midLink)&&(identical(other.follow, follow) || other.follow == follow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,fans,nickname,avatar,midLink,follow);

@override
String toString() {
  return 'ReplyUser(mid: $mid, fans: $fans, nickname: $nickname, avatar: $avatar, midLink: $midLink, follow: $follow)';
}


}

/// @nodoc
abstract mixin class $ReplyUserCopyWith<$Res>  {
  factory $ReplyUserCopyWith(ReplyUser value, $Res Function(ReplyUser) _then) = _$ReplyUserCopyWithImpl;
@useResult
$Res call({
 int mid, int fans, String nickname, String avatar,@JsonKey(name: 'mid_link') String midLink, bool follow
});




}
/// @nodoc
class _$ReplyUserCopyWithImpl<$Res>
    implements $ReplyUserCopyWith<$Res> {
  _$ReplyUserCopyWithImpl(this._self, this._then);

  final ReplyUser _self;
  final $Res Function(ReplyUser) _then;

/// Create a copy of ReplyUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = null,Object? fans = null,Object? nickname = null,Object? avatar = null,Object? midLink = null,Object? follow = null,}) {
  return _then(_self.copyWith(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,fans: null == fans ? _self.fans : fans // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,midLink: null == midLink ? _self.midLink : midLink // ignore: cast_nullable_to_non_nullable
as String,follow: null == follow ? _self.follow : follow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyUser].
extension ReplyUserPatterns on ReplyUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyUser value)  $default,){
final _that = this;
switch (_that) {
case _ReplyUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyUser value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mid,  int fans,  String nickname,  String avatar, @JsonKey(name: 'mid_link')  String midLink,  bool follow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyUser() when $default != null:
return $default(_that.mid,_that.fans,_that.nickname,_that.avatar,_that.midLink,_that.follow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mid,  int fans,  String nickname,  String avatar, @JsonKey(name: 'mid_link')  String midLink,  bool follow)  $default,) {final _that = this;
switch (_that) {
case _ReplyUser():
return $default(_that.mid,_that.fans,_that.nickname,_that.avatar,_that.midLink,_that.follow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mid,  int fans,  String nickname,  String avatar, @JsonKey(name: 'mid_link')  String midLink,  bool follow)?  $default,) {final _that = this;
switch (_that) {
case _ReplyUser() when $default != null:
return $default(_that.mid,_that.fans,_that.nickname,_that.avatar,_that.midLink,_that.follow);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyUser implements ReplyUser {
  const _ReplyUser({required this.mid, this.fans = 0, required this.nickname, required this.avatar, @JsonKey(name: 'mid_link') this.midLink = '', this.follow = false});
  factory _ReplyUser.fromJson(Map<String, dynamic> json) => _$ReplyUserFromJson(json);

@override final  int mid;
@override@JsonKey() final  int fans;
@override final  String nickname;
@override final  String avatar;
@override@JsonKey(name: 'mid_link') final  String midLink;
@override@JsonKey() final  bool follow;

/// Create a copy of ReplyUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyUserCopyWith<_ReplyUser> get copyWith => __$ReplyUserCopyWithImpl<_ReplyUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyUser&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.fans, fans) || other.fans == fans)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.midLink, midLink) || other.midLink == midLink)&&(identical(other.follow, follow) || other.follow == follow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,fans,nickname,avatar,midLink,follow);

@override
String toString() {
  return 'ReplyUser(mid: $mid, fans: $fans, nickname: $nickname, avatar: $avatar, midLink: $midLink, follow: $follow)';
}


}

/// @nodoc
abstract mixin class _$ReplyUserCopyWith<$Res> implements $ReplyUserCopyWith<$Res> {
  factory _$ReplyUserCopyWith(_ReplyUser value, $Res Function(_ReplyUser) _then) = __$ReplyUserCopyWithImpl;
@override @useResult
$Res call({
 int mid, int fans, String nickname, String avatar,@JsonKey(name: 'mid_link') String midLink, bool follow
});




}
/// @nodoc
class __$ReplyUserCopyWithImpl<$Res>
    implements _$ReplyUserCopyWith<$Res> {
  __$ReplyUserCopyWithImpl(this._self, this._then);

  final _ReplyUser _self;
  final $Res Function(_ReplyUser) _then;

/// Create a copy of ReplyUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = null,Object? fans = null,Object? nickname = null,Object? avatar = null,Object? midLink = null,Object? follow = null,}) {
  return _then(_ReplyUser(
mid: null == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as int,fans: null == fans ? _self.fans : fans // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,midLink: null == midLink ? _self.midLink : midLink // ignore: cast_nullable_to_non_nullable
as String,follow: null == follow ? _self.follow : follow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReplyItemDetail {

@JsonKey(name: 'subject_id', readValue: _readSubjectId) int get subjectId;@JsonKey(name: 'root_id') int get rootId;@JsonKey(name: 'source_id') int get sourceId;@JsonKey(name: 'target_id') int get targetId; String get type;@JsonKey(name: 'business_id') int get businessId; String get business; String get title; String get desc; String get image; String get uri;@JsonKey(name: 'native_uri') String get nativeUri;@JsonKey(name: 'root_reply_content') String get rootReplyContent;@JsonKey(name: 'source_content') String get sourceContent;@JsonKey(name: 'target_reply_content') String get targetReplyContent;@JsonKey(name: 'at_details') List<ReplyUser> get atDetails;@JsonKey(name: 'hide_reply_button') bool get hideReplyButton;@JsonKey(name: 'hide_like_button') bool get hideLikeButton;@JsonKey(name: 'like_state') int get likeState; String get message;
/// Create a copy of ReplyItemDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyItemDetailCopyWith<ReplyItemDetail> get copyWith => _$ReplyItemDetailCopyWithImpl<ReplyItemDetail>(this as ReplyItemDetail, _$identity);

  /// Serializes this ReplyItemDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyItemDetail&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.rootId, rootId) || other.rootId == rootId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.type, type) || other.type == type)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.business, business) || other.business == business)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.image, image) || other.image == image)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.nativeUri, nativeUri) || other.nativeUri == nativeUri)&&(identical(other.rootReplyContent, rootReplyContent) || other.rootReplyContent == rootReplyContent)&&(identical(other.sourceContent, sourceContent) || other.sourceContent == sourceContent)&&(identical(other.targetReplyContent, targetReplyContent) || other.targetReplyContent == targetReplyContent)&&const DeepCollectionEquality().equals(other.atDetails, atDetails)&&(identical(other.hideReplyButton, hideReplyButton) || other.hideReplyButton == hideReplyButton)&&(identical(other.hideLikeButton, hideLikeButton) || other.hideLikeButton == hideLikeButton)&&(identical(other.likeState, likeState) || other.likeState == likeState)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,subjectId,rootId,sourceId,targetId,type,businessId,business,title,desc,image,uri,nativeUri,rootReplyContent,sourceContent,targetReplyContent,const DeepCollectionEquality().hash(atDetails),hideReplyButton,hideLikeButton,likeState,message]);

@override
String toString() {
  return 'ReplyItemDetail(subjectId: $subjectId, rootId: $rootId, sourceId: $sourceId, targetId: $targetId, type: $type, businessId: $businessId, business: $business, title: $title, desc: $desc, image: $image, uri: $uri, nativeUri: $nativeUri, rootReplyContent: $rootReplyContent, sourceContent: $sourceContent, targetReplyContent: $targetReplyContent, atDetails: $atDetails, hideReplyButton: $hideReplyButton, hideLikeButton: $hideLikeButton, likeState: $likeState, message: $message)';
}


}

/// @nodoc
abstract mixin class $ReplyItemDetailCopyWith<$Res>  {
  factory $ReplyItemDetailCopyWith(ReplyItemDetail value, $Res Function(ReplyItemDetail) _then) = _$ReplyItemDetailCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subject_id', readValue: _readSubjectId) int subjectId,@JsonKey(name: 'root_id') int rootId,@JsonKey(name: 'source_id') int sourceId,@JsonKey(name: 'target_id') int targetId, String type,@JsonKey(name: 'business_id') int businessId, String business, String title, String desc, String image, String uri,@JsonKey(name: 'native_uri') String nativeUri,@JsonKey(name: 'root_reply_content') String rootReplyContent,@JsonKey(name: 'source_content') String sourceContent,@JsonKey(name: 'target_reply_content') String targetReplyContent,@JsonKey(name: 'at_details') List<ReplyUser> atDetails,@JsonKey(name: 'hide_reply_button') bool hideReplyButton,@JsonKey(name: 'hide_like_button') bool hideLikeButton,@JsonKey(name: 'like_state') int likeState, String message
});




}
/// @nodoc
class _$ReplyItemDetailCopyWithImpl<$Res>
    implements $ReplyItemDetailCopyWith<$Res> {
  _$ReplyItemDetailCopyWithImpl(this._self, this._then);

  final ReplyItemDetail _self;
  final $Res Function(ReplyItemDetail) _then;

/// Create a copy of ReplyItemDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectId = null,Object? rootId = null,Object? sourceId = null,Object? targetId = null,Object? type = null,Object? businessId = null,Object? business = null,Object? title = null,Object? desc = null,Object? image = null,Object? uri = null,Object? nativeUri = null,Object? rootReplyContent = null,Object? sourceContent = null,Object? targetReplyContent = null,Object? atDetails = null,Object? hideReplyButton = null,Object? hideLikeButton = null,Object? likeState = null,Object? message = null,}) {
  return _then(_self.copyWith(
subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int,rootId: null == rootId ? _self.rootId : rootId // ignore: cast_nullable_to_non_nullable
as int,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as int,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as int,business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,nativeUri: null == nativeUri ? _self.nativeUri : nativeUri // ignore: cast_nullable_to_non_nullable
as String,rootReplyContent: null == rootReplyContent ? _self.rootReplyContent : rootReplyContent // ignore: cast_nullable_to_non_nullable
as String,sourceContent: null == sourceContent ? _self.sourceContent : sourceContent // ignore: cast_nullable_to_non_nullable
as String,targetReplyContent: null == targetReplyContent ? _self.targetReplyContent : targetReplyContent // ignore: cast_nullable_to_non_nullable
as String,atDetails: null == atDetails ? _self.atDetails : atDetails // ignore: cast_nullable_to_non_nullable
as List<ReplyUser>,hideReplyButton: null == hideReplyButton ? _self.hideReplyButton : hideReplyButton // ignore: cast_nullable_to_non_nullable
as bool,hideLikeButton: null == hideLikeButton ? _self.hideLikeButton : hideLikeButton // ignore: cast_nullable_to_non_nullable
as bool,likeState: null == likeState ? _self.likeState : likeState // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyItemDetail].
extension ReplyItemDetailPatterns on ReplyItemDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyItemDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyItemDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyItemDetail value)  $default,){
final _that = this;
switch (_that) {
case _ReplyItemDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyItemDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyItemDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'subject_id', readValue: _readSubjectId)  int subjectId, @JsonKey(name: 'root_id')  int rootId, @JsonKey(name: 'source_id')  int sourceId, @JsonKey(name: 'target_id')  int targetId,  String type, @JsonKey(name: 'business_id')  int businessId,  String business,  String title,  String desc,  String image,  String uri, @JsonKey(name: 'native_uri')  String nativeUri, @JsonKey(name: 'root_reply_content')  String rootReplyContent, @JsonKey(name: 'source_content')  String sourceContent, @JsonKey(name: 'target_reply_content')  String targetReplyContent, @JsonKey(name: 'at_details')  List<ReplyUser> atDetails, @JsonKey(name: 'hide_reply_button')  bool hideReplyButton, @JsonKey(name: 'hide_like_button')  bool hideLikeButton, @JsonKey(name: 'like_state')  int likeState,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyItemDetail() when $default != null:
return $default(_that.subjectId,_that.rootId,_that.sourceId,_that.targetId,_that.type,_that.businessId,_that.business,_that.title,_that.desc,_that.image,_that.uri,_that.nativeUri,_that.rootReplyContent,_that.sourceContent,_that.targetReplyContent,_that.atDetails,_that.hideReplyButton,_that.hideLikeButton,_that.likeState,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'subject_id', readValue: _readSubjectId)  int subjectId, @JsonKey(name: 'root_id')  int rootId, @JsonKey(name: 'source_id')  int sourceId, @JsonKey(name: 'target_id')  int targetId,  String type, @JsonKey(name: 'business_id')  int businessId,  String business,  String title,  String desc,  String image,  String uri, @JsonKey(name: 'native_uri')  String nativeUri, @JsonKey(name: 'root_reply_content')  String rootReplyContent, @JsonKey(name: 'source_content')  String sourceContent, @JsonKey(name: 'target_reply_content')  String targetReplyContent, @JsonKey(name: 'at_details')  List<ReplyUser> atDetails, @JsonKey(name: 'hide_reply_button')  bool hideReplyButton, @JsonKey(name: 'hide_like_button')  bool hideLikeButton, @JsonKey(name: 'like_state')  int likeState,  String message)  $default,) {final _that = this;
switch (_that) {
case _ReplyItemDetail():
return $default(_that.subjectId,_that.rootId,_that.sourceId,_that.targetId,_that.type,_that.businessId,_that.business,_that.title,_that.desc,_that.image,_that.uri,_that.nativeUri,_that.rootReplyContent,_that.sourceContent,_that.targetReplyContent,_that.atDetails,_that.hideReplyButton,_that.hideLikeButton,_that.likeState,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'subject_id', readValue: _readSubjectId)  int subjectId, @JsonKey(name: 'root_id')  int rootId, @JsonKey(name: 'source_id')  int sourceId, @JsonKey(name: 'target_id')  int targetId,  String type, @JsonKey(name: 'business_id')  int businessId,  String business,  String title,  String desc,  String image,  String uri, @JsonKey(name: 'native_uri')  String nativeUri, @JsonKey(name: 'root_reply_content')  String rootReplyContent, @JsonKey(name: 'source_content')  String sourceContent, @JsonKey(name: 'target_reply_content')  String targetReplyContent, @JsonKey(name: 'at_details')  List<ReplyUser> atDetails, @JsonKey(name: 'hide_reply_button')  bool hideReplyButton, @JsonKey(name: 'hide_like_button')  bool hideLikeButton, @JsonKey(name: 'like_state')  int likeState,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ReplyItemDetail() when $default != null:
return $default(_that.subjectId,_that.rootId,_that.sourceId,_that.targetId,_that.type,_that.businessId,_that.business,_that.title,_that.desc,_that.image,_that.uri,_that.nativeUri,_that.rootReplyContent,_that.sourceContent,_that.targetReplyContent,_that.atDetails,_that.hideReplyButton,_that.hideLikeButton,_that.likeState,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyItemDetail implements ReplyItemDetail {
  const _ReplyItemDetail({@JsonKey(name: 'subject_id', readValue: _readSubjectId) required this.subjectId, @JsonKey(name: 'root_id') this.rootId = 0, @JsonKey(name: 'source_id') this.sourceId = 0, @JsonKey(name: 'target_id') this.targetId = 0, required this.type, @JsonKey(name: 'business_id') required this.businessId, required this.business, this.title = '', this.desc = '', this.image = '', this.uri = '', @JsonKey(name: 'native_uri') this.nativeUri = '', @JsonKey(name: 'root_reply_content') this.rootReplyContent = '', @JsonKey(name: 'source_content') this.sourceContent = '', @JsonKey(name: 'target_reply_content') this.targetReplyContent = '', @JsonKey(name: 'at_details') final  List<ReplyUser> atDetails = const [], @JsonKey(name: 'hide_reply_button') this.hideReplyButton = false, @JsonKey(name: 'hide_like_button') this.hideLikeButton = false, @JsonKey(name: 'like_state') this.likeState = 0, this.message = ''}): _atDetails = atDetails;
  factory _ReplyItemDetail.fromJson(Map<String, dynamic> json) => _$ReplyItemDetailFromJson(json);

@override@JsonKey(name: 'subject_id', readValue: _readSubjectId) final  int subjectId;
@override@JsonKey(name: 'root_id') final  int rootId;
@override@JsonKey(name: 'source_id') final  int sourceId;
@override@JsonKey(name: 'target_id') final  int targetId;
@override final  String type;
@override@JsonKey(name: 'business_id') final  int businessId;
@override final  String business;
@override@JsonKey() final  String title;
@override@JsonKey() final  String desc;
@override@JsonKey() final  String image;
@override@JsonKey() final  String uri;
@override@JsonKey(name: 'native_uri') final  String nativeUri;
@override@JsonKey(name: 'root_reply_content') final  String rootReplyContent;
@override@JsonKey(name: 'source_content') final  String sourceContent;
@override@JsonKey(name: 'target_reply_content') final  String targetReplyContent;
 final  List<ReplyUser> _atDetails;
@override@JsonKey(name: 'at_details') List<ReplyUser> get atDetails {
  if (_atDetails is EqualUnmodifiableListView) return _atDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_atDetails);
}

@override@JsonKey(name: 'hide_reply_button') final  bool hideReplyButton;
@override@JsonKey(name: 'hide_like_button') final  bool hideLikeButton;
@override@JsonKey(name: 'like_state') final  int likeState;
@override@JsonKey() final  String message;

/// Create a copy of ReplyItemDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyItemDetailCopyWith<_ReplyItemDetail> get copyWith => __$ReplyItemDetailCopyWithImpl<_ReplyItemDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyItemDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyItemDetail&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.rootId, rootId) || other.rootId == rootId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.type, type) || other.type == type)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.business, business) || other.business == business)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.image, image) || other.image == image)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.nativeUri, nativeUri) || other.nativeUri == nativeUri)&&(identical(other.rootReplyContent, rootReplyContent) || other.rootReplyContent == rootReplyContent)&&(identical(other.sourceContent, sourceContent) || other.sourceContent == sourceContent)&&(identical(other.targetReplyContent, targetReplyContent) || other.targetReplyContent == targetReplyContent)&&const DeepCollectionEquality().equals(other._atDetails, _atDetails)&&(identical(other.hideReplyButton, hideReplyButton) || other.hideReplyButton == hideReplyButton)&&(identical(other.hideLikeButton, hideLikeButton) || other.hideLikeButton == hideLikeButton)&&(identical(other.likeState, likeState) || other.likeState == likeState)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,subjectId,rootId,sourceId,targetId,type,businessId,business,title,desc,image,uri,nativeUri,rootReplyContent,sourceContent,targetReplyContent,const DeepCollectionEquality().hash(_atDetails),hideReplyButton,hideLikeButton,likeState,message]);

@override
String toString() {
  return 'ReplyItemDetail(subjectId: $subjectId, rootId: $rootId, sourceId: $sourceId, targetId: $targetId, type: $type, businessId: $businessId, business: $business, title: $title, desc: $desc, image: $image, uri: $uri, nativeUri: $nativeUri, rootReplyContent: $rootReplyContent, sourceContent: $sourceContent, targetReplyContent: $targetReplyContent, atDetails: $atDetails, hideReplyButton: $hideReplyButton, hideLikeButton: $hideLikeButton, likeState: $likeState, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ReplyItemDetailCopyWith<$Res> implements $ReplyItemDetailCopyWith<$Res> {
  factory _$ReplyItemDetailCopyWith(_ReplyItemDetail value, $Res Function(_ReplyItemDetail) _then) = __$ReplyItemDetailCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subject_id', readValue: _readSubjectId) int subjectId,@JsonKey(name: 'root_id') int rootId,@JsonKey(name: 'source_id') int sourceId,@JsonKey(name: 'target_id') int targetId, String type,@JsonKey(name: 'business_id') int businessId, String business, String title, String desc, String image, String uri,@JsonKey(name: 'native_uri') String nativeUri,@JsonKey(name: 'root_reply_content') String rootReplyContent,@JsonKey(name: 'source_content') String sourceContent,@JsonKey(name: 'target_reply_content') String targetReplyContent,@JsonKey(name: 'at_details') List<ReplyUser> atDetails,@JsonKey(name: 'hide_reply_button') bool hideReplyButton,@JsonKey(name: 'hide_like_button') bool hideLikeButton,@JsonKey(name: 'like_state') int likeState, String message
});




}
/// @nodoc
class __$ReplyItemDetailCopyWithImpl<$Res>
    implements _$ReplyItemDetailCopyWith<$Res> {
  __$ReplyItemDetailCopyWithImpl(this._self, this._then);

  final _ReplyItemDetail _self;
  final $Res Function(_ReplyItemDetail) _then;

/// Create a copy of ReplyItemDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectId = null,Object? rootId = null,Object? sourceId = null,Object? targetId = null,Object? type = null,Object? businessId = null,Object? business = null,Object? title = null,Object? desc = null,Object? image = null,Object? uri = null,Object? nativeUri = null,Object? rootReplyContent = null,Object? sourceContent = null,Object? targetReplyContent = null,Object? atDetails = null,Object? hideReplyButton = null,Object? hideLikeButton = null,Object? likeState = null,Object? message = null,}) {
  return _then(_ReplyItemDetail(
subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int,rootId: null == rootId ? _self.rootId : rootId // ignore: cast_nullable_to_non_nullable
as int,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as int,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as int,business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,nativeUri: null == nativeUri ? _self.nativeUri : nativeUri // ignore: cast_nullable_to_non_nullable
as String,rootReplyContent: null == rootReplyContent ? _self.rootReplyContent : rootReplyContent // ignore: cast_nullable_to_non_nullable
as String,sourceContent: null == sourceContent ? _self.sourceContent : sourceContent // ignore: cast_nullable_to_non_nullable
as String,targetReplyContent: null == targetReplyContent ? _self.targetReplyContent : targetReplyContent // ignore: cast_nullable_to_non_nullable
as String,atDetails: null == atDetails ? _self._atDetails : atDetails // ignore: cast_nullable_to_non_nullable
as List<ReplyUser>,hideReplyButton: null == hideReplyButton ? _self.hideReplyButton : hideReplyButton // ignore: cast_nullable_to_non_nullable
as bool,hideLikeButton: null == hideLikeButton ? _self.hideLikeButton : hideLikeButton // ignore: cast_nullable_to_non_nullable
as bool,likeState: null == likeState ? _self.likeState : likeState // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
