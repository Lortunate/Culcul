// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unread_count_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnreadCountModel {

 int get at; int get chat; int get coin; int get danmu; int get favorite; int get like;@JsonKey(name: 'recv_like') int get recvLike;@JsonKey(name: 'recv_reply') int get recvReply; int get reply;@JsonKey(name: 'sys_msg') int get sysMsg; int get up;
/// Create a copy of UnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnreadCountModelCopyWith<UnreadCountModel> get copyWith => _$UnreadCountModelCopyWithImpl<UnreadCountModel>(this as UnreadCountModel, _$identity);

  /// Serializes this UnreadCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnreadCountModel&&(identical(other.at, at) || other.at == at)&&(identical(other.chat, chat) || other.chat == chat)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.danmu, danmu) || other.danmu == danmu)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.like, like) || other.like == like)&&(identical(other.recvLike, recvLike) || other.recvLike == recvLike)&&(identical(other.recvReply, recvReply) || other.recvReply == recvReply)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.sysMsg, sysMsg) || other.sysMsg == sysMsg)&&(identical(other.up, up) || other.up == up));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,at,chat,coin,danmu,favorite,like,recvLike,recvReply,reply,sysMsg,up);

@override
String toString() {
  return 'UnreadCountModel(at: $at, chat: $chat, coin: $coin, danmu: $danmu, favorite: $favorite, like: $like, recvLike: $recvLike, recvReply: $recvReply, reply: $reply, sysMsg: $sysMsg, up: $up)';
}


}

/// @nodoc
abstract mixin class $UnreadCountModelCopyWith<$Res>  {
  factory $UnreadCountModelCopyWith(UnreadCountModel value, $Res Function(UnreadCountModel) _then) = _$UnreadCountModelCopyWithImpl;
@useResult
$Res call({
 int at, int chat, int coin, int danmu, int favorite, int like,@JsonKey(name: 'recv_like') int recvLike,@JsonKey(name: 'recv_reply') int recvReply, int reply,@JsonKey(name: 'sys_msg') int sysMsg, int up
});




}
/// @nodoc
class _$UnreadCountModelCopyWithImpl<$Res>
    implements $UnreadCountModelCopyWith<$Res> {
  _$UnreadCountModelCopyWithImpl(this._self, this._then);

  final UnreadCountModel _self;
  final $Res Function(UnreadCountModel) _then;

/// Create a copy of UnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? at = null,Object? chat = null,Object? coin = null,Object? danmu = null,Object? favorite = null,Object? like = null,Object? recvLike = null,Object? recvReply = null,Object? reply = null,Object? sysMsg = null,Object? up = null,}) {
  return _then(_self.copyWith(
at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as int,chat: null == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as int,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int,danmu: null == danmu ? _self.danmu : danmu // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,recvLike: null == recvLike ? _self.recvLike : recvLike // ignore: cast_nullable_to_non_nullable
as int,recvReply: null == recvReply ? _self.recvReply : recvReply // ignore: cast_nullable_to_non_nullable
as int,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int,sysMsg: null == sysMsg ? _self.sysMsg : sysMsg // ignore: cast_nullable_to_non_nullable
as int,up: null == up ? _self.up : up // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UnreadCountModel].
extension UnreadCountModelPatterns on UnreadCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnreadCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnreadCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnreadCountModel value)  $default,){
final _that = this;
switch (_that) {
case _UnreadCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnreadCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _UnreadCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int at,  int chat,  int coin,  int danmu,  int favorite,  int like, @JsonKey(name: 'recv_like')  int recvLike, @JsonKey(name: 'recv_reply')  int recvReply,  int reply, @JsonKey(name: 'sys_msg')  int sysMsg,  int up)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnreadCountModel() when $default != null:
return $default(_that.at,_that.chat,_that.coin,_that.danmu,_that.favorite,_that.like,_that.recvLike,_that.recvReply,_that.reply,_that.sysMsg,_that.up);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int at,  int chat,  int coin,  int danmu,  int favorite,  int like, @JsonKey(name: 'recv_like')  int recvLike, @JsonKey(name: 'recv_reply')  int recvReply,  int reply, @JsonKey(name: 'sys_msg')  int sysMsg,  int up)  $default,) {final _that = this;
switch (_that) {
case _UnreadCountModel():
return $default(_that.at,_that.chat,_that.coin,_that.danmu,_that.favorite,_that.like,_that.recvLike,_that.recvReply,_that.reply,_that.sysMsg,_that.up);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int at,  int chat,  int coin,  int danmu,  int favorite,  int like, @JsonKey(name: 'recv_like')  int recvLike, @JsonKey(name: 'recv_reply')  int recvReply,  int reply, @JsonKey(name: 'sys_msg')  int sysMsg,  int up)?  $default,) {final _that = this;
switch (_that) {
case _UnreadCountModel() when $default != null:
return $default(_that.at,_that.chat,_that.coin,_that.danmu,_that.favorite,_that.like,_that.recvLike,_that.recvReply,_that.reply,_that.sysMsg,_that.up);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnreadCountModel implements UnreadCountModel {
  const _UnreadCountModel({this.at = 0, this.chat = 0, this.coin = 0, this.danmu = 0, this.favorite = 0, this.like = 0, @JsonKey(name: 'recv_like') this.recvLike = 0, @JsonKey(name: 'recv_reply') this.recvReply = 0, this.reply = 0, @JsonKey(name: 'sys_msg') this.sysMsg = 0, this.up = 0});
  factory _UnreadCountModel.fromJson(Map<String, dynamic> json) => _$UnreadCountModelFromJson(json);

@override@JsonKey() final  int at;
@override@JsonKey() final  int chat;
@override@JsonKey() final  int coin;
@override@JsonKey() final  int danmu;
@override@JsonKey() final  int favorite;
@override@JsonKey() final  int like;
@override@JsonKey(name: 'recv_like') final  int recvLike;
@override@JsonKey(name: 'recv_reply') final  int recvReply;
@override@JsonKey() final  int reply;
@override@JsonKey(name: 'sys_msg') final  int sysMsg;
@override@JsonKey() final  int up;

/// Create a copy of UnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnreadCountModelCopyWith<_UnreadCountModel> get copyWith => __$UnreadCountModelCopyWithImpl<_UnreadCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnreadCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnreadCountModel&&(identical(other.at, at) || other.at == at)&&(identical(other.chat, chat) || other.chat == chat)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.danmu, danmu) || other.danmu == danmu)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.like, like) || other.like == like)&&(identical(other.recvLike, recvLike) || other.recvLike == recvLike)&&(identical(other.recvReply, recvReply) || other.recvReply == recvReply)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.sysMsg, sysMsg) || other.sysMsg == sysMsg)&&(identical(other.up, up) || other.up == up));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,at,chat,coin,danmu,favorite,like,recvLike,recvReply,reply,sysMsg,up);

@override
String toString() {
  return 'UnreadCountModel(at: $at, chat: $chat, coin: $coin, danmu: $danmu, favorite: $favorite, like: $like, recvLike: $recvLike, recvReply: $recvReply, reply: $reply, sysMsg: $sysMsg, up: $up)';
}


}

/// @nodoc
abstract mixin class _$UnreadCountModelCopyWith<$Res> implements $UnreadCountModelCopyWith<$Res> {
  factory _$UnreadCountModelCopyWith(_UnreadCountModel value, $Res Function(_UnreadCountModel) _then) = __$UnreadCountModelCopyWithImpl;
@override @useResult
$Res call({
 int at, int chat, int coin, int danmu, int favorite, int like,@JsonKey(name: 'recv_like') int recvLike,@JsonKey(name: 'recv_reply') int recvReply, int reply,@JsonKey(name: 'sys_msg') int sysMsg, int up
});




}
/// @nodoc
class __$UnreadCountModelCopyWithImpl<$Res>
    implements _$UnreadCountModelCopyWith<$Res> {
  __$UnreadCountModelCopyWithImpl(this._self, this._then);

  final _UnreadCountModel _self;
  final $Res Function(_UnreadCountModel) _then;

/// Create a copy of UnreadCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? at = null,Object? chat = null,Object? coin = null,Object? danmu = null,Object? favorite = null,Object? like = null,Object? recvLike = null,Object? recvReply = null,Object? reply = null,Object? sysMsg = null,Object? up = null,}) {
  return _then(_UnreadCountModel(
at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as int,chat: null == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as int,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int,danmu: null == danmu ? _self.danmu : danmu // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,recvLike: null == recvLike ? _self.recvLike : recvLike // ignore: cast_nullable_to_non_nullable
as int,recvReply: null == recvReply ? _self.recvReply : recvReply // ignore: cast_nullable_to_non_nullable
as int,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int,sysMsg: null == sysMsg ? _self.sysMsg : sysMsg // ignore: cast_nullable_to_non_nullable
as int,up: null == up ? _self.up : up // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
