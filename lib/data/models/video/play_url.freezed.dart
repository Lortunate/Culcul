// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayUrl {

 String get format; int get quality;@JsonKey(name: 'timelength') int get timeLength;@JsonKey(name: 'accept_format') String get acceptFormat;@JsonKey(name: 'accept_description') List<String> get acceptDescription;@JsonKey(name: 'accept_quality') List<int> get acceptQuality;@JsonKey(name: 'video_codecid') int get videoCodecId; List<Durl> get durl;@JsonKey(name: 'support_formats') List<SupportFormat> get supportFormats;
/// Create a copy of PlayUrl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayUrlCopyWith<PlayUrl> get copyWith => _$PlayUrlCopyWithImpl<PlayUrl>(this as PlayUrl, _$identity);

  /// Serializes this PlayUrl to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayUrl&&(identical(other.format, format) || other.format == format)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.timeLength, timeLength) || other.timeLength == timeLength)&&(identical(other.acceptFormat, acceptFormat) || other.acceptFormat == acceptFormat)&&const DeepCollectionEquality().equals(other.acceptDescription, acceptDescription)&&const DeepCollectionEquality().equals(other.acceptQuality, acceptQuality)&&(identical(other.videoCodecId, videoCodecId) || other.videoCodecId == videoCodecId)&&const DeepCollectionEquality().equals(other.durl, durl)&&const DeepCollectionEquality().equals(other.supportFormats, supportFormats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,quality,timeLength,acceptFormat,const DeepCollectionEquality().hash(acceptDescription),const DeepCollectionEquality().hash(acceptQuality),videoCodecId,const DeepCollectionEquality().hash(durl),const DeepCollectionEquality().hash(supportFormats));

@override
String toString() {
  return 'PlayUrl(format: $format, quality: $quality, timeLength: $timeLength, acceptFormat: $acceptFormat, acceptDescription: $acceptDescription, acceptQuality: $acceptQuality, videoCodecId: $videoCodecId, durl: $durl, supportFormats: $supportFormats)';
}


}

/// @nodoc
abstract mixin class $PlayUrlCopyWith<$Res>  {
  factory $PlayUrlCopyWith(PlayUrl value, $Res Function(PlayUrl) _then) = _$PlayUrlCopyWithImpl;
@useResult
$Res call({
 String format, int quality,@JsonKey(name: 'timelength') int timeLength,@JsonKey(name: 'accept_format') String acceptFormat,@JsonKey(name: 'accept_description') List<String> acceptDescription,@JsonKey(name: 'accept_quality') List<int> acceptQuality,@JsonKey(name: 'video_codecid') int videoCodecId, List<Durl> durl,@JsonKey(name: 'support_formats') List<SupportFormat> supportFormats
});




}
/// @nodoc
class _$PlayUrlCopyWithImpl<$Res>
    implements $PlayUrlCopyWith<$Res> {
  _$PlayUrlCopyWithImpl(this._self, this._then);

  final PlayUrl _self;
  final $Res Function(PlayUrl) _then;

/// Create a copy of PlayUrl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? format = null,Object? quality = null,Object? timeLength = null,Object? acceptFormat = null,Object? acceptDescription = null,Object? acceptQuality = null,Object? videoCodecId = null,Object? durl = null,Object? supportFormats = null,}) {
  return _then(_self.copyWith(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,timeLength: null == timeLength ? _self.timeLength : timeLength // ignore: cast_nullable_to_non_nullable
as int,acceptFormat: null == acceptFormat ? _self.acceptFormat : acceptFormat // ignore: cast_nullable_to_non_nullable
as String,acceptDescription: null == acceptDescription ? _self.acceptDescription : acceptDescription // ignore: cast_nullable_to_non_nullable
as List<String>,acceptQuality: null == acceptQuality ? _self.acceptQuality : acceptQuality // ignore: cast_nullable_to_non_nullable
as List<int>,videoCodecId: null == videoCodecId ? _self.videoCodecId : videoCodecId // ignore: cast_nullable_to_non_nullable
as int,durl: null == durl ? _self.durl : durl // ignore: cast_nullable_to_non_nullable
as List<Durl>,supportFormats: null == supportFormats ? _self.supportFormats : supportFormats // ignore: cast_nullable_to_non_nullable
as List<SupportFormat>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayUrl].
extension PlayUrlPatterns on PlayUrl {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayUrl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayUrl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayUrl value)  $default,){
final _that = this;
switch (_that) {
case _PlayUrl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayUrl value)?  $default,){
final _that = this;
switch (_that) {
case _PlayUrl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String format,  int quality, @JsonKey(name: 'timelength')  int timeLength, @JsonKey(name: 'accept_format')  String acceptFormat, @JsonKey(name: 'accept_description')  List<String> acceptDescription, @JsonKey(name: 'accept_quality')  List<int> acceptQuality, @JsonKey(name: 'video_codecid')  int videoCodecId,  List<Durl> durl, @JsonKey(name: 'support_formats')  List<SupportFormat> supportFormats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayUrl() when $default != null:
return $default(_that.format,_that.quality,_that.timeLength,_that.acceptFormat,_that.acceptDescription,_that.acceptQuality,_that.videoCodecId,_that.durl,_that.supportFormats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String format,  int quality, @JsonKey(name: 'timelength')  int timeLength, @JsonKey(name: 'accept_format')  String acceptFormat, @JsonKey(name: 'accept_description')  List<String> acceptDescription, @JsonKey(name: 'accept_quality')  List<int> acceptQuality, @JsonKey(name: 'video_codecid')  int videoCodecId,  List<Durl> durl, @JsonKey(name: 'support_formats')  List<SupportFormat> supportFormats)  $default,) {final _that = this;
switch (_that) {
case _PlayUrl():
return $default(_that.format,_that.quality,_that.timeLength,_that.acceptFormat,_that.acceptDescription,_that.acceptQuality,_that.videoCodecId,_that.durl,_that.supportFormats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String format,  int quality, @JsonKey(name: 'timelength')  int timeLength, @JsonKey(name: 'accept_format')  String acceptFormat, @JsonKey(name: 'accept_description')  List<String> acceptDescription, @JsonKey(name: 'accept_quality')  List<int> acceptQuality, @JsonKey(name: 'video_codecid')  int videoCodecId,  List<Durl> durl, @JsonKey(name: 'support_formats')  List<SupportFormat> supportFormats)?  $default,) {final _that = this;
switch (_that) {
case _PlayUrl() when $default != null:
return $default(_that.format,_that.quality,_that.timeLength,_that.acceptFormat,_that.acceptDescription,_that.acceptQuality,_that.videoCodecId,_that.durl,_that.supportFormats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayUrl implements PlayUrl {
  const _PlayUrl({required this.format, required this.quality, @JsonKey(name: 'timelength') required this.timeLength, @JsonKey(name: 'accept_format') required this.acceptFormat, @JsonKey(name: 'accept_description') required final  List<String> acceptDescription, @JsonKey(name: 'accept_quality') required final  List<int> acceptQuality, @JsonKey(name: 'video_codecid') required this.videoCodecId, required final  List<Durl> durl, @JsonKey(name: 'support_formats') final  List<SupportFormat> supportFormats = const []}): _acceptDescription = acceptDescription,_acceptQuality = acceptQuality,_durl = durl,_supportFormats = supportFormats;
  factory _PlayUrl.fromJson(Map<String, dynamic> json) => _$PlayUrlFromJson(json);

@override final  String format;
@override final  int quality;
@override@JsonKey(name: 'timelength') final  int timeLength;
@override@JsonKey(name: 'accept_format') final  String acceptFormat;
 final  List<String> _acceptDescription;
@override@JsonKey(name: 'accept_description') List<String> get acceptDescription {
  if (_acceptDescription is EqualUnmodifiableListView) return _acceptDescription;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptDescription);
}

 final  List<int> _acceptQuality;
@override@JsonKey(name: 'accept_quality') List<int> get acceptQuality {
  if (_acceptQuality is EqualUnmodifiableListView) return _acceptQuality;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptQuality);
}

@override@JsonKey(name: 'video_codecid') final  int videoCodecId;
 final  List<Durl> _durl;
@override List<Durl> get durl {
  if (_durl is EqualUnmodifiableListView) return _durl;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_durl);
}

 final  List<SupportFormat> _supportFormats;
@override@JsonKey(name: 'support_formats') List<SupportFormat> get supportFormats {
  if (_supportFormats is EqualUnmodifiableListView) return _supportFormats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportFormats);
}


/// Create a copy of PlayUrl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayUrlCopyWith<_PlayUrl> get copyWith => __$PlayUrlCopyWithImpl<_PlayUrl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayUrlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayUrl&&(identical(other.format, format) || other.format == format)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.timeLength, timeLength) || other.timeLength == timeLength)&&(identical(other.acceptFormat, acceptFormat) || other.acceptFormat == acceptFormat)&&const DeepCollectionEquality().equals(other._acceptDescription, _acceptDescription)&&const DeepCollectionEquality().equals(other._acceptQuality, _acceptQuality)&&(identical(other.videoCodecId, videoCodecId) || other.videoCodecId == videoCodecId)&&const DeepCollectionEquality().equals(other._durl, _durl)&&const DeepCollectionEquality().equals(other._supportFormats, _supportFormats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,quality,timeLength,acceptFormat,const DeepCollectionEquality().hash(_acceptDescription),const DeepCollectionEquality().hash(_acceptQuality),videoCodecId,const DeepCollectionEquality().hash(_durl),const DeepCollectionEquality().hash(_supportFormats));

@override
String toString() {
  return 'PlayUrl(format: $format, quality: $quality, timeLength: $timeLength, acceptFormat: $acceptFormat, acceptDescription: $acceptDescription, acceptQuality: $acceptQuality, videoCodecId: $videoCodecId, durl: $durl, supportFormats: $supportFormats)';
}


}

/// @nodoc
abstract mixin class _$PlayUrlCopyWith<$Res> implements $PlayUrlCopyWith<$Res> {
  factory _$PlayUrlCopyWith(_PlayUrl value, $Res Function(_PlayUrl) _then) = __$PlayUrlCopyWithImpl;
@override @useResult
$Res call({
 String format, int quality,@JsonKey(name: 'timelength') int timeLength,@JsonKey(name: 'accept_format') String acceptFormat,@JsonKey(name: 'accept_description') List<String> acceptDescription,@JsonKey(name: 'accept_quality') List<int> acceptQuality,@JsonKey(name: 'video_codecid') int videoCodecId, List<Durl> durl,@JsonKey(name: 'support_formats') List<SupportFormat> supportFormats
});




}
/// @nodoc
class __$PlayUrlCopyWithImpl<$Res>
    implements _$PlayUrlCopyWith<$Res> {
  __$PlayUrlCopyWithImpl(this._self, this._then);

  final _PlayUrl _self;
  final $Res Function(_PlayUrl) _then;

/// Create a copy of PlayUrl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? format = null,Object? quality = null,Object? timeLength = null,Object? acceptFormat = null,Object? acceptDescription = null,Object? acceptQuality = null,Object? videoCodecId = null,Object? durl = null,Object? supportFormats = null,}) {
  return _then(_PlayUrl(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,timeLength: null == timeLength ? _self.timeLength : timeLength // ignore: cast_nullable_to_non_nullable
as int,acceptFormat: null == acceptFormat ? _self.acceptFormat : acceptFormat // ignore: cast_nullable_to_non_nullable
as String,acceptDescription: null == acceptDescription ? _self._acceptDescription : acceptDescription // ignore: cast_nullable_to_non_nullable
as List<String>,acceptQuality: null == acceptQuality ? _self._acceptQuality : acceptQuality // ignore: cast_nullable_to_non_nullable
as List<int>,videoCodecId: null == videoCodecId ? _self.videoCodecId : videoCodecId // ignore: cast_nullable_to_non_nullable
as int,durl: null == durl ? _self._durl : durl // ignore: cast_nullable_to_non_nullable
as List<Durl>,supportFormats: null == supportFormats ? _self._supportFormats : supportFormats // ignore: cast_nullable_to_non_nullable
as List<SupportFormat>,
  ));
}


}


/// @nodoc
mixin _$Durl {

 int get order; int get length; int get size; String get url; List<String> get backupUrl;
/// Create a copy of Durl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DurlCopyWith<Durl> get copyWith => _$DurlCopyWithImpl<Durl>(this as Durl, _$identity);

  /// Serializes this Durl to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Durl&&(identical(other.order, order) || other.order == order)&&(identical(other.length, length) || other.length == length)&&(identical(other.size, size) || other.size == size)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.backupUrl, backupUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,length,size,url,const DeepCollectionEquality().hash(backupUrl));

@override
String toString() {
  return 'Durl(order: $order, length: $length, size: $size, url: $url, backupUrl: $backupUrl)';
}


}

/// @nodoc
abstract mixin class $DurlCopyWith<$Res>  {
  factory $DurlCopyWith(Durl value, $Res Function(Durl) _then) = _$DurlCopyWithImpl;
@useResult
$Res call({
 int order, int length, int size, String url, List<String> backupUrl
});




}
/// @nodoc
class _$DurlCopyWithImpl<$Res>
    implements $DurlCopyWith<$Res> {
  _$DurlCopyWithImpl(this._self, this._then);

  final Durl _self;
  final $Res Function(Durl) _then;

/// Create a copy of Durl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? length = null,Object? size = null,Object? url = null,Object? backupUrl = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,backupUrl: null == backupUrl ? _self.backupUrl : backupUrl // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Durl].
extension DurlPatterns on Durl {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Durl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Durl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Durl value)  $default,){
final _that = this;
switch (_that) {
case _Durl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Durl value)?  $default,){
final _that = this;
switch (_that) {
case _Durl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  int length,  int size,  String url,  List<String> backupUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Durl() when $default != null:
return $default(_that.order,_that.length,_that.size,_that.url,_that.backupUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  int length,  int size,  String url,  List<String> backupUrl)  $default,) {final _that = this;
switch (_that) {
case _Durl():
return $default(_that.order,_that.length,_that.size,_that.url,_that.backupUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  int length,  int size,  String url,  List<String> backupUrl)?  $default,) {final _that = this;
switch (_that) {
case _Durl() when $default != null:
return $default(_that.order,_that.length,_that.size,_that.url,_that.backupUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Durl implements Durl {
  const _Durl({required this.order, required this.length, required this.size, required this.url, final  List<String> backupUrl = const []}): _backupUrl = backupUrl;
  factory _Durl.fromJson(Map<String, dynamic> json) => _$DurlFromJson(json);

@override final  int order;
@override final  int length;
@override final  int size;
@override final  String url;
 final  List<String> _backupUrl;
@override@JsonKey() List<String> get backupUrl {
  if (_backupUrl is EqualUnmodifiableListView) return _backupUrl;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backupUrl);
}


/// Create a copy of Durl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DurlCopyWith<_Durl> get copyWith => __$DurlCopyWithImpl<_Durl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DurlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Durl&&(identical(other.order, order) || other.order == order)&&(identical(other.length, length) || other.length == length)&&(identical(other.size, size) || other.size == size)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._backupUrl, _backupUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,length,size,url,const DeepCollectionEquality().hash(_backupUrl));

@override
String toString() {
  return 'Durl(order: $order, length: $length, size: $size, url: $url, backupUrl: $backupUrl)';
}


}

/// @nodoc
abstract mixin class _$DurlCopyWith<$Res> implements $DurlCopyWith<$Res> {
  factory _$DurlCopyWith(_Durl value, $Res Function(_Durl) _then) = __$DurlCopyWithImpl;
@override @useResult
$Res call({
 int order, int length, int size, String url, List<String> backupUrl
});




}
/// @nodoc
class __$DurlCopyWithImpl<$Res>
    implements _$DurlCopyWith<$Res> {
  __$DurlCopyWithImpl(this._self, this._then);

  final _Durl _self;
  final $Res Function(_Durl) _then;

/// Create a copy of Durl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? length = null,Object? size = null,Object? url = null,Object? backupUrl = null,}) {
  return _then(_Durl(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,backupUrl: null == backupUrl ? _self._backupUrl : backupUrl // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SupportFormat {

 int get quality; String get format;@JsonKey(name: 'new_description') String get newDescription;@JsonKey(name: 'display_desc') String get displayDesc; String get superscript; List<String> get codecs;
/// Create a copy of SupportFormat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportFormatCopyWith<SupportFormat> get copyWith => _$SupportFormatCopyWithImpl<SupportFormat>(this as SupportFormat, _$identity);

  /// Serializes this SupportFormat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportFormat&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.format, format) || other.format == format)&&(identical(other.newDescription, newDescription) || other.newDescription == newDescription)&&(identical(other.displayDesc, displayDesc) || other.displayDesc == displayDesc)&&(identical(other.superscript, superscript) || other.superscript == superscript)&&const DeepCollectionEquality().equals(other.codecs, codecs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quality,format,newDescription,displayDesc,superscript,const DeepCollectionEquality().hash(codecs));

@override
String toString() {
  return 'SupportFormat(quality: $quality, format: $format, newDescription: $newDescription, displayDesc: $displayDesc, superscript: $superscript, codecs: $codecs)';
}


}

/// @nodoc
abstract mixin class $SupportFormatCopyWith<$Res>  {
  factory $SupportFormatCopyWith(SupportFormat value, $Res Function(SupportFormat) _then) = _$SupportFormatCopyWithImpl;
@useResult
$Res call({
 int quality, String format,@JsonKey(name: 'new_description') String newDescription,@JsonKey(name: 'display_desc') String displayDesc, String superscript, List<String> codecs
});




}
/// @nodoc
class _$SupportFormatCopyWithImpl<$Res>
    implements $SupportFormatCopyWith<$Res> {
  _$SupportFormatCopyWithImpl(this._self, this._then);

  final SupportFormat _self;
  final $Res Function(SupportFormat) _then;

/// Create a copy of SupportFormat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quality = null,Object? format = null,Object? newDescription = null,Object? displayDesc = null,Object? superscript = null,Object? codecs = null,}) {
  return _then(_self.copyWith(
quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,newDescription: null == newDescription ? _self.newDescription : newDescription // ignore: cast_nullable_to_non_nullable
as String,displayDesc: null == displayDesc ? _self.displayDesc : displayDesc // ignore: cast_nullable_to_non_nullable
as String,superscript: null == superscript ? _self.superscript : superscript // ignore: cast_nullable_to_non_nullable
as String,codecs: null == codecs ? _self.codecs : codecs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportFormat].
extension SupportFormatPatterns on SupportFormat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportFormat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportFormat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportFormat value)  $default,){
final _that = this;
switch (_that) {
case _SupportFormat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportFormat value)?  $default,){
final _that = this;
switch (_that) {
case _SupportFormat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quality,  String format, @JsonKey(name: 'new_description')  String newDescription, @JsonKey(name: 'display_desc')  String displayDesc,  String superscript,  List<String> codecs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportFormat() when $default != null:
return $default(_that.quality,_that.format,_that.newDescription,_that.displayDesc,_that.superscript,_that.codecs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quality,  String format, @JsonKey(name: 'new_description')  String newDescription, @JsonKey(name: 'display_desc')  String displayDesc,  String superscript,  List<String> codecs)  $default,) {final _that = this;
switch (_that) {
case _SupportFormat():
return $default(_that.quality,_that.format,_that.newDescription,_that.displayDesc,_that.superscript,_that.codecs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quality,  String format, @JsonKey(name: 'new_description')  String newDescription, @JsonKey(name: 'display_desc')  String displayDesc,  String superscript,  List<String> codecs)?  $default,) {final _that = this;
switch (_that) {
case _SupportFormat() when $default != null:
return $default(_that.quality,_that.format,_that.newDescription,_that.displayDesc,_that.superscript,_that.codecs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportFormat implements SupportFormat {
  const _SupportFormat({required this.quality, required this.format, @JsonKey(name: 'new_description') required this.newDescription, @JsonKey(name: 'display_desc') required this.displayDesc, required this.superscript, final  List<String> codecs = const []}): _codecs = codecs;
  factory _SupportFormat.fromJson(Map<String, dynamic> json) => _$SupportFormatFromJson(json);

@override final  int quality;
@override final  String format;
@override@JsonKey(name: 'new_description') final  String newDescription;
@override@JsonKey(name: 'display_desc') final  String displayDesc;
@override final  String superscript;
 final  List<String> _codecs;
@override@JsonKey() List<String> get codecs {
  if (_codecs is EqualUnmodifiableListView) return _codecs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_codecs);
}


/// Create a copy of SupportFormat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportFormatCopyWith<_SupportFormat> get copyWith => __$SupportFormatCopyWithImpl<_SupportFormat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportFormatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportFormat&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.format, format) || other.format == format)&&(identical(other.newDescription, newDescription) || other.newDescription == newDescription)&&(identical(other.displayDesc, displayDesc) || other.displayDesc == displayDesc)&&(identical(other.superscript, superscript) || other.superscript == superscript)&&const DeepCollectionEquality().equals(other._codecs, _codecs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quality,format,newDescription,displayDesc,superscript,const DeepCollectionEquality().hash(_codecs));

@override
String toString() {
  return 'SupportFormat(quality: $quality, format: $format, newDescription: $newDescription, displayDesc: $displayDesc, superscript: $superscript, codecs: $codecs)';
}


}

/// @nodoc
abstract mixin class _$SupportFormatCopyWith<$Res> implements $SupportFormatCopyWith<$Res> {
  factory _$SupportFormatCopyWith(_SupportFormat value, $Res Function(_SupportFormat) _then) = __$SupportFormatCopyWithImpl;
@override @useResult
$Res call({
 int quality, String format,@JsonKey(name: 'new_description') String newDescription,@JsonKey(name: 'display_desc') String displayDesc, String superscript, List<String> codecs
});




}
/// @nodoc
class __$SupportFormatCopyWithImpl<$Res>
    implements _$SupportFormatCopyWith<$Res> {
  __$SupportFormatCopyWithImpl(this._self, this._then);

  final _SupportFormat _self;
  final $Res Function(_SupportFormat) _then;

/// Create a copy of SupportFormat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quality = null,Object? format = null,Object? newDescription = null,Object? displayDesc = null,Object? superscript = null,Object? codecs = null,}) {
  return _then(_SupportFormat(
quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,newDescription: null == newDescription ? _self.newDescription : newDescription // ignore: cast_nullable_to_non_nullable
as String,displayDesc: null == displayDesc ? _self.displayDesc : displayDesc // ignore: cast_nullable_to_non_nullable
as String,superscript: null == superscript ? _self.superscript : superscript // ignore: cast_nullable_to_non_nullable
as String,codecs: null == codecs ? _self._codecs : codecs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
