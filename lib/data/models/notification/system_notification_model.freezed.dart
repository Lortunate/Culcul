// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SystemNotificationItem {

 int get id; String? get title; String? get text; int get time; String? get uri;@JsonKey(name: 'jump_text') String? get jumpText;
/// Create a copy of SystemNotificationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemNotificationItemCopyWith<SystemNotificationItem> get copyWith => _$SystemNotificationItemCopyWithImpl<SystemNotificationItem>(this as SystemNotificationItem, _$identity);

  /// Serializes this SystemNotificationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemNotificationItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.time, time) || other.time == time)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.jumpText, jumpText) || other.jumpText == jumpText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,text,time,uri,jumpText);

@override
String toString() {
  return 'SystemNotificationItem(id: $id, title: $title, text: $text, time: $time, uri: $uri, jumpText: $jumpText)';
}


}

/// @nodoc
abstract mixin class $SystemNotificationItemCopyWith<$Res>  {
  factory $SystemNotificationItemCopyWith(SystemNotificationItem value, $Res Function(SystemNotificationItem) _then) = _$SystemNotificationItemCopyWithImpl;
@useResult
$Res call({
 int id, String? title, String? text, int time, String? uri,@JsonKey(name: 'jump_text') String? jumpText
});




}
/// @nodoc
class _$SystemNotificationItemCopyWithImpl<$Res>
    implements $SystemNotificationItemCopyWith<$Res> {
  _$SystemNotificationItemCopyWithImpl(this._self, this._then);

  final SystemNotificationItem _self;
  final $Res Function(SystemNotificationItem) _then;

/// Create a copy of SystemNotificationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? text = freezed,Object? time = null,Object? uri = freezed,Object? jumpText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,jumpText: freezed == jumpText ? _self.jumpText : jumpText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SystemNotificationItem].
extension SystemNotificationItemPatterns on SystemNotificationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SystemNotificationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SystemNotificationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SystemNotificationItem value)  $default,){
final _that = this;
switch (_that) {
case _SystemNotificationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SystemNotificationItem value)?  $default,){
final _that = this;
switch (_that) {
case _SystemNotificationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? title,  String? text,  int time,  String? uri, @JsonKey(name: 'jump_text')  String? jumpText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SystemNotificationItem() when $default != null:
return $default(_that.id,_that.title,_that.text,_that.time,_that.uri,_that.jumpText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? title,  String? text,  int time,  String? uri, @JsonKey(name: 'jump_text')  String? jumpText)  $default,) {final _that = this;
switch (_that) {
case _SystemNotificationItem():
return $default(_that.id,_that.title,_that.text,_that.time,_that.uri,_that.jumpText);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? title,  String? text,  int time,  String? uri, @JsonKey(name: 'jump_text')  String? jumpText)?  $default,) {final _that = this;
switch (_that) {
case _SystemNotificationItem() when $default != null:
return $default(_that.id,_that.title,_that.text,_that.time,_that.uri,_that.jumpText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SystemNotificationItem implements SystemNotificationItem {
  const _SystemNotificationItem({required this.id, this.title, this.text, required this.time, this.uri, @JsonKey(name: 'jump_text') this.jumpText});
  factory _SystemNotificationItem.fromJson(Map<String, dynamic> json) => _$SystemNotificationItemFromJson(json);

@override final  int id;
@override final  String? title;
@override final  String? text;
@override final  int time;
@override final  String? uri;
@override@JsonKey(name: 'jump_text') final  String? jumpText;

/// Create a copy of SystemNotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemNotificationItemCopyWith<_SystemNotificationItem> get copyWith => __$SystemNotificationItemCopyWithImpl<_SystemNotificationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemNotificationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemNotificationItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.time, time) || other.time == time)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.jumpText, jumpText) || other.jumpText == jumpText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,text,time,uri,jumpText);

@override
String toString() {
  return 'SystemNotificationItem(id: $id, title: $title, text: $text, time: $time, uri: $uri, jumpText: $jumpText)';
}


}

/// @nodoc
abstract mixin class _$SystemNotificationItemCopyWith<$Res> implements $SystemNotificationItemCopyWith<$Res> {
  factory _$SystemNotificationItemCopyWith(_SystemNotificationItem value, $Res Function(_SystemNotificationItem) _then) = __$SystemNotificationItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String? title, String? text, int time, String? uri,@JsonKey(name: 'jump_text') String? jumpText
});




}
/// @nodoc
class __$SystemNotificationItemCopyWithImpl<$Res>
    implements _$SystemNotificationItemCopyWith<$Res> {
  __$SystemNotificationItemCopyWithImpl(this._self, this._then);

  final _SystemNotificationItem _self;
  final $Res Function(_SystemNotificationItem) _then;

/// Create a copy of SystemNotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? text = freezed,Object? time = null,Object? uri = freezed,Object? jumpText = freezed,}) {
  return _then(_SystemNotificationItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,jumpText: freezed == jumpText ? _self.jumpText : jumpText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
