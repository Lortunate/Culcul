// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_history_danmaku_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveHistoryDanmakuModel {

 List<LiveDanmakuItem> get admin; List<LiveDanmakuItem> get room;
/// Create a copy of LiveHistoryDanmakuModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveHistoryDanmakuModelCopyWith<LiveHistoryDanmakuModel> get copyWith => _$LiveHistoryDanmakuModelCopyWithImpl<LiveHistoryDanmakuModel>(this as LiveHistoryDanmakuModel, _$identity);

  /// Serializes this LiveHistoryDanmakuModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveHistoryDanmakuModel&&const DeepCollectionEquality().equals(other.admin, admin)&&const DeepCollectionEquality().equals(other.room, room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(admin),const DeepCollectionEquality().hash(room));

@override
String toString() {
  return 'LiveHistoryDanmakuModel(admin: $admin, room: $room)';
}


}

/// @nodoc
abstract mixin class $LiveHistoryDanmakuModelCopyWith<$Res>  {
  factory $LiveHistoryDanmakuModelCopyWith(LiveHistoryDanmakuModel value, $Res Function(LiveHistoryDanmakuModel) _then) = _$LiveHistoryDanmakuModelCopyWithImpl;
@useResult
$Res call({
 List<LiveDanmakuItem> admin, List<LiveDanmakuItem> room
});




}
/// @nodoc
class _$LiveHistoryDanmakuModelCopyWithImpl<$Res>
    implements $LiveHistoryDanmakuModelCopyWith<$Res> {
  _$LiveHistoryDanmakuModelCopyWithImpl(this._self, this._then);

  final LiveHistoryDanmakuModel _self;
  final $Res Function(LiveHistoryDanmakuModel) _then;

/// Create a copy of LiveHistoryDanmakuModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? admin = null,Object? room = null,}) {
  return _then(_self.copyWith(
admin: null == admin ? _self.admin : admin // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuItem>,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveHistoryDanmakuModel].
extension LiveHistoryDanmakuModelPatterns on LiveHistoryDanmakuModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveHistoryDanmakuModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveHistoryDanmakuModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveHistoryDanmakuModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveHistoryDanmakuModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveHistoryDanmakuModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveHistoryDanmakuModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LiveDanmakuItem> admin,  List<LiveDanmakuItem> room)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveHistoryDanmakuModel() when $default != null:
return $default(_that.admin,_that.room);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LiveDanmakuItem> admin,  List<LiveDanmakuItem> room)  $default,) {final _that = this;
switch (_that) {
case _LiveHistoryDanmakuModel():
return $default(_that.admin,_that.room);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LiveDanmakuItem> admin,  List<LiveDanmakuItem> room)?  $default,) {final _that = this;
switch (_that) {
case _LiveHistoryDanmakuModel() when $default != null:
return $default(_that.admin,_that.room);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveHistoryDanmakuModel implements LiveHistoryDanmakuModel {
  const _LiveHistoryDanmakuModel({required final  List<LiveDanmakuItem> admin, required final  List<LiveDanmakuItem> room}): _admin = admin,_room = room;
  factory _LiveHistoryDanmakuModel.fromJson(Map<String, dynamic> json) => _$LiveHistoryDanmakuModelFromJson(json);

 final  List<LiveDanmakuItem> _admin;
@override List<LiveDanmakuItem> get admin {
  if (_admin is EqualUnmodifiableListView) return _admin;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_admin);
}

 final  List<LiveDanmakuItem> _room;
@override List<LiveDanmakuItem> get room {
  if (_room is EqualUnmodifiableListView) return _room;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_room);
}


/// Create a copy of LiveHistoryDanmakuModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveHistoryDanmakuModelCopyWith<_LiveHistoryDanmakuModel> get copyWith => __$LiveHistoryDanmakuModelCopyWithImpl<_LiveHistoryDanmakuModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveHistoryDanmakuModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveHistoryDanmakuModel&&const DeepCollectionEquality().equals(other._admin, _admin)&&const DeepCollectionEquality().equals(other._room, _room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_admin),const DeepCollectionEquality().hash(_room));

@override
String toString() {
  return 'LiveHistoryDanmakuModel(admin: $admin, room: $room)';
}


}

/// @nodoc
abstract mixin class _$LiveHistoryDanmakuModelCopyWith<$Res> implements $LiveHistoryDanmakuModelCopyWith<$Res> {
  factory _$LiveHistoryDanmakuModelCopyWith(_LiveHistoryDanmakuModel value, $Res Function(_LiveHistoryDanmakuModel) _then) = __$LiveHistoryDanmakuModelCopyWithImpl;
@override @useResult
$Res call({
 List<LiveDanmakuItem> admin, List<LiveDanmakuItem> room
});




}
/// @nodoc
class __$LiveHistoryDanmakuModelCopyWithImpl<$Res>
    implements _$LiveHistoryDanmakuModelCopyWith<$Res> {
  __$LiveHistoryDanmakuModelCopyWithImpl(this._self, this._then);

  final _LiveHistoryDanmakuModel _self;
  final $Res Function(_LiveHistoryDanmakuModel) _then;

/// Create a copy of LiveHistoryDanmakuModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? admin = null,Object? room = null,}) {
  return _then(_LiveHistoryDanmakuModel(
admin: null == admin ? _self._admin : admin // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuItem>,room: null == room ? _self._room : room // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuItem>,
  ));
}


}


/// @nodoc
mixin _$LiveDanmakuItem {

 String get text; String get nickname; int get uid;@JsonKey(name: 'timeline') String get timeline;@JsonKey(name: 'dm_type') int get dmType; int get isadmin; int get vip; int get svip; List<dynamic> get medal; List<dynamic> get title;@JsonKey(name: 'user_level') List<dynamic> get userLevel; int get rank; int get teamid; String get rnd;@JsonKey(name: 'user_title') String get userTitle;@JsonKey(name: 'guard_level') int get guardLevel; int get bubble;@JsonKey(name: 'check_info') Map<String, dynamic> get checkInfo;
/// Create a copy of LiveDanmakuItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmakuItemCopyWith<LiveDanmakuItem> get copyWith => _$LiveDanmakuItemCopyWithImpl<LiveDanmakuItem>(this as LiveDanmakuItem, _$identity);

  /// Serializes this LiveDanmakuItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmakuItem&&(identical(other.text, text) || other.text == text)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.timeline, timeline) || other.timeline == timeline)&&(identical(other.dmType, dmType) || other.dmType == dmType)&&(identical(other.isadmin, isadmin) || other.isadmin == isadmin)&&(identical(other.vip, vip) || other.vip == vip)&&(identical(other.svip, svip) || other.svip == svip)&&const DeepCollectionEquality().equals(other.medal, medal)&&const DeepCollectionEquality().equals(other.title, title)&&const DeepCollectionEquality().equals(other.userLevel, userLevel)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.teamid, teamid) || other.teamid == teamid)&&(identical(other.rnd, rnd) || other.rnd == rnd)&&(identical(other.userTitle, userTitle) || other.userTitle == userTitle)&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel)&&(identical(other.bubble, bubble) || other.bubble == bubble)&&const DeepCollectionEquality().equals(other.checkInfo, checkInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,nickname,uid,timeline,dmType,isadmin,vip,svip,const DeepCollectionEquality().hash(medal),const DeepCollectionEquality().hash(title),const DeepCollectionEquality().hash(userLevel),rank,teamid,rnd,userTitle,guardLevel,bubble,const DeepCollectionEquality().hash(checkInfo));

@override
String toString() {
  return 'LiveDanmakuItem(text: $text, nickname: $nickname, uid: $uid, timeline: $timeline, dmType: $dmType, isadmin: $isadmin, vip: $vip, svip: $svip, medal: $medal, title: $title, userLevel: $userLevel, rank: $rank, teamid: $teamid, rnd: $rnd, userTitle: $userTitle, guardLevel: $guardLevel, bubble: $bubble, checkInfo: $checkInfo)';
}


}

/// @nodoc
abstract mixin class $LiveDanmakuItemCopyWith<$Res>  {
  factory $LiveDanmakuItemCopyWith(LiveDanmakuItem value, $Res Function(LiveDanmakuItem) _then) = _$LiveDanmakuItemCopyWithImpl;
@useResult
$Res call({
 String text, String nickname, int uid,@JsonKey(name: 'timeline') String timeline,@JsonKey(name: 'dm_type') int dmType, int isadmin, int vip, int svip, List<dynamic> medal, List<dynamic> title,@JsonKey(name: 'user_level') List<dynamic> userLevel, int rank, int teamid, String rnd,@JsonKey(name: 'user_title') String userTitle,@JsonKey(name: 'guard_level') int guardLevel, int bubble,@JsonKey(name: 'check_info') Map<String, dynamic> checkInfo
});




}
/// @nodoc
class _$LiveDanmakuItemCopyWithImpl<$Res>
    implements $LiveDanmakuItemCopyWith<$Res> {
  _$LiveDanmakuItemCopyWithImpl(this._self, this._then);

  final LiveDanmakuItem _self;
  final $Res Function(LiveDanmakuItem) _then;

/// Create a copy of LiveDanmakuItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? nickname = null,Object? uid = null,Object? timeline = null,Object? dmType = null,Object? isadmin = null,Object? vip = null,Object? svip = null,Object? medal = null,Object? title = null,Object? userLevel = null,Object? rank = null,Object? teamid = null,Object? rnd = null,Object? userTitle = null,Object? guardLevel = null,Object? bubble = null,Object? checkInfo = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as String,dmType: null == dmType ? _self.dmType : dmType // ignore: cast_nullable_to_non_nullable
as int,isadmin: null == isadmin ? _self.isadmin : isadmin // ignore: cast_nullable_to_non_nullable
as int,vip: null == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as int,svip: null == svip ? _self.svip : svip // ignore: cast_nullable_to_non_nullable
as int,medal: null == medal ? _self.medal : medal // ignore: cast_nullable_to_non_nullable
as List<dynamic>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as List<dynamic>,userLevel: null == userLevel ? _self.userLevel : userLevel // ignore: cast_nullable_to_non_nullable
as List<dynamic>,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,teamid: null == teamid ? _self.teamid : teamid // ignore: cast_nullable_to_non_nullable
as int,rnd: null == rnd ? _self.rnd : rnd // ignore: cast_nullable_to_non_nullable
as String,userTitle: null == userTitle ? _self.userTitle : userTitle // ignore: cast_nullable_to_non_nullable
as String,guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,bubble: null == bubble ? _self.bubble : bubble // ignore: cast_nullable_to_non_nullable
as int,checkInfo: null == checkInfo ? _self.checkInfo : checkInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmakuItem].
extension LiveDanmakuItemPatterns on LiveDanmakuItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmakuItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmakuItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmakuItem value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmakuItem value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String nickname,  int uid, @JsonKey(name: 'timeline')  String timeline, @JsonKey(name: 'dm_type')  int dmType,  int isadmin,  int vip,  int svip,  List<dynamic> medal,  List<dynamic> title, @JsonKey(name: 'user_level')  List<dynamic> userLevel,  int rank,  int teamid,  String rnd, @JsonKey(name: 'user_title')  String userTitle, @JsonKey(name: 'guard_level')  int guardLevel,  int bubble, @JsonKey(name: 'check_info')  Map<String, dynamic> checkInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmakuItem() when $default != null:
return $default(_that.text,_that.nickname,_that.uid,_that.timeline,_that.dmType,_that.isadmin,_that.vip,_that.svip,_that.medal,_that.title,_that.userLevel,_that.rank,_that.teamid,_that.rnd,_that.userTitle,_that.guardLevel,_that.bubble,_that.checkInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String nickname,  int uid, @JsonKey(name: 'timeline')  String timeline, @JsonKey(name: 'dm_type')  int dmType,  int isadmin,  int vip,  int svip,  List<dynamic> medal,  List<dynamic> title, @JsonKey(name: 'user_level')  List<dynamic> userLevel,  int rank,  int teamid,  String rnd, @JsonKey(name: 'user_title')  String userTitle, @JsonKey(name: 'guard_level')  int guardLevel,  int bubble, @JsonKey(name: 'check_info')  Map<String, dynamic> checkInfo)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuItem():
return $default(_that.text,_that.nickname,_that.uid,_that.timeline,_that.dmType,_that.isadmin,_that.vip,_that.svip,_that.medal,_that.title,_that.userLevel,_that.rank,_that.teamid,_that.rnd,_that.userTitle,_that.guardLevel,_that.bubble,_that.checkInfo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String nickname,  int uid, @JsonKey(name: 'timeline')  String timeline, @JsonKey(name: 'dm_type')  int dmType,  int isadmin,  int vip,  int svip,  List<dynamic> medal,  List<dynamic> title, @JsonKey(name: 'user_level')  List<dynamic> userLevel,  int rank,  int teamid,  String rnd, @JsonKey(name: 'user_title')  String userTitle, @JsonKey(name: 'guard_level')  int guardLevel,  int bubble, @JsonKey(name: 'check_info')  Map<String, dynamic> checkInfo)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuItem() when $default != null:
return $default(_that.text,_that.nickname,_that.uid,_that.timeline,_that.dmType,_that.isadmin,_that.vip,_that.svip,_that.medal,_that.title,_that.userLevel,_that.rank,_that.teamid,_that.rnd,_that.userTitle,_that.guardLevel,_that.bubble,_that.checkInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmakuItem implements LiveDanmakuItem {
  const _LiveDanmakuItem({required this.text, required this.nickname, required this.uid, @JsonKey(name: 'timeline') this.timeline = '', @JsonKey(name: 'dm_type') this.dmType = 0, this.isadmin = 0, this.vip = 0, this.svip = 0, final  List<dynamic> medal = const [], final  List<dynamic> title = const [], @JsonKey(name: 'user_level') final  List<dynamic> userLevel = const [], this.rank = 0, this.teamid = 0, this.rnd = '', @JsonKey(name: 'user_title') this.userTitle = '', @JsonKey(name: 'guard_level') this.guardLevel = 0, this.bubble = 0, @JsonKey(name: 'check_info') final  Map<String, dynamic> checkInfo = const {}}): _medal = medal,_title = title,_userLevel = userLevel,_checkInfo = checkInfo;
  factory _LiveDanmakuItem.fromJson(Map<String, dynamic> json) => _$LiveDanmakuItemFromJson(json);

@override final  String text;
@override final  String nickname;
@override final  int uid;
@override@JsonKey(name: 'timeline') final  String timeline;
@override@JsonKey(name: 'dm_type') final  int dmType;
@override@JsonKey() final  int isadmin;
@override@JsonKey() final  int vip;
@override@JsonKey() final  int svip;
 final  List<dynamic> _medal;
@override@JsonKey() List<dynamic> get medal {
  if (_medal is EqualUnmodifiableListView) return _medal;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medal);
}

 final  List<dynamic> _title;
@override@JsonKey() List<dynamic> get title {
  if (_title is EqualUnmodifiableListView) return _title;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_title);
}

 final  List<dynamic> _userLevel;
@override@JsonKey(name: 'user_level') List<dynamic> get userLevel {
  if (_userLevel is EqualUnmodifiableListView) return _userLevel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userLevel);
}

@override@JsonKey() final  int rank;
@override@JsonKey() final  int teamid;
@override@JsonKey() final  String rnd;
@override@JsonKey(name: 'user_title') final  String userTitle;
@override@JsonKey(name: 'guard_level') final  int guardLevel;
@override@JsonKey() final  int bubble;
 final  Map<String, dynamic> _checkInfo;
@override@JsonKey(name: 'check_info') Map<String, dynamic> get checkInfo {
  if (_checkInfo is EqualUnmodifiableMapView) return _checkInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_checkInfo);
}


/// Create a copy of LiveDanmakuItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmakuItemCopyWith<_LiveDanmakuItem> get copyWith => __$LiveDanmakuItemCopyWithImpl<_LiveDanmakuItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmakuItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmakuItem&&(identical(other.text, text) || other.text == text)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.timeline, timeline) || other.timeline == timeline)&&(identical(other.dmType, dmType) || other.dmType == dmType)&&(identical(other.isadmin, isadmin) || other.isadmin == isadmin)&&(identical(other.vip, vip) || other.vip == vip)&&(identical(other.svip, svip) || other.svip == svip)&&const DeepCollectionEquality().equals(other._medal, _medal)&&const DeepCollectionEquality().equals(other._title, _title)&&const DeepCollectionEquality().equals(other._userLevel, _userLevel)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.teamid, teamid) || other.teamid == teamid)&&(identical(other.rnd, rnd) || other.rnd == rnd)&&(identical(other.userTitle, userTitle) || other.userTitle == userTitle)&&(identical(other.guardLevel, guardLevel) || other.guardLevel == guardLevel)&&(identical(other.bubble, bubble) || other.bubble == bubble)&&const DeepCollectionEquality().equals(other._checkInfo, _checkInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,nickname,uid,timeline,dmType,isadmin,vip,svip,const DeepCollectionEquality().hash(_medal),const DeepCollectionEquality().hash(_title),const DeepCollectionEquality().hash(_userLevel),rank,teamid,rnd,userTitle,guardLevel,bubble,const DeepCollectionEquality().hash(_checkInfo));

@override
String toString() {
  return 'LiveDanmakuItem(text: $text, nickname: $nickname, uid: $uid, timeline: $timeline, dmType: $dmType, isadmin: $isadmin, vip: $vip, svip: $svip, medal: $medal, title: $title, userLevel: $userLevel, rank: $rank, teamid: $teamid, rnd: $rnd, userTitle: $userTitle, guardLevel: $guardLevel, bubble: $bubble, checkInfo: $checkInfo)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmakuItemCopyWith<$Res> implements $LiveDanmakuItemCopyWith<$Res> {
  factory _$LiveDanmakuItemCopyWith(_LiveDanmakuItem value, $Res Function(_LiveDanmakuItem) _then) = __$LiveDanmakuItemCopyWithImpl;
@override @useResult
$Res call({
 String text, String nickname, int uid,@JsonKey(name: 'timeline') String timeline,@JsonKey(name: 'dm_type') int dmType, int isadmin, int vip, int svip, List<dynamic> medal, List<dynamic> title,@JsonKey(name: 'user_level') List<dynamic> userLevel, int rank, int teamid, String rnd,@JsonKey(name: 'user_title') String userTitle,@JsonKey(name: 'guard_level') int guardLevel, int bubble,@JsonKey(name: 'check_info') Map<String, dynamic> checkInfo
});




}
/// @nodoc
class __$LiveDanmakuItemCopyWithImpl<$Res>
    implements _$LiveDanmakuItemCopyWith<$Res> {
  __$LiveDanmakuItemCopyWithImpl(this._self, this._then);

  final _LiveDanmakuItem _self;
  final $Res Function(_LiveDanmakuItem) _then;

/// Create a copy of LiveDanmakuItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? nickname = null,Object? uid = null,Object? timeline = null,Object? dmType = null,Object? isadmin = null,Object? vip = null,Object? svip = null,Object? medal = null,Object? title = null,Object? userLevel = null,Object? rank = null,Object? teamid = null,Object? rnd = null,Object? userTitle = null,Object? guardLevel = null,Object? bubble = null,Object? checkInfo = null,}) {
  return _then(_LiveDanmakuItem(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as String,dmType: null == dmType ? _self.dmType : dmType // ignore: cast_nullable_to_non_nullable
as int,isadmin: null == isadmin ? _self.isadmin : isadmin // ignore: cast_nullable_to_non_nullable
as int,vip: null == vip ? _self.vip : vip // ignore: cast_nullable_to_non_nullable
as int,svip: null == svip ? _self.svip : svip // ignore: cast_nullable_to_non_nullable
as int,medal: null == medal ? _self._medal : medal // ignore: cast_nullable_to_non_nullable
as List<dynamic>,title: null == title ? _self._title : title // ignore: cast_nullable_to_non_nullable
as List<dynamic>,userLevel: null == userLevel ? _self._userLevel : userLevel // ignore: cast_nullable_to_non_nullable
as List<dynamic>,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,teamid: null == teamid ? _self.teamid : teamid // ignore: cast_nullable_to_non_nullable
as int,rnd: null == rnd ? _self.rnd : rnd // ignore: cast_nullable_to_non_nullable
as String,userTitle: null == userTitle ? _self.userTitle : userTitle // ignore: cast_nullable_to_non_nullable
as String,guardLevel: null == guardLevel ? _self.guardLevel : guardLevel // ignore: cast_nullable_to_non_nullable
as int,bubble: null == bubble ? _self.bubble : bubble // ignore: cast_nullable_to_non_nullable
as int,checkInfo: null == checkInfo ? _self._checkInfo : checkInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
