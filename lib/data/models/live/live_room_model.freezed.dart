// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveRoomModel {

@JsonKey(name: 'roomid') int get roomId;@JsonKey(name: 'uid') int get uid; String get title; String get uname; String get cover; String get face;@JsonKey(name: 'online') int get online;@JsonKey(name: 'area_v2_name') String get areaName;@JsonKey(name: 'area_v2_parent_name') String get parentAreaName;@JsonKey(name: 'link') String get link;@JsonKey(name: 'keyframe') String? get keyframe;@JsonKey(name: 'watched_show') WatchedShow? get watchedShow;@JsonKey(name: 'is_auto_play') int? get isAutoPlay;
/// Create a copy of LiveRoomModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRoomModelCopyWith<LiveRoomModel> get copyWith => _$LiveRoomModelCopyWithImpl<LiveRoomModel>(this as LiveRoomModel, _$identity);

  /// Serializes this LiveRoomModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRoomModel&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.title, title) || other.title == title)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.face, face) || other.face == face)&&(identical(other.online, online) || other.online == online)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.parentAreaName, parentAreaName) || other.parentAreaName == parentAreaName)&&(identical(other.link, link) || other.link == link)&&(identical(other.keyframe, keyframe) || other.keyframe == keyframe)&&(identical(other.watchedShow, watchedShow) || other.watchedShow == watchedShow)&&(identical(other.isAutoPlay, isAutoPlay) || other.isAutoPlay == isAutoPlay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,uid,title,uname,cover,face,online,areaName,parentAreaName,link,keyframe,watchedShow,isAutoPlay);

@override
String toString() {
  return 'LiveRoomModel(roomId: $roomId, uid: $uid, title: $title, uname: $uname, cover: $cover, face: $face, online: $online, areaName: $areaName, parentAreaName: $parentAreaName, link: $link, keyframe: $keyframe, watchedShow: $watchedShow, isAutoPlay: $isAutoPlay)';
}


}

/// @nodoc
abstract mixin class $LiveRoomModelCopyWith<$Res>  {
  factory $LiveRoomModelCopyWith(LiveRoomModel value, $Res Function(LiveRoomModel) _then) = _$LiveRoomModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'roomid') int roomId,@JsonKey(name: 'uid') int uid, String title, String uname, String cover, String face,@JsonKey(name: 'online') int online,@JsonKey(name: 'area_v2_name') String areaName,@JsonKey(name: 'area_v2_parent_name') String parentAreaName,@JsonKey(name: 'link') String link,@JsonKey(name: 'keyframe') String? keyframe,@JsonKey(name: 'watched_show') WatchedShow? watchedShow,@JsonKey(name: 'is_auto_play') int? isAutoPlay
});


$WatchedShowCopyWith<$Res>? get watchedShow;

}
/// @nodoc
class _$LiveRoomModelCopyWithImpl<$Res>
    implements $LiveRoomModelCopyWith<$Res> {
  _$LiveRoomModelCopyWithImpl(this._self, this._then);

  final LiveRoomModel _self;
  final $Res Function(LiveRoomModel) _then;

/// Create a copy of LiveRoomModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? uid = null,Object? title = null,Object? uname = null,Object? cover = null,Object? face = null,Object? online = null,Object? areaName = null,Object? parentAreaName = null,Object? link = null,Object? keyframe = freezed,Object? watchedShow = freezed,Object? isAutoPlay = freezed,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,parentAreaName: null == parentAreaName ? _self.parentAreaName : parentAreaName // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,keyframe: freezed == keyframe ? _self.keyframe : keyframe // ignore: cast_nullable_to_non_nullable
as String?,watchedShow: freezed == watchedShow ? _self.watchedShow : watchedShow // ignore: cast_nullable_to_non_nullable
as WatchedShow?,isAutoPlay: freezed == isAutoPlay ? _self.isAutoPlay : isAutoPlay // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of LiveRoomModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WatchedShowCopyWith<$Res>? get watchedShow {
    if (_self.watchedShow == null) {
    return null;
  }

  return $WatchedShowCopyWith<$Res>(_self.watchedShow!, (value) {
    return _then(_self.copyWith(watchedShow: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveRoomModel].
extension LiveRoomModelPatterns on LiveRoomModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRoomModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRoomModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRoomModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveRoomModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRoomModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRoomModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'roomid')  int roomId, @JsonKey(name: 'uid')  int uid,  String title,  String uname,  String cover,  String face, @JsonKey(name: 'online')  int online, @JsonKey(name: 'area_v2_name')  String areaName, @JsonKey(name: 'area_v2_parent_name')  String parentAreaName, @JsonKey(name: 'link')  String link, @JsonKey(name: 'keyframe')  String? keyframe, @JsonKey(name: 'watched_show')  WatchedShow? watchedShow, @JsonKey(name: 'is_auto_play')  int? isAutoPlay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRoomModel() when $default != null:
return $default(_that.roomId,_that.uid,_that.title,_that.uname,_that.cover,_that.face,_that.online,_that.areaName,_that.parentAreaName,_that.link,_that.keyframe,_that.watchedShow,_that.isAutoPlay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'roomid')  int roomId, @JsonKey(name: 'uid')  int uid,  String title,  String uname,  String cover,  String face, @JsonKey(name: 'online')  int online, @JsonKey(name: 'area_v2_name')  String areaName, @JsonKey(name: 'area_v2_parent_name')  String parentAreaName, @JsonKey(name: 'link')  String link, @JsonKey(name: 'keyframe')  String? keyframe, @JsonKey(name: 'watched_show')  WatchedShow? watchedShow, @JsonKey(name: 'is_auto_play')  int? isAutoPlay)  $default,) {final _that = this;
switch (_that) {
case _LiveRoomModel():
return $default(_that.roomId,_that.uid,_that.title,_that.uname,_that.cover,_that.face,_that.online,_that.areaName,_that.parentAreaName,_that.link,_that.keyframe,_that.watchedShow,_that.isAutoPlay);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'roomid')  int roomId, @JsonKey(name: 'uid')  int uid,  String title,  String uname,  String cover,  String face, @JsonKey(name: 'online')  int online, @JsonKey(name: 'area_v2_name')  String areaName, @JsonKey(name: 'area_v2_parent_name')  String parentAreaName, @JsonKey(name: 'link')  String link, @JsonKey(name: 'keyframe')  String? keyframe, @JsonKey(name: 'watched_show')  WatchedShow? watchedShow, @JsonKey(name: 'is_auto_play')  int? isAutoPlay)?  $default,) {final _that = this;
switch (_that) {
case _LiveRoomModel() when $default != null:
return $default(_that.roomId,_that.uid,_that.title,_that.uname,_that.cover,_that.face,_that.online,_that.areaName,_that.parentAreaName,_that.link,_that.keyframe,_that.watchedShow,_that.isAutoPlay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveRoomModel implements LiveRoomModel {
  const _LiveRoomModel({@JsonKey(name: 'roomid') required this.roomId, @JsonKey(name: 'uid') required this.uid, required this.title, required this.uname, required this.cover, required this.face, @JsonKey(name: 'online') required this.online, @JsonKey(name: 'area_v2_name') required this.areaName, @JsonKey(name: 'area_v2_parent_name') required this.parentAreaName, @JsonKey(name: 'link') required this.link, @JsonKey(name: 'keyframe') this.keyframe, @JsonKey(name: 'watched_show') this.watchedShow, @JsonKey(name: 'is_auto_play') this.isAutoPlay});
  factory _LiveRoomModel.fromJson(Map<String, dynamic> json) => _$LiveRoomModelFromJson(json);

@override@JsonKey(name: 'roomid') final  int roomId;
@override@JsonKey(name: 'uid') final  int uid;
@override final  String title;
@override final  String uname;
@override final  String cover;
@override final  String face;
@override@JsonKey(name: 'online') final  int online;
@override@JsonKey(name: 'area_v2_name') final  String areaName;
@override@JsonKey(name: 'area_v2_parent_name') final  String parentAreaName;
@override@JsonKey(name: 'link') final  String link;
@override@JsonKey(name: 'keyframe') final  String? keyframe;
@override@JsonKey(name: 'watched_show') final  WatchedShow? watchedShow;
@override@JsonKey(name: 'is_auto_play') final  int? isAutoPlay;

/// Create a copy of LiveRoomModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRoomModelCopyWith<_LiveRoomModel> get copyWith => __$LiveRoomModelCopyWithImpl<_LiveRoomModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveRoomModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRoomModel&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.title, title) || other.title == title)&&(identical(other.uname, uname) || other.uname == uname)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.face, face) || other.face == face)&&(identical(other.online, online) || other.online == online)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.parentAreaName, parentAreaName) || other.parentAreaName == parentAreaName)&&(identical(other.link, link) || other.link == link)&&(identical(other.keyframe, keyframe) || other.keyframe == keyframe)&&(identical(other.watchedShow, watchedShow) || other.watchedShow == watchedShow)&&(identical(other.isAutoPlay, isAutoPlay) || other.isAutoPlay == isAutoPlay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,uid,title,uname,cover,face,online,areaName,parentAreaName,link,keyframe,watchedShow,isAutoPlay);

@override
String toString() {
  return 'LiveRoomModel(roomId: $roomId, uid: $uid, title: $title, uname: $uname, cover: $cover, face: $face, online: $online, areaName: $areaName, parentAreaName: $parentAreaName, link: $link, keyframe: $keyframe, watchedShow: $watchedShow, isAutoPlay: $isAutoPlay)';
}


}

/// @nodoc
abstract mixin class _$LiveRoomModelCopyWith<$Res> implements $LiveRoomModelCopyWith<$Res> {
  factory _$LiveRoomModelCopyWith(_LiveRoomModel value, $Res Function(_LiveRoomModel) _then) = __$LiveRoomModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'roomid') int roomId,@JsonKey(name: 'uid') int uid, String title, String uname, String cover, String face,@JsonKey(name: 'online') int online,@JsonKey(name: 'area_v2_name') String areaName,@JsonKey(name: 'area_v2_parent_name') String parentAreaName,@JsonKey(name: 'link') String link,@JsonKey(name: 'keyframe') String? keyframe,@JsonKey(name: 'watched_show') WatchedShow? watchedShow,@JsonKey(name: 'is_auto_play') int? isAutoPlay
});


@override $WatchedShowCopyWith<$Res>? get watchedShow;

}
/// @nodoc
class __$LiveRoomModelCopyWithImpl<$Res>
    implements _$LiveRoomModelCopyWith<$Res> {
  __$LiveRoomModelCopyWithImpl(this._self, this._then);

  final _LiveRoomModel _self;
  final $Res Function(_LiveRoomModel) _then;

/// Create a copy of LiveRoomModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? uid = null,Object? title = null,Object? uname = null,Object? cover = null,Object? face = null,Object? online = null,Object? areaName = null,Object? parentAreaName = null,Object? link = null,Object? keyframe = freezed,Object? watchedShow = freezed,Object? isAutoPlay = freezed,}) {
  return _then(_LiveRoomModel(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as String,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,parentAreaName: null == parentAreaName ? _self.parentAreaName : parentAreaName // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,keyframe: freezed == keyframe ? _self.keyframe : keyframe // ignore: cast_nullable_to_non_nullable
as String?,watchedShow: freezed == watchedShow ? _self.watchedShow : watchedShow // ignore: cast_nullable_to_non_nullable
as WatchedShow?,isAutoPlay: freezed == isAutoPlay ? _self.isAutoPlay : isAutoPlay // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of LiveRoomModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WatchedShowCopyWith<$Res>? get watchedShow {
    if (_self.watchedShow == null) {
    return null;
  }

  return $WatchedShowCopyWith<$Res>(_self.watchedShow!, (value) {
    return _then(_self.copyWith(watchedShow: value));
  });
}
}


/// @nodoc
mixin _$WatchedShow {

@JsonKey(name: 'switch') bool get switchStatus; int get num;@JsonKey(name: 'text_small') String get textSmall;@JsonKey(name: 'text_large') String get textLarge; String get icon;@JsonKey(name: 'icon_web') String get iconWeb;
/// Create a copy of WatchedShow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchedShowCopyWith<WatchedShow> get copyWith => _$WatchedShowCopyWithImpl<WatchedShow>(this as WatchedShow, _$identity);

  /// Serializes this WatchedShow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchedShow&&(identical(other.switchStatus, switchStatus) || other.switchStatus == switchStatus)&&(identical(other.num, num) || other.num == num)&&(identical(other.textSmall, textSmall) || other.textSmall == textSmall)&&(identical(other.textLarge, textLarge) || other.textLarge == textLarge)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconWeb, iconWeb) || other.iconWeb == iconWeb));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,switchStatus,num,textSmall,textLarge,icon,iconWeb);

@override
String toString() {
  return 'WatchedShow(switchStatus: $switchStatus, num: $num, textSmall: $textSmall, textLarge: $textLarge, icon: $icon, iconWeb: $iconWeb)';
}


}

/// @nodoc
abstract mixin class $WatchedShowCopyWith<$Res>  {
  factory $WatchedShowCopyWith(WatchedShow value, $Res Function(WatchedShow) _then) = _$WatchedShowCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'switch') bool switchStatus, int num,@JsonKey(name: 'text_small') String textSmall,@JsonKey(name: 'text_large') String textLarge, String icon,@JsonKey(name: 'icon_web') String iconWeb
});




}
/// @nodoc
class _$WatchedShowCopyWithImpl<$Res>
    implements $WatchedShowCopyWith<$Res> {
  _$WatchedShowCopyWithImpl(this._self, this._then);

  final WatchedShow _self;
  final $Res Function(WatchedShow) _then;

/// Create a copy of WatchedShow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? switchStatus = null,Object? num = null,Object? textSmall = null,Object? textLarge = null,Object? icon = null,Object? iconWeb = null,}) {
  return _then(_self.copyWith(
switchStatus: null == switchStatus ? _self.switchStatus : switchStatus // ignore: cast_nullable_to_non_nullable
as bool,num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,textSmall: null == textSmall ? _self.textSmall : textSmall // ignore: cast_nullable_to_non_nullable
as String,textLarge: null == textLarge ? _self.textLarge : textLarge // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,iconWeb: null == iconWeb ? _self.iconWeb : iconWeb // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchedShow].
extension WatchedShowPatterns on WatchedShow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchedShow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchedShow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchedShow value)  $default,){
final _that = this;
switch (_that) {
case _WatchedShow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchedShow value)?  $default,){
final _that = this;
switch (_that) {
case _WatchedShow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'switch')  bool switchStatus,  int num, @JsonKey(name: 'text_small')  String textSmall, @JsonKey(name: 'text_large')  String textLarge,  String icon, @JsonKey(name: 'icon_web')  String iconWeb)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchedShow() when $default != null:
return $default(_that.switchStatus,_that.num,_that.textSmall,_that.textLarge,_that.icon,_that.iconWeb);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'switch')  bool switchStatus,  int num, @JsonKey(name: 'text_small')  String textSmall, @JsonKey(name: 'text_large')  String textLarge,  String icon, @JsonKey(name: 'icon_web')  String iconWeb)  $default,) {final _that = this;
switch (_that) {
case _WatchedShow():
return $default(_that.switchStatus,_that.num,_that.textSmall,_that.textLarge,_that.icon,_that.iconWeb);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'switch')  bool switchStatus,  int num, @JsonKey(name: 'text_small')  String textSmall, @JsonKey(name: 'text_large')  String textLarge,  String icon, @JsonKey(name: 'icon_web')  String iconWeb)?  $default,) {final _that = this;
switch (_that) {
case _WatchedShow() when $default != null:
return $default(_that.switchStatus,_that.num,_that.textSmall,_that.textLarge,_that.icon,_that.iconWeb);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchedShow implements WatchedShow {
  const _WatchedShow({@JsonKey(name: 'switch') required this.switchStatus, required this.num, @JsonKey(name: 'text_small') required this.textSmall, @JsonKey(name: 'text_large') required this.textLarge, required this.icon, @JsonKey(name: 'icon_web') required this.iconWeb});
  factory _WatchedShow.fromJson(Map<String, dynamic> json) => _$WatchedShowFromJson(json);

@override@JsonKey(name: 'switch') final  bool switchStatus;
@override final  int num;
@override@JsonKey(name: 'text_small') final  String textSmall;
@override@JsonKey(name: 'text_large') final  String textLarge;
@override final  String icon;
@override@JsonKey(name: 'icon_web') final  String iconWeb;

/// Create a copy of WatchedShow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchedShowCopyWith<_WatchedShow> get copyWith => __$WatchedShowCopyWithImpl<_WatchedShow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchedShowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchedShow&&(identical(other.switchStatus, switchStatus) || other.switchStatus == switchStatus)&&(identical(other.num, num) || other.num == num)&&(identical(other.textSmall, textSmall) || other.textSmall == textSmall)&&(identical(other.textLarge, textLarge) || other.textLarge == textLarge)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconWeb, iconWeb) || other.iconWeb == iconWeb));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,switchStatus,num,textSmall,textLarge,icon,iconWeb);

@override
String toString() {
  return 'WatchedShow(switchStatus: $switchStatus, num: $num, textSmall: $textSmall, textLarge: $textLarge, icon: $icon, iconWeb: $iconWeb)';
}


}

/// @nodoc
abstract mixin class _$WatchedShowCopyWith<$Res> implements $WatchedShowCopyWith<$Res> {
  factory _$WatchedShowCopyWith(_WatchedShow value, $Res Function(_WatchedShow) _then) = __$WatchedShowCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'switch') bool switchStatus, int num,@JsonKey(name: 'text_small') String textSmall,@JsonKey(name: 'text_large') String textLarge, String icon,@JsonKey(name: 'icon_web') String iconWeb
});




}
/// @nodoc
class __$WatchedShowCopyWithImpl<$Res>
    implements _$WatchedShowCopyWith<$Res> {
  __$WatchedShowCopyWithImpl(this._self, this._then);

  final _WatchedShow _self;
  final $Res Function(_WatchedShow) _then;

/// Create a copy of WatchedShow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? switchStatus = null,Object? num = null,Object? textSmall = null,Object? textLarge = null,Object? icon = null,Object? iconWeb = null,}) {
  return _then(_WatchedShow(
switchStatus: null == switchStatus ? _self.switchStatus : switchStatus // ignore: cast_nullable_to_non_nullable
as bool,num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,textSmall: null == textSmall ? _self.textSmall : textSmall // ignore: cast_nullable_to_non_nullable
as String,textLarge: null == textLarge ? _self.textLarge : textLarge // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,iconWeb: null == iconWeb ? _self.iconWeb : iconWeb // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
