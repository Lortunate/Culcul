// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_reply_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommentReplyState {

 CommentItem? get rootComment; List<CommentItem> get replies; int get page; bool get hasMore; bool get isLoading; Object? get error;
/// Create a copy of CommentReplyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentReplyStateCopyWith<CommentReplyState> get copyWith => _$CommentReplyStateCopyWithImpl<CommentReplyState>(this as CommentReplyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentReplyState&&(identical(other.rootComment, rootComment) || other.rootComment == rootComment)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,rootComment,const DeepCollectionEquality().hash(replies),page,hasMore,isLoading,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'CommentReplyState(rootComment: $rootComment, replies: $replies, page: $page, hasMore: $hasMore, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $CommentReplyStateCopyWith<$Res>  {
  factory $CommentReplyStateCopyWith(CommentReplyState value, $Res Function(CommentReplyState) _then) = _$CommentReplyStateCopyWithImpl;
@useResult
$Res call({
 CommentItem? rootComment, List<CommentItem> replies, int page, bool hasMore, bool isLoading, Object? error
});


$CommentItemCopyWith<$Res>? get rootComment;

}
/// @nodoc
class _$CommentReplyStateCopyWithImpl<$Res>
    implements $CommentReplyStateCopyWith<$Res> {
  _$CommentReplyStateCopyWithImpl(this._self, this._then);

  final CommentReplyState _self;
  final $Res Function(CommentReplyState) _then;

/// Create a copy of CommentReplyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rootComment = freezed,Object? replies = null,Object? page = null,Object? hasMore = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
rootComment: freezed == rootComment ? _self.rootComment : rootComment // ignore: cast_nullable_to_non_nullable
as CommentItem?,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error ,
  ));
}
/// Create a copy of CommentReplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentItemCopyWith<$Res>? get rootComment {
    if (_self.rootComment == null) {
    return null;
  }

  return $CommentItemCopyWith<$Res>(_self.rootComment!, (value) {
    return _then(_self.copyWith(rootComment: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentReplyState].
extension CommentReplyStatePatterns on CommentReplyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentReplyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentReplyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentReplyState value)  $default,){
final _that = this;
switch (_that) {
case _CommentReplyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentReplyState value)?  $default,){
final _that = this;
switch (_that) {
case _CommentReplyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommentItem? rootComment,  List<CommentItem> replies,  int page,  bool hasMore,  bool isLoading,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentReplyState() when $default != null:
return $default(_that.rootComment,_that.replies,_that.page,_that.hasMore,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommentItem? rootComment,  List<CommentItem> replies,  int page,  bool hasMore,  bool isLoading,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _CommentReplyState():
return $default(_that.rootComment,_that.replies,_that.page,_that.hasMore,_that.isLoading,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommentItem? rootComment,  List<CommentItem> replies,  int page,  bool hasMore,  bool isLoading,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _CommentReplyState() when $default != null:
return $default(_that.rootComment,_that.replies,_that.page,_that.hasMore,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CommentReplyState implements CommentReplyState {
  const _CommentReplyState({this.rootComment, final  List<CommentItem> replies = const [], this.page = 1, this.hasMore = true, this.isLoading = false, this.error}): _replies = replies;
  

@override final  CommentItem? rootComment;
 final  List<CommentItem> _replies;
@override@JsonKey() List<CommentItem> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoading;
@override final  Object? error;

/// Create a copy of CommentReplyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentReplyStateCopyWith<_CommentReplyState> get copyWith => __$CommentReplyStateCopyWithImpl<_CommentReplyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentReplyState&&(identical(other.rootComment, rootComment) || other.rootComment == rootComment)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,rootComment,const DeepCollectionEquality().hash(_replies),page,hasMore,isLoading,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'CommentReplyState(rootComment: $rootComment, replies: $replies, page: $page, hasMore: $hasMore, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CommentReplyStateCopyWith<$Res> implements $CommentReplyStateCopyWith<$Res> {
  factory _$CommentReplyStateCopyWith(_CommentReplyState value, $Res Function(_CommentReplyState) _then) = __$CommentReplyStateCopyWithImpl;
@override @useResult
$Res call({
 CommentItem? rootComment, List<CommentItem> replies, int page, bool hasMore, bool isLoading, Object? error
});


@override $CommentItemCopyWith<$Res>? get rootComment;

}
/// @nodoc
class __$CommentReplyStateCopyWithImpl<$Res>
    implements _$CommentReplyStateCopyWith<$Res> {
  __$CommentReplyStateCopyWithImpl(this._self, this._then);

  final _CommentReplyState _self;
  final $Res Function(_CommentReplyState) _then;

/// Create a copy of CommentReplyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rootComment = freezed,Object? replies = null,Object? page = null,Object? hasMore = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_CommentReplyState(
rootComment: freezed == rootComment ? _self.rootComment : rootComment // ignore: cast_nullable_to_non_nullable
as CommentItem?,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error ,
  ));
}

/// Create a copy of CommentReplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentItemCopyWith<$Res>? get rootComment {
    if (_self.rootComment == null) {
    return null;
  }

  return $CommentItemCopyWith<$Res>(_self.rootComment!, (value) {
    return _then(_self.copyWith(rootComment: value));
  });
}
}

// dart format on
