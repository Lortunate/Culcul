// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_comment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DynamicCommentState {

 List<CommentItem> get comments; bool get isLoading; bool get hasMore; int get page; int get sort;// 0: time, 1: like (hot)
 AppException? get error;
/// Create a copy of DynamicCommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicCommentStateCopyWith<DynamicCommentState> get copyWith => _$DynamicCommentStateCopyWithImpl<DynamicCommentState>(this as DynamicCommentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicCommentState&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(comments),isLoading,hasMore,page,sort,error);

@override
String toString() {
  return 'DynamicCommentState(comments: $comments, isLoading: $isLoading, hasMore: $hasMore, page: $page, sort: $sort, error: $error)';
}


}

/// @nodoc
abstract mixin class $DynamicCommentStateCopyWith<$Res>  {
  factory $DynamicCommentStateCopyWith(DynamicCommentState value, $Res Function(DynamicCommentState) _then) = _$DynamicCommentStateCopyWithImpl;
@useResult
$Res call({
 List<CommentItem> comments, bool isLoading, bool hasMore, int page, int sort, AppException? error
});




}
/// @nodoc
class _$DynamicCommentStateCopyWithImpl<$Res>
    implements $DynamicCommentStateCopyWith<$Res> {
  _$DynamicCommentStateCopyWithImpl(this._self, this._then);

  final DynamicCommentState _self;
  final $Res Function(DynamicCommentState) _then;

/// Create a copy of DynamicCommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comments = null,Object? isLoading = null,Object? hasMore = null,Object? page = null,Object? sort = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicCommentState].
extension DynamicCommentStatePatterns on DynamicCommentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicCommentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicCommentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicCommentState value)  $default,){
final _that = this;
switch (_that) {
case _DynamicCommentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicCommentState value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicCommentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommentItem> comments,  bool isLoading,  bool hasMore,  int page,  int sort,  AppException? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicCommentState() when $default != null:
return $default(_that.comments,_that.isLoading,_that.hasMore,_that.page,_that.sort,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommentItem> comments,  bool isLoading,  bool hasMore,  int page,  int sort,  AppException? error)  $default,) {final _that = this;
switch (_that) {
case _DynamicCommentState():
return $default(_that.comments,_that.isLoading,_that.hasMore,_that.page,_that.sort,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommentItem> comments,  bool isLoading,  bool hasMore,  int page,  int sort,  AppException? error)?  $default,) {final _that = this;
switch (_that) {
case _DynamicCommentState() when $default != null:
return $default(_that.comments,_that.isLoading,_that.hasMore,_that.page,_that.sort,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DynamicCommentState implements DynamicCommentState {
  const _DynamicCommentState({final  List<CommentItem> comments = const [], this.isLoading = true, this.hasMore = false, this.page = 1, this.sort = 1, this.error}): _comments = comments;
  

 final  List<CommentItem> _comments;
@override@JsonKey() List<CommentItem> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int page;
@override@JsonKey() final  int sort;
// 0: time, 1: like (hot)
@override final  AppException? error;

/// Create a copy of DynamicCommentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicCommentStateCopyWith<_DynamicCommentState> get copyWith => __$DynamicCommentStateCopyWithImpl<_DynamicCommentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicCommentState&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_comments),isLoading,hasMore,page,sort,error);

@override
String toString() {
  return 'DynamicCommentState(comments: $comments, isLoading: $isLoading, hasMore: $hasMore, page: $page, sort: $sort, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DynamicCommentStateCopyWith<$Res> implements $DynamicCommentStateCopyWith<$Res> {
  factory _$DynamicCommentStateCopyWith(_DynamicCommentState value, $Res Function(_DynamicCommentState) _then) = __$DynamicCommentStateCopyWithImpl;
@override @useResult
$Res call({
 List<CommentItem> comments, bool isLoading, bool hasMore, int page, int sort, AppException? error
});




}
/// @nodoc
class __$DynamicCommentStateCopyWithImpl<$Res>
    implements _$DynamicCommentStateCopyWith<$Res> {
  __$DynamicCommentStateCopyWithImpl(this._self, this._then);

  final _DynamicCommentState _self;
  final $Res Function(_DynamicCommentState) _then;

/// Create a copy of DynamicCommentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comments = null,Object? isLoading = null,Object? hasMore = null,Object? page = null,Object? sort = null,Object? error = freezed,}) {
  return _then(_DynamicCommentState(
comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}


}

// dart format on
