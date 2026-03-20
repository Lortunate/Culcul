// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emote_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmoteResponse {

 List<EmotePackage> get packages;
/// Create a copy of EmoteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmoteResponseCopyWith<EmoteResponse> get copyWith => _$EmoteResponseCopyWithImpl<EmoteResponse>(this as EmoteResponse, _$identity);

  /// Serializes this EmoteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmoteResponse&&const DeepCollectionEquality().equals(other.packages, packages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(packages));

@override
String toString() {
  return 'EmoteResponse(packages: $packages)';
}


}

/// @nodoc
abstract mixin class $EmoteResponseCopyWith<$Res>  {
  factory $EmoteResponseCopyWith(EmoteResponse value, $Res Function(EmoteResponse) _then) = _$EmoteResponseCopyWithImpl;
@useResult
$Res call({
 List<EmotePackage> packages
});




}
/// @nodoc
class _$EmoteResponseCopyWithImpl<$Res>
    implements $EmoteResponseCopyWith<$Res> {
  _$EmoteResponseCopyWithImpl(this._self, this._then);

  final EmoteResponse _self;
  final $Res Function(EmoteResponse) _then;

/// Create a copy of EmoteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packages = null,}) {
  return _then(_self.copyWith(
packages: null == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as List<EmotePackage>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmoteResponse].
extension EmoteResponsePatterns on EmoteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmoteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmoteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmoteResponse value)  $default,){
final _that = this;
switch (_that) {
case _EmoteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmoteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EmoteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EmotePackage> packages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmoteResponse() when $default != null:
return $default(_that.packages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EmotePackage> packages)  $default,) {final _that = this;
switch (_that) {
case _EmoteResponse():
return $default(_that.packages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EmotePackage> packages)?  $default,) {final _that = this;
switch (_that) {
case _EmoteResponse() when $default != null:
return $default(_that.packages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmoteResponse implements EmoteResponse {
  const _EmoteResponse({required final  List<EmotePackage> packages}): _packages = packages;
  factory _EmoteResponse.fromJson(Map<String, dynamic> json) => _$EmoteResponseFromJson(json);

 final  List<EmotePackage> _packages;
@override List<EmotePackage> get packages {
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packages);
}


/// Create a copy of EmoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmoteResponseCopyWith<_EmoteResponse> get copyWith => __$EmoteResponseCopyWithImpl<_EmoteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmoteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmoteResponse&&const DeepCollectionEquality().equals(other._packages, _packages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_packages));

@override
String toString() {
  return 'EmoteResponse(packages: $packages)';
}


}

/// @nodoc
abstract mixin class _$EmoteResponseCopyWith<$Res> implements $EmoteResponseCopyWith<$Res> {
  factory _$EmoteResponseCopyWith(_EmoteResponse value, $Res Function(_EmoteResponse) _then) = __$EmoteResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EmotePackage> packages
});




}
/// @nodoc
class __$EmoteResponseCopyWithImpl<$Res>
    implements _$EmoteResponseCopyWith<$Res> {
  __$EmoteResponseCopyWithImpl(this._self, this._then);

  final _EmoteResponse _self;
  final $Res Function(_EmoteResponse) _then;

/// Create a copy of EmoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packages = null,}) {
  return _then(_EmoteResponse(
packages: null == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<EmotePackage>,
  ));
}


}


/// @nodoc
mixin _$EmotePackage {

 int get id; String get text; String get url; List<Emote> get emote;
/// Create a copy of EmotePackage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmotePackageCopyWith<EmotePackage> get copyWith => _$EmotePackageCopyWithImpl<EmotePackage>(this as EmotePackage, _$identity);

  /// Serializes this EmotePackage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmotePackage&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.emote, emote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,url,const DeepCollectionEquality().hash(emote));

@override
String toString() {
  return 'EmotePackage(id: $id, text: $text, url: $url, emote: $emote)';
}


}

/// @nodoc
abstract mixin class $EmotePackageCopyWith<$Res>  {
  factory $EmotePackageCopyWith(EmotePackage value, $Res Function(EmotePackage) _then) = _$EmotePackageCopyWithImpl;
@useResult
$Res call({
 int id, String text, String url, List<Emote> emote
});




}
/// @nodoc
class _$EmotePackageCopyWithImpl<$Res>
    implements $EmotePackageCopyWith<$Res> {
  _$EmotePackageCopyWithImpl(this._self, this._then);

  final EmotePackage _self;
  final $Res Function(EmotePackage) _then;

/// Create a copy of EmotePackage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? url = null,Object? emote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,emote: null == emote ? _self.emote : emote // ignore: cast_nullable_to_non_nullable
as List<Emote>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmotePackage].
extension EmotePackagePatterns on EmotePackage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmotePackage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmotePackage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmotePackage value)  $default,){
final _that = this;
switch (_that) {
case _EmotePackage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmotePackage value)?  $default,){
final _that = this;
switch (_that) {
case _EmotePackage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  String url,  List<Emote> emote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmotePackage() when $default != null:
return $default(_that.id,_that.text,_that.url,_that.emote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  String url,  List<Emote> emote)  $default,) {final _that = this;
switch (_that) {
case _EmotePackage():
return $default(_that.id,_that.text,_that.url,_that.emote);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  String url,  List<Emote> emote)?  $default,) {final _that = this;
switch (_that) {
case _EmotePackage() when $default != null:
return $default(_that.id,_that.text,_that.url,_that.emote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmotePackage implements EmotePackage {
  const _EmotePackage({required this.id, required this.text, required this.url, required final  List<Emote> emote}): _emote = emote;
  factory _EmotePackage.fromJson(Map<String, dynamic> json) => _$EmotePackageFromJson(json);

@override final  int id;
@override final  String text;
@override final  String url;
 final  List<Emote> _emote;
@override List<Emote> get emote {
  if (_emote is EqualUnmodifiableListView) return _emote;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emote);
}


/// Create a copy of EmotePackage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmotePackageCopyWith<_EmotePackage> get copyWith => __$EmotePackageCopyWithImpl<_EmotePackage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmotePackageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmotePackage&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._emote, _emote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,url,const DeepCollectionEquality().hash(_emote));

@override
String toString() {
  return 'EmotePackage(id: $id, text: $text, url: $url, emote: $emote)';
}


}

/// @nodoc
abstract mixin class _$EmotePackageCopyWith<$Res> implements $EmotePackageCopyWith<$Res> {
  factory _$EmotePackageCopyWith(_EmotePackage value, $Res Function(_EmotePackage) _then) = __$EmotePackageCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, String url, List<Emote> emote
});




}
/// @nodoc
class __$EmotePackageCopyWithImpl<$Res>
    implements _$EmotePackageCopyWith<$Res> {
  __$EmotePackageCopyWithImpl(this._self, this._then);

  final _EmotePackage _self;
  final $Res Function(_EmotePackage) _then;

/// Create a copy of EmotePackage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? url = null,Object? emote = null,}) {
  return _then(_EmotePackage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,emote: null == emote ? _self._emote : emote // ignore: cast_nullable_to_non_nullable
as List<Emote>,
  ));
}


}


/// @nodoc
mixin _$Emote {

 int get id; String get text; String get url;
/// Create a copy of Emote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmoteCopyWith<Emote> get copyWith => _$EmoteCopyWithImpl<Emote>(this as Emote, _$identity);

  /// Serializes this Emote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Emote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,url);

@override
String toString() {
  return 'Emote(id: $id, text: $text, url: $url)';
}


}

/// @nodoc
abstract mixin class $EmoteCopyWith<$Res>  {
  factory $EmoteCopyWith(Emote value, $Res Function(Emote) _then) = _$EmoteCopyWithImpl;
@useResult
$Res call({
 int id, String text, String url
});




}
/// @nodoc
class _$EmoteCopyWithImpl<$Res>
    implements $EmoteCopyWith<$Res> {
  _$EmoteCopyWithImpl(this._self, this._then);

  final Emote _self;
  final $Res Function(Emote) _then;

/// Create a copy of Emote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? url = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Emote].
extension EmotePatterns on Emote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Emote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Emote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Emote value)  $default,){
final _that = this;
switch (_that) {
case _Emote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Emote value)?  $default,){
final _that = this;
switch (_that) {
case _Emote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Emote() when $default != null:
return $default(_that.id,_that.text,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  String url)  $default,) {final _that = this;
switch (_that) {
case _Emote():
return $default(_that.id,_that.text,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  String url)?  $default,) {final _that = this;
switch (_that) {
case _Emote() when $default != null:
return $default(_that.id,_that.text,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Emote implements Emote {
  const _Emote({required this.id, required this.text, required this.url});
  factory _Emote.fromJson(Map<String, dynamic> json) => _$EmoteFromJson(json);

@override final  int id;
@override final  String text;
@override final  String url;

/// Create a copy of Emote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmoteCopyWith<_Emote> get copyWith => __$EmoteCopyWithImpl<_Emote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Emote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,url);

@override
String toString() {
  return 'Emote(id: $id, text: $text, url: $url)';
}


}

/// @nodoc
abstract mixin class _$EmoteCopyWith<$Res> implements $EmoteCopyWith<$Res> {
  factory _$EmoteCopyWith(_Emote value, $Res Function(_Emote) _then) = __$EmoteCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, String url
});




}
/// @nodoc
class __$EmoteCopyWithImpl<$Res>
    implements _$EmoteCopyWith<$Res> {
  __$EmoteCopyWithImpl(this._self, this._then);

  final _Emote _self;
  final $Res Function(_Emote) _then;

/// Create a copy of Emote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? url = null,}) {
  return _then(_Emote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
