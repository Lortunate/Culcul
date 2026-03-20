// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_room_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveRoomState {

 int get roomId; bool get isLoading; AppException? get error; LiveRoomDetailModel? get roomInfo; UserCardModel? get anchorInfo; LiveAnchorInfoModel? get liveAnchorInfo; LiveGoldRankModel? get goldRank; LiveGuardListModel? get guardList; LivePlayUrlModel? get playUrl; LiveDanmakuConfigModel? get danmakuConfig; List<LiveDanmakuItem> get danmakuHistory; bool get isPlaying; double get volume; bool get isDanmakuEnabled;
/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRoomStateCopyWith<LiveRoomState> get copyWith => _$LiveRoomStateCopyWithImpl<LiveRoomState>(this as LiveRoomState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRoomState&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.roomInfo, roomInfo) || other.roomInfo == roomInfo)&&(identical(other.anchorInfo, anchorInfo) || other.anchorInfo == anchorInfo)&&(identical(other.liveAnchorInfo, liveAnchorInfo) || other.liveAnchorInfo == liveAnchorInfo)&&(identical(other.goldRank, goldRank) || other.goldRank == goldRank)&&(identical(other.guardList, guardList) || other.guardList == guardList)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&(identical(other.danmakuConfig, danmakuConfig) || other.danmakuConfig == danmakuConfig)&&const DeepCollectionEquality().equals(other.danmakuHistory, danmakuHistory)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.isDanmakuEnabled, isDanmakuEnabled) || other.isDanmakuEnabled == isDanmakuEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,roomId,isLoading,error,roomInfo,anchorInfo,liveAnchorInfo,goldRank,guardList,playUrl,danmakuConfig,const DeepCollectionEquality().hash(danmakuHistory),isPlaying,volume,isDanmakuEnabled);

@override
String toString() {
  return 'LiveRoomState(roomId: $roomId, isLoading: $isLoading, error: $error, roomInfo: $roomInfo, anchorInfo: $anchorInfo, liveAnchorInfo: $liveAnchorInfo, goldRank: $goldRank, guardList: $guardList, playUrl: $playUrl, danmakuConfig: $danmakuConfig, danmakuHistory: $danmakuHistory, isPlaying: $isPlaying, volume: $volume, isDanmakuEnabled: $isDanmakuEnabled)';
}


}

/// @nodoc
abstract mixin class $LiveRoomStateCopyWith<$Res>  {
  factory $LiveRoomStateCopyWith(LiveRoomState value, $Res Function(LiveRoomState) _then) = _$LiveRoomStateCopyWithImpl;
@useResult
$Res call({
 int roomId, bool isLoading, AppException? error, LiveRoomDetailModel? roomInfo, UserCardModel? anchorInfo, LiveAnchorInfoModel? liveAnchorInfo, LiveGoldRankModel? goldRank, LiveGuardListModel? guardList, LivePlayUrlModel? playUrl, LiveDanmakuConfigModel? danmakuConfig, List<LiveDanmakuItem> danmakuHistory, bool isPlaying, double volume, bool isDanmakuEnabled
});


$LiveRoomDetailModelCopyWith<$Res>? get roomInfo;$UserCardModelCopyWith<$Res>? get anchorInfo;$LiveAnchorInfoModelCopyWith<$Res>? get liveAnchorInfo;$LiveGoldRankModelCopyWith<$Res>? get goldRank;$LiveGuardListModelCopyWith<$Res>? get guardList;$LivePlayUrlModelCopyWith<$Res>? get playUrl;$LiveDanmakuConfigModelCopyWith<$Res>? get danmakuConfig;

}
/// @nodoc
class _$LiveRoomStateCopyWithImpl<$Res>
    implements $LiveRoomStateCopyWith<$Res> {
  _$LiveRoomStateCopyWithImpl(this._self, this._then);

  final LiveRoomState _self;
  final $Res Function(LiveRoomState) _then;

/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? isLoading = null,Object? error = freezed,Object? roomInfo = freezed,Object? anchorInfo = freezed,Object? liveAnchorInfo = freezed,Object? goldRank = freezed,Object? guardList = freezed,Object? playUrl = freezed,Object? danmakuConfig = freezed,Object? danmakuHistory = null,Object? isPlaying = null,Object? volume = null,Object? isDanmakuEnabled = null,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,roomInfo: freezed == roomInfo ? _self.roomInfo : roomInfo // ignore: cast_nullable_to_non_nullable
as LiveRoomDetailModel?,anchorInfo: freezed == anchorInfo ? _self.anchorInfo : anchorInfo // ignore: cast_nullable_to_non_nullable
as UserCardModel?,liveAnchorInfo: freezed == liveAnchorInfo ? _self.liveAnchorInfo : liveAnchorInfo // ignore: cast_nullable_to_non_nullable
as LiveAnchorInfoModel?,goldRank: freezed == goldRank ? _self.goldRank : goldRank // ignore: cast_nullable_to_non_nullable
as LiveGoldRankModel?,guardList: freezed == guardList ? _self.guardList : guardList // ignore: cast_nullable_to_non_nullable
as LiveGuardListModel?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as LivePlayUrlModel?,danmakuConfig: freezed == danmakuConfig ? _self.danmakuConfig : danmakuConfig // ignore: cast_nullable_to_non_nullable
as LiveDanmakuConfigModel?,danmakuHistory: null == danmakuHistory ? _self.danmakuHistory : danmakuHistory // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuItem>,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,isDanmakuEnabled: null == isDanmakuEnabled ? _self.isDanmakuEnabled : isDanmakuEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveRoomDetailModelCopyWith<$Res>? get roomInfo {
    if (_self.roomInfo == null) {
    return null;
  }

  return $LiveRoomDetailModelCopyWith<$Res>(_self.roomInfo!, (value) {
    return _then(_self.copyWith(roomInfo: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCardModelCopyWith<$Res>? get anchorInfo {
    if (_self.anchorInfo == null) {
    return null;
  }

  return $UserCardModelCopyWith<$Res>(_self.anchorInfo!, (value) {
    return _then(_self.copyWith(anchorInfo: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorInfoModelCopyWith<$Res>? get liveAnchorInfo {
    if (_self.liveAnchorInfo == null) {
    return null;
  }

  return $LiveAnchorInfoModelCopyWith<$Res>(_self.liveAnchorInfo!, (value) {
    return _then(_self.copyWith(liveAnchorInfo: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGoldRankModelCopyWith<$Res>? get goldRank {
    if (_self.goldRank == null) {
    return null;
  }

  return $LiveGoldRankModelCopyWith<$Res>(_self.goldRank!, (value) {
    return _then(_self.copyWith(goldRank: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardListModelCopyWith<$Res>? get guardList {
    if (_self.guardList == null) {
    return null;
  }

  return $LiveGuardListModelCopyWith<$Res>(_self.guardList!, (value) {
    return _then(_self.copyWith(guardList: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePlayUrlModelCopyWith<$Res>? get playUrl {
    if (_self.playUrl == null) {
    return null;
  }

  return $LivePlayUrlModelCopyWith<$Res>(_self.playUrl!, (value) {
    return _then(_self.copyWith(playUrl: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveDanmakuConfigModelCopyWith<$Res>? get danmakuConfig {
    if (_self.danmakuConfig == null) {
    return null;
  }

  return $LiveDanmakuConfigModelCopyWith<$Res>(_self.danmakuConfig!, (value) {
    return _then(_self.copyWith(danmakuConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveRoomState].
extension LiveRoomStatePatterns on LiveRoomState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRoomState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRoomState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRoomState value)  $default,){
final _that = this;
switch (_that) {
case _LiveRoomState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRoomState value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRoomState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int roomId,  bool isLoading,  AppException? error,  LiveRoomDetailModel? roomInfo,  UserCardModel? anchorInfo,  LiveAnchorInfoModel? liveAnchorInfo,  LiveGoldRankModel? goldRank,  LiveGuardListModel? guardList,  LivePlayUrlModel? playUrl,  LiveDanmakuConfigModel? danmakuConfig,  List<LiveDanmakuItem> danmakuHistory,  bool isPlaying,  double volume,  bool isDanmakuEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRoomState() when $default != null:
return $default(_that.roomId,_that.isLoading,_that.error,_that.roomInfo,_that.anchorInfo,_that.liveAnchorInfo,_that.goldRank,_that.guardList,_that.playUrl,_that.danmakuConfig,_that.danmakuHistory,_that.isPlaying,_that.volume,_that.isDanmakuEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int roomId,  bool isLoading,  AppException? error,  LiveRoomDetailModel? roomInfo,  UserCardModel? anchorInfo,  LiveAnchorInfoModel? liveAnchorInfo,  LiveGoldRankModel? goldRank,  LiveGuardListModel? guardList,  LivePlayUrlModel? playUrl,  LiveDanmakuConfigModel? danmakuConfig,  List<LiveDanmakuItem> danmakuHistory,  bool isPlaying,  double volume,  bool isDanmakuEnabled)  $default,) {final _that = this;
switch (_that) {
case _LiveRoomState():
return $default(_that.roomId,_that.isLoading,_that.error,_that.roomInfo,_that.anchorInfo,_that.liveAnchorInfo,_that.goldRank,_that.guardList,_that.playUrl,_that.danmakuConfig,_that.danmakuHistory,_that.isPlaying,_that.volume,_that.isDanmakuEnabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int roomId,  bool isLoading,  AppException? error,  LiveRoomDetailModel? roomInfo,  UserCardModel? anchorInfo,  LiveAnchorInfoModel? liveAnchorInfo,  LiveGoldRankModel? goldRank,  LiveGuardListModel? guardList,  LivePlayUrlModel? playUrl,  LiveDanmakuConfigModel? danmakuConfig,  List<LiveDanmakuItem> danmakuHistory,  bool isPlaying,  double volume,  bool isDanmakuEnabled)?  $default,) {final _that = this;
switch (_that) {
case _LiveRoomState() when $default != null:
return $default(_that.roomId,_that.isLoading,_that.error,_that.roomInfo,_that.anchorInfo,_that.liveAnchorInfo,_that.goldRank,_that.guardList,_that.playUrl,_that.danmakuConfig,_that.danmakuHistory,_that.isPlaying,_that.volume,_that.isDanmakuEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _LiveRoomState implements LiveRoomState {
  const _LiveRoomState({required this.roomId, this.isLoading = true, this.error, this.roomInfo, this.anchorInfo, this.liveAnchorInfo, this.goldRank, this.guardList, this.playUrl, this.danmakuConfig, final  List<LiveDanmakuItem> danmakuHistory = const [], this.isPlaying = false, this.volume = 1.0, this.isDanmakuEnabled = false}): _danmakuHistory = danmakuHistory;
  

@override final  int roomId;
@override@JsonKey() final  bool isLoading;
@override final  AppException? error;
@override final  LiveRoomDetailModel? roomInfo;
@override final  UserCardModel? anchorInfo;
@override final  LiveAnchorInfoModel? liveAnchorInfo;
@override final  LiveGoldRankModel? goldRank;
@override final  LiveGuardListModel? guardList;
@override final  LivePlayUrlModel? playUrl;
@override final  LiveDanmakuConfigModel? danmakuConfig;
 final  List<LiveDanmakuItem> _danmakuHistory;
@override@JsonKey() List<LiveDanmakuItem> get danmakuHistory {
  if (_danmakuHistory is EqualUnmodifiableListView) return _danmakuHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_danmakuHistory);
}

@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  double volume;
@override@JsonKey() final  bool isDanmakuEnabled;

/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRoomStateCopyWith<_LiveRoomState> get copyWith => __$LiveRoomStateCopyWithImpl<_LiveRoomState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRoomState&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.roomInfo, roomInfo) || other.roomInfo == roomInfo)&&(identical(other.anchorInfo, anchorInfo) || other.anchorInfo == anchorInfo)&&(identical(other.liveAnchorInfo, liveAnchorInfo) || other.liveAnchorInfo == liveAnchorInfo)&&(identical(other.goldRank, goldRank) || other.goldRank == goldRank)&&(identical(other.guardList, guardList) || other.guardList == guardList)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&(identical(other.danmakuConfig, danmakuConfig) || other.danmakuConfig == danmakuConfig)&&const DeepCollectionEquality().equals(other._danmakuHistory, _danmakuHistory)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.isDanmakuEnabled, isDanmakuEnabled) || other.isDanmakuEnabled == isDanmakuEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,roomId,isLoading,error,roomInfo,anchorInfo,liveAnchorInfo,goldRank,guardList,playUrl,danmakuConfig,const DeepCollectionEquality().hash(_danmakuHistory),isPlaying,volume,isDanmakuEnabled);

@override
String toString() {
  return 'LiveRoomState(roomId: $roomId, isLoading: $isLoading, error: $error, roomInfo: $roomInfo, anchorInfo: $anchorInfo, liveAnchorInfo: $liveAnchorInfo, goldRank: $goldRank, guardList: $guardList, playUrl: $playUrl, danmakuConfig: $danmakuConfig, danmakuHistory: $danmakuHistory, isPlaying: $isPlaying, volume: $volume, isDanmakuEnabled: $isDanmakuEnabled)';
}


}

/// @nodoc
abstract mixin class _$LiveRoomStateCopyWith<$Res> implements $LiveRoomStateCopyWith<$Res> {
  factory _$LiveRoomStateCopyWith(_LiveRoomState value, $Res Function(_LiveRoomState) _then) = __$LiveRoomStateCopyWithImpl;
@override @useResult
$Res call({
 int roomId, bool isLoading, AppException? error, LiveRoomDetailModel? roomInfo, UserCardModel? anchorInfo, LiveAnchorInfoModel? liveAnchorInfo, LiveGoldRankModel? goldRank, LiveGuardListModel? guardList, LivePlayUrlModel? playUrl, LiveDanmakuConfigModel? danmakuConfig, List<LiveDanmakuItem> danmakuHistory, bool isPlaying, double volume, bool isDanmakuEnabled
});


@override $LiveRoomDetailModelCopyWith<$Res>? get roomInfo;@override $UserCardModelCopyWith<$Res>? get anchorInfo;@override $LiveAnchorInfoModelCopyWith<$Res>? get liveAnchorInfo;@override $LiveGoldRankModelCopyWith<$Res>? get goldRank;@override $LiveGuardListModelCopyWith<$Res>? get guardList;@override $LivePlayUrlModelCopyWith<$Res>? get playUrl;@override $LiveDanmakuConfigModelCopyWith<$Res>? get danmakuConfig;

}
/// @nodoc
class __$LiveRoomStateCopyWithImpl<$Res>
    implements _$LiveRoomStateCopyWith<$Res> {
  __$LiveRoomStateCopyWithImpl(this._self, this._then);

  final _LiveRoomState _self;
  final $Res Function(_LiveRoomState) _then;

/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? isLoading = null,Object? error = freezed,Object? roomInfo = freezed,Object? anchorInfo = freezed,Object? liveAnchorInfo = freezed,Object? goldRank = freezed,Object? guardList = freezed,Object? playUrl = freezed,Object? danmakuConfig = freezed,Object? danmakuHistory = null,Object? isPlaying = null,Object? volume = null,Object? isDanmakuEnabled = null,}) {
  return _then(_LiveRoomState(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,roomInfo: freezed == roomInfo ? _self.roomInfo : roomInfo // ignore: cast_nullable_to_non_nullable
as LiveRoomDetailModel?,anchorInfo: freezed == anchorInfo ? _self.anchorInfo : anchorInfo // ignore: cast_nullable_to_non_nullable
as UserCardModel?,liveAnchorInfo: freezed == liveAnchorInfo ? _self.liveAnchorInfo : liveAnchorInfo // ignore: cast_nullable_to_non_nullable
as LiveAnchorInfoModel?,goldRank: freezed == goldRank ? _self.goldRank : goldRank // ignore: cast_nullable_to_non_nullable
as LiveGoldRankModel?,guardList: freezed == guardList ? _self.guardList : guardList // ignore: cast_nullable_to_non_nullable
as LiveGuardListModel?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as LivePlayUrlModel?,danmakuConfig: freezed == danmakuConfig ? _self.danmakuConfig : danmakuConfig // ignore: cast_nullable_to_non_nullable
as LiveDanmakuConfigModel?,danmakuHistory: null == danmakuHistory ? _self._danmakuHistory : danmakuHistory // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuItem>,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,isDanmakuEnabled: null == isDanmakuEnabled ? _self.isDanmakuEnabled : isDanmakuEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveRoomDetailModelCopyWith<$Res>? get roomInfo {
    if (_self.roomInfo == null) {
    return null;
  }

  return $LiveRoomDetailModelCopyWith<$Res>(_self.roomInfo!, (value) {
    return _then(_self.copyWith(roomInfo: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCardModelCopyWith<$Res>? get anchorInfo {
    if (_self.anchorInfo == null) {
    return null;
  }

  return $UserCardModelCopyWith<$Res>(_self.anchorInfo!, (value) {
    return _then(_self.copyWith(anchorInfo: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAnchorInfoModelCopyWith<$Res>? get liveAnchorInfo {
    if (_self.liveAnchorInfo == null) {
    return null;
  }

  return $LiveAnchorInfoModelCopyWith<$Res>(_self.liveAnchorInfo!, (value) {
    return _then(_self.copyWith(liveAnchorInfo: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGoldRankModelCopyWith<$Res>? get goldRank {
    if (_self.goldRank == null) {
    return null;
  }

  return $LiveGoldRankModelCopyWith<$Res>(_self.goldRank!, (value) {
    return _then(_self.copyWith(goldRank: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGuardListModelCopyWith<$Res>? get guardList {
    if (_self.guardList == null) {
    return null;
  }

  return $LiveGuardListModelCopyWith<$Res>(_self.guardList!, (value) {
    return _then(_self.copyWith(guardList: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePlayUrlModelCopyWith<$Res>? get playUrl {
    if (_self.playUrl == null) {
    return null;
  }

  return $LivePlayUrlModelCopyWith<$Res>(_self.playUrl!, (value) {
    return _then(_self.copyWith(playUrl: value));
  });
}/// Create a copy of LiveRoomState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveDanmakuConfigModelCopyWith<$Res>? get danmakuConfig {
    if (_self.danmakuConfig == null) {
    return null;
  }

  return $LiveDanmakuConfigModelCopyWith<$Res>(_self.danmakuConfig!, (value) {
    return _then(_self.copyWith(danmakuConfig: value));
  });
}
}

// dart format on
