// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoSubtitle {

 List<SubtitleInfo> get list;
/// Create a copy of VideoSubtitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoSubtitleCopyWith<VideoSubtitle> get copyWith => _$VideoSubtitleCopyWithImpl<VideoSubtitle>(this as VideoSubtitle, _$identity);

  /// Serializes this VideoSubtitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoSubtitle&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'VideoSubtitle(list: $list)';
}


}

/// @nodoc
abstract mixin class $VideoSubtitleCopyWith<$Res>  {
  factory $VideoSubtitleCopyWith(VideoSubtitle value, $Res Function(VideoSubtitle) _then) = _$VideoSubtitleCopyWithImpl;
@useResult
$Res call({
 List<SubtitleInfo> list
});




}
/// @nodoc
class _$VideoSubtitleCopyWithImpl<$Res>
    implements $VideoSubtitleCopyWith<$Res> {
  _$VideoSubtitleCopyWithImpl(this._self, this._then);

  final VideoSubtitle _self;
  final $Res Function(VideoSubtitle) _then;

/// Create a copy of VideoSubtitle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<SubtitleInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoSubtitle].
extension VideoSubtitlePatterns on VideoSubtitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoSubtitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoSubtitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoSubtitle value)  $default,){
final _that = this;
switch (_that) {
case _VideoSubtitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoSubtitle value)?  $default,){
final _that = this;
switch (_that) {
case _VideoSubtitle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SubtitleInfo> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoSubtitle() when $default != null:
return $default(_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SubtitleInfo> list)  $default,) {final _that = this;
switch (_that) {
case _VideoSubtitle():
return $default(_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SubtitleInfo> list)?  $default,) {final _that = this;
switch (_that) {
case _VideoSubtitle() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoSubtitle implements VideoSubtitle {
  const _VideoSubtitle({final  List<SubtitleInfo> list = const []}): _list = list;
  factory _VideoSubtitle.fromJson(Map<String, dynamic> json) => _$VideoSubtitleFromJson(json);

 final  List<SubtitleInfo> _list;
@override@JsonKey() List<SubtitleInfo> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of VideoSubtitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoSubtitleCopyWith<_VideoSubtitle> get copyWith => __$VideoSubtitleCopyWithImpl<_VideoSubtitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoSubtitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoSubtitle&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'VideoSubtitle(list: $list)';
}


}

/// @nodoc
abstract mixin class _$VideoSubtitleCopyWith<$Res> implements $VideoSubtitleCopyWith<$Res> {
  factory _$VideoSubtitleCopyWith(_VideoSubtitle value, $Res Function(_VideoSubtitle) _then) = __$VideoSubtitleCopyWithImpl;
@override @useResult
$Res call({
 List<SubtitleInfo> list
});




}
/// @nodoc
class __$VideoSubtitleCopyWithImpl<$Res>
    implements _$VideoSubtitleCopyWith<$Res> {
  __$VideoSubtitleCopyWithImpl(this._self, this._then);

  final _VideoSubtitle _self;
  final $Res Function(_VideoSubtitle) _then;

/// Create a copy of VideoSubtitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_VideoSubtitle(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<SubtitleInfo>,
  ));
}


}


/// @nodoc
mixin _$SubtitleInfo {

 int get id; String get lan;@JsonKey(name: 'lan_doc') String get lanDoc;@JsonKey(name: 'subtitle_url') String get subtitleUrl;@JsonKey(name: 'is_lock') bool get isLock;@JsonKey(name: 'id_str') String? get idStr; int get type;
/// Create a copy of SubtitleInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleInfoCopyWith<SubtitleInfo> get copyWith => _$SubtitleInfoCopyWithImpl<SubtitleInfo>(this as SubtitleInfo, _$identity);

  /// Serializes this SubtitleInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.lan, lan) || other.lan == lan)&&(identical(other.lanDoc, lanDoc) || other.lanDoc == lanDoc)&&(identical(other.subtitleUrl, subtitleUrl) || other.subtitleUrl == subtitleUrl)&&(identical(other.isLock, isLock) || other.isLock == isLock)&&(identical(other.idStr, idStr) || other.idStr == idStr)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lan,lanDoc,subtitleUrl,isLock,idStr,type);

@override
String toString() {
  return 'SubtitleInfo(id: $id, lan: $lan, lanDoc: $lanDoc, subtitleUrl: $subtitleUrl, isLock: $isLock, idStr: $idStr, type: $type)';
}


}

/// @nodoc
abstract mixin class $SubtitleInfoCopyWith<$Res>  {
  factory $SubtitleInfoCopyWith(SubtitleInfo value, $Res Function(SubtitleInfo) _then) = _$SubtitleInfoCopyWithImpl;
@useResult
$Res call({
 int id, String lan,@JsonKey(name: 'lan_doc') String lanDoc,@JsonKey(name: 'subtitle_url') String subtitleUrl,@JsonKey(name: 'is_lock') bool isLock,@JsonKey(name: 'id_str') String? idStr, int type
});




}
/// @nodoc
class _$SubtitleInfoCopyWithImpl<$Res>
    implements $SubtitleInfoCopyWith<$Res> {
  _$SubtitleInfoCopyWithImpl(this._self, this._then);

  final SubtitleInfo _self;
  final $Res Function(SubtitleInfo) _then;

/// Create a copy of SubtitleInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lan = null,Object? lanDoc = null,Object? subtitleUrl = null,Object? isLock = null,Object? idStr = freezed,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lan: null == lan ? _self.lan : lan // ignore: cast_nullable_to_non_nullable
as String,lanDoc: null == lanDoc ? _self.lanDoc : lanDoc // ignore: cast_nullable_to_non_nullable
as String,subtitleUrl: null == subtitleUrl ? _self.subtitleUrl : subtitleUrl // ignore: cast_nullable_to_non_nullable
as String,isLock: null == isLock ? _self.isLock : isLock // ignore: cast_nullable_to_non_nullable
as bool,idStr: freezed == idStr ? _self.idStr : idStr // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleInfo].
extension SubtitleInfoPatterns on SubtitleInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleInfo value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String lan, @JsonKey(name: 'lan_doc')  String lanDoc, @JsonKey(name: 'subtitle_url')  String subtitleUrl, @JsonKey(name: 'is_lock')  bool isLock, @JsonKey(name: 'id_str')  String? idStr,  int type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleInfo() when $default != null:
return $default(_that.id,_that.lan,_that.lanDoc,_that.subtitleUrl,_that.isLock,_that.idStr,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String lan, @JsonKey(name: 'lan_doc')  String lanDoc, @JsonKey(name: 'subtitle_url')  String subtitleUrl, @JsonKey(name: 'is_lock')  bool isLock, @JsonKey(name: 'id_str')  String? idStr,  int type)  $default,) {final _that = this;
switch (_that) {
case _SubtitleInfo():
return $default(_that.id,_that.lan,_that.lanDoc,_that.subtitleUrl,_that.isLock,_that.idStr,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String lan, @JsonKey(name: 'lan_doc')  String lanDoc, @JsonKey(name: 'subtitle_url')  String subtitleUrl, @JsonKey(name: 'is_lock')  bool isLock, @JsonKey(name: 'id_str')  String? idStr,  int type)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleInfo() when $default != null:
return $default(_that.id,_that.lan,_that.lanDoc,_that.subtitleUrl,_that.isLock,_that.idStr,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleInfo implements SubtitleInfo {
  const _SubtitleInfo({required this.id, required this.lan, @JsonKey(name: 'lan_doc') required this.lanDoc, @JsonKey(name: 'subtitle_url') required this.subtitleUrl, @JsonKey(name: 'is_lock') this.isLock = false, @JsonKey(name: 'id_str') this.idStr, this.type = 0});
  factory _SubtitleInfo.fromJson(Map<String, dynamic> json) => _$SubtitleInfoFromJson(json);

@override final  int id;
@override final  String lan;
@override@JsonKey(name: 'lan_doc') final  String lanDoc;
@override@JsonKey(name: 'subtitle_url') final  String subtitleUrl;
@override@JsonKey(name: 'is_lock') final  bool isLock;
@override@JsonKey(name: 'id_str') final  String? idStr;
@override@JsonKey() final  int type;

/// Create a copy of SubtitleInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleInfoCopyWith<_SubtitleInfo> get copyWith => __$SubtitleInfoCopyWithImpl<_SubtitleInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.lan, lan) || other.lan == lan)&&(identical(other.lanDoc, lanDoc) || other.lanDoc == lanDoc)&&(identical(other.subtitleUrl, subtitleUrl) || other.subtitleUrl == subtitleUrl)&&(identical(other.isLock, isLock) || other.isLock == isLock)&&(identical(other.idStr, idStr) || other.idStr == idStr)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lan,lanDoc,subtitleUrl,isLock,idStr,type);

@override
String toString() {
  return 'SubtitleInfo(id: $id, lan: $lan, lanDoc: $lanDoc, subtitleUrl: $subtitleUrl, isLock: $isLock, idStr: $idStr, type: $type)';
}


}

/// @nodoc
abstract mixin class _$SubtitleInfoCopyWith<$Res> implements $SubtitleInfoCopyWith<$Res> {
  factory _$SubtitleInfoCopyWith(_SubtitleInfo value, $Res Function(_SubtitleInfo) _then) = __$SubtitleInfoCopyWithImpl;
@override @useResult
$Res call({
 int id, String lan,@JsonKey(name: 'lan_doc') String lanDoc,@JsonKey(name: 'subtitle_url') String subtitleUrl,@JsonKey(name: 'is_lock') bool isLock,@JsonKey(name: 'id_str') String? idStr, int type
});




}
/// @nodoc
class __$SubtitleInfoCopyWithImpl<$Res>
    implements _$SubtitleInfoCopyWith<$Res> {
  __$SubtitleInfoCopyWithImpl(this._self, this._then);

  final _SubtitleInfo _self;
  final $Res Function(_SubtitleInfo) _then;

/// Create a copy of SubtitleInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lan = null,Object? lanDoc = null,Object? subtitleUrl = null,Object? isLock = null,Object? idStr = freezed,Object? type = null,}) {
  return _then(_SubtitleInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lan: null == lan ? _self.lan : lan // ignore: cast_nullable_to_non_nullable
as String,lanDoc: null == lanDoc ? _self.lanDoc : lanDoc // ignore: cast_nullable_to_non_nullable
as String,subtitleUrl: null == subtitleUrl ? _self.subtitleUrl : subtitleUrl // ignore: cast_nullable_to_non_nullable
as String,isLock: null == isLock ? _self.isLock : isLock // ignore: cast_nullable_to_non_nullable
as bool,idStr: freezed == idStr ? _self.idStr : idStr // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SubtitleContent {

@JsonKey(name: 'font_size') double? get fontSize;@JsonKey(name: 'font_color') String? get fontColor;@JsonKey(name: 'background_alpha') double? get backgroundAlpha;@JsonKey(name: 'background_color') String? get backgroundColor; List<SubtitleItem> get body;
/// Create a copy of SubtitleContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleContentCopyWith<SubtitleContent> get copyWith => _$SubtitleContentCopyWithImpl<SubtitleContent>(this as SubtitleContent, _$identity);

  /// Serializes this SubtitleContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleContent&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontColor, fontColor) || other.fontColor == fontColor)&&(identical(other.backgroundAlpha, backgroundAlpha) || other.backgroundAlpha == backgroundAlpha)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other.body, body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fontSize,fontColor,backgroundAlpha,backgroundColor,const DeepCollectionEquality().hash(body));

@override
String toString() {
  return 'SubtitleContent(fontSize: $fontSize, fontColor: $fontColor, backgroundAlpha: $backgroundAlpha, backgroundColor: $backgroundColor, body: $body)';
}


}

/// @nodoc
abstract mixin class $SubtitleContentCopyWith<$Res>  {
  factory $SubtitleContentCopyWith(SubtitleContent value, $Res Function(SubtitleContent) _then) = _$SubtitleContentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'font_size') double? fontSize,@JsonKey(name: 'font_color') String? fontColor,@JsonKey(name: 'background_alpha') double? backgroundAlpha,@JsonKey(name: 'background_color') String? backgroundColor, List<SubtitleItem> body
});




}
/// @nodoc
class _$SubtitleContentCopyWithImpl<$Res>
    implements $SubtitleContentCopyWith<$Res> {
  _$SubtitleContentCopyWithImpl(this._self, this._then);

  final SubtitleContent _self;
  final $Res Function(SubtitleContent) _then;

/// Create a copy of SubtitleContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fontSize = freezed,Object? fontColor = freezed,Object? backgroundAlpha = freezed,Object? backgroundColor = freezed,Object? body = null,}) {
  return _then(_self.copyWith(
fontSize: freezed == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double?,fontColor: freezed == fontColor ? _self.fontColor : fontColor // ignore: cast_nullable_to_non_nullable
as String?,backgroundAlpha: freezed == backgroundAlpha ? _self.backgroundAlpha : backgroundAlpha // ignore: cast_nullable_to_non_nullable
as double?,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as List<SubtitleItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleContent].
extension SubtitleContentPatterns on SubtitleContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleContent value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleContent value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'font_size')  double? fontSize, @JsonKey(name: 'font_color')  String? fontColor, @JsonKey(name: 'background_alpha')  double? backgroundAlpha, @JsonKey(name: 'background_color')  String? backgroundColor,  List<SubtitleItem> body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleContent() when $default != null:
return $default(_that.fontSize,_that.fontColor,_that.backgroundAlpha,_that.backgroundColor,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'font_size')  double? fontSize, @JsonKey(name: 'font_color')  String? fontColor, @JsonKey(name: 'background_alpha')  double? backgroundAlpha, @JsonKey(name: 'background_color')  String? backgroundColor,  List<SubtitleItem> body)  $default,) {final _that = this;
switch (_that) {
case _SubtitleContent():
return $default(_that.fontSize,_that.fontColor,_that.backgroundAlpha,_that.backgroundColor,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'font_size')  double? fontSize, @JsonKey(name: 'font_color')  String? fontColor, @JsonKey(name: 'background_alpha')  double? backgroundAlpha, @JsonKey(name: 'background_color')  String? backgroundColor,  List<SubtitleItem> body)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleContent() when $default != null:
return $default(_that.fontSize,_that.fontColor,_that.backgroundAlpha,_that.backgroundColor,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleContent implements SubtitleContent {
  const _SubtitleContent({@JsonKey(name: 'font_size') this.fontSize, @JsonKey(name: 'font_color') this.fontColor, @JsonKey(name: 'background_alpha') this.backgroundAlpha, @JsonKey(name: 'background_color') this.backgroundColor, final  List<SubtitleItem> body = const []}): _body = body;
  factory _SubtitleContent.fromJson(Map<String, dynamic> json) => _$SubtitleContentFromJson(json);

@override@JsonKey(name: 'font_size') final  double? fontSize;
@override@JsonKey(name: 'font_color') final  String? fontColor;
@override@JsonKey(name: 'background_alpha') final  double? backgroundAlpha;
@override@JsonKey(name: 'background_color') final  String? backgroundColor;
 final  List<SubtitleItem> _body;
@override@JsonKey() List<SubtitleItem> get body {
  if (_body is EqualUnmodifiableListView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_body);
}


/// Create a copy of SubtitleContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleContentCopyWith<_SubtitleContent> get copyWith => __$SubtitleContentCopyWithImpl<_SubtitleContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleContent&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontColor, fontColor) || other.fontColor == fontColor)&&(identical(other.backgroundAlpha, backgroundAlpha) || other.backgroundAlpha == backgroundAlpha)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other._body, _body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fontSize,fontColor,backgroundAlpha,backgroundColor,const DeepCollectionEquality().hash(_body));

@override
String toString() {
  return 'SubtitleContent(fontSize: $fontSize, fontColor: $fontColor, backgroundAlpha: $backgroundAlpha, backgroundColor: $backgroundColor, body: $body)';
}


}

/// @nodoc
abstract mixin class _$SubtitleContentCopyWith<$Res> implements $SubtitleContentCopyWith<$Res> {
  factory _$SubtitleContentCopyWith(_SubtitleContent value, $Res Function(_SubtitleContent) _then) = __$SubtitleContentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'font_size') double? fontSize,@JsonKey(name: 'font_color') String? fontColor,@JsonKey(name: 'background_alpha') double? backgroundAlpha,@JsonKey(name: 'background_color') String? backgroundColor, List<SubtitleItem> body
});




}
/// @nodoc
class __$SubtitleContentCopyWithImpl<$Res>
    implements _$SubtitleContentCopyWith<$Res> {
  __$SubtitleContentCopyWithImpl(this._self, this._then);

  final _SubtitleContent _self;
  final $Res Function(_SubtitleContent) _then;

/// Create a copy of SubtitleContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fontSize = freezed,Object? fontColor = freezed,Object? backgroundAlpha = freezed,Object? backgroundColor = freezed,Object? body = null,}) {
  return _then(_SubtitleContent(
fontSize: freezed == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double?,fontColor: freezed == fontColor ? _self.fontColor : fontColor // ignore: cast_nullable_to_non_nullable
as String?,backgroundAlpha: freezed == backgroundAlpha ? _self.backgroundAlpha : backgroundAlpha // ignore: cast_nullable_to_non_nullable
as double?,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as List<SubtitleItem>,
  ));
}


}


/// @nodoc
mixin _$SubtitleItem {

 double get from; double get to; int get location; String get content;
/// Create a copy of SubtitleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleItemCopyWith<SubtitleItem> get copyWith => _$SubtitleItemCopyWithImpl<SubtitleItem>(this as SubtitleItem, _$identity);

  /// Serializes this SubtitleItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleItem&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.location, location) || other.location == location)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,location,content);

@override
String toString() {
  return 'SubtitleItem(from: $from, to: $to, location: $location, content: $content)';
}


}

/// @nodoc
abstract mixin class $SubtitleItemCopyWith<$Res>  {
  factory $SubtitleItemCopyWith(SubtitleItem value, $Res Function(SubtitleItem) _then) = _$SubtitleItemCopyWithImpl;
@useResult
$Res call({
 double from, double to, int location, String content
});




}
/// @nodoc
class _$SubtitleItemCopyWithImpl<$Res>
    implements $SubtitleItemCopyWith<$Res> {
  _$SubtitleItemCopyWithImpl(this._self, this._then);

  final SubtitleItem _self;
  final $Res Function(SubtitleItem) _then;

/// Create a copy of SubtitleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? location = null,Object? content = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as double,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleItem].
extension SubtitleItemPatterns on SubtitleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleItem value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleItem value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double from,  double to,  int location,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleItem() when $default != null:
return $default(_that.from,_that.to,_that.location,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double from,  double to,  int location,  String content)  $default,) {final _that = this;
switch (_that) {
case _SubtitleItem():
return $default(_that.from,_that.to,_that.location,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double from,  double to,  int location,  String content)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleItem() when $default != null:
return $default(_that.from,_that.to,_that.location,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleItem implements SubtitleItem {
  const _SubtitleItem({required this.from, required this.to, required this.location, required this.content});
  factory _SubtitleItem.fromJson(Map<String, dynamic> json) => _$SubtitleItemFromJson(json);

@override final  double from;
@override final  double to;
@override final  int location;
@override final  String content;

/// Create a copy of SubtitleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleItemCopyWith<_SubtitleItem> get copyWith => __$SubtitleItemCopyWithImpl<_SubtitleItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleItem&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.location, location) || other.location == location)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,location,content);

@override
String toString() {
  return 'SubtitleItem(from: $from, to: $to, location: $location, content: $content)';
}


}

/// @nodoc
abstract mixin class _$SubtitleItemCopyWith<$Res> implements $SubtitleItemCopyWith<$Res> {
  factory _$SubtitleItemCopyWith(_SubtitleItem value, $Res Function(_SubtitleItem) _then) = __$SubtitleItemCopyWithImpl;
@override @useResult
$Res call({
 double from, double to, int location, String content
});




}
/// @nodoc
class __$SubtitleItemCopyWithImpl<$Res>
    implements _$SubtitleItemCopyWith<$Res> {
  __$SubtitleItemCopyWithImpl(this._self, this._then);

  final _SubtitleItem _self;
  final $Res Function(_SubtitleItem) _then;

/// Create a copy of SubtitleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? location = null,Object? content = null,}) {
  return _then(_SubtitleItem(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as double,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
