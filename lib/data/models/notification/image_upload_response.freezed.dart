// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageUploadResponse {

@JsonKey(name: 'image_url') String get imageUrl;@JsonKey(name: 'image_width') int get imageWidth;@JsonKey(name: 'image_height') int get imageHeight;
/// Create a copy of ImageUploadResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageUploadResponseCopyWith<ImageUploadResponse> get copyWith => _$ImageUploadResponseCopyWithImpl<ImageUploadResponse>(this as ImageUploadResponse, _$identity);

  /// Serializes this ImageUploadResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageUploadResponse&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageWidth, imageWidth) || other.imageWidth == imageWidth)&&(identical(other.imageHeight, imageHeight) || other.imageHeight == imageHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,imageWidth,imageHeight);

@override
String toString() {
  return 'ImageUploadResponse(imageUrl: $imageUrl, imageWidth: $imageWidth, imageHeight: $imageHeight)';
}


}

/// @nodoc
abstract mixin class $ImageUploadResponseCopyWith<$Res>  {
  factory $ImageUploadResponseCopyWith(ImageUploadResponse value, $Res Function(ImageUploadResponse) _then) = _$ImageUploadResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'image_width') int imageWidth,@JsonKey(name: 'image_height') int imageHeight
});




}
/// @nodoc
class _$ImageUploadResponseCopyWithImpl<$Res>
    implements $ImageUploadResponseCopyWith<$Res> {
  _$ImageUploadResponseCopyWithImpl(this._self, this._then);

  final ImageUploadResponse _self;
  final $Res Function(ImageUploadResponse) _then;

/// Create a copy of ImageUploadResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? imageWidth = null,Object? imageHeight = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageWidth: null == imageWidth ? _self.imageWidth : imageWidth // ignore: cast_nullable_to_non_nullable
as int,imageHeight: null == imageHeight ? _self.imageHeight : imageHeight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageUploadResponse].
extension ImageUploadResponsePatterns on ImageUploadResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageUploadResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageUploadResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageUploadResponse value)  $default,){
final _that = this;
switch (_that) {
case _ImageUploadResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageUploadResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ImageUploadResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'image_width')  int imageWidth, @JsonKey(name: 'image_height')  int imageHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageUploadResponse() when $default != null:
return $default(_that.imageUrl,_that.imageWidth,_that.imageHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'image_width')  int imageWidth, @JsonKey(name: 'image_height')  int imageHeight)  $default,) {final _that = this;
switch (_that) {
case _ImageUploadResponse():
return $default(_that.imageUrl,_that.imageWidth,_that.imageHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'image_width')  int imageWidth, @JsonKey(name: 'image_height')  int imageHeight)?  $default,) {final _that = this;
switch (_that) {
case _ImageUploadResponse() when $default != null:
return $default(_that.imageUrl,_that.imageWidth,_that.imageHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageUploadResponse implements ImageUploadResponse {
  const _ImageUploadResponse({@JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'image_width') required this.imageWidth, @JsonKey(name: 'image_height') required this.imageHeight});
  factory _ImageUploadResponse.fromJson(Map<String, dynamic> json) => _$ImageUploadResponseFromJson(json);

@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@JsonKey(name: 'image_width') final  int imageWidth;
@override@JsonKey(name: 'image_height') final  int imageHeight;

/// Create a copy of ImageUploadResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageUploadResponseCopyWith<_ImageUploadResponse> get copyWith => __$ImageUploadResponseCopyWithImpl<_ImageUploadResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageUploadResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageUploadResponse&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageWidth, imageWidth) || other.imageWidth == imageWidth)&&(identical(other.imageHeight, imageHeight) || other.imageHeight == imageHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,imageWidth,imageHeight);

@override
String toString() {
  return 'ImageUploadResponse(imageUrl: $imageUrl, imageWidth: $imageWidth, imageHeight: $imageHeight)';
}


}

/// @nodoc
abstract mixin class _$ImageUploadResponseCopyWith<$Res> implements $ImageUploadResponseCopyWith<$Res> {
  factory _$ImageUploadResponseCopyWith(_ImageUploadResponse value, $Res Function(_ImageUploadResponse) _then) = __$ImageUploadResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'image_width') int imageWidth,@JsonKey(name: 'image_height') int imageHeight
});




}
/// @nodoc
class __$ImageUploadResponseCopyWithImpl<$Res>
    implements _$ImageUploadResponseCopyWith<$Res> {
  __$ImageUploadResponseCopyWithImpl(this._self, this._then);

  final _ImageUploadResponse _self;
  final $Res Function(_ImageUploadResponse) _then;

/// Create a copy of ImageUploadResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? imageWidth = null,Object? imageHeight = null,}) {
  return _then(_ImageUploadResponse(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageWidth: null == imageWidth ? _self.imageWidth : imageWidth // ignore: cast_nullable_to_non_nullable
as int,imageHeight: null == imageHeight ? _self.imageHeight : imageHeight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
