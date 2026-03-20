// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_play_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LivePlayUrlModel {

@JsonKey(name: 'current_quality') int get currentQuality;@JsonKey(name: 'accept_quality') List<String> get acceptQuality;@JsonKey(name: 'current_qn') int get currentQn;@JsonKey(name: 'quality_description') List<LiveQualityDescription> get qualityDescription; List<LiveStreamUrl> get durl;
/// Create a copy of LivePlayUrlModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePlayUrlModelCopyWith<LivePlayUrlModel> get copyWith => _$LivePlayUrlModelCopyWithImpl<LivePlayUrlModel>(this as LivePlayUrlModel, _$identity);

  /// Serializes this LivePlayUrlModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePlayUrlModel&&(identical(other.currentQuality, currentQuality) || other.currentQuality == currentQuality)&&const DeepCollectionEquality().equals(other.acceptQuality, acceptQuality)&&(identical(other.currentQn, currentQn) || other.currentQn == currentQn)&&const DeepCollectionEquality().equals(other.qualityDescription, qualityDescription)&&const DeepCollectionEquality().equals(other.durl, durl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentQuality,const DeepCollectionEquality().hash(acceptQuality),currentQn,const DeepCollectionEquality().hash(qualityDescription),const DeepCollectionEquality().hash(durl));

@override
String toString() {
  return 'LivePlayUrlModel(currentQuality: $currentQuality, acceptQuality: $acceptQuality, currentQn: $currentQn, qualityDescription: $qualityDescription, durl: $durl)';
}


}

/// @nodoc
abstract mixin class $LivePlayUrlModelCopyWith<$Res>  {
  factory $LivePlayUrlModelCopyWith(LivePlayUrlModel value, $Res Function(LivePlayUrlModel) _then) = _$LivePlayUrlModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'current_quality') int currentQuality,@JsonKey(name: 'accept_quality') List<String> acceptQuality,@JsonKey(name: 'current_qn') int currentQn,@JsonKey(name: 'quality_description') List<LiveQualityDescription> qualityDescription, List<LiveStreamUrl> durl
});




}
/// @nodoc
class _$LivePlayUrlModelCopyWithImpl<$Res>
    implements $LivePlayUrlModelCopyWith<$Res> {
  _$LivePlayUrlModelCopyWithImpl(this._self, this._then);

  final LivePlayUrlModel _self;
  final $Res Function(LivePlayUrlModel) _then;

/// Create a copy of LivePlayUrlModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentQuality = null,Object? acceptQuality = null,Object? currentQn = null,Object? qualityDescription = null,Object? durl = null,}) {
  return _then(_self.copyWith(
currentQuality: null == currentQuality ? _self.currentQuality : currentQuality // ignore: cast_nullable_to_non_nullable
as int,acceptQuality: null == acceptQuality ? _self.acceptQuality : acceptQuality // ignore: cast_nullable_to_non_nullable
as List<String>,currentQn: null == currentQn ? _self.currentQn : currentQn // ignore: cast_nullable_to_non_nullable
as int,qualityDescription: null == qualityDescription ? _self.qualityDescription : qualityDescription // ignore: cast_nullable_to_non_nullable
as List<LiveQualityDescription>,durl: null == durl ? _self.durl : durl // ignore: cast_nullable_to_non_nullable
as List<LiveStreamUrl>,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePlayUrlModel].
extension LivePlayUrlModelPatterns on LivePlayUrlModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePlayUrlModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePlayUrlModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePlayUrlModel value)  $default,){
final _that = this;
switch (_that) {
case _LivePlayUrlModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePlayUrlModel value)?  $default,){
final _that = this;
switch (_that) {
case _LivePlayUrlModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_quality')  int currentQuality, @JsonKey(name: 'accept_quality')  List<String> acceptQuality, @JsonKey(name: 'current_qn')  int currentQn, @JsonKey(name: 'quality_description')  List<LiveQualityDescription> qualityDescription,  List<LiveStreamUrl> durl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePlayUrlModel() when $default != null:
return $default(_that.currentQuality,_that.acceptQuality,_that.currentQn,_that.qualityDescription,_that.durl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_quality')  int currentQuality, @JsonKey(name: 'accept_quality')  List<String> acceptQuality, @JsonKey(name: 'current_qn')  int currentQn, @JsonKey(name: 'quality_description')  List<LiveQualityDescription> qualityDescription,  List<LiveStreamUrl> durl)  $default,) {final _that = this;
switch (_that) {
case _LivePlayUrlModel():
return $default(_that.currentQuality,_that.acceptQuality,_that.currentQn,_that.qualityDescription,_that.durl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'current_quality')  int currentQuality, @JsonKey(name: 'accept_quality')  List<String> acceptQuality, @JsonKey(name: 'current_qn')  int currentQn, @JsonKey(name: 'quality_description')  List<LiveQualityDescription> qualityDescription,  List<LiveStreamUrl> durl)?  $default,) {final _that = this;
switch (_that) {
case _LivePlayUrlModel() when $default != null:
return $default(_that.currentQuality,_that.acceptQuality,_that.currentQn,_that.qualityDescription,_that.durl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePlayUrlModel implements LivePlayUrlModel {
  const _LivePlayUrlModel({@JsonKey(name: 'current_quality') required this.currentQuality, @JsonKey(name: 'accept_quality') required final  List<String> acceptQuality, @JsonKey(name: 'current_qn') required this.currentQn, @JsonKey(name: 'quality_description') required final  List<LiveQualityDescription> qualityDescription, required final  List<LiveStreamUrl> durl}): _acceptQuality = acceptQuality,_qualityDescription = qualityDescription,_durl = durl;
  factory _LivePlayUrlModel.fromJson(Map<String, dynamic> json) => _$LivePlayUrlModelFromJson(json);

@override@JsonKey(name: 'current_quality') final  int currentQuality;
 final  List<String> _acceptQuality;
@override@JsonKey(name: 'accept_quality') List<String> get acceptQuality {
  if (_acceptQuality is EqualUnmodifiableListView) return _acceptQuality;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptQuality);
}

@override@JsonKey(name: 'current_qn') final  int currentQn;
 final  List<LiveQualityDescription> _qualityDescription;
@override@JsonKey(name: 'quality_description') List<LiveQualityDescription> get qualityDescription {
  if (_qualityDescription is EqualUnmodifiableListView) return _qualityDescription;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qualityDescription);
}

 final  List<LiveStreamUrl> _durl;
@override List<LiveStreamUrl> get durl {
  if (_durl is EqualUnmodifiableListView) return _durl;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_durl);
}


/// Create a copy of LivePlayUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePlayUrlModelCopyWith<_LivePlayUrlModel> get copyWith => __$LivePlayUrlModelCopyWithImpl<_LivePlayUrlModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePlayUrlModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePlayUrlModel&&(identical(other.currentQuality, currentQuality) || other.currentQuality == currentQuality)&&const DeepCollectionEquality().equals(other._acceptQuality, _acceptQuality)&&(identical(other.currentQn, currentQn) || other.currentQn == currentQn)&&const DeepCollectionEquality().equals(other._qualityDescription, _qualityDescription)&&const DeepCollectionEquality().equals(other._durl, _durl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentQuality,const DeepCollectionEquality().hash(_acceptQuality),currentQn,const DeepCollectionEquality().hash(_qualityDescription),const DeepCollectionEquality().hash(_durl));

@override
String toString() {
  return 'LivePlayUrlModel(currentQuality: $currentQuality, acceptQuality: $acceptQuality, currentQn: $currentQn, qualityDescription: $qualityDescription, durl: $durl)';
}


}

/// @nodoc
abstract mixin class _$LivePlayUrlModelCopyWith<$Res> implements $LivePlayUrlModelCopyWith<$Res> {
  factory _$LivePlayUrlModelCopyWith(_LivePlayUrlModel value, $Res Function(_LivePlayUrlModel) _then) = __$LivePlayUrlModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'current_quality') int currentQuality,@JsonKey(name: 'accept_quality') List<String> acceptQuality,@JsonKey(name: 'current_qn') int currentQn,@JsonKey(name: 'quality_description') List<LiveQualityDescription> qualityDescription, List<LiveStreamUrl> durl
});




}
/// @nodoc
class __$LivePlayUrlModelCopyWithImpl<$Res>
    implements _$LivePlayUrlModelCopyWith<$Res> {
  __$LivePlayUrlModelCopyWithImpl(this._self, this._then);

  final _LivePlayUrlModel _self;
  final $Res Function(_LivePlayUrlModel) _then;

/// Create a copy of LivePlayUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentQuality = null,Object? acceptQuality = null,Object? currentQn = null,Object? qualityDescription = null,Object? durl = null,}) {
  return _then(_LivePlayUrlModel(
currentQuality: null == currentQuality ? _self.currentQuality : currentQuality // ignore: cast_nullable_to_non_nullable
as int,acceptQuality: null == acceptQuality ? _self._acceptQuality : acceptQuality // ignore: cast_nullable_to_non_nullable
as List<String>,currentQn: null == currentQn ? _self.currentQn : currentQn // ignore: cast_nullable_to_non_nullable
as int,qualityDescription: null == qualityDescription ? _self._qualityDescription : qualityDescription // ignore: cast_nullable_to_non_nullable
as List<LiveQualityDescription>,durl: null == durl ? _self._durl : durl // ignore: cast_nullable_to_non_nullable
as List<LiveStreamUrl>,
  ));
}


}


/// @nodoc
mixin _$LiveQualityDescription {

 int get qn; String get desc;
/// Create a copy of LiveQualityDescription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveQualityDescriptionCopyWith<LiveQualityDescription> get copyWith => _$LiveQualityDescriptionCopyWithImpl<LiveQualityDescription>(this as LiveQualityDescription, _$identity);

  /// Serializes this LiveQualityDescription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveQualityDescription&&(identical(other.qn, qn) || other.qn == qn)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,qn,desc);

@override
String toString() {
  return 'LiveQualityDescription(qn: $qn, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $LiveQualityDescriptionCopyWith<$Res>  {
  factory $LiveQualityDescriptionCopyWith(LiveQualityDescription value, $Res Function(LiveQualityDescription) _then) = _$LiveQualityDescriptionCopyWithImpl;
@useResult
$Res call({
 int qn, String desc
});




}
/// @nodoc
class _$LiveQualityDescriptionCopyWithImpl<$Res>
    implements $LiveQualityDescriptionCopyWith<$Res> {
  _$LiveQualityDescriptionCopyWithImpl(this._self, this._then);

  final LiveQualityDescription _self;
  final $Res Function(LiveQualityDescription) _then;

/// Create a copy of LiveQualityDescription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qn = null,Object? desc = null,}) {
  return _then(_self.copyWith(
qn: null == qn ? _self.qn : qn // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveQualityDescription].
extension LiveQualityDescriptionPatterns on LiveQualityDescription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveQualityDescription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveQualityDescription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveQualityDescription value)  $default,){
final _that = this;
switch (_that) {
case _LiveQualityDescription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveQualityDescription value)?  $default,){
final _that = this;
switch (_that) {
case _LiveQualityDescription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int qn,  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveQualityDescription() when $default != null:
return $default(_that.qn,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int qn,  String desc)  $default,) {final _that = this;
switch (_that) {
case _LiveQualityDescription():
return $default(_that.qn,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int qn,  String desc)?  $default,) {final _that = this;
switch (_that) {
case _LiveQualityDescription() when $default != null:
return $default(_that.qn,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveQualityDescription implements LiveQualityDescription {
  const _LiveQualityDescription({required this.qn, required this.desc});
  factory _LiveQualityDescription.fromJson(Map<String, dynamic> json) => _$LiveQualityDescriptionFromJson(json);

@override final  int qn;
@override final  String desc;

/// Create a copy of LiveQualityDescription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveQualityDescriptionCopyWith<_LiveQualityDescription> get copyWith => __$LiveQualityDescriptionCopyWithImpl<_LiveQualityDescription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveQualityDescriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveQualityDescription&&(identical(other.qn, qn) || other.qn == qn)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,qn,desc);

@override
String toString() {
  return 'LiveQualityDescription(qn: $qn, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$LiveQualityDescriptionCopyWith<$Res> implements $LiveQualityDescriptionCopyWith<$Res> {
  factory _$LiveQualityDescriptionCopyWith(_LiveQualityDescription value, $Res Function(_LiveQualityDescription) _then) = __$LiveQualityDescriptionCopyWithImpl;
@override @useResult
$Res call({
 int qn, String desc
});




}
/// @nodoc
class __$LiveQualityDescriptionCopyWithImpl<$Res>
    implements _$LiveQualityDescriptionCopyWith<$Res> {
  __$LiveQualityDescriptionCopyWithImpl(this._self, this._then);

  final _LiveQualityDescription _self;
  final $Res Function(_LiveQualityDescription) _then;

/// Create a copy of LiveQualityDescription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qn = null,Object? desc = null,}) {
  return _then(_LiveQualityDescription(
qn: null == qn ? _self.qn : qn // ignore: cast_nullable_to_non_nullable
as int,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LiveStreamUrl {

 String get url; int get length; int get order;@JsonKey(name: 'stream_type') int get streamType;@JsonKey(name: 'p2p_type') int get p2pType;
/// Create a copy of LiveStreamUrl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveStreamUrlCopyWith<LiveStreamUrl> get copyWith => _$LiveStreamUrlCopyWithImpl<LiveStreamUrl>(this as LiveStreamUrl, _$identity);

  /// Serializes this LiveStreamUrl to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveStreamUrl&&(identical(other.url, url) || other.url == url)&&(identical(other.length, length) || other.length == length)&&(identical(other.order, order) || other.order == order)&&(identical(other.streamType, streamType) || other.streamType == streamType)&&(identical(other.p2pType, p2pType) || other.p2pType == p2pType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,length,order,streamType,p2pType);

@override
String toString() {
  return 'LiveStreamUrl(url: $url, length: $length, order: $order, streamType: $streamType, p2pType: $p2pType)';
}


}

/// @nodoc
abstract mixin class $LiveStreamUrlCopyWith<$Res>  {
  factory $LiveStreamUrlCopyWith(LiveStreamUrl value, $Res Function(LiveStreamUrl) _then) = _$LiveStreamUrlCopyWithImpl;
@useResult
$Res call({
 String url, int length, int order,@JsonKey(name: 'stream_type') int streamType,@JsonKey(name: 'p2p_type') int p2pType
});




}
/// @nodoc
class _$LiveStreamUrlCopyWithImpl<$Res>
    implements $LiveStreamUrlCopyWith<$Res> {
  _$LiveStreamUrlCopyWithImpl(this._self, this._then);

  final LiveStreamUrl _self;
  final $Res Function(LiveStreamUrl) _then;

/// Create a copy of LiveStreamUrl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? length = null,Object? order = null,Object? streamType = null,Object? p2pType = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,streamType: null == streamType ? _self.streamType : streamType // ignore: cast_nullable_to_non_nullable
as int,p2pType: null == p2pType ? _self.p2pType : p2pType // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveStreamUrl].
extension LiveStreamUrlPatterns on LiveStreamUrl {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveStreamUrl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveStreamUrl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveStreamUrl value)  $default,){
final _that = this;
switch (_that) {
case _LiveStreamUrl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveStreamUrl value)?  $default,){
final _that = this;
switch (_that) {
case _LiveStreamUrl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  int length,  int order, @JsonKey(name: 'stream_type')  int streamType, @JsonKey(name: 'p2p_type')  int p2pType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveStreamUrl() when $default != null:
return $default(_that.url,_that.length,_that.order,_that.streamType,_that.p2pType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  int length,  int order, @JsonKey(name: 'stream_type')  int streamType, @JsonKey(name: 'p2p_type')  int p2pType)  $default,) {final _that = this;
switch (_that) {
case _LiveStreamUrl():
return $default(_that.url,_that.length,_that.order,_that.streamType,_that.p2pType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  int length,  int order, @JsonKey(name: 'stream_type')  int streamType, @JsonKey(name: 'p2p_type')  int p2pType)?  $default,) {final _that = this;
switch (_that) {
case _LiveStreamUrl() when $default != null:
return $default(_that.url,_that.length,_that.order,_that.streamType,_that.p2pType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveStreamUrl implements LiveStreamUrl {
  const _LiveStreamUrl({required this.url, required this.length, required this.order, @JsonKey(name: 'stream_type') required this.streamType, @JsonKey(name: 'p2p_type') required this.p2pType});
  factory _LiveStreamUrl.fromJson(Map<String, dynamic> json) => _$LiveStreamUrlFromJson(json);

@override final  String url;
@override final  int length;
@override final  int order;
@override@JsonKey(name: 'stream_type') final  int streamType;
@override@JsonKey(name: 'p2p_type') final  int p2pType;

/// Create a copy of LiveStreamUrl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveStreamUrlCopyWith<_LiveStreamUrl> get copyWith => __$LiveStreamUrlCopyWithImpl<_LiveStreamUrl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveStreamUrlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveStreamUrl&&(identical(other.url, url) || other.url == url)&&(identical(other.length, length) || other.length == length)&&(identical(other.order, order) || other.order == order)&&(identical(other.streamType, streamType) || other.streamType == streamType)&&(identical(other.p2pType, p2pType) || other.p2pType == p2pType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,length,order,streamType,p2pType);

@override
String toString() {
  return 'LiveStreamUrl(url: $url, length: $length, order: $order, streamType: $streamType, p2pType: $p2pType)';
}


}

/// @nodoc
abstract mixin class _$LiveStreamUrlCopyWith<$Res> implements $LiveStreamUrlCopyWith<$Res> {
  factory _$LiveStreamUrlCopyWith(_LiveStreamUrl value, $Res Function(_LiveStreamUrl) _then) = __$LiveStreamUrlCopyWithImpl;
@override @useResult
$Res call({
 String url, int length, int order,@JsonKey(name: 'stream_type') int streamType,@JsonKey(name: 'p2p_type') int p2pType
});




}
/// @nodoc
class __$LiveStreamUrlCopyWithImpl<$Res>
    implements _$LiveStreamUrlCopyWith<$Res> {
  __$LiveStreamUrlCopyWithImpl(this._self, this._then);

  final _LiveStreamUrl _self;
  final $Res Function(_LiveStreamUrl) _then;

/// Create a copy of LiveStreamUrl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? length = null,Object? order = null,Object? streamType = null,Object? p2pType = null,}) {
  return _then(_LiveStreamUrl(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,streamType: null == streamType ? _self.streamType : streamType // ignore: cast_nullable_to_non_nullable
as int,p2pType: null == p2pType ? _self.p2pType : p2pType // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
