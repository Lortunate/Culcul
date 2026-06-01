// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoDetailState {

 bool get isLoading; VideoDetailViewData? get videoDetail; PlayUrl? get playUrl; AppError? get error; int get currentCid; List<VideoModel> get relatedVideos; int get selectedQuality; double get playbackSpeed; List<int> get availableQualities;
/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoDetailStateCopyWith<VideoDetailState> get copyWith => _$VideoDetailStateCopyWithImpl<VideoDetailState>(this as VideoDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.videoDetail, videoDetail) || other.videoDetail == videoDetail)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&(identical(other.error, error) || other.error == error)&&(identical(other.currentCid, currentCid) || other.currentCid == currentCid)&&const DeepCollectionEquality().equals(other.relatedVideos, relatedVideos)&&(identical(other.selectedQuality, selectedQuality) || other.selectedQuality == selectedQuality)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&const DeepCollectionEquality().equals(other.availableQualities, availableQualities));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,videoDetail,playUrl,error,currentCid,const DeepCollectionEquality().hash(relatedVideos),selectedQuality,playbackSpeed,const DeepCollectionEquality().hash(availableQualities));

@override
String toString() {
  return 'VideoDetailState(isLoading: $isLoading, videoDetail: $videoDetail, playUrl: $playUrl, error: $error, currentCid: $currentCid, relatedVideos: $relatedVideos, selectedQuality: $selectedQuality, playbackSpeed: $playbackSpeed, availableQualities: $availableQualities)';
}


}

/// @nodoc
abstract mixin class $VideoDetailStateCopyWith<$Res>  {
  factory $VideoDetailStateCopyWith(VideoDetailState value, $Res Function(VideoDetailState) _then) = _$VideoDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, VideoDetailViewData? videoDetail, PlayUrl? playUrl, AppError? error, int currentCid, List<VideoModel> relatedVideos, int selectedQuality, double playbackSpeed, List<int> availableQualities
});




}
/// @nodoc
class _$VideoDetailStateCopyWithImpl<$Res>
    implements $VideoDetailStateCopyWith<$Res> {
  _$VideoDetailStateCopyWithImpl(this._self, this._then);

  final VideoDetailState _self;
  final $Res Function(VideoDetailState) _then;

/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? videoDetail = freezed,Object? playUrl = freezed,Object? error = freezed,Object? currentCid = null,Object? relatedVideos = null,Object? selectedQuality = null,Object? playbackSpeed = null,Object? availableQualities = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,videoDetail: freezed == videoDetail ? _self.videoDetail : videoDetail // ignore: cast_nullable_to_non_nullable
as VideoDetailViewData?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as PlayUrl?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,currentCid: null == currentCid ? _self.currentCid : currentCid // ignore: cast_nullable_to_non_nullable
as int,relatedVideos: null == relatedVideos ? _self.relatedVideos : relatedVideos // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,selectedQuality: null == selectedQuality ? _self.selectedQuality : selectedQuality // ignore: cast_nullable_to_non_nullable
as int,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,availableQualities: null == availableQualities ? _self.availableQualities : availableQualities // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  VideoDetailViewData? videoDetail,  PlayUrl? playUrl,  AppError? error,  int currentCid,  List<VideoModel> relatedVideos,  int selectedQuality,  double playbackSpeed,  List<int> availableQualities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoDetailState() when $default != null:
return $default(_that.isLoading,_that.videoDetail,_that.playUrl,_that.error,_that.currentCid,_that.relatedVideos,_that.selectedQuality,_that.playbackSpeed,_that.availableQualities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  VideoDetailViewData? videoDetail,  PlayUrl? playUrl,  AppError? error,  int currentCid,  List<VideoModel> relatedVideos,  int selectedQuality,  double playbackSpeed,  List<int> availableQualities)  $default,) {final _that = this;
switch (_that) {
case _VideoDetailState():
return $default(_that.isLoading,_that.videoDetail,_that.playUrl,_that.error,_that.currentCid,_that.relatedVideos,_that.selectedQuality,_that.playbackSpeed,_that.availableQualities);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  VideoDetailViewData? videoDetail,  PlayUrl? playUrl,  AppError? error,  int currentCid,  List<VideoModel> relatedVideos,  int selectedQuality,  double playbackSpeed,  List<int> availableQualities)?  $default,) {final _that = this;
switch (_that) {
case _VideoDetailState() when $default != null:
return $default(_that.isLoading,_that.videoDetail,_that.playUrl,_that.error,_that.currentCid,_that.relatedVideos,_that.selectedQuality,_that.playbackSpeed,_that.availableQualities);case _:
  return null;

}
}

}

/// @nodoc


class _VideoDetailState implements VideoDetailState {
  const _VideoDetailState({this.isLoading = true, this.videoDetail, this.playUrl, this.error, this.currentCid = 0, final  List<VideoModel> relatedVideos = const [], this.selectedQuality = 80, this.playbackSpeed = 1.0, final  List<int> availableQualities = const []}): _relatedVideos = relatedVideos,_availableQualities = availableQualities;
  

@override@JsonKey() final  bool isLoading;
@override final  VideoDetailViewData? videoDetail;
@override final  PlayUrl? playUrl;
@override final  AppError? error;
@override@JsonKey() final  int currentCid;
 final  List<VideoModel> _relatedVideos;
@override@JsonKey() List<VideoModel> get relatedVideos {
  if (_relatedVideos is EqualUnmodifiableListView) return _relatedVideos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relatedVideos);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.videoDetail, videoDetail) || other.videoDetail == videoDetail)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&(identical(other.error, error) || other.error == error)&&(identical(other.currentCid, currentCid) || other.currentCid == currentCid)&&const DeepCollectionEquality().equals(other._relatedVideos, _relatedVideos)&&(identical(other.selectedQuality, selectedQuality) || other.selectedQuality == selectedQuality)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&const DeepCollectionEquality().equals(other._availableQualities, _availableQualities));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,videoDetail,playUrl,error,currentCid,const DeepCollectionEquality().hash(_relatedVideos),selectedQuality,playbackSpeed,const DeepCollectionEquality().hash(_availableQualities));

@override
String toString() {
  return 'VideoDetailState(isLoading: $isLoading, videoDetail: $videoDetail, playUrl: $playUrl, error: $error, currentCid: $currentCid, relatedVideos: $relatedVideos, selectedQuality: $selectedQuality, playbackSpeed: $playbackSpeed, availableQualities: $availableQualities)';
}


}

/// @nodoc
abstract mixin class _$VideoDetailStateCopyWith<$Res> implements $VideoDetailStateCopyWith<$Res> {
  factory _$VideoDetailStateCopyWith(_VideoDetailState value, $Res Function(_VideoDetailState) _then) = __$VideoDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, VideoDetailViewData? videoDetail, PlayUrl? playUrl, AppError? error, int currentCid, List<VideoModel> relatedVideos, int selectedQuality, double playbackSpeed, List<int> availableQualities
});




}
/// @nodoc
class __$VideoDetailStateCopyWithImpl<$Res>
    implements _$VideoDetailStateCopyWith<$Res> {
  __$VideoDetailStateCopyWithImpl(this._self, this._then);

  final _VideoDetailState _self;
  final $Res Function(_VideoDetailState) _then;

/// Create a copy of VideoDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? videoDetail = freezed,Object? playUrl = freezed,Object? error = freezed,Object? currentCid = null,Object? relatedVideos = null,Object? selectedQuality = null,Object? playbackSpeed = null,Object? availableQualities = null,}) {
  return _then(_VideoDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,videoDetail: freezed == videoDetail ? _self.videoDetail : videoDetail // ignore: cast_nullable_to_non_nullable
as VideoDetailViewData?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as PlayUrl?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,currentCid: null == currentCid ? _self.currentCid : currentCid // ignore: cast_nullable_to_non_nullable
as int,relatedVideos: null == relatedVideos ? _self._relatedVideos : relatedVideos // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,selectedQuality: null == selectedQuality ? _self.selectedQuality : selectedQuality // ignore: cast_nullable_to_non_nullable
as int,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,availableQualities: null == availableQualities ? _self._availableQualities : availableQualities // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
