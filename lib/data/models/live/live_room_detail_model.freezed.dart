// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_room_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveRoomDetailModel {

 int get uid;@JsonKey(name: 'room_id') int get roomId;@JsonKey(name: 'short_id') int get shortId; int get attention; int get online;@JsonKey(name: 'is_portrait') bool get isPortrait; String get description;@JsonKey(name: 'live_status') int get liveStatus;@JsonKey(name: 'area_id') int get areaId;@JsonKey(name: 'parent_area_id') int get parentAreaId;@JsonKey(name: 'parent_area_name') String get parentAreaName;@JsonKey(name: 'old_area_id') int get oldAreaId; String get background; String get title;@JsonKey(name: 'user_cover') String get userCover; String get keyframe;@JsonKey(name: 'is_strict_room') bool get isStrictRoom;@JsonKey(name: 'live_time') String get liveTime; String get tags;@JsonKey(name: 'is_anchor') int get isAnchor;@JsonKey(name: 'room_silent_type') String get roomSilentType;@JsonKey(name: 'room_silent_level') int get roomSilentLevel;@JsonKey(name: 'room_silent_second') int get roomSilentSecond;@JsonKey(name: 'area_name') String get areaName; String get pendants;@JsonKey(name: 'area_pendants') String get areaPendants;@JsonKey(name: 'hot_words') List<String> get hotWords;@JsonKey(name: 'hot_words_status') int get hotWordsStatus; String get verify;@JsonKey(name: 'new_pendants') Map<String, dynamic> get newPendants;@JsonKey(name: 'up_session') String get upSession;@JsonKey(name: 'pk_status') int get pkStatus;@JsonKey(name: 'pk_id') int get pkId;@JsonKey(name: 'battle_id') int get battleId;@JsonKey(name: 'allow_change_area_time') int get allowChangeAreaTime;@JsonKey(name: 'allow_upload_cover_time') int get allowUploadCoverTime;@JsonKey(name: 'studio_info') Map<String, dynamic> get studioInfo;
/// Create a copy of LiveRoomDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRoomDetailModelCopyWith<LiveRoomDetailModel> get copyWith => _$LiveRoomDetailModelCopyWithImpl<LiveRoomDetailModel>(this as LiveRoomDetailModel, _$identity);

  /// Serializes this LiveRoomDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRoomDetailModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.shortId, shortId) || other.shortId == shortId)&&(identical(other.attention, attention) || other.attention == attention)&&(identical(other.online, online) || other.online == online)&&(identical(other.isPortrait, isPortrait) || other.isPortrait == isPortrait)&&(identical(other.description, description) || other.description == description)&&(identical(other.liveStatus, liveStatus) || other.liveStatus == liveStatus)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.parentAreaId, parentAreaId) || other.parentAreaId == parentAreaId)&&(identical(other.parentAreaName, parentAreaName) || other.parentAreaName == parentAreaName)&&(identical(other.oldAreaId, oldAreaId) || other.oldAreaId == oldAreaId)&&(identical(other.background, background) || other.background == background)&&(identical(other.title, title) || other.title == title)&&(identical(other.userCover, userCover) || other.userCover == userCover)&&(identical(other.keyframe, keyframe) || other.keyframe == keyframe)&&(identical(other.isStrictRoom, isStrictRoom) || other.isStrictRoom == isStrictRoom)&&(identical(other.liveTime, liveTime) || other.liveTime == liveTime)&&(identical(other.tags, tags) || other.tags == tags)&&(identical(other.isAnchor, isAnchor) || other.isAnchor == isAnchor)&&(identical(other.roomSilentType, roomSilentType) || other.roomSilentType == roomSilentType)&&(identical(other.roomSilentLevel, roomSilentLevel) || other.roomSilentLevel == roomSilentLevel)&&(identical(other.roomSilentSecond, roomSilentSecond) || other.roomSilentSecond == roomSilentSecond)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.pendants, pendants) || other.pendants == pendants)&&(identical(other.areaPendants, areaPendants) || other.areaPendants == areaPendants)&&const DeepCollectionEquality().equals(other.hotWords, hotWords)&&(identical(other.hotWordsStatus, hotWordsStatus) || other.hotWordsStatus == hotWordsStatus)&&(identical(other.verify, verify) || other.verify == verify)&&const DeepCollectionEquality().equals(other.newPendants, newPendants)&&(identical(other.upSession, upSession) || other.upSession == upSession)&&(identical(other.pkStatus, pkStatus) || other.pkStatus == pkStatus)&&(identical(other.pkId, pkId) || other.pkId == pkId)&&(identical(other.battleId, battleId) || other.battleId == battleId)&&(identical(other.allowChangeAreaTime, allowChangeAreaTime) || other.allowChangeAreaTime == allowChangeAreaTime)&&(identical(other.allowUploadCoverTime, allowUploadCoverTime) || other.allowUploadCoverTime == allowUploadCoverTime)&&const DeepCollectionEquality().equals(other.studioInfo, studioInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,roomId,shortId,attention,online,isPortrait,description,liveStatus,areaId,parentAreaId,parentAreaName,oldAreaId,background,title,userCover,keyframe,isStrictRoom,liveTime,tags,isAnchor,roomSilentType,roomSilentLevel,roomSilentSecond,areaName,pendants,areaPendants,const DeepCollectionEquality().hash(hotWords),hotWordsStatus,verify,const DeepCollectionEquality().hash(newPendants),upSession,pkStatus,pkId,battleId,allowChangeAreaTime,allowUploadCoverTime,const DeepCollectionEquality().hash(studioInfo)]);

@override
String toString() {
  return 'LiveRoomDetailModel(uid: $uid, roomId: $roomId, shortId: $shortId, attention: $attention, online: $online, isPortrait: $isPortrait, description: $description, liveStatus: $liveStatus, areaId: $areaId, parentAreaId: $parentAreaId, parentAreaName: $parentAreaName, oldAreaId: $oldAreaId, background: $background, title: $title, userCover: $userCover, keyframe: $keyframe, isStrictRoom: $isStrictRoom, liveTime: $liveTime, tags: $tags, isAnchor: $isAnchor, roomSilentType: $roomSilentType, roomSilentLevel: $roomSilentLevel, roomSilentSecond: $roomSilentSecond, areaName: $areaName, pendants: $pendants, areaPendants: $areaPendants, hotWords: $hotWords, hotWordsStatus: $hotWordsStatus, verify: $verify, newPendants: $newPendants, upSession: $upSession, pkStatus: $pkStatus, pkId: $pkId, battleId: $battleId, allowChangeAreaTime: $allowChangeAreaTime, allowUploadCoverTime: $allowUploadCoverTime, studioInfo: $studioInfo)';
}


}

/// @nodoc
abstract mixin class $LiveRoomDetailModelCopyWith<$Res>  {
  factory $LiveRoomDetailModelCopyWith(LiveRoomDetailModel value, $Res Function(LiveRoomDetailModel) _then) = _$LiveRoomDetailModelCopyWithImpl;
@useResult
$Res call({
 int uid,@JsonKey(name: 'room_id') int roomId,@JsonKey(name: 'short_id') int shortId, int attention, int online,@JsonKey(name: 'is_portrait') bool isPortrait, String description,@JsonKey(name: 'live_status') int liveStatus,@JsonKey(name: 'area_id') int areaId,@JsonKey(name: 'parent_area_id') int parentAreaId,@JsonKey(name: 'parent_area_name') String parentAreaName,@JsonKey(name: 'old_area_id') int oldAreaId, String background, String title,@JsonKey(name: 'user_cover') String userCover, String keyframe,@JsonKey(name: 'is_strict_room') bool isStrictRoom,@JsonKey(name: 'live_time') String liveTime, String tags,@JsonKey(name: 'is_anchor') int isAnchor,@JsonKey(name: 'room_silent_type') String roomSilentType,@JsonKey(name: 'room_silent_level') int roomSilentLevel,@JsonKey(name: 'room_silent_second') int roomSilentSecond,@JsonKey(name: 'area_name') String areaName, String pendants,@JsonKey(name: 'area_pendants') String areaPendants,@JsonKey(name: 'hot_words') List<String> hotWords,@JsonKey(name: 'hot_words_status') int hotWordsStatus, String verify,@JsonKey(name: 'new_pendants') Map<String, dynamic> newPendants,@JsonKey(name: 'up_session') String upSession,@JsonKey(name: 'pk_status') int pkStatus,@JsonKey(name: 'pk_id') int pkId,@JsonKey(name: 'battle_id') int battleId,@JsonKey(name: 'allow_change_area_time') int allowChangeAreaTime,@JsonKey(name: 'allow_upload_cover_time') int allowUploadCoverTime,@JsonKey(name: 'studio_info') Map<String, dynamic> studioInfo
});




}
/// @nodoc
class _$LiveRoomDetailModelCopyWithImpl<$Res>
    implements $LiveRoomDetailModelCopyWith<$Res> {
  _$LiveRoomDetailModelCopyWithImpl(this._self, this._then);

  final LiveRoomDetailModel _self;
  final $Res Function(LiveRoomDetailModel) _then;

/// Create a copy of LiveRoomDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? roomId = null,Object? shortId = null,Object? attention = null,Object? online = null,Object? isPortrait = null,Object? description = null,Object? liveStatus = null,Object? areaId = null,Object? parentAreaId = null,Object? parentAreaName = null,Object? oldAreaId = null,Object? background = null,Object? title = null,Object? userCover = null,Object? keyframe = null,Object? isStrictRoom = null,Object? liveTime = null,Object? tags = null,Object? isAnchor = null,Object? roomSilentType = null,Object? roomSilentLevel = null,Object? roomSilentSecond = null,Object? areaName = null,Object? pendants = null,Object? areaPendants = null,Object? hotWords = null,Object? hotWordsStatus = null,Object? verify = null,Object? newPendants = null,Object? upSession = null,Object? pkStatus = null,Object? pkId = null,Object? battleId = null,Object? allowChangeAreaTime = null,Object? allowUploadCoverTime = null,Object? studioInfo = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,shortId: null == shortId ? _self.shortId : shortId // ignore: cast_nullable_to_non_nullable
as int,attention: null == attention ? _self.attention : attention // ignore: cast_nullable_to_non_nullable
as int,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as int,isPortrait: null == isPortrait ? _self.isPortrait : isPortrait // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,liveStatus: null == liveStatus ? _self.liveStatus : liveStatus // ignore: cast_nullable_to_non_nullable
as int,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,parentAreaId: null == parentAreaId ? _self.parentAreaId : parentAreaId // ignore: cast_nullable_to_non_nullable
as int,parentAreaName: null == parentAreaName ? _self.parentAreaName : parentAreaName // ignore: cast_nullable_to_non_nullable
as String,oldAreaId: null == oldAreaId ? _self.oldAreaId : oldAreaId // ignore: cast_nullable_to_non_nullable
as int,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,userCover: null == userCover ? _self.userCover : userCover // ignore: cast_nullable_to_non_nullable
as String,keyframe: null == keyframe ? _self.keyframe : keyframe // ignore: cast_nullable_to_non_nullable
as String,isStrictRoom: null == isStrictRoom ? _self.isStrictRoom : isStrictRoom // ignore: cast_nullable_to_non_nullable
as bool,liveTime: null == liveTime ? _self.liveTime : liveTime // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as String,isAnchor: null == isAnchor ? _self.isAnchor : isAnchor // ignore: cast_nullable_to_non_nullable
as int,roomSilentType: null == roomSilentType ? _self.roomSilentType : roomSilentType // ignore: cast_nullable_to_non_nullable
as String,roomSilentLevel: null == roomSilentLevel ? _self.roomSilentLevel : roomSilentLevel // ignore: cast_nullable_to_non_nullable
as int,roomSilentSecond: null == roomSilentSecond ? _self.roomSilentSecond : roomSilentSecond // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,pendants: null == pendants ? _self.pendants : pendants // ignore: cast_nullable_to_non_nullable
as String,areaPendants: null == areaPendants ? _self.areaPendants : areaPendants // ignore: cast_nullable_to_non_nullable
as String,hotWords: null == hotWords ? _self.hotWords : hotWords // ignore: cast_nullable_to_non_nullable
as List<String>,hotWordsStatus: null == hotWordsStatus ? _self.hotWordsStatus : hotWordsStatus // ignore: cast_nullable_to_non_nullable
as int,verify: null == verify ? _self.verify : verify // ignore: cast_nullable_to_non_nullable
as String,newPendants: null == newPendants ? _self.newPendants : newPendants // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,upSession: null == upSession ? _self.upSession : upSession // ignore: cast_nullable_to_non_nullable
as String,pkStatus: null == pkStatus ? _self.pkStatus : pkStatus // ignore: cast_nullable_to_non_nullable
as int,pkId: null == pkId ? _self.pkId : pkId // ignore: cast_nullable_to_non_nullable
as int,battleId: null == battleId ? _self.battleId : battleId // ignore: cast_nullable_to_non_nullable
as int,allowChangeAreaTime: null == allowChangeAreaTime ? _self.allowChangeAreaTime : allowChangeAreaTime // ignore: cast_nullable_to_non_nullable
as int,allowUploadCoverTime: null == allowUploadCoverTime ? _self.allowUploadCoverTime : allowUploadCoverTime // ignore: cast_nullable_to_non_nullable
as int,studioInfo: null == studioInfo ? _self.studioInfo : studioInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveRoomDetailModel].
extension LiveRoomDetailModelPatterns on LiveRoomDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRoomDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRoomDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRoomDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveRoomDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRoomDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRoomDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int uid, @JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'short_id')  int shortId,  int attention,  int online, @JsonKey(name: 'is_portrait')  bool isPortrait,  String description, @JsonKey(name: 'live_status')  int liveStatus, @JsonKey(name: 'area_id')  int areaId, @JsonKey(name: 'parent_area_id')  int parentAreaId, @JsonKey(name: 'parent_area_name')  String parentAreaName, @JsonKey(name: 'old_area_id')  int oldAreaId,  String background,  String title, @JsonKey(name: 'user_cover')  String userCover,  String keyframe, @JsonKey(name: 'is_strict_room')  bool isStrictRoom, @JsonKey(name: 'live_time')  String liveTime,  String tags, @JsonKey(name: 'is_anchor')  int isAnchor, @JsonKey(name: 'room_silent_type')  String roomSilentType, @JsonKey(name: 'room_silent_level')  int roomSilentLevel, @JsonKey(name: 'room_silent_second')  int roomSilentSecond, @JsonKey(name: 'area_name')  String areaName,  String pendants, @JsonKey(name: 'area_pendants')  String areaPendants, @JsonKey(name: 'hot_words')  List<String> hotWords, @JsonKey(name: 'hot_words_status')  int hotWordsStatus,  String verify, @JsonKey(name: 'new_pendants')  Map<String, dynamic> newPendants, @JsonKey(name: 'up_session')  String upSession, @JsonKey(name: 'pk_status')  int pkStatus, @JsonKey(name: 'pk_id')  int pkId, @JsonKey(name: 'battle_id')  int battleId, @JsonKey(name: 'allow_change_area_time')  int allowChangeAreaTime, @JsonKey(name: 'allow_upload_cover_time')  int allowUploadCoverTime, @JsonKey(name: 'studio_info')  Map<String, dynamic> studioInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRoomDetailModel() when $default != null:
return $default(_that.uid,_that.roomId,_that.shortId,_that.attention,_that.online,_that.isPortrait,_that.description,_that.liveStatus,_that.areaId,_that.parentAreaId,_that.parentAreaName,_that.oldAreaId,_that.background,_that.title,_that.userCover,_that.keyframe,_that.isStrictRoom,_that.liveTime,_that.tags,_that.isAnchor,_that.roomSilentType,_that.roomSilentLevel,_that.roomSilentSecond,_that.areaName,_that.pendants,_that.areaPendants,_that.hotWords,_that.hotWordsStatus,_that.verify,_that.newPendants,_that.upSession,_that.pkStatus,_that.pkId,_that.battleId,_that.allowChangeAreaTime,_that.allowUploadCoverTime,_that.studioInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int uid, @JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'short_id')  int shortId,  int attention,  int online, @JsonKey(name: 'is_portrait')  bool isPortrait,  String description, @JsonKey(name: 'live_status')  int liveStatus, @JsonKey(name: 'area_id')  int areaId, @JsonKey(name: 'parent_area_id')  int parentAreaId, @JsonKey(name: 'parent_area_name')  String parentAreaName, @JsonKey(name: 'old_area_id')  int oldAreaId,  String background,  String title, @JsonKey(name: 'user_cover')  String userCover,  String keyframe, @JsonKey(name: 'is_strict_room')  bool isStrictRoom, @JsonKey(name: 'live_time')  String liveTime,  String tags, @JsonKey(name: 'is_anchor')  int isAnchor, @JsonKey(name: 'room_silent_type')  String roomSilentType, @JsonKey(name: 'room_silent_level')  int roomSilentLevel, @JsonKey(name: 'room_silent_second')  int roomSilentSecond, @JsonKey(name: 'area_name')  String areaName,  String pendants, @JsonKey(name: 'area_pendants')  String areaPendants, @JsonKey(name: 'hot_words')  List<String> hotWords, @JsonKey(name: 'hot_words_status')  int hotWordsStatus,  String verify, @JsonKey(name: 'new_pendants')  Map<String, dynamic> newPendants, @JsonKey(name: 'up_session')  String upSession, @JsonKey(name: 'pk_status')  int pkStatus, @JsonKey(name: 'pk_id')  int pkId, @JsonKey(name: 'battle_id')  int battleId, @JsonKey(name: 'allow_change_area_time')  int allowChangeAreaTime, @JsonKey(name: 'allow_upload_cover_time')  int allowUploadCoverTime, @JsonKey(name: 'studio_info')  Map<String, dynamic> studioInfo)  $default,) {final _that = this;
switch (_that) {
case _LiveRoomDetailModel():
return $default(_that.uid,_that.roomId,_that.shortId,_that.attention,_that.online,_that.isPortrait,_that.description,_that.liveStatus,_that.areaId,_that.parentAreaId,_that.parentAreaName,_that.oldAreaId,_that.background,_that.title,_that.userCover,_that.keyframe,_that.isStrictRoom,_that.liveTime,_that.tags,_that.isAnchor,_that.roomSilentType,_that.roomSilentLevel,_that.roomSilentSecond,_that.areaName,_that.pendants,_that.areaPendants,_that.hotWords,_that.hotWordsStatus,_that.verify,_that.newPendants,_that.upSession,_that.pkStatus,_that.pkId,_that.battleId,_that.allowChangeAreaTime,_that.allowUploadCoverTime,_that.studioInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int uid, @JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'short_id')  int shortId,  int attention,  int online, @JsonKey(name: 'is_portrait')  bool isPortrait,  String description, @JsonKey(name: 'live_status')  int liveStatus, @JsonKey(name: 'area_id')  int areaId, @JsonKey(name: 'parent_area_id')  int parentAreaId, @JsonKey(name: 'parent_area_name')  String parentAreaName, @JsonKey(name: 'old_area_id')  int oldAreaId,  String background,  String title, @JsonKey(name: 'user_cover')  String userCover,  String keyframe, @JsonKey(name: 'is_strict_room')  bool isStrictRoom, @JsonKey(name: 'live_time')  String liveTime,  String tags, @JsonKey(name: 'is_anchor')  int isAnchor, @JsonKey(name: 'room_silent_type')  String roomSilentType, @JsonKey(name: 'room_silent_level')  int roomSilentLevel, @JsonKey(name: 'room_silent_second')  int roomSilentSecond, @JsonKey(name: 'area_name')  String areaName,  String pendants, @JsonKey(name: 'area_pendants')  String areaPendants, @JsonKey(name: 'hot_words')  List<String> hotWords, @JsonKey(name: 'hot_words_status')  int hotWordsStatus,  String verify, @JsonKey(name: 'new_pendants')  Map<String, dynamic> newPendants, @JsonKey(name: 'up_session')  String upSession, @JsonKey(name: 'pk_status')  int pkStatus, @JsonKey(name: 'pk_id')  int pkId, @JsonKey(name: 'battle_id')  int battleId, @JsonKey(name: 'allow_change_area_time')  int allowChangeAreaTime, @JsonKey(name: 'allow_upload_cover_time')  int allowUploadCoverTime, @JsonKey(name: 'studio_info')  Map<String, dynamic> studioInfo)?  $default,) {final _that = this;
switch (_that) {
case _LiveRoomDetailModel() when $default != null:
return $default(_that.uid,_that.roomId,_that.shortId,_that.attention,_that.online,_that.isPortrait,_that.description,_that.liveStatus,_that.areaId,_that.parentAreaId,_that.parentAreaName,_that.oldAreaId,_that.background,_that.title,_that.userCover,_that.keyframe,_that.isStrictRoom,_that.liveTime,_that.tags,_that.isAnchor,_that.roomSilentType,_that.roomSilentLevel,_that.roomSilentSecond,_that.areaName,_that.pendants,_that.areaPendants,_that.hotWords,_that.hotWordsStatus,_that.verify,_that.newPendants,_that.upSession,_that.pkStatus,_that.pkId,_that.battleId,_that.allowChangeAreaTime,_that.allowUploadCoverTime,_that.studioInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveRoomDetailModel implements LiveRoomDetailModel {
  const _LiveRoomDetailModel({required this.uid, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'short_id') required this.shortId, required this.attention, required this.online, @JsonKey(name: 'is_portrait') required this.isPortrait, required this.description, @JsonKey(name: 'live_status') required this.liveStatus, @JsonKey(name: 'area_id') required this.areaId, @JsonKey(name: 'parent_area_id') required this.parentAreaId, @JsonKey(name: 'parent_area_name') required this.parentAreaName, @JsonKey(name: 'old_area_id') required this.oldAreaId, required this.background, required this.title, @JsonKey(name: 'user_cover') required this.userCover, required this.keyframe, @JsonKey(name: 'is_strict_room') required this.isStrictRoom, @JsonKey(name: 'live_time') required this.liveTime, required this.tags, @JsonKey(name: 'is_anchor') required this.isAnchor, @JsonKey(name: 'room_silent_type') required this.roomSilentType, @JsonKey(name: 'room_silent_level') required this.roomSilentLevel, @JsonKey(name: 'room_silent_second') required this.roomSilentSecond, @JsonKey(name: 'area_name') required this.areaName, required this.pendants, @JsonKey(name: 'area_pendants') required this.areaPendants, @JsonKey(name: 'hot_words') required final  List<String> hotWords, @JsonKey(name: 'hot_words_status') required this.hotWordsStatus, required this.verify, @JsonKey(name: 'new_pendants') required final  Map<String, dynamic> newPendants, @JsonKey(name: 'up_session') required this.upSession, @JsonKey(name: 'pk_status') required this.pkStatus, @JsonKey(name: 'pk_id') required this.pkId, @JsonKey(name: 'battle_id') required this.battleId, @JsonKey(name: 'allow_change_area_time') required this.allowChangeAreaTime, @JsonKey(name: 'allow_upload_cover_time') required this.allowUploadCoverTime, @JsonKey(name: 'studio_info') required final  Map<String, dynamic> studioInfo}): _hotWords = hotWords,_newPendants = newPendants,_studioInfo = studioInfo;
  factory _LiveRoomDetailModel.fromJson(Map<String, dynamic> json) => _$LiveRoomDetailModelFromJson(json);

@override final  int uid;
@override@JsonKey(name: 'room_id') final  int roomId;
@override@JsonKey(name: 'short_id') final  int shortId;
@override final  int attention;
@override final  int online;
@override@JsonKey(name: 'is_portrait') final  bool isPortrait;
@override final  String description;
@override@JsonKey(name: 'live_status') final  int liveStatus;
@override@JsonKey(name: 'area_id') final  int areaId;
@override@JsonKey(name: 'parent_area_id') final  int parentAreaId;
@override@JsonKey(name: 'parent_area_name') final  String parentAreaName;
@override@JsonKey(name: 'old_area_id') final  int oldAreaId;
@override final  String background;
@override final  String title;
@override@JsonKey(name: 'user_cover') final  String userCover;
@override final  String keyframe;
@override@JsonKey(name: 'is_strict_room') final  bool isStrictRoom;
@override@JsonKey(name: 'live_time') final  String liveTime;
@override final  String tags;
@override@JsonKey(name: 'is_anchor') final  int isAnchor;
@override@JsonKey(name: 'room_silent_type') final  String roomSilentType;
@override@JsonKey(name: 'room_silent_level') final  int roomSilentLevel;
@override@JsonKey(name: 'room_silent_second') final  int roomSilentSecond;
@override@JsonKey(name: 'area_name') final  String areaName;
@override final  String pendants;
@override@JsonKey(name: 'area_pendants') final  String areaPendants;
 final  List<String> _hotWords;
@override@JsonKey(name: 'hot_words') List<String> get hotWords {
  if (_hotWords is EqualUnmodifiableListView) return _hotWords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hotWords);
}

@override@JsonKey(name: 'hot_words_status') final  int hotWordsStatus;
@override final  String verify;
 final  Map<String, dynamic> _newPendants;
@override@JsonKey(name: 'new_pendants') Map<String, dynamic> get newPendants {
  if (_newPendants is EqualUnmodifiableMapView) return _newPendants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_newPendants);
}

@override@JsonKey(name: 'up_session') final  String upSession;
@override@JsonKey(name: 'pk_status') final  int pkStatus;
@override@JsonKey(name: 'pk_id') final  int pkId;
@override@JsonKey(name: 'battle_id') final  int battleId;
@override@JsonKey(name: 'allow_change_area_time') final  int allowChangeAreaTime;
@override@JsonKey(name: 'allow_upload_cover_time') final  int allowUploadCoverTime;
 final  Map<String, dynamic> _studioInfo;
@override@JsonKey(name: 'studio_info') Map<String, dynamic> get studioInfo {
  if (_studioInfo is EqualUnmodifiableMapView) return _studioInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_studioInfo);
}


/// Create a copy of LiveRoomDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRoomDetailModelCopyWith<_LiveRoomDetailModel> get copyWith => __$LiveRoomDetailModelCopyWithImpl<_LiveRoomDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveRoomDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRoomDetailModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.shortId, shortId) || other.shortId == shortId)&&(identical(other.attention, attention) || other.attention == attention)&&(identical(other.online, online) || other.online == online)&&(identical(other.isPortrait, isPortrait) || other.isPortrait == isPortrait)&&(identical(other.description, description) || other.description == description)&&(identical(other.liveStatus, liveStatus) || other.liveStatus == liveStatus)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.parentAreaId, parentAreaId) || other.parentAreaId == parentAreaId)&&(identical(other.parentAreaName, parentAreaName) || other.parentAreaName == parentAreaName)&&(identical(other.oldAreaId, oldAreaId) || other.oldAreaId == oldAreaId)&&(identical(other.background, background) || other.background == background)&&(identical(other.title, title) || other.title == title)&&(identical(other.userCover, userCover) || other.userCover == userCover)&&(identical(other.keyframe, keyframe) || other.keyframe == keyframe)&&(identical(other.isStrictRoom, isStrictRoom) || other.isStrictRoom == isStrictRoom)&&(identical(other.liveTime, liveTime) || other.liveTime == liveTime)&&(identical(other.tags, tags) || other.tags == tags)&&(identical(other.isAnchor, isAnchor) || other.isAnchor == isAnchor)&&(identical(other.roomSilentType, roomSilentType) || other.roomSilentType == roomSilentType)&&(identical(other.roomSilentLevel, roomSilentLevel) || other.roomSilentLevel == roomSilentLevel)&&(identical(other.roomSilentSecond, roomSilentSecond) || other.roomSilentSecond == roomSilentSecond)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.pendants, pendants) || other.pendants == pendants)&&(identical(other.areaPendants, areaPendants) || other.areaPendants == areaPendants)&&const DeepCollectionEquality().equals(other._hotWords, _hotWords)&&(identical(other.hotWordsStatus, hotWordsStatus) || other.hotWordsStatus == hotWordsStatus)&&(identical(other.verify, verify) || other.verify == verify)&&const DeepCollectionEquality().equals(other._newPendants, _newPendants)&&(identical(other.upSession, upSession) || other.upSession == upSession)&&(identical(other.pkStatus, pkStatus) || other.pkStatus == pkStatus)&&(identical(other.pkId, pkId) || other.pkId == pkId)&&(identical(other.battleId, battleId) || other.battleId == battleId)&&(identical(other.allowChangeAreaTime, allowChangeAreaTime) || other.allowChangeAreaTime == allowChangeAreaTime)&&(identical(other.allowUploadCoverTime, allowUploadCoverTime) || other.allowUploadCoverTime == allowUploadCoverTime)&&const DeepCollectionEquality().equals(other._studioInfo, _studioInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,roomId,shortId,attention,online,isPortrait,description,liveStatus,areaId,parentAreaId,parentAreaName,oldAreaId,background,title,userCover,keyframe,isStrictRoom,liveTime,tags,isAnchor,roomSilentType,roomSilentLevel,roomSilentSecond,areaName,pendants,areaPendants,const DeepCollectionEquality().hash(_hotWords),hotWordsStatus,verify,const DeepCollectionEquality().hash(_newPendants),upSession,pkStatus,pkId,battleId,allowChangeAreaTime,allowUploadCoverTime,const DeepCollectionEquality().hash(_studioInfo)]);

@override
String toString() {
  return 'LiveRoomDetailModel(uid: $uid, roomId: $roomId, shortId: $shortId, attention: $attention, online: $online, isPortrait: $isPortrait, description: $description, liveStatus: $liveStatus, areaId: $areaId, parentAreaId: $parentAreaId, parentAreaName: $parentAreaName, oldAreaId: $oldAreaId, background: $background, title: $title, userCover: $userCover, keyframe: $keyframe, isStrictRoom: $isStrictRoom, liveTime: $liveTime, tags: $tags, isAnchor: $isAnchor, roomSilentType: $roomSilentType, roomSilentLevel: $roomSilentLevel, roomSilentSecond: $roomSilentSecond, areaName: $areaName, pendants: $pendants, areaPendants: $areaPendants, hotWords: $hotWords, hotWordsStatus: $hotWordsStatus, verify: $verify, newPendants: $newPendants, upSession: $upSession, pkStatus: $pkStatus, pkId: $pkId, battleId: $battleId, allowChangeAreaTime: $allowChangeAreaTime, allowUploadCoverTime: $allowUploadCoverTime, studioInfo: $studioInfo)';
}


}

/// @nodoc
abstract mixin class _$LiveRoomDetailModelCopyWith<$Res> implements $LiveRoomDetailModelCopyWith<$Res> {
  factory _$LiveRoomDetailModelCopyWith(_LiveRoomDetailModel value, $Res Function(_LiveRoomDetailModel) _then) = __$LiveRoomDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int uid,@JsonKey(name: 'room_id') int roomId,@JsonKey(name: 'short_id') int shortId, int attention, int online,@JsonKey(name: 'is_portrait') bool isPortrait, String description,@JsonKey(name: 'live_status') int liveStatus,@JsonKey(name: 'area_id') int areaId,@JsonKey(name: 'parent_area_id') int parentAreaId,@JsonKey(name: 'parent_area_name') String parentAreaName,@JsonKey(name: 'old_area_id') int oldAreaId, String background, String title,@JsonKey(name: 'user_cover') String userCover, String keyframe,@JsonKey(name: 'is_strict_room') bool isStrictRoom,@JsonKey(name: 'live_time') String liveTime, String tags,@JsonKey(name: 'is_anchor') int isAnchor,@JsonKey(name: 'room_silent_type') String roomSilentType,@JsonKey(name: 'room_silent_level') int roomSilentLevel,@JsonKey(name: 'room_silent_second') int roomSilentSecond,@JsonKey(name: 'area_name') String areaName, String pendants,@JsonKey(name: 'area_pendants') String areaPendants,@JsonKey(name: 'hot_words') List<String> hotWords,@JsonKey(name: 'hot_words_status') int hotWordsStatus, String verify,@JsonKey(name: 'new_pendants') Map<String, dynamic> newPendants,@JsonKey(name: 'up_session') String upSession,@JsonKey(name: 'pk_status') int pkStatus,@JsonKey(name: 'pk_id') int pkId,@JsonKey(name: 'battle_id') int battleId,@JsonKey(name: 'allow_change_area_time') int allowChangeAreaTime,@JsonKey(name: 'allow_upload_cover_time') int allowUploadCoverTime,@JsonKey(name: 'studio_info') Map<String, dynamic> studioInfo
});




}
/// @nodoc
class __$LiveRoomDetailModelCopyWithImpl<$Res>
    implements _$LiveRoomDetailModelCopyWith<$Res> {
  __$LiveRoomDetailModelCopyWithImpl(this._self, this._then);

  final _LiveRoomDetailModel _self;
  final $Res Function(_LiveRoomDetailModel) _then;

/// Create a copy of LiveRoomDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? roomId = null,Object? shortId = null,Object? attention = null,Object? online = null,Object? isPortrait = null,Object? description = null,Object? liveStatus = null,Object? areaId = null,Object? parentAreaId = null,Object? parentAreaName = null,Object? oldAreaId = null,Object? background = null,Object? title = null,Object? userCover = null,Object? keyframe = null,Object? isStrictRoom = null,Object? liveTime = null,Object? tags = null,Object? isAnchor = null,Object? roomSilentType = null,Object? roomSilentLevel = null,Object? roomSilentSecond = null,Object? areaName = null,Object? pendants = null,Object? areaPendants = null,Object? hotWords = null,Object? hotWordsStatus = null,Object? verify = null,Object? newPendants = null,Object? upSession = null,Object? pkStatus = null,Object? pkId = null,Object? battleId = null,Object? allowChangeAreaTime = null,Object? allowUploadCoverTime = null,Object? studioInfo = null,}) {
  return _then(_LiveRoomDetailModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,shortId: null == shortId ? _self.shortId : shortId // ignore: cast_nullable_to_non_nullable
as int,attention: null == attention ? _self.attention : attention // ignore: cast_nullable_to_non_nullable
as int,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as int,isPortrait: null == isPortrait ? _self.isPortrait : isPortrait // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,liveStatus: null == liveStatus ? _self.liveStatus : liveStatus // ignore: cast_nullable_to_non_nullable
as int,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,parentAreaId: null == parentAreaId ? _self.parentAreaId : parentAreaId // ignore: cast_nullable_to_non_nullable
as int,parentAreaName: null == parentAreaName ? _self.parentAreaName : parentAreaName // ignore: cast_nullable_to_non_nullable
as String,oldAreaId: null == oldAreaId ? _self.oldAreaId : oldAreaId // ignore: cast_nullable_to_non_nullable
as int,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,userCover: null == userCover ? _self.userCover : userCover // ignore: cast_nullable_to_non_nullable
as String,keyframe: null == keyframe ? _self.keyframe : keyframe // ignore: cast_nullable_to_non_nullable
as String,isStrictRoom: null == isStrictRoom ? _self.isStrictRoom : isStrictRoom // ignore: cast_nullable_to_non_nullable
as bool,liveTime: null == liveTime ? _self.liveTime : liveTime // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as String,isAnchor: null == isAnchor ? _self.isAnchor : isAnchor // ignore: cast_nullable_to_non_nullable
as int,roomSilentType: null == roomSilentType ? _self.roomSilentType : roomSilentType // ignore: cast_nullable_to_non_nullable
as String,roomSilentLevel: null == roomSilentLevel ? _self.roomSilentLevel : roomSilentLevel // ignore: cast_nullable_to_non_nullable
as int,roomSilentSecond: null == roomSilentSecond ? _self.roomSilentSecond : roomSilentSecond // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,pendants: null == pendants ? _self.pendants : pendants // ignore: cast_nullable_to_non_nullable
as String,areaPendants: null == areaPendants ? _self.areaPendants : areaPendants // ignore: cast_nullable_to_non_nullable
as String,hotWords: null == hotWords ? _self._hotWords : hotWords // ignore: cast_nullable_to_non_nullable
as List<String>,hotWordsStatus: null == hotWordsStatus ? _self.hotWordsStatus : hotWordsStatus // ignore: cast_nullable_to_non_nullable
as int,verify: null == verify ? _self.verify : verify // ignore: cast_nullable_to_non_nullable
as String,newPendants: null == newPendants ? _self._newPendants : newPendants // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,upSession: null == upSession ? _self.upSession : upSession // ignore: cast_nullable_to_non_nullable
as String,pkStatus: null == pkStatus ? _self.pkStatus : pkStatus // ignore: cast_nullable_to_non_nullable
as int,pkId: null == pkId ? _self.pkId : pkId // ignore: cast_nullable_to_non_nullable
as int,battleId: null == battleId ? _self.battleId : battleId // ignore: cast_nullable_to_non_nullable
as int,allowChangeAreaTime: null == allowChangeAreaTime ? _self.allowChangeAreaTime : allowChangeAreaTime // ignore: cast_nullable_to_non_nullable
as int,allowUploadCoverTime: null == allowUploadCoverTime ? _self.allowUploadCoverTime : allowUploadCoverTime // ignore: cast_nullable_to_non_nullable
as int,studioInfo: null == studioInfo ? _self._studioInfo : studioInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
