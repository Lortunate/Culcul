// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoDetailState {

 bool get isLoading; VideoDetail? get videoDetail; PlayUrl? get playUrl; Object? get error; int get currentCid; List<RelatedVideo> get relatedVideos; List<CommentItem> get comments; int get commentSort; int get commentPage; bool get isCommentLoading; bool get hasMoreComments; int get selectedQuality; double get playbackSpeed; List<int> get availableQualities;
/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoDetailStateCopyWith<VideoDetailState> get copyWith => _$VideoDetailStateCopyWithImpl<VideoDetailState>(this as VideoDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.videoDetail, videoDetail) || other.videoDetail == videoDetail)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.currentCid, currentCid) || other.currentCid == currentCid)&&const DeepCollectionEquality().equals(other.relatedVideos, relatedVideos)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.commentSort, commentSort) || other.commentSort == commentSort)&&(identical(other.commentPage, commentPage) || other.commentPage == commentPage)&&(identical(other.isCommentLoading, isCommentLoading) || other.isCommentLoading == isCommentLoading)&&(identical(other.hasMoreComments, hasMoreComments) || other.hasMoreComments == hasMoreComments)&&(identical(other.selectedQuality, selectedQuality) || other.selectedQuality == selectedQuality)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&const DeepCollectionEquality().equals(other.availableQualities, availableQualities));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,videoDetail,playUrl,const DeepCollectionEquality().hash(error),currentCid,const DeepCollectionEquality().hash(relatedVideos),const DeepCollectionEquality().hash(comments),commentSort,commentPage,isCommentLoading,hasMoreComments,selectedQuality,playbackSpeed,const DeepCollectionEquality().hash(availableQualities));

@override
String toString() {
  return 'VideoDetailState(isLoading: $isLoading, videoDetail: $videoDetail, playUrl: $playUrl, error: $error, currentCid: $currentCid, relatedVideos: $relatedVideos, comments: $comments, commentSort: $commentSort, commentPage: $commentPage, isCommentLoading: $isCommentLoading, hasMoreComments: $hasMoreComments, selectedQuality: $selectedQuality, playbackSpeed: $playbackSpeed, availableQualities: $availableQualities)';
}


}

/// @nodoc
abstract mixin class $VideoDetailStateCopyWith<$Res>  {
  factory $VideoDetailStateCopyWith(VideoDetailState value, $Res Function(VideoDetailState) _then) = _$VideoDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, VideoDetail? videoDetail, PlayUrl? playUrl, Object? error, int currentCid, List<RelatedVideo> relatedVideos, List<CommentItem> comments, int commentSort, int commentPage, bool isCommentLoading, bool hasMoreComments, int selectedQuality, double playbackSpeed, List<int> availableQualities
});


$VideoDetailCopyWith<$Res>? get videoDetail;$PlayUrlCopyWith<$Res>? get playUrl;

}
/// @nodoc
class _$VideoDetailStateCopyWithImpl<$Res>
    implements $VideoDetailStateCopyWith<$Res> {
  _$VideoDetailStateCopyWithImpl(this._self, this._then);

  final VideoDetailState _self;
  final $Res Function(VideoDetailState) _then;

/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? videoDetail = freezed,Object? playUrl = freezed,Object? error = freezed,Object? currentCid = null,Object? relatedVideos = null,Object? comments = null,Object? commentSort = null,Object? commentPage = null,Object? isCommentLoading = null,Object? hasMoreComments = null,Object? selectedQuality = null,Object? playbackSpeed = null,Object? availableQualities = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,videoDetail: freezed == videoDetail ? _self.videoDetail : videoDetail // ignore: cast_nullable_to_non_nullable
as VideoDetail?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as PlayUrl?,error: freezed == error ? _self.error : error ,currentCid: null == currentCid ? _self.currentCid : currentCid // ignore: cast_nullable_to_non_nullable
as int,relatedVideos: null == relatedVideos ? _self.relatedVideos : relatedVideos // ignore: cast_nullable_to_non_nullable
as List<RelatedVideo>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,commentSort: null == commentSort ? _self.commentSort : commentSort // ignore: cast_nullable_to_non_nullable
as int,commentPage: null == commentPage ? _self.commentPage : commentPage // ignore: cast_nullable_to_non_nullable
as int,isCommentLoading: null == isCommentLoading ? _self.isCommentLoading : isCommentLoading // ignore: cast_nullable_to_non_nullable
as bool,hasMoreComments: null == hasMoreComments ? _self.hasMoreComments : hasMoreComments // ignore: cast_nullable_to_non_nullable
as bool,selectedQuality: null == selectedQuality ? _self.selectedQuality : selectedQuality // ignore: cast_nullable_to_non_nullable
as int,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,availableQualities: null == availableQualities ? _self.availableQualities : availableQualities // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoDetailCopyWith<$Res>? get videoDetail {
    if (_self.videoDetail == null) {
    return null;
  }

  return $VideoDetailCopyWith<$Res>(_self.videoDetail!, (value) {
    return _then(_self.copyWith(videoDetail: value));
  });
}/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayUrlCopyWith<$Res>? get playUrl {
    if (_self.playUrl == null) {
    return null;
  }

  return $PlayUrlCopyWith<$Res>(_self.playUrl!, (value) {
    return _then(_self.copyWith(playUrl: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoDetailState].
extension VideoDetailStatePatterns on VideoDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoDetailState value)  $default,){
final _that = this;
switch (_that) {
case _VideoDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _VideoDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  VideoDetail? videoDetail,  PlayUrl? playUrl,  Object? error,  int currentCid,  List<RelatedVideo> relatedVideos,  List<CommentItem> comments,  int commentSort,  int commentPage,  bool isCommentLoading,  bool hasMoreComments,  int selectedQuality,  double playbackSpeed,  List<int> availableQualities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoDetailState() when $default != null:
return $default(_that.isLoading,_that.videoDetail,_that.playUrl,_that.error,_that.currentCid,_that.relatedVideos,_that.comments,_that.commentSort,_that.commentPage,_that.isCommentLoading,_that.hasMoreComments,_that.selectedQuality,_that.playbackSpeed,_that.availableQualities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  VideoDetail? videoDetail,  PlayUrl? playUrl,  Object? error,  int currentCid,  List<RelatedVideo> relatedVideos,  List<CommentItem> comments,  int commentSort,  int commentPage,  bool isCommentLoading,  bool hasMoreComments,  int selectedQuality,  double playbackSpeed,  List<int> availableQualities)  $default,) {final _that = this;
switch (_that) {
case _VideoDetailState():
return $default(_that.isLoading,_that.videoDetail,_that.playUrl,_that.error,_that.currentCid,_that.relatedVideos,_that.comments,_that.commentSort,_that.commentPage,_that.isCommentLoading,_that.hasMoreComments,_that.selectedQuality,_that.playbackSpeed,_that.availableQualities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  VideoDetail? videoDetail,  PlayUrl? playUrl,  Object? error,  int currentCid,  List<RelatedVideo> relatedVideos,  List<CommentItem> comments,  int commentSort,  int commentPage,  bool isCommentLoading,  bool hasMoreComments,  int selectedQuality,  double playbackSpeed,  List<int> availableQualities)?  $default,) {final _that = this;
switch (_that) {
case _VideoDetailState() when $default != null:
return $default(_that.isLoading,_that.videoDetail,_that.playUrl,_that.error,_that.currentCid,_that.relatedVideos,_that.comments,_that.commentSort,_that.commentPage,_that.isCommentLoading,_that.hasMoreComments,_that.selectedQuality,_that.playbackSpeed,_that.availableQualities);case _:
  return null;

}
}

}

/// @nodoc


class _VideoDetailState implements VideoDetailState {
  const _VideoDetailState({this.isLoading = true, this.videoDetail, this.playUrl, this.error, this.currentCid = 0, final  List<RelatedVideo> relatedVideos = const [], final  List<CommentItem> comments = const [], this.commentSort = 1, this.commentPage = 1, this.isCommentLoading = false, this.hasMoreComments = true, this.selectedQuality = 80, this.playbackSpeed = 1.0, final  List<int> availableQualities = const []}): _relatedVideos = relatedVideos,_comments = comments,_availableQualities = availableQualities;
  

@override@JsonKey() final  bool isLoading;
@override final  VideoDetail? videoDetail;
@override final  PlayUrl? playUrl;
@override final  Object? error;
@override@JsonKey() final  int currentCid;
 final  List<RelatedVideo> _relatedVideos;
@override@JsonKey() List<RelatedVideo> get relatedVideos {
  if (_relatedVideos is EqualUnmodifiableListView) return _relatedVideos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relatedVideos);
}

 final  List<CommentItem> _comments;
@override@JsonKey() List<CommentItem> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  int commentSort;
@override@JsonKey() final  int commentPage;
@override@JsonKey() final  bool isCommentLoading;
@override@JsonKey() final  bool hasMoreComments;
@override@JsonKey() final  int selectedQuality;
@override@JsonKey() final  double playbackSpeed;
 final  List<int> _availableQualities;
@override@JsonKey() List<int> get availableQualities {
  if (_availableQualities is EqualUnmodifiableListView) return _availableQualities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableQualities);
}


/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoDetailStateCopyWith<_VideoDetailState> get copyWith => __$VideoDetailStateCopyWithImpl<_VideoDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.videoDetail, videoDetail) || other.videoDetail == videoDetail)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.currentCid, currentCid) || other.currentCid == currentCid)&&const DeepCollectionEquality().equals(other._relatedVideos, _relatedVideos)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.commentSort, commentSort) || other.commentSort == commentSort)&&(identical(other.commentPage, commentPage) || other.commentPage == commentPage)&&(identical(other.isCommentLoading, isCommentLoading) || other.isCommentLoading == isCommentLoading)&&(identical(other.hasMoreComments, hasMoreComments) || other.hasMoreComments == hasMoreComments)&&(identical(other.selectedQuality, selectedQuality) || other.selectedQuality == selectedQuality)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&const DeepCollectionEquality().equals(other._availableQualities, _availableQualities));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,videoDetail,playUrl,const DeepCollectionEquality().hash(error),currentCid,const DeepCollectionEquality().hash(_relatedVideos),const DeepCollectionEquality().hash(_comments),commentSort,commentPage,isCommentLoading,hasMoreComments,selectedQuality,playbackSpeed,const DeepCollectionEquality().hash(_availableQualities));

@override
String toString() {
  return 'VideoDetailState(isLoading: $isLoading, videoDetail: $videoDetail, playUrl: $playUrl, error: $error, currentCid: $currentCid, relatedVideos: $relatedVideos, comments: $comments, commentSort: $commentSort, commentPage: $commentPage, isCommentLoading: $isCommentLoading, hasMoreComments: $hasMoreComments, selectedQuality: $selectedQuality, playbackSpeed: $playbackSpeed, availableQualities: $availableQualities)';
}


}

/// @nodoc
abstract mixin class _$VideoDetailStateCopyWith<$Res> implements $VideoDetailStateCopyWith<$Res> {
  factory _$VideoDetailStateCopyWith(_VideoDetailState value, $Res Function(_VideoDetailState) _then) = __$VideoDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, VideoDetail? videoDetail, PlayUrl? playUrl, Object? error, int currentCid, List<RelatedVideo> relatedVideos, List<CommentItem> comments, int commentSort, int commentPage, bool isCommentLoading, bool hasMoreComments, int selectedQuality, double playbackSpeed, List<int> availableQualities
});


@override $VideoDetailCopyWith<$Res>? get videoDetail;@override $PlayUrlCopyWith<$Res>? get playUrl;

}
/// @nodoc
class __$VideoDetailStateCopyWithImpl<$Res>
    implements _$VideoDetailStateCopyWith<$Res> {
  __$VideoDetailStateCopyWithImpl(this._self, this._then);

  final _VideoDetailState _self;
  final $Res Function(_VideoDetailState) _then;

/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? videoDetail = freezed,Object? playUrl = freezed,Object? error = freezed,Object? currentCid = null,Object? relatedVideos = null,Object? comments = null,Object? commentSort = null,Object? commentPage = null,Object? isCommentLoading = null,Object? hasMoreComments = null,Object? selectedQuality = null,Object? playbackSpeed = null,Object? availableQualities = null,}) {
  return _then(_VideoDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,videoDetail: freezed == videoDetail ? _self.videoDetail : videoDetail // ignore: cast_nullable_to_non_nullable
as VideoDetail?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as PlayUrl?,error: freezed == error ? _self.error : error ,currentCid: null == currentCid ? _self.currentCid : currentCid // ignore: cast_nullable_to_non_nullable
as int,relatedVideos: null == relatedVideos ? _self._relatedVideos : relatedVideos // ignore: cast_nullable_to_non_nullable
as List<RelatedVideo>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentItem>,commentSort: null == commentSort ? _self.commentSort : commentSort // ignore: cast_nullable_to_non_nullable
as int,commentPage: null == commentPage ? _self.commentPage : commentPage // ignore: cast_nullable_to_non_nullable
as int,isCommentLoading: null == isCommentLoading ? _self.isCommentLoading : isCommentLoading // ignore: cast_nullable_to_non_nullable
as bool,hasMoreComments: null == hasMoreComments ? _self.hasMoreComments : hasMoreComments // ignore: cast_nullable_to_non_nullable
as bool,selectedQuality: null == selectedQuality ? _self.selectedQuality : selectedQuality // ignore: cast_nullable_to_non_nullable
as int,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,availableQualities: null == availableQualities ? _self._availableQualities : availableQualities // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoDetailCopyWith<$Res>? get videoDetail {
    if (_self.videoDetail == null) {
    return null;
  }

  return $VideoDetailCopyWith<$Res>(_self.videoDetail!, (value) {
    return _then(_self.copyWith(videoDetail: value));
  });
}/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayUrlCopyWith<$Res>? get playUrl {
    if (_self.playUrl == null) {
    return null;
  }

  return $PlayUrlCopyWith<$Res>(_self.playUrl!, (value) {
    return _then(_self.copyWith(playUrl: value));
  });
}
}

// dart format on
