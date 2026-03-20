// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_danmu_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveDanmuInfoModel {

 String get token;@JsonKey(name: 'host_list') List<LiveDanmuHost> get hostList;
/// Create a copy of LiveDanmuInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmuInfoModelCopyWith<LiveDanmuInfoModel> get copyWith => _$LiveDanmuInfoModelCopyWithImpl<LiveDanmuInfoModel>(this as LiveDanmuInfoModel, _$identity);

  /// Serializes this LiveDanmuInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmuInfoModel&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other.hostList, hostList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,const DeepCollectionEquality().hash(hostList));

@override
String toString() {
  return 'LiveDanmuInfoModel(token: $token, hostList: $hostList)';
}


}

/// @nodoc
abstract mixin class $LiveDanmuInfoModelCopyWith<$Res>  {
  factory $LiveDanmuInfoModelCopyWith(LiveDanmuInfoModel value, $Res Function(LiveDanmuInfoModel) _then) = _$LiveDanmuInfoModelCopyWithImpl;
@useResult
$Res call({
 String token,@JsonKey(name: 'host_list') List<LiveDanmuHost> hostList
});




}
/// @nodoc
class _$LiveDanmuInfoModelCopyWithImpl<$Res>
    implements $LiveDanmuInfoModelCopyWith<$Res> {
  _$LiveDanmuInfoModelCopyWithImpl(this._self, this._then);

  final LiveDanmuInfoModel _self;
  final $Res Function(LiveDanmuInfoModel) _then;

/// Create a copy of LiveDanmuInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? hostList = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,hostList: null == hostList ? _self.hostList : hostList // ignore: cast_nullable_to_non_nullable
as List<LiveDanmuHost>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmuInfoModel].
extension LiveDanmuInfoModelPatterns on LiveDanmuInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmuInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmuInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmuInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmuInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmuInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmuInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token, @JsonKey(name: 'host_list')  List<LiveDanmuHost> hostList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmuInfoModel() when $default != null:
return $default(_that.token,_that.hostList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token, @JsonKey(name: 'host_list')  List<LiveDanmuHost> hostList)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmuInfoModel():
return $default(_that.token,_that.hostList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token, @JsonKey(name: 'host_list')  List<LiveDanmuHost> hostList)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmuInfoModel() when $default != null:
return $default(_that.token,_that.hostList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmuInfoModel implements LiveDanmuInfoModel {
  const _LiveDanmuInfoModel({required this.token, @JsonKey(name: 'host_list') required final  List<LiveDanmuHost> hostList}): _hostList = hostList;
  factory _LiveDanmuInfoModel.fromJson(Map<String, dynamic> json) => _$LiveDanmuInfoModelFromJson(json);

@override final  String token;
 final  List<LiveDanmuHost> _hostList;
@override@JsonKey(name: 'host_list') List<LiveDanmuHost> get hostList {
  if (_hostList is EqualUnmodifiableListView) return _hostList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hostList);
}


/// Create a copy of LiveDanmuInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmuInfoModelCopyWith<_LiveDanmuInfoModel> get copyWith => __$LiveDanmuInfoModelCopyWithImpl<_LiveDanmuInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmuInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmuInfoModel&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other._hostList, _hostList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,const DeepCollectionEquality().hash(_hostList));

@override
String toString() {
  return 'LiveDanmuInfoModel(token: $token, hostList: $hostList)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmuInfoModelCopyWith<$Res> implements $LiveDanmuInfoModelCopyWith<$Res> {
  factory _$LiveDanmuInfoModelCopyWith(_LiveDanmuInfoModel value, $Res Function(_LiveDanmuInfoModel) _then) = __$LiveDanmuInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String token,@JsonKey(name: 'host_list') List<LiveDanmuHost> hostList
});




}
/// @nodoc
class __$LiveDanmuInfoModelCopyWithImpl<$Res>
    implements _$LiveDanmuInfoModelCopyWith<$Res> {
  __$LiveDanmuInfoModelCopyWithImpl(this._self, this._then);

  final _LiveDanmuInfoModel _self;
  final $Res Function(_LiveDanmuInfoModel) _then;

/// Create a copy of LiveDanmuInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? hostList = null,}) {
  return _then(_LiveDanmuInfoModel(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,hostList: null == hostList ? _self._hostList : hostList // ignore: cast_nullable_to_non_nullable
as List<LiveDanmuHost>,
  ));
}


}


/// @nodoc
mixin _$LiveDanmuHost {

 String get host;@JsonKey(name: 'wss_port') int get wssPort;@JsonKey(name: 'ws_port') int get wsPort;
/// Create a copy of LiveDanmuHost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmuHostCopyWith<LiveDanmuHost> get copyWith => _$LiveDanmuHostCopyWithImpl<LiveDanmuHost>(this as LiveDanmuHost, _$identity);

  /// Serializes this LiveDanmuHost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmuHost&&(identical(other.host, host) || other.host == host)&&(identical(other.wssPort, wssPort) || other.wssPort == wssPort)&&(identical(other.wsPort, wsPort) || other.wsPort == wsPort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,wssPort,wsPort);

@override
String toString() {
  return 'LiveDanmuHost(host: $host, wssPort: $wssPort, wsPort: $wsPort)';
}


}

/// @nodoc
abstract mixin class $LiveDanmuHostCopyWith<$Res>  {
  factory $LiveDanmuHostCopyWith(LiveDanmuHost value, $Res Function(LiveDanmuHost) _then) = _$LiveDanmuHostCopyWithImpl;
@useResult
$Res call({
 String host,@JsonKey(name: 'wss_port') int wssPort,@JsonKey(name: 'ws_port') int wsPort
});




}
/// @nodoc
class _$LiveDanmuHostCopyWithImpl<$Res>
    implements $LiveDanmuHostCopyWith<$Res> {
  _$LiveDanmuHostCopyWithImpl(this._self, this._then);

  final LiveDanmuHost _self;
  final $Res Function(LiveDanmuHost) _then;

/// Create a copy of LiveDanmuHost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? host = null,Object? wssPort = null,Object? wsPort = null,}) {
  return _then(_self.copyWith(
host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,wssPort: null == wssPort ? _self.wssPort : wssPort // ignore: cast_nullable_to_non_nullable
as int,wsPort: null == wsPort ? _self.wsPort : wsPort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmuHost].
extension LiveDanmuHostPatterns on LiveDanmuHost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmuHost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmuHost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmuHost value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmuHost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmuHost value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmuHost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String host, @JsonKey(name: 'wss_port')  int wssPort, @JsonKey(name: 'ws_port')  int wsPort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmuHost() when $default != null:
return $default(_that.host,_that.wssPort,_that.wsPort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String host, @JsonKey(name: 'wss_port')  int wssPort, @JsonKey(name: 'ws_port')  int wsPort)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmuHost():
return $default(_that.host,_that.wssPort,_that.wsPort);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String host, @JsonKey(name: 'wss_port')  int wssPort, @JsonKey(name: 'ws_port')  int wsPort)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmuHost() when $default != null:
return $default(_that.host,_that.wssPort,_that.wsPort);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmuHost implements LiveDanmuHost {
  const _LiveDanmuHost({required this.host, @JsonKey(name: 'wss_port') required this.wssPort, @JsonKey(name: 'ws_port') required this.wsPort});
  factory _LiveDanmuHost.fromJson(Map<String, dynamic> json) => _$LiveDanmuHostFromJson(json);

@override final  String host;
@override@JsonKey(name: 'wss_port') final  int wssPort;
@override@JsonKey(name: 'ws_port') final  int wsPort;

/// Create a copy of LiveDanmuHost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmuHostCopyWith<_LiveDanmuHost> get copyWith => __$LiveDanmuHostCopyWithImpl<_LiveDanmuHost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmuHostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmuHost&&(identical(other.host, host) || other.host == host)&&(identical(other.wssPort, wssPort) || other.wssPort == wssPort)&&(identical(other.wsPort, wsPort) || other.wsPort == wsPort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,wssPort,wsPort);

@override
String toString() {
  return 'LiveDanmuHost(host: $host, wssPort: $wssPort, wsPort: $wsPort)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmuHostCopyWith<$Res> implements $LiveDanmuHostCopyWith<$Res> {
  factory _$LiveDanmuHostCopyWith(_LiveDanmuHost value, $Res Function(_LiveDanmuHost) _then) = __$LiveDanmuHostCopyWithImpl;
@override @useResult
$Res call({
 String host,@JsonKey(name: 'wss_port') int wssPort,@JsonKey(name: 'ws_port') int wsPort
});




}
/// @nodoc
class __$LiveDanmuHostCopyWithImpl<$Res>
    implements _$LiveDanmuHostCopyWith<$Res> {
  __$LiveDanmuHostCopyWithImpl(this._self, this._then);

  final _LiveDanmuHost _self;
  final $Res Function(_LiveDanmuHost) _then;

/// Create a copy of LiveDanmuHost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? host = null,Object? wssPort = null,Object? wsPort = null,}) {
  return _then(_LiveDanmuHost(
host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,wssPort: null == wssPort ? _self.wssPort : wssPort // ignore: cast_nullable_to_non_nullable
as int,wsPort: null == wsPort ? _self.wsPort : wsPort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
