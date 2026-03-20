// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'private_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrivateMessageSessionResponse {

@JsonKey(name: 'session_list') List<PrivateMessageSession>? get sessionList;@JsonKey(name: 'has_more') int get hasMore;@JsonKey(name: 'system_msg') Map<String, int>? get systemMsg;
/// Create a copy of PrivateMessageSessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivateMessageSessionResponseCopyWith<PrivateMessageSessionResponse> get copyWith => _$PrivateMessageSessionResponseCopyWithImpl<PrivateMessageSessionResponse>(this as PrivateMessageSessionResponse, _$identity);

  /// Serializes this PrivateMessageSessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivateMessageSessionResponse&&const DeepCollectionEquality().equals(other.sessionList, sessionList)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other.systemMsg, systemMsg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessionList),hasMore,const DeepCollectionEquality().hash(systemMsg));

@override
String toString() {
  return 'PrivateMessageSessionResponse(sessionList: $sessionList, hasMore: $hasMore, systemMsg: $systemMsg)';
}


}

/// @nodoc
abstract mixin class $PrivateMessageSessionResponseCopyWith<$Res>  {
  factory $PrivateMessageSessionResponseCopyWith(PrivateMessageSessionResponse value, $Res Function(PrivateMessageSessionResponse) _then) = _$PrivateMessageSessionResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'session_list') List<PrivateMessageSession>? sessionList,@JsonKey(name: 'has_more') int hasMore,@JsonKey(name: 'system_msg') Map<String, int>? systemMsg
});




}
/// @nodoc
class _$PrivateMessageSessionResponseCopyWithImpl<$Res>
    implements $PrivateMessageSessionResponseCopyWith<$Res> {
  _$PrivateMessageSessionResponseCopyWithImpl(this._self, this._then);

  final PrivateMessageSessionResponse _self;
  final $Res Function(PrivateMessageSessionResponse) _then;

/// Create a copy of PrivateMessageSessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionList = freezed,Object? hasMore = null,Object? systemMsg = freezed,}) {
  return _then(_self.copyWith(
sessionList: freezed == sessionList ? _self.sessionList : sessionList // ignore: cast_nullable_to_non_nullable
as List<PrivateMessageSession>?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as int,systemMsg: freezed == systemMsg ? _self.systemMsg : systemMsg // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivateMessageSessionResponse].
extension PrivateMessageSessionResponsePatterns on PrivateMessageSessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivateMessageSessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivateMessageSessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivateMessageSessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageSessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivateMessageSessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageSessionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'session_list')  List<PrivateMessageSession>? sessionList, @JsonKey(name: 'has_more')  int hasMore, @JsonKey(name: 'system_msg')  Map<String, int>? systemMsg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivateMessageSessionResponse() when $default != null:
return $default(_that.sessionList,_that.hasMore,_that.systemMsg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'session_list')  List<PrivateMessageSession>? sessionList, @JsonKey(name: 'has_more')  int hasMore, @JsonKey(name: 'system_msg')  Map<String, int>? systemMsg)  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageSessionResponse():
return $default(_that.sessionList,_that.hasMore,_that.systemMsg);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'session_list')  List<PrivateMessageSession>? sessionList, @JsonKey(name: 'has_more')  int hasMore, @JsonKey(name: 'system_msg')  Map<String, int>? systemMsg)?  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageSessionResponse() when $default != null:
return $default(_that.sessionList,_that.hasMore,_that.systemMsg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivateMessageSessionResponse implements PrivateMessageSessionResponse {
  const _PrivateMessageSessionResponse({@JsonKey(name: 'session_list') final  List<PrivateMessageSession>? sessionList, @JsonKey(name: 'has_more') this.hasMore = 0, @JsonKey(name: 'system_msg') final  Map<String, int>? systemMsg}): _sessionList = sessionList,_systemMsg = systemMsg;
  factory _PrivateMessageSessionResponse.fromJson(Map<String, dynamic> json) => _$PrivateMessageSessionResponseFromJson(json);

 final  List<PrivateMessageSession>? _sessionList;
@override@JsonKey(name: 'session_list') List<PrivateMessageSession>? get sessionList {
  final value = _sessionList;
  if (value == null) return null;
  if (_sessionList is EqualUnmodifiableListView) return _sessionList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'has_more') final  int hasMore;
 final  Map<String, int>? _systemMsg;
@override@JsonKey(name: 'system_msg') Map<String, int>? get systemMsg {
  final value = _systemMsg;
  if (value == null) return null;
  if (_systemMsg is EqualUnmodifiableMapView) return _systemMsg;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PrivateMessageSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivateMessageSessionResponseCopyWith<_PrivateMessageSessionResponse> get copyWith => __$PrivateMessageSessionResponseCopyWithImpl<_PrivateMessageSessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivateMessageSessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivateMessageSessionResponse&&const DeepCollectionEquality().equals(other._sessionList, _sessionList)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._systemMsg, _systemMsg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessionList),hasMore,const DeepCollectionEquality().hash(_systemMsg));

@override
String toString() {
  return 'PrivateMessageSessionResponse(sessionList: $sessionList, hasMore: $hasMore, systemMsg: $systemMsg)';
}


}

/// @nodoc
abstract mixin class _$PrivateMessageSessionResponseCopyWith<$Res> implements $PrivateMessageSessionResponseCopyWith<$Res> {
  factory _$PrivateMessageSessionResponseCopyWith(_PrivateMessageSessionResponse value, $Res Function(_PrivateMessageSessionResponse) _then) = __$PrivateMessageSessionResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'session_list') List<PrivateMessageSession>? sessionList,@JsonKey(name: 'has_more') int hasMore,@JsonKey(name: 'system_msg') Map<String, int>? systemMsg
});




}
/// @nodoc
class __$PrivateMessageSessionResponseCopyWithImpl<$Res>
    implements _$PrivateMessageSessionResponseCopyWith<$Res> {
  __$PrivateMessageSessionResponseCopyWithImpl(this._self, this._then);

  final _PrivateMessageSessionResponse _self;
  final $Res Function(_PrivateMessageSessionResponse) _then;

/// Create a copy of PrivateMessageSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionList = freezed,Object? hasMore = null,Object? systemMsg = freezed,}) {
  return _then(_PrivateMessageSessionResponse(
sessionList: freezed == sessionList ? _self._sessionList : sessionList // ignore: cast_nullable_to_non_nullable
as List<PrivateMessageSession>?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as int,systemMsg: freezed == systemMsg ? _self._systemMsg : systemMsg // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}


}


/// @nodoc
mixin _$PrivateMessageSession {

@JsonKey(name: 'talker_id') int get talkerId;@JsonKey(name: 'session_type') int get sessionType;@JsonKey(name: 'unread_count') int get unreadCount;@JsonKey(name: 'last_msg') PrivateMessageDetail? get lastMsg;@JsonKey(name: 'group_name') String? get groupName;@JsonKey(name: 'group_cover') String? get groupCover;@JsonKey(name: 'is_follow') int get isFollow;@JsonKey(name: 'session_ts') int get sessionTs;@JsonKey(name: 'account_info') PrivateMessageAccountInfo? get accountInfo;
/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivateMessageSessionCopyWith<PrivateMessageSession> get copyWith => _$PrivateMessageSessionCopyWithImpl<PrivateMessageSession>(this as PrivateMessageSession, _$identity);

  /// Serializes this PrivateMessageSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivateMessageSession&&(identical(other.talkerId, talkerId) || other.talkerId == talkerId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.lastMsg, lastMsg) || other.lastMsg == lastMsg)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.groupCover, groupCover) || other.groupCover == groupCover)&&(identical(other.isFollow, isFollow) || other.isFollow == isFollow)&&(identical(other.sessionTs, sessionTs) || other.sessionTs == sessionTs)&&(identical(other.accountInfo, accountInfo) || other.accountInfo == accountInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,talkerId,sessionType,unreadCount,lastMsg,groupName,groupCover,isFollow,sessionTs,accountInfo);

@override
String toString() {
  return 'PrivateMessageSession(talkerId: $talkerId, sessionType: $sessionType, unreadCount: $unreadCount, lastMsg: $lastMsg, groupName: $groupName, groupCover: $groupCover, isFollow: $isFollow, sessionTs: $sessionTs, accountInfo: $accountInfo)';
}


}

/// @nodoc
abstract mixin class $PrivateMessageSessionCopyWith<$Res>  {
  factory $PrivateMessageSessionCopyWith(PrivateMessageSession value, $Res Function(PrivateMessageSession) _then) = _$PrivateMessageSessionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'talker_id') int talkerId,@JsonKey(name: 'session_type') int sessionType,@JsonKey(name: 'unread_count') int unreadCount,@JsonKey(name: 'last_msg') PrivateMessageDetail? lastMsg,@JsonKey(name: 'group_name') String? groupName,@JsonKey(name: 'group_cover') String? groupCover,@JsonKey(name: 'is_follow') int isFollow,@JsonKey(name: 'session_ts') int sessionTs,@JsonKey(name: 'account_info') PrivateMessageAccountInfo? accountInfo
});


$PrivateMessageDetailCopyWith<$Res>? get lastMsg;$PrivateMessageAccountInfoCopyWith<$Res>? get accountInfo;

}
/// @nodoc
class _$PrivateMessageSessionCopyWithImpl<$Res>
    implements $PrivateMessageSessionCopyWith<$Res> {
  _$PrivateMessageSessionCopyWithImpl(this._self, this._then);

  final PrivateMessageSession _self;
  final $Res Function(PrivateMessageSession) _then;

/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? talkerId = null,Object? sessionType = null,Object? unreadCount = null,Object? lastMsg = freezed,Object? groupName = freezed,Object? groupCover = freezed,Object? isFollow = null,Object? sessionTs = null,Object? accountInfo = freezed,}) {
  return _then(_self.copyWith(
talkerId: null == talkerId ? _self.talkerId : talkerId // ignore: cast_nullable_to_non_nullable
as int,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,lastMsg: freezed == lastMsg ? _self.lastMsg : lastMsg // ignore: cast_nullable_to_non_nullable
as PrivateMessageDetail?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,groupCover: freezed == groupCover ? _self.groupCover : groupCover // ignore: cast_nullable_to_non_nullable
as String?,isFollow: null == isFollow ? _self.isFollow : isFollow // ignore: cast_nullable_to_non_nullable
as int,sessionTs: null == sessionTs ? _self.sessionTs : sessionTs // ignore: cast_nullable_to_non_nullable
as int,accountInfo: freezed == accountInfo ? _self.accountInfo : accountInfo // ignore: cast_nullable_to_non_nullable
as PrivateMessageAccountInfo?,
  ));
}
/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivateMessageDetailCopyWith<$Res>? get lastMsg {
    if (_self.lastMsg == null) {
    return null;
  }

  return $PrivateMessageDetailCopyWith<$Res>(_self.lastMsg!, (value) {
    return _then(_self.copyWith(lastMsg: value));
  });
}/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivateMessageAccountInfoCopyWith<$Res>? get accountInfo {
    if (_self.accountInfo == null) {
    return null;
  }

  return $PrivateMessageAccountInfoCopyWith<$Res>(_self.accountInfo!, (value) {
    return _then(_self.copyWith(accountInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrivateMessageSession].
extension PrivateMessageSessionPatterns on PrivateMessageSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivateMessageSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivateMessageSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivateMessageSession value)  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivateMessageSession value)?  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'talker_id')  int talkerId, @JsonKey(name: 'session_type')  int sessionType, @JsonKey(name: 'unread_count')  int unreadCount, @JsonKey(name: 'last_msg')  PrivateMessageDetail? lastMsg, @JsonKey(name: 'group_name')  String? groupName, @JsonKey(name: 'group_cover')  String? groupCover, @JsonKey(name: 'is_follow')  int isFollow, @JsonKey(name: 'session_ts')  int sessionTs, @JsonKey(name: 'account_info')  PrivateMessageAccountInfo? accountInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivateMessageSession() when $default != null:
return $default(_that.talkerId,_that.sessionType,_that.unreadCount,_that.lastMsg,_that.groupName,_that.groupCover,_that.isFollow,_that.sessionTs,_that.accountInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'talker_id')  int talkerId, @JsonKey(name: 'session_type')  int sessionType, @JsonKey(name: 'unread_count')  int unreadCount, @JsonKey(name: 'last_msg')  PrivateMessageDetail? lastMsg, @JsonKey(name: 'group_name')  String? groupName, @JsonKey(name: 'group_cover')  String? groupCover, @JsonKey(name: 'is_follow')  int isFollow, @JsonKey(name: 'session_ts')  int sessionTs, @JsonKey(name: 'account_info')  PrivateMessageAccountInfo? accountInfo)  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageSession():
return $default(_that.talkerId,_that.sessionType,_that.unreadCount,_that.lastMsg,_that.groupName,_that.groupCover,_that.isFollow,_that.sessionTs,_that.accountInfo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'talker_id')  int talkerId, @JsonKey(name: 'session_type')  int sessionType, @JsonKey(name: 'unread_count')  int unreadCount, @JsonKey(name: 'last_msg')  PrivateMessageDetail? lastMsg, @JsonKey(name: 'group_name')  String? groupName, @JsonKey(name: 'group_cover')  String? groupCover, @JsonKey(name: 'is_follow')  int isFollow, @JsonKey(name: 'session_ts')  int sessionTs, @JsonKey(name: 'account_info')  PrivateMessageAccountInfo? accountInfo)?  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageSession() when $default != null:
return $default(_that.talkerId,_that.sessionType,_that.unreadCount,_that.lastMsg,_that.groupName,_that.groupCover,_that.isFollow,_that.sessionTs,_that.accountInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivateMessageSession extends PrivateMessageSession {
  const _PrivateMessageSession({@JsonKey(name: 'talker_id') required this.talkerId, @JsonKey(name: 'session_type') required this.sessionType, @JsonKey(name: 'unread_count') this.unreadCount = 0, @JsonKey(name: 'last_msg') this.lastMsg, @JsonKey(name: 'group_name') this.groupName, @JsonKey(name: 'group_cover') this.groupCover, @JsonKey(name: 'is_follow') this.isFollow = 0, @JsonKey(name: 'session_ts') required this.sessionTs, @JsonKey(name: 'account_info') this.accountInfo}): super._();
  factory _PrivateMessageSession.fromJson(Map<String, dynamic> json) => _$PrivateMessageSessionFromJson(json);

@override@JsonKey(name: 'talker_id') final  int talkerId;
@override@JsonKey(name: 'session_type') final  int sessionType;
@override@JsonKey(name: 'unread_count') final  int unreadCount;
@override@JsonKey(name: 'last_msg') final  PrivateMessageDetail? lastMsg;
@override@JsonKey(name: 'group_name') final  String? groupName;
@override@JsonKey(name: 'group_cover') final  String? groupCover;
@override@JsonKey(name: 'is_follow') final  int isFollow;
@override@JsonKey(name: 'session_ts') final  int sessionTs;
@override@JsonKey(name: 'account_info') final  PrivateMessageAccountInfo? accountInfo;

/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivateMessageSessionCopyWith<_PrivateMessageSession> get copyWith => __$PrivateMessageSessionCopyWithImpl<_PrivateMessageSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivateMessageSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivateMessageSession&&(identical(other.talkerId, talkerId) || other.talkerId == talkerId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.lastMsg, lastMsg) || other.lastMsg == lastMsg)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.groupCover, groupCover) || other.groupCover == groupCover)&&(identical(other.isFollow, isFollow) || other.isFollow == isFollow)&&(identical(other.sessionTs, sessionTs) || other.sessionTs == sessionTs)&&(identical(other.accountInfo, accountInfo) || other.accountInfo == accountInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,talkerId,sessionType,unreadCount,lastMsg,groupName,groupCover,isFollow,sessionTs,accountInfo);

@override
String toString() {
  return 'PrivateMessageSession(talkerId: $talkerId, sessionType: $sessionType, unreadCount: $unreadCount, lastMsg: $lastMsg, groupName: $groupName, groupCover: $groupCover, isFollow: $isFollow, sessionTs: $sessionTs, accountInfo: $accountInfo)';
}


}

/// @nodoc
abstract mixin class _$PrivateMessageSessionCopyWith<$Res> implements $PrivateMessageSessionCopyWith<$Res> {
  factory _$PrivateMessageSessionCopyWith(_PrivateMessageSession value, $Res Function(_PrivateMessageSession) _then) = __$PrivateMessageSessionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'talker_id') int talkerId,@JsonKey(name: 'session_type') int sessionType,@JsonKey(name: 'unread_count') int unreadCount,@JsonKey(name: 'last_msg') PrivateMessageDetail? lastMsg,@JsonKey(name: 'group_name') String? groupName,@JsonKey(name: 'group_cover') String? groupCover,@JsonKey(name: 'is_follow') int isFollow,@JsonKey(name: 'session_ts') int sessionTs,@JsonKey(name: 'account_info') PrivateMessageAccountInfo? accountInfo
});


@override $PrivateMessageDetailCopyWith<$Res>? get lastMsg;@override $PrivateMessageAccountInfoCopyWith<$Res>? get accountInfo;

}
/// @nodoc
class __$PrivateMessageSessionCopyWithImpl<$Res>
    implements _$PrivateMessageSessionCopyWith<$Res> {
  __$PrivateMessageSessionCopyWithImpl(this._self, this._then);

  final _PrivateMessageSession _self;
  final $Res Function(_PrivateMessageSession) _then;

/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? talkerId = null,Object? sessionType = null,Object? unreadCount = null,Object? lastMsg = freezed,Object? groupName = freezed,Object? groupCover = freezed,Object? isFollow = null,Object? sessionTs = null,Object? accountInfo = freezed,}) {
  return _then(_PrivateMessageSession(
talkerId: null == talkerId ? _self.talkerId : talkerId // ignore: cast_nullable_to_non_nullable
as int,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,lastMsg: freezed == lastMsg ? _self.lastMsg : lastMsg // ignore: cast_nullable_to_non_nullable
as PrivateMessageDetail?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,groupCover: freezed == groupCover ? _self.groupCover : groupCover // ignore: cast_nullable_to_non_nullable
as String?,isFollow: null == isFollow ? _self.isFollow : isFollow // ignore: cast_nullable_to_non_nullable
as int,sessionTs: null == sessionTs ? _self.sessionTs : sessionTs // ignore: cast_nullable_to_non_nullable
as int,accountInfo: freezed == accountInfo ? _self.accountInfo : accountInfo // ignore: cast_nullable_to_non_nullable
as PrivateMessageAccountInfo?,
  ));
}

/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivateMessageDetailCopyWith<$Res>? get lastMsg {
    if (_self.lastMsg == null) {
    return null;
  }

  return $PrivateMessageDetailCopyWith<$Res>(_self.lastMsg!, (value) {
    return _then(_self.copyWith(lastMsg: value));
  });
}/// Create a copy of PrivateMessageSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivateMessageAccountInfoCopyWith<$Res>? get accountInfo {
    if (_self.accountInfo == null) {
    return null;
  }

  return $PrivateMessageAccountInfoCopyWith<$Res>(_self.accountInfo!, (value) {
    return _then(_self.copyWith(accountInfo: value));
  });
}
}


/// @nodoc
mixin _$PrivateMessageDetail {

@JsonKey(name: 'sender_uid') int get senderUid;@JsonKey(name: 'receiver_type') int get receiverType;@JsonKey(name: 'receiver_id') int get receiverId;@JsonKey(name: 'msg_type') int get msgType; dynamic get content;// Can be String (json) or Map depending on context, usually String in last_msg
@JsonKey(name: 'msg_seqno') int get msgSeqno; int get timestamp;@JsonKey(name: 'at_uids') List<int>? get atUids;@JsonKey(name: 'msg_key') int? get msgKey;@JsonKey(name: 'msg_status') int? get msgStatus;@JsonKey(name: 'notify_code') String? get notifyCode;@JsonKey(name: 'new_face_version') int? get newFaceVersion;@JsonKey(name: 'msg_source') int? get msgSource;
/// Create a copy of PrivateMessageDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivateMessageDetailCopyWith<PrivateMessageDetail> get copyWith => _$PrivateMessageDetailCopyWithImpl<PrivateMessageDetail>(this as PrivateMessageDetail, _$identity);

  /// Serializes this PrivateMessageDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivateMessageDetail&&(identical(other.senderUid, senderUid) || other.senderUid == senderUid)&&(identical(other.receiverType, receiverType) || other.receiverType == receiverType)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.msgType, msgType) || other.msgType == msgType)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.msgSeqno, msgSeqno) || other.msgSeqno == msgSeqno)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.atUids, atUids)&&(identical(other.msgKey, msgKey) || other.msgKey == msgKey)&&(identical(other.msgStatus, msgStatus) || other.msgStatus == msgStatus)&&(identical(other.notifyCode, notifyCode) || other.notifyCode == notifyCode)&&(identical(other.newFaceVersion, newFaceVersion) || other.newFaceVersion == newFaceVersion)&&(identical(other.msgSource, msgSource) || other.msgSource == msgSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,senderUid,receiverType,receiverId,msgType,const DeepCollectionEquality().hash(content),msgSeqno,timestamp,const DeepCollectionEquality().hash(atUids),msgKey,msgStatus,notifyCode,newFaceVersion,msgSource);

@override
String toString() {
  return 'PrivateMessageDetail(senderUid: $senderUid, receiverType: $receiverType, receiverId: $receiverId, msgType: $msgType, content: $content, msgSeqno: $msgSeqno, timestamp: $timestamp, atUids: $atUids, msgKey: $msgKey, msgStatus: $msgStatus, notifyCode: $notifyCode, newFaceVersion: $newFaceVersion, msgSource: $msgSource)';
}


}

/// @nodoc
abstract mixin class $PrivateMessageDetailCopyWith<$Res>  {
  factory $PrivateMessageDetailCopyWith(PrivateMessageDetail value, $Res Function(PrivateMessageDetail) _then) = _$PrivateMessageDetailCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'sender_uid') int senderUid,@JsonKey(name: 'receiver_type') int receiverType,@JsonKey(name: 'receiver_id') int receiverId,@JsonKey(name: 'msg_type') int msgType, dynamic content,@JsonKey(name: 'msg_seqno') int msgSeqno, int timestamp,@JsonKey(name: 'at_uids') List<int>? atUids,@JsonKey(name: 'msg_key') int? msgKey,@JsonKey(name: 'msg_status') int? msgStatus,@JsonKey(name: 'notify_code') String? notifyCode,@JsonKey(name: 'new_face_version') int? newFaceVersion,@JsonKey(name: 'msg_source') int? msgSource
});




}
/// @nodoc
class _$PrivateMessageDetailCopyWithImpl<$Res>
    implements $PrivateMessageDetailCopyWith<$Res> {
  _$PrivateMessageDetailCopyWithImpl(this._self, this._then);

  final PrivateMessageDetail _self;
  final $Res Function(PrivateMessageDetail) _then;

/// Create a copy of PrivateMessageDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? senderUid = null,Object? receiverType = null,Object? receiverId = null,Object? msgType = null,Object? content = freezed,Object? msgSeqno = null,Object? timestamp = null,Object? atUids = freezed,Object? msgKey = freezed,Object? msgStatus = freezed,Object? notifyCode = freezed,Object? newFaceVersion = freezed,Object? msgSource = freezed,}) {
  return _then(_self.copyWith(
senderUid: null == senderUid ? _self.senderUid : senderUid // ignore: cast_nullable_to_non_nullable
as int,receiverType: null == receiverType ? _self.receiverType : receiverType // ignore: cast_nullable_to_non_nullable
as int,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as int,msgType: null == msgType ? _self.msgType : msgType // ignore: cast_nullable_to_non_nullable
as int,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as dynamic,msgSeqno: null == msgSeqno ? _self.msgSeqno : msgSeqno // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,atUids: freezed == atUids ? _self.atUids : atUids // ignore: cast_nullable_to_non_nullable
as List<int>?,msgKey: freezed == msgKey ? _self.msgKey : msgKey // ignore: cast_nullable_to_non_nullable
as int?,msgStatus: freezed == msgStatus ? _self.msgStatus : msgStatus // ignore: cast_nullable_to_non_nullable
as int?,notifyCode: freezed == notifyCode ? _self.notifyCode : notifyCode // ignore: cast_nullable_to_non_nullable
as String?,newFaceVersion: freezed == newFaceVersion ? _self.newFaceVersion : newFaceVersion // ignore: cast_nullable_to_non_nullable
as int?,msgSource: freezed == msgSource ? _self.msgSource : msgSource // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivateMessageDetail].
extension PrivateMessageDetailPatterns on PrivateMessageDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivateMessageDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivateMessageDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivateMessageDetail value)  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivateMessageDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'sender_uid')  int senderUid, @JsonKey(name: 'receiver_type')  int receiverType, @JsonKey(name: 'receiver_id')  int receiverId, @JsonKey(name: 'msg_type')  int msgType,  dynamic content, @JsonKey(name: 'msg_seqno')  int msgSeqno,  int timestamp, @JsonKey(name: 'at_uids')  List<int>? atUids, @JsonKey(name: 'msg_key')  int? msgKey, @JsonKey(name: 'msg_status')  int? msgStatus, @JsonKey(name: 'notify_code')  String? notifyCode, @JsonKey(name: 'new_face_version')  int? newFaceVersion, @JsonKey(name: 'msg_source')  int? msgSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivateMessageDetail() when $default != null:
return $default(_that.senderUid,_that.receiverType,_that.receiverId,_that.msgType,_that.content,_that.msgSeqno,_that.timestamp,_that.atUids,_that.msgKey,_that.msgStatus,_that.notifyCode,_that.newFaceVersion,_that.msgSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'sender_uid')  int senderUid, @JsonKey(name: 'receiver_type')  int receiverType, @JsonKey(name: 'receiver_id')  int receiverId, @JsonKey(name: 'msg_type')  int msgType,  dynamic content, @JsonKey(name: 'msg_seqno')  int msgSeqno,  int timestamp, @JsonKey(name: 'at_uids')  List<int>? atUids, @JsonKey(name: 'msg_key')  int? msgKey, @JsonKey(name: 'msg_status')  int? msgStatus, @JsonKey(name: 'notify_code')  String? notifyCode, @JsonKey(name: 'new_face_version')  int? newFaceVersion, @JsonKey(name: 'msg_source')  int? msgSource)  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageDetail():
return $default(_that.senderUid,_that.receiverType,_that.receiverId,_that.msgType,_that.content,_that.msgSeqno,_that.timestamp,_that.atUids,_that.msgKey,_that.msgStatus,_that.notifyCode,_that.newFaceVersion,_that.msgSource);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'sender_uid')  int senderUid, @JsonKey(name: 'receiver_type')  int receiverType, @JsonKey(name: 'receiver_id')  int receiverId, @JsonKey(name: 'msg_type')  int msgType,  dynamic content, @JsonKey(name: 'msg_seqno')  int msgSeqno,  int timestamp, @JsonKey(name: 'at_uids')  List<int>? atUids, @JsonKey(name: 'msg_key')  int? msgKey, @JsonKey(name: 'msg_status')  int? msgStatus, @JsonKey(name: 'notify_code')  String? notifyCode, @JsonKey(name: 'new_face_version')  int? newFaceVersion, @JsonKey(name: 'msg_source')  int? msgSource)?  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageDetail() when $default != null:
return $default(_that.senderUid,_that.receiverType,_that.receiverId,_that.msgType,_that.content,_that.msgSeqno,_that.timestamp,_that.atUids,_that.msgKey,_that.msgStatus,_that.notifyCode,_that.newFaceVersion,_that.msgSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivateMessageDetail extends PrivateMessageDetail {
  const _PrivateMessageDetail({@JsonKey(name: 'sender_uid') required this.senderUid, @JsonKey(name: 'receiver_type') required this.receiverType, @JsonKey(name: 'receiver_id') required this.receiverId, @JsonKey(name: 'msg_type') required this.msgType, required this.content, @JsonKey(name: 'msg_seqno') required this.msgSeqno, required this.timestamp, @JsonKey(name: 'at_uids') final  List<int>? atUids, @JsonKey(name: 'msg_key') this.msgKey, @JsonKey(name: 'msg_status') this.msgStatus, @JsonKey(name: 'notify_code') this.notifyCode, @JsonKey(name: 'new_face_version') this.newFaceVersion, @JsonKey(name: 'msg_source') this.msgSource}): _atUids = atUids,super._();
  factory _PrivateMessageDetail.fromJson(Map<String, dynamic> json) => _$PrivateMessageDetailFromJson(json);

@override@JsonKey(name: 'sender_uid') final  int senderUid;
@override@JsonKey(name: 'receiver_type') final  int receiverType;
@override@JsonKey(name: 'receiver_id') final  int receiverId;
@override@JsonKey(name: 'msg_type') final  int msgType;
@override final  dynamic content;
// Can be String (json) or Map depending on context, usually String in last_msg
@override@JsonKey(name: 'msg_seqno') final  int msgSeqno;
@override final  int timestamp;
 final  List<int>? _atUids;
@override@JsonKey(name: 'at_uids') List<int>? get atUids {
  final value = _atUids;
  if (value == null) return null;
  if (_atUids is EqualUnmodifiableListView) return _atUids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'msg_key') final  int? msgKey;
@override@JsonKey(name: 'msg_status') final  int? msgStatus;
@override@JsonKey(name: 'notify_code') final  String? notifyCode;
@override@JsonKey(name: 'new_face_version') final  int? newFaceVersion;
@override@JsonKey(name: 'msg_source') final  int? msgSource;

/// Create a copy of PrivateMessageDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivateMessageDetailCopyWith<_PrivateMessageDetail> get copyWith => __$PrivateMessageDetailCopyWithImpl<_PrivateMessageDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivateMessageDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivateMessageDetail&&(identical(other.senderUid, senderUid) || other.senderUid == senderUid)&&(identical(other.receiverType, receiverType) || other.receiverType == receiverType)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.msgType, msgType) || other.msgType == msgType)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.msgSeqno, msgSeqno) || other.msgSeqno == msgSeqno)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._atUids, _atUids)&&(identical(other.msgKey, msgKey) || other.msgKey == msgKey)&&(identical(other.msgStatus, msgStatus) || other.msgStatus == msgStatus)&&(identical(other.notifyCode, notifyCode) || other.notifyCode == notifyCode)&&(identical(other.newFaceVersion, newFaceVersion) || other.newFaceVersion == newFaceVersion)&&(identical(other.msgSource, msgSource) || other.msgSource == msgSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,senderUid,receiverType,receiverId,msgType,const DeepCollectionEquality().hash(content),msgSeqno,timestamp,const DeepCollectionEquality().hash(_atUids),msgKey,msgStatus,notifyCode,newFaceVersion,msgSource);

@override
String toString() {
  return 'PrivateMessageDetail(senderUid: $senderUid, receiverType: $receiverType, receiverId: $receiverId, msgType: $msgType, content: $content, msgSeqno: $msgSeqno, timestamp: $timestamp, atUids: $atUids, msgKey: $msgKey, msgStatus: $msgStatus, notifyCode: $notifyCode, newFaceVersion: $newFaceVersion, msgSource: $msgSource)';
}


}

/// @nodoc
abstract mixin class _$PrivateMessageDetailCopyWith<$Res> implements $PrivateMessageDetailCopyWith<$Res> {
  factory _$PrivateMessageDetailCopyWith(_PrivateMessageDetail value, $Res Function(_PrivateMessageDetail) _then) = __$PrivateMessageDetailCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'sender_uid') int senderUid,@JsonKey(name: 'receiver_type') int receiverType,@JsonKey(name: 'receiver_id') int receiverId,@JsonKey(name: 'msg_type') int msgType, dynamic content,@JsonKey(name: 'msg_seqno') int msgSeqno, int timestamp,@JsonKey(name: 'at_uids') List<int>? atUids,@JsonKey(name: 'msg_key') int? msgKey,@JsonKey(name: 'msg_status') int? msgStatus,@JsonKey(name: 'notify_code') String? notifyCode,@JsonKey(name: 'new_face_version') int? newFaceVersion,@JsonKey(name: 'msg_source') int? msgSource
});




}
/// @nodoc
class __$PrivateMessageDetailCopyWithImpl<$Res>
    implements _$PrivateMessageDetailCopyWith<$Res> {
  __$PrivateMessageDetailCopyWithImpl(this._self, this._then);

  final _PrivateMessageDetail _self;
  final $Res Function(_PrivateMessageDetail) _then;

/// Create a copy of PrivateMessageDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? senderUid = null,Object? receiverType = null,Object? receiverId = null,Object? msgType = null,Object? content = freezed,Object? msgSeqno = null,Object? timestamp = null,Object? atUids = freezed,Object? msgKey = freezed,Object? msgStatus = freezed,Object? notifyCode = freezed,Object? newFaceVersion = freezed,Object? msgSource = freezed,}) {
  return _then(_PrivateMessageDetail(
senderUid: null == senderUid ? _self.senderUid : senderUid // ignore: cast_nullable_to_non_nullable
as int,receiverType: null == receiverType ? _self.receiverType : receiverType // ignore: cast_nullable_to_non_nullable
as int,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as int,msgType: null == msgType ? _self.msgType : msgType // ignore: cast_nullable_to_non_nullable
as int,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as dynamic,msgSeqno: null == msgSeqno ? _self.msgSeqno : msgSeqno // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,atUids: freezed == atUids ? _self._atUids : atUids // ignore: cast_nullable_to_non_nullable
as List<int>?,msgKey: freezed == msgKey ? _self.msgKey : msgKey // ignore: cast_nullable_to_non_nullable
as int?,msgStatus: freezed == msgStatus ? _self.msgStatus : msgStatus // ignore: cast_nullable_to_non_nullable
as int?,notifyCode: freezed == notifyCode ? _self.notifyCode : notifyCode // ignore: cast_nullable_to_non_nullable
as String?,newFaceVersion: freezed == newFaceVersion ? _self.newFaceVersion : newFaceVersion // ignore: cast_nullable_to_non_nullable
as int?,msgSource: freezed == msgSource ? _self.msgSource : msgSource // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PrivateMessageListResponse {

 List<PrivateMessageDetail>? get messages;@JsonKey(name: 'has_more') int get hasMore;@JsonKey(name: 'min_seqno') int? get minSeqno;@JsonKey(name: 'max_seqno') int? get maxSeqno;@JsonKey(name: 'e_infos') List<PrivateMessageEmojiInfo>? get emojiInfos;
/// Create a copy of PrivateMessageListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivateMessageListResponseCopyWith<PrivateMessageListResponse> get copyWith => _$PrivateMessageListResponseCopyWithImpl<PrivateMessageListResponse>(this as PrivateMessageListResponse, _$identity);

  /// Serializes this PrivateMessageListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivateMessageListResponse&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.minSeqno, minSeqno) || other.minSeqno == minSeqno)&&(identical(other.maxSeqno, maxSeqno) || other.maxSeqno == maxSeqno)&&const DeepCollectionEquality().equals(other.emojiInfos, emojiInfos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),hasMore,minSeqno,maxSeqno,const DeepCollectionEquality().hash(emojiInfos));

@override
String toString() {
  return 'PrivateMessageListResponse(messages: $messages, hasMore: $hasMore, minSeqno: $minSeqno, maxSeqno: $maxSeqno, emojiInfos: $emojiInfos)';
}


}

/// @nodoc
abstract mixin class $PrivateMessageListResponseCopyWith<$Res>  {
  factory $PrivateMessageListResponseCopyWith(PrivateMessageListResponse value, $Res Function(PrivateMessageListResponse) _then) = _$PrivateMessageListResponseCopyWithImpl;
@useResult
$Res call({
 List<PrivateMessageDetail>? messages,@JsonKey(name: 'has_more') int hasMore,@JsonKey(name: 'min_seqno') int? minSeqno,@JsonKey(name: 'max_seqno') int? maxSeqno,@JsonKey(name: 'e_infos') List<PrivateMessageEmojiInfo>? emojiInfos
});




}
/// @nodoc
class _$PrivateMessageListResponseCopyWithImpl<$Res>
    implements $PrivateMessageListResponseCopyWith<$Res> {
  _$PrivateMessageListResponseCopyWithImpl(this._self, this._then);

  final PrivateMessageListResponse _self;
  final $Res Function(PrivateMessageListResponse) _then;

/// Create a copy of PrivateMessageListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = freezed,Object? hasMore = null,Object? minSeqno = freezed,Object? maxSeqno = freezed,Object? emojiInfos = freezed,}) {
  return _then(_self.copyWith(
messages: freezed == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<PrivateMessageDetail>?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as int,minSeqno: freezed == minSeqno ? _self.minSeqno : minSeqno // ignore: cast_nullable_to_non_nullable
as int?,maxSeqno: freezed == maxSeqno ? _self.maxSeqno : maxSeqno // ignore: cast_nullable_to_non_nullable
as int?,emojiInfos: freezed == emojiInfos ? _self.emojiInfos : emojiInfos // ignore: cast_nullable_to_non_nullable
as List<PrivateMessageEmojiInfo>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivateMessageListResponse].
extension PrivateMessageListResponsePatterns on PrivateMessageListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivateMessageListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivateMessageListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivateMessageListResponse value)  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivateMessageListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PrivateMessageDetail>? messages, @JsonKey(name: 'has_more')  int hasMore, @JsonKey(name: 'min_seqno')  int? minSeqno, @JsonKey(name: 'max_seqno')  int? maxSeqno, @JsonKey(name: 'e_infos')  List<PrivateMessageEmojiInfo>? emojiInfos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivateMessageListResponse() when $default != null:
return $default(_that.messages,_that.hasMore,_that.minSeqno,_that.maxSeqno,_that.emojiInfos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PrivateMessageDetail>? messages, @JsonKey(name: 'has_more')  int hasMore, @JsonKey(name: 'min_seqno')  int? minSeqno, @JsonKey(name: 'max_seqno')  int? maxSeqno, @JsonKey(name: 'e_infos')  List<PrivateMessageEmojiInfo>? emojiInfos)  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageListResponse():
return $default(_that.messages,_that.hasMore,_that.minSeqno,_that.maxSeqno,_that.emojiInfos);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PrivateMessageDetail>? messages, @JsonKey(name: 'has_more')  int hasMore, @JsonKey(name: 'min_seqno')  int? minSeqno, @JsonKey(name: 'max_seqno')  int? maxSeqno, @JsonKey(name: 'e_infos')  List<PrivateMessageEmojiInfo>? emojiInfos)?  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageListResponse() when $default != null:
return $default(_that.messages,_that.hasMore,_that.minSeqno,_that.maxSeqno,_that.emojiInfos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivateMessageListResponse implements PrivateMessageListResponse {
  const _PrivateMessageListResponse({final  List<PrivateMessageDetail>? messages, @JsonKey(name: 'has_more') this.hasMore = 0, @JsonKey(name: 'min_seqno') this.minSeqno, @JsonKey(name: 'max_seqno') this.maxSeqno, @JsonKey(name: 'e_infos') final  List<PrivateMessageEmojiInfo>? emojiInfos}): _messages = messages,_emojiInfos = emojiInfos;
  factory _PrivateMessageListResponse.fromJson(Map<String, dynamic> json) => _$PrivateMessageListResponseFromJson(json);

 final  List<PrivateMessageDetail>? _messages;
@override List<PrivateMessageDetail>? get messages {
  final value = _messages;
  if (value == null) return null;
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'has_more') final  int hasMore;
@override@JsonKey(name: 'min_seqno') final  int? minSeqno;
@override@JsonKey(name: 'max_seqno') final  int? maxSeqno;
 final  List<PrivateMessageEmojiInfo>? _emojiInfos;
@override@JsonKey(name: 'e_infos') List<PrivateMessageEmojiInfo>? get emojiInfos {
  final value = _emojiInfos;
  if (value == null) return null;
  if (_emojiInfos is EqualUnmodifiableListView) return _emojiInfos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PrivateMessageListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivateMessageListResponseCopyWith<_PrivateMessageListResponse> get copyWith => __$PrivateMessageListResponseCopyWithImpl<_PrivateMessageListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivateMessageListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivateMessageListResponse&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.minSeqno, minSeqno) || other.minSeqno == minSeqno)&&(identical(other.maxSeqno, maxSeqno) || other.maxSeqno == maxSeqno)&&const DeepCollectionEquality().equals(other._emojiInfos, _emojiInfos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore,minSeqno,maxSeqno,const DeepCollectionEquality().hash(_emojiInfos));

@override
String toString() {
  return 'PrivateMessageListResponse(messages: $messages, hasMore: $hasMore, minSeqno: $minSeqno, maxSeqno: $maxSeqno, emojiInfos: $emojiInfos)';
}


}

/// @nodoc
abstract mixin class _$PrivateMessageListResponseCopyWith<$Res> implements $PrivateMessageListResponseCopyWith<$Res> {
  factory _$PrivateMessageListResponseCopyWith(_PrivateMessageListResponse value, $Res Function(_PrivateMessageListResponse) _then) = __$PrivateMessageListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<PrivateMessageDetail>? messages,@JsonKey(name: 'has_more') int hasMore,@JsonKey(name: 'min_seqno') int? minSeqno,@JsonKey(name: 'max_seqno') int? maxSeqno,@JsonKey(name: 'e_infos') List<PrivateMessageEmojiInfo>? emojiInfos
});




}
/// @nodoc
class __$PrivateMessageListResponseCopyWithImpl<$Res>
    implements _$PrivateMessageListResponseCopyWith<$Res> {
  __$PrivateMessageListResponseCopyWithImpl(this._self, this._then);

  final _PrivateMessageListResponse _self;
  final $Res Function(_PrivateMessageListResponse) _then;

/// Create a copy of PrivateMessageListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = freezed,Object? hasMore = null,Object? minSeqno = freezed,Object? maxSeqno = freezed,Object? emojiInfos = freezed,}) {
  return _then(_PrivateMessageListResponse(
messages: freezed == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<PrivateMessageDetail>?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as int,minSeqno: freezed == minSeqno ? _self.minSeqno : minSeqno // ignore: cast_nullable_to_non_nullable
as int?,maxSeqno: freezed == maxSeqno ? _self.maxSeqno : maxSeqno // ignore: cast_nullable_to_non_nullable
as int?,emojiInfos: freezed == emojiInfos ? _self._emojiInfos : emojiInfos // ignore: cast_nullable_to_non_nullable
as List<PrivateMessageEmojiInfo>?,
  ));
}


}


/// @nodoc
mixin _$PrivateMessageEmojiInfo {

 String get text; String get url; int get size;@JsonKey(name: 'gif_url') String? get gifUrl;
/// Create a copy of PrivateMessageEmojiInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivateMessageEmojiInfoCopyWith<PrivateMessageEmojiInfo> get copyWith => _$PrivateMessageEmojiInfoCopyWithImpl<PrivateMessageEmojiInfo>(this as PrivateMessageEmojiInfo, _$identity);

  /// Serializes this PrivateMessageEmojiInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivateMessageEmojiInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&(identical(other.size, size) || other.size == size)&&(identical(other.gifUrl, gifUrl) || other.gifUrl == gifUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,url,size,gifUrl);

@override
String toString() {
  return 'PrivateMessageEmojiInfo(text: $text, url: $url, size: $size, gifUrl: $gifUrl)';
}


}

/// @nodoc
abstract mixin class $PrivateMessageEmojiInfoCopyWith<$Res>  {
  factory $PrivateMessageEmojiInfoCopyWith(PrivateMessageEmojiInfo value, $Res Function(PrivateMessageEmojiInfo) _then) = _$PrivateMessageEmojiInfoCopyWithImpl;
@useResult
$Res call({
 String text, String url, int size,@JsonKey(name: 'gif_url') String? gifUrl
});




}
/// @nodoc
class _$PrivateMessageEmojiInfoCopyWithImpl<$Res>
    implements $PrivateMessageEmojiInfoCopyWith<$Res> {
  _$PrivateMessageEmojiInfoCopyWithImpl(this._self, this._then);

  final PrivateMessageEmojiInfo _self;
  final $Res Function(PrivateMessageEmojiInfo) _then;

/// Create a copy of PrivateMessageEmojiInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? url = null,Object? size = null,Object? gifUrl = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,gifUrl: freezed == gifUrl ? _self.gifUrl : gifUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivateMessageEmojiInfo].
extension PrivateMessageEmojiInfoPatterns on PrivateMessageEmojiInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivateMessageEmojiInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivateMessageEmojiInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivateMessageEmojiInfo value)  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageEmojiInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivateMessageEmojiInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageEmojiInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String url,  int size, @JsonKey(name: 'gif_url')  String? gifUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivateMessageEmojiInfo() when $default != null:
return $default(_that.text,_that.url,_that.size,_that.gifUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String url,  int size, @JsonKey(name: 'gif_url')  String? gifUrl)  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageEmojiInfo():
return $default(_that.text,_that.url,_that.size,_that.gifUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String url,  int size, @JsonKey(name: 'gif_url')  String? gifUrl)?  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageEmojiInfo() when $default != null:
return $default(_that.text,_that.url,_that.size,_that.gifUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivateMessageEmojiInfo implements PrivateMessageEmojiInfo {
  const _PrivateMessageEmojiInfo({required this.text, required this.url, this.size = 1, @JsonKey(name: 'gif_url') this.gifUrl});
  factory _PrivateMessageEmojiInfo.fromJson(Map<String, dynamic> json) => _$PrivateMessageEmojiInfoFromJson(json);

@override final  String text;
@override final  String url;
@override@JsonKey() final  int size;
@override@JsonKey(name: 'gif_url') final  String? gifUrl;

/// Create a copy of PrivateMessageEmojiInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivateMessageEmojiInfoCopyWith<_PrivateMessageEmojiInfo> get copyWith => __$PrivateMessageEmojiInfoCopyWithImpl<_PrivateMessageEmojiInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivateMessageEmojiInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivateMessageEmojiInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&(identical(other.size, size) || other.size == size)&&(identical(other.gifUrl, gifUrl) || other.gifUrl == gifUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,url,size,gifUrl);

@override
String toString() {
  return 'PrivateMessageEmojiInfo(text: $text, url: $url, size: $size, gifUrl: $gifUrl)';
}


}

/// @nodoc
abstract mixin class _$PrivateMessageEmojiInfoCopyWith<$Res> implements $PrivateMessageEmojiInfoCopyWith<$Res> {
  factory _$PrivateMessageEmojiInfoCopyWith(_PrivateMessageEmojiInfo value, $Res Function(_PrivateMessageEmojiInfo) _then) = __$PrivateMessageEmojiInfoCopyWithImpl;
@override @useResult
$Res call({
 String text, String url, int size,@JsonKey(name: 'gif_url') String? gifUrl
});




}
/// @nodoc
class __$PrivateMessageEmojiInfoCopyWithImpl<$Res>
    implements _$PrivateMessageEmojiInfoCopyWith<$Res> {
  __$PrivateMessageEmojiInfoCopyWithImpl(this._self, this._then);

  final _PrivateMessageEmojiInfo _self;
  final $Res Function(_PrivateMessageEmojiInfo) _then;

/// Create a copy of PrivateMessageEmojiInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? url = null,Object? size = null,Object? gifUrl = freezed,}) {
  return _then(_PrivateMessageEmojiInfo(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,gifUrl: freezed == gifUrl ? _self.gifUrl : gifUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SendMessageResponse {

@JsonKey(name: 'msg_key') int get msgKey;@JsonKey(name: 'msg_content') String? get msgContent;@JsonKey(name: 'key_hit_infos') Map<String, dynamic>? get keyHitInfos;
/// Create a copy of SendMessageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageResponseCopyWith<SendMessageResponse> get copyWith => _$SendMessageResponseCopyWithImpl<SendMessageResponse>(this as SendMessageResponse, _$identity);

  /// Serializes this SendMessageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageResponse&&(identical(other.msgKey, msgKey) || other.msgKey == msgKey)&&(identical(other.msgContent, msgContent) || other.msgContent == msgContent)&&const DeepCollectionEquality().equals(other.keyHitInfos, keyHitInfos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,msgKey,msgContent,const DeepCollectionEquality().hash(keyHitInfos));

@override
String toString() {
  return 'SendMessageResponse(msgKey: $msgKey, msgContent: $msgContent, keyHitInfos: $keyHitInfos)';
}


}

/// @nodoc
abstract mixin class $SendMessageResponseCopyWith<$Res>  {
  factory $SendMessageResponseCopyWith(SendMessageResponse value, $Res Function(SendMessageResponse) _then) = _$SendMessageResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'msg_key') int msgKey,@JsonKey(name: 'msg_content') String? msgContent,@JsonKey(name: 'key_hit_infos') Map<String, dynamic>? keyHitInfos
});




}
/// @nodoc
class _$SendMessageResponseCopyWithImpl<$Res>
    implements $SendMessageResponseCopyWith<$Res> {
  _$SendMessageResponseCopyWithImpl(this._self, this._then);

  final SendMessageResponse _self;
  final $Res Function(SendMessageResponse) _then;

/// Create a copy of SendMessageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? msgKey = null,Object? msgContent = freezed,Object? keyHitInfos = freezed,}) {
  return _then(_self.copyWith(
msgKey: null == msgKey ? _self.msgKey : msgKey // ignore: cast_nullable_to_non_nullable
as int,msgContent: freezed == msgContent ? _self.msgContent : msgContent // ignore: cast_nullable_to_non_nullable
as String?,keyHitInfos: freezed == keyHitInfos ? _self.keyHitInfos : keyHitInfos // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendMessageResponse].
extension SendMessageResponsePatterns on SendMessageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendMessageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendMessageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendMessageResponse value)  $default,){
final _that = this;
switch (_that) {
case _SendMessageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendMessageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SendMessageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'msg_key')  int msgKey, @JsonKey(name: 'msg_content')  String? msgContent, @JsonKey(name: 'key_hit_infos')  Map<String, dynamic>? keyHitInfos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendMessageResponse() when $default != null:
return $default(_that.msgKey,_that.msgContent,_that.keyHitInfos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'msg_key')  int msgKey, @JsonKey(name: 'msg_content')  String? msgContent, @JsonKey(name: 'key_hit_infos')  Map<String, dynamic>? keyHitInfos)  $default,) {final _that = this;
switch (_that) {
case _SendMessageResponse():
return $default(_that.msgKey,_that.msgContent,_that.keyHitInfos);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'msg_key')  int msgKey, @JsonKey(name: 'msg_content')  String? msgContent, @JsonKey(name: 'key_hit_infos')  Map<String, dynamic>? keyHitInfos)?  $default,) {final _that = this;
switch (_that) {
case _SendMessageResponse() when $default != null:
return $default(_that.msgKey,_that.msgContent,_that.keyHitInfos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendMessageResponse implements SendMessageResponse {
  const _SendMessageResponse({@JsonKey(name: 'msg_key') required this.msgKey, @JsonKey(name: 'msg_content') this.msgContent, @JsonKey(name: 'key_hit_infos') final  Map<String, dynamic>? keyHitInfos}): _keyHitInfos = keyHitInfos;
  factory _SendMessageResponse.fromJson(Map<String, dynamic> json) => _$SendMessageResponseFromJson(json);

@override@JsonKey(name: 'msg_key') final  int msgKey;
@override@JsonKey(name: 'msg_content') final  String? msgContent;
 final  Map<String, dynamic>? _keyHitInfos;
@override@JsonKey(name: 'key_hit_infos') Map<String, dynamic>? get keyHitInfos {
  final value = _keyHitInfos;
  if (value == null) return null;
  if (_keyHitInfos is EqualUnmodifiableMapView) return _keyHitInfos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SendMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMessageResponseCopyWith<_SendMessageResponse> get copyWith => __$SendMessageResponseCopyWithImpl<_SendMessageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMessageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMessageResponse&&(identical(other.msgKey, msgKey) || other.msgKey == msgKey)&&(identical(other.msgContent, msgContent) || other.msgContent == msgContent)&&const DeepCollectionEquality().equals(other._keyHitInfos, _keyHitInfos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,msgKey,msgContent,const DeepCollectionEquality().hash(_keyHitInfos));

@override
String toString() {
  return 'SendMessageResponse(msgKey: $msgKey, msgContent: $msgContent, keyHitInfos: $keyHitInfos)';
}


}

/// @nodoc
abstract mixin class _$SendMessageResponseCopyWith<$Res> implements $SendMessageResponseCopyWith<$Res> {
  factory _$SendMessageResponseCopyWith(_SendMessageResponse value, $Res Function(_SendMessageResponse) _then) = __$SendMessageResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'msg_key') int msgKey,@JsonKey(name: 'msg_content') String? msgContent,@JsonKey(name: 'key_hit_infos') Map<String, dynamic>? keyHitInfos
});




}
/// @nodoc
class __$SendMessageResponseCopyWithImpl<$Res>
    implements _$SendMessageResponseCopyWith<$Res> {
  __$SendMessageResponseCopyWithImpl(this._self, this._then);

  final _SendMessageResponse _self;
  final $Res Function(_SendMessageResponse) _then;

/// Create a copy of SendMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? msgKey = null,Object? msgContent = freezed,Object? keyHitInfos = freezed,}) {
  return _then(_SendMessageResponse(
msgKey: null == msgKey ? _self.msgKey : msgKey // ignore: cast_nullable_to_non_nullable
as int,msgContent: freezed == msgContent ? _self.msgContent : msgContent // ignore: cast_nullable_to_non_nullable
as String?,keyHitInfos: freezed == keyHitInfos ? _self._keyHitInfos : keyHitInfos // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$PrivateMessageAccountInfo {

 String get name;@JsonKey(name: 'pic_url') String get picUrl;
/// Create a copy of PrivateMessageAccountInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivateMessageAccountInfoCopyWith<PrivateMessageAccountInfo> get copyWith => _$PrivateMessageAccountInfoCopyWithImpl<PrivateMessageAccountInfo>(this as PrivateMessageAccountInfo, _$identity);

  /// Serializes this PrivateMessageAccountInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivateMessageAccountInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.picUrl, picUrl) || other.picUrl == picUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,picUrl);

@override
String toString() {
  return 'PrivateMessageAccountInfo(name: $name, picUrl: $picUrl)';
}


}

/// @nodoc
abstract mixin class $PrivateMessageAccountInfoCopyWith<$Res>  {
  factory $PrivateMessageAccountInfoCopyWith(PrivateMessageAccountInfo value, $Res Function(PrivateMessageAccountInfo) _then) = _$PrivateMessageAccountInfoCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'pic_url') String picUrl
});




}
/// @nodoc
class _$PrivateMessageAccountInfoCopyWithImpl<$Res>
    implements $PrivateMessageAccountInfoCopyWith<$Res> {
  _$PrivateMessageAccountInfoCopyWithImpl(this._self, this._then);

  final PrivateMessageAccountInfo _self;
  final $Res Function(PrivateMessageAccountInfo) _then;

/// Create a copy of PrivateMessageAccountInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? picUrl = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,picUrl: null == picUrl ? _self.picUrl : picUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivateMessageAccountInfo].
extension PrivateMessageAccountInfoPatterns on PrivateMessageAccountInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivateMessageAccountInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivateMessageAccountInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivateMessageAccountInfo value)  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageAccountInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivateMessageAccountInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PrivateMessageAccountInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'pic_url')  String picUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivateMessageAccountInfo() when $default != null:
return $default(_that.name,_that.picUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'pic_url')  String picUrl)  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageAccountInfo():
return $default(_that.name,_that.picUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'pic_url')  String picUrl)?  $default,) {final _that = this;
switch (_that) {
case _PrivateMessageAccountInfo() when $default != null:
return $default(_that.name,_that.picUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivateMessageAccountInfo implements PrivateMessageAccountInfo {
  const _PrivateMessageAccountInfo({required this.name, @JsonKey(name: 'pic_url') required this.picUrl});
  factory _PrivateMessageAccountInfo.fromJson(Map<String, dynamic> json) => _$PrivateMessageAccountInfoFromJson(json);

@override final  String name;
@override@JsonKey(name: 'pic_url') final  String picUrl;

/// Create a copy of PrivateMessageAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivateMessageAccountInfoCopyWith<_PrivateMessageAccountInfo> get copyWith => __$PrivateMessageAccountInfoCopyWithImpl<_PrivateMessageAccountInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivateMessageAccountInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivateMessageAccountInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.picUrl, picUrl) || other.picUrl == picUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,picUrl);

@override
String toString() {
  return 'PrivateMessageAccountInfo(name: $name, picUrl: $picUrl)';
}


}

/// @nodoc
abstract mixin class _$PrivateMessageAccountInfoCopyWith<$Res> implements $PrivateMessageAccountInfoCopyWith<$Res> {
  factory _$PrivateMessageAccountInfoCopyWith(_PrivateMessageAccountInfo value, $Res Function(_PrivateMessageAccountInfo) _then) = __$PrivateMessageAccountInfoCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'pic_url') String picUrl
});




}
/// @nodoc
class __$PrivateMessageAccountInfoCopyWithImpl<$Res>
    implements _$PrivateMessageAccountInfoCopyWith<$Res> {
  __$PrivateMessageAccountInfoCopyWithImpl(this._self, this._then);

  final _PrivateMessageAccountInfo _self;
  final $Res Function(_PrivateMessageAccountInfo) _then;

/// Create a copy of PrivateMessageAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? picUrl = null,}) {
  return _then(_PrivateMessageAccountInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,picUrl: null == picUrl ? _self.picUrl : picUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
