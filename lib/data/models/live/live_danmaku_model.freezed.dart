// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_danmaku_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveDanmakuConfigModel {

 List<LiveDanmakuGroup> get group; List<LiveDanmakuMode> get mode;
/// Create a copy of LiveDanmakuConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmakuConfigModelCopyWith<LiveDanmakuConfigModel> get copyWith => _$LiveDanmakuConfigModelCopyWithImpl<LiveDanmakuConfigModel>(this as LiveDanmakuConfigModel, _$identity);

  /// Serializes this LiveDanmakuConfigModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmakuConfigModel&&const DeepCollectionEquality().equals(other.group, group)&&const DeepCollectionEquality().equals(other.mode, mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(group),const DeepCollectionEquality().hash(mode));

@override
String toString() {
  return 'LiveDanmakuConfigModel(group: $group, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $LiveDanmakuConfigModelCopyWith<$Res>  {
  factory $LiveDanmakuConfigModelCopyWith(LiveDanmakuConfigModel value, $Res Function(LiveDanmakuConfigModel) _then) = _$LiveDanmakuConfigModelCopyWithImpl;
@useResult
$Res call({
 List<LiveDanmakuGroup> group, List<LiveDanmakuMode> mode
});




}
/// @nodoc
class _$LiveDanmakuConfigModelCopyWithImpl<$Res>
    implements $LiveDanmakuConfigModelCopyWith<$Res> {
  _$LiveDanmakuConfigModelCopyWithImpl(this._self, this._then);

  final LiveDanmakuConfigModel _self;
  final $Res Function(LiveDanmakuConfigModel) _then;

/// Create a copy of LiveDanmakuConfigModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? group = null,Object? mode = null,}) {
  return _then(_self.copyWith(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuGroup>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuMode>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmakuConfigModel].
extension LiveDanmakuConfigModelPatterns on LiveDanmakuConfigModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmakuConfigModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmakuConfigModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmakuConfigModel value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuConfigModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmakuConfigModel value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuConfigModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LiveDanmakuGroup> group,  List<LiveDanmakuMode> mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmakuConfigModel() when $default != null:
return $default(_that.group,_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LiveDanmakuGroup> group,  List<LiveDanmakuMode> mode)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuConfigModel():
return $default(_that.group,_that.mode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LiveDanmakuGroup> group,  List<LiveDanmakuMode> mode)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuConfigModel() when $default != null:
return $default(_that.group,_that.mode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmakuConfigModel implements LiveDanmakuConfigModel {
  const _LiveDanmakuConfigModel({required final  List<LiveDanmakuGroup> group, required final  List<LiveDanmakuMode> mode}): _group = group,_mode = mode;
  factory _LiveDanmakuConfigModel.fromJson(Map<String, dynamic> json) => _$LiveDanmakuConfigModelFromJson(json);

 final  List<LiveDanmakuGroup> _group;
@override List<LiveDanmakuGroup> get group {
  if (_group is EqualUnmodifiableListView) return _group;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_group);
}

 final  List<LiveDanmakuMode> _mode;
@override List<LiveDanmakuMode> get mode {
  if (_mode is EqualUnmodifiableListView) return _mode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mode);
}


/// Create a copy of LiveDanmakuConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmakuConfigModelCopyWith<_LiveDanmakuConfigModel> get copyWith => __$LiveDanmakuConfigModelCopyWithImpl<_LiveDanmakuConfigModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmakuConfigModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmakuConfigModel&&const DeepCollectionEquality().equals(other._group, _group)&&const DeepCollectionEquality().equals(other._mode, _mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_group),const DeepCollectionEquality().hash(_mode));

@override
String toString() {
  return 'LiveDanmakuConfigModel(group: $group, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmakuConfigModelCopyWith<$Res> implements $LiveDanmakuConfigModelCopyWith<$Res> {
  factory _$LiveDanmakuConfigModelCopyWith(_LiveDanmakuConfigModel value, $Res Function(_LiveDanmakuConfigModel) _then) = __$LiveDanmakuConfigModelCopyWithImpl;
@override @useResult
$Res call({
 List<LiveDanmakuGroup> group, List<LiveDanmakuMode> mode
});




}
/// @nodoc
class __$LiveDanmakuConfigModelCopyWithImpl<$Res>
    implements _$LiveDanmakuConfigModelCopyWith<$Res> {
  __$LiveDanmakuConfigModelCopyWithImpl(this._self, this._then);

  final _LiveDanmakuConfigModel _self;
  final $Res Function(_LiveDanmakuConfigModel) _then;

/// Create a copy of LiveDanmakuConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? group = null,Object? mode = null,}) {
  return _then(_LiveDanmakuConfigModel(
group: null == group ? _self._group : group // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuGroup>,mode: null == mode ? _self._mode : mode // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuMode>,
  ));
}


}


/// @nodoc
mixin _$LiveDanmakuGroup {

 String get name; int get sort; List<LiveDanmakuColor> get color;
/// Create a copy of LiveDanmakuGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmakuGroupCopyWith<LiveDanmakuGroup> get copyWith => _$LiveDanmakuGroupCopyWithImpl<LiveDanmakuGroup>(this as LiveDanmakuGroup, _$identity);

  /// Serializes this LiveDanmakuGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmakuGroup&&(identical(other.name, name) || other.name == name)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other.color, color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,sort,const DeepCollectionEquality().hash(color));

@override
String toString() {
  return 'LiveDanmakuGroup(name: $name, sort: $sort, color: $color)';
}


}

/// @nodoc
abstract mixin class $LiveDanmakuGroupCopyWith<$Res>  {
  factory $LiveDanmakuGroupCopyWith(LiveDanmakuGroup value, $Res Function(LiveDanmakuGroup) _then) = _$LiveDanmakuGroupCopyWithImpl;
@useResult
$Res call({
 String name, int sort, List<LiveDanmakuColor> color
});




}
/// @nodoc
class _$LiveDanmakuGroupCopyWithImpl<$Res>
    implements $LiveDanmakuGroupCopyWith<$Res> {
  _$LiveDanmakuGroupCopyWithImpl(this._self, this._then);

  final LiveDanmakuGroup _self;
  final $Res Function(LiveDanmakuGroup) _then;

/// Create a copy of LiveDanmakuGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? sort = null,Object? color = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuColor>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmakuGroup].
extension LiveDanmakuGroupPatterns on LiveDanmakuGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmakuGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmakuGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmakuGroup value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmakuGroup value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int sort,  List<LiveDanmakuColor> color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmakuGroup() when $default != null:
return $default(_that.name,_that.sort,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int sort,  List<LiveDanmakuColor> color)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuGroup():
return $default(_that.name,_that.sort,_that.color);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int sort,  List<LiveDanmakuColor> color)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuGroup() when $default != null:
return $default(_that.name,_that.sort,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmakuGroup implements LiveDanmakuGroup {
  const _LiveDanmakuGroup({required this.name, required this.sort, required final  List<LiveDanmakuColor> color}): _color = color;
  factory _LiveDanmakuGroup.fromJson(Map<String, dynamic> json) => _$LiveDanmakuGroupFromJson(json);

@override final  String name;
@override final  int sort;
 final  List<LiveDanmakuColor> _color;
@override List<LiveDanmakuColor> get color {
  if (_color is EqualUnmodifiableListView) return _color;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_color);
}


/// Create a copy of LiveDanmakuGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmakuGroupCopyWith<_LiveDanmakuGroup> get copyWith => __$LiveDanmakuGroupCopyWithImpl<_LiveDanmakuGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmakuGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmakuGroup&&(identical(other.name, name) || other.name == name)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other._color, _color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,sort,const DeepCollectionEquality().hash(_color));

@override
String toString() {
  return 'LiveDanmakuGroup(name: $name, sort: $sort, color: $color)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmakuGroupCopyWith<$Res> implements $LiveDanmakuGroupCopyWith<$Res> {
  factory _$LiveDanmakuGroupCopyWith(_LiveDanmakuGroup value, $Res Function(_LiveDanmakuGroup) _then) = __$LiveDanmakuGroupCopyWithImpl;
@override @useResult
$Res call({
 String name, int sort, List<LiveDanmakuColor> color
});




}
/// @nodoc
class __$LiveDanmakuGroupCopyWithImpl<$Res>
    implements _$LiveDanmakuGroupCopyWith<$Res> {
  __$LiveDanmakuGroupCopyWithImpl(this._self, this._then);

  final _LiveDanmakuGroup _self;
  final $Res Function(_LiveDanmakuGroup) _then;

/// Create a copy of LiveDanmakuGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? sort = null,Object? color = null,}) {
  return _then(_LiveDanmakuGroup(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self._color : color // ignore: cast_nullable_to_non_nullable
as List<LiveDanmakuColor>,
  ));
}


}


/// @nodoc
mixin _$LiveDanmakuColor {

 String get name; String get color;@JsonKey(name: 'color_hex') String get colorHex; int get status; int get weight;@JsonKey(name: 'color_id') int get colorId; int get origin;
/// Create a copy of LiveDanmakuColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmakuColorCopyWith<LiveDanmakuColor> get copyWith => _$LiveDanmakuColorCopyWithImpl<LiveDanmakuColor>(this as LiveDanmakuColor, _$identity);

  /// Serializes this LiveDanmakuColor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmakuColor&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.status, status) || other.status == status)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.colorId, colorId) || other.colorId == colorId)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,color,colorHex,status,weight,colorId,origin);

@override
String toString() {
  return 'LiveDanmakuColor(name: $name, color: $color, colorHex: $colorHex, status: $status, weight: $weight, colorId: $colorId, origin: $origin)';
}


}

/// @nodoc
abstract mixin class $LiveDanmakuColorCopyWith<$Res>  {
  factory $LiveDanmakuColorCopyWith(LiveDanmakuColor value, $Res Function(LiveDanmakuColor) _then) = _$LiveDanmakuColorCopyWithImpl;
@useResult
$Res call({
 String name, String color,@JsonKey(name: 'color_hex') String colorHex, int status, int weight,@JsonKey(name: 'color_id') int colorId, int origin
});




}
/// @nodoc
class _$LiveDanmakuColorCopyWithImpl<$Res>
    implements $LiveDanmakuColorCopyWith<$Res> {
  _$LiveDanmakuColorCopyWithImpl(this._self, this._then);

  final LiveDanmakuColor _self;
  final $Res Function(LiveDanmakuColor) _then;

/// Create a copy of LiveDanmakuColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? color = null,Object? colorHex = null,Object? status = null,Object? weight = null,Object? colorId = null,Object? origin = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,colorId: null == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as int,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmakuColor].
extension LiveDanmakuColorPatterns on LiveDanmakuColor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmakuColor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmakuColor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmakuColor value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuColor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmakuColor value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuColor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String color, @JsonKey(name: 'color_hex')  String colorHex,  int status,  int weight, @JsonKey(name: 'color_id')  int colorId,  int origin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmakuColor() when $default != null:
return $default(_that.name,_that.color,_that.colorHex,_that.status,_that.weight,_that.colorId,_that.origin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String color, @JsonKey(name: 'color_hex')  String colorHex,  int status,  int weight, @JsonKey(name: 'color_id')  int colorId,  int origin)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuColor():
return $default(_that.name,_that.color,_that.colorHex,_that.status,_that.weight,_that.colorId,_that.origin);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String color, @JsonKey(name: 'color_hex')  String colorHex,  int status,  int weight, @JsonKey(name: 'color_id')  int colorId,  int origin)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuColor() when $default != null:
return $default(_that.name,_that.color,_that.colorHex,_that.status,_that.weight,_that.colorId,_that.origin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmakuColor implements LiveDanmakuColor {
  const _LiveDanmakuColor({required this.name, required this.color, @JsonKey(name: 'color_hex') required this.colorHex, required this.status, required this.weight, @JsonKey(name: 'color_id') required this.colorId, required this.origin});
  factory _LiveDanmakuColor.fromJson(Map<String, dynamic> json) => _$LiveDanmakuColorFromJson(json);

@override final  String name;
@override final  String color;
@override@JsonKey(name: 'color_hex') final  String colorHex;
@override final  int status;
@override final  int weight;
@override@JsonKey(name: 'color_id') final  int colorId;
@override final  int origin;

/// Create a copy of LiveDanmakuColor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmakuColorCopyWith<_LiveDanmakuColor> get copyWith => __$LiveDanmakuColorCopyWithImpl<_LiveDanmakuColor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmakuColorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmakuColor&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.status, status) || other.status == status)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.colorId, colorId) || other.colorId == colorId)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,color,colorHex,status,weight,colorId,origin);

@override
String toString() {
  return 'LiveDanmakuColor(name: $name, color: $color, colorHex: $colorHex, status: $status, weight: $weight, colorId: $colorId, origin: $origin)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmakuColorCopyWith<$Res> implements $LiveDanmakuColorCopyWith<$Res> {
  factory _$LiveDanmakuColorCopyWith(_LiveDanmakuColor value, $Res Function(_LiveDanmakuColor) _then) = __$LiveDanmakuColorCopyWithImpl;
@override @useResult
$Res call({
 String name, String color,@JsonKey(name: 'color_hex') String colorHex, int status, int weight,@JsonKey(name: 'color_id') int colorId, int origin
});




}
/// @nodoc
class __$LiveDanmakuColorCopyWithImpl<$Res>
    implements _$LiveDanmakuColorCopyWith<$Res> {
  __$LiveDanmakuColorCopyWithImpl(this._self, this._then);

  final _LiveDanmakuColor _self;
  final $Res Function(_LiveDanmakuColor) _then;

/// Create a copy of LiveDanmakuColor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? color = null,Object? colorHex = null,Object? status = null,Object? weight = null,Object? colorId = null,Object? origin = null,}) {
  return _then(_LiveDanmakuColor(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,colorId: null == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as int,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveDanmakuMode {

 String get name; int get mode; String get type; int get status;
/// Create a copy of LiveDanmakuMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDanmakuModeCopyWith<LiveDanmakuMode> get copyWith => _$LiveDanmakuModeCopyWithImpl<LiveDanmakuMode>(this as LiveDanmakuMode, _$identity);

  /// Serializes this LiveDanmakuMode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveDanmakuMode&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,mode,type,status);

@override
String toString() {
  return 'LiveDanmakuMode(name: $name, mode: $mode, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class $LiveDanmakuModeCopyWith<$Res>  {
  factory $LiveDanmakuModeCopyWith(LiveDanmakuMode value, $Res Function(LiveDanmakuMode) _then) = _$LiveDanmakuModeCopyWithImpl;
@useResult
$Res call({
 String name, int mode, String type, int status
});




}
/// @nodoc
class _$LiveDanmakuModeCopyWithImpl<$Res>
    implements $LiveDanmakuModeCopyWith<$Res> {
  _$LiveDanmakuModeCopyWithImpl(this._self, this._then);

  final LiveDanmakuMode _self;
  final $Res Function(LiveDanmakuMode) _then;

/// Create a copy of LiveDanmakuMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? mode = null,Object? type = null,Object? status = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveDanmakuMode].
extension LiveDanmakuModePatterns on LiveDanmakuMode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveDanmakuMode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveDanmakuMode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveDanmakuMode value)  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuMode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveDanmakuMode value)?  $default,){
final _that = this;
switch (_that) {
case _LiveDanmakuMode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int mode,  String type,  int status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveDanmakuMode() when $default != null:
return $default(_that.name,_that.mode,_that.type,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int mode,  String type,  int status)  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuMode():
return $default(_that.name,_that.mode,_that.type,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int mode,  String type,  int status)?  $default,) {final _that = this;
switch (_that) {
case _LiveDanmakuMode() when $default != null:
return $default(_that.name,_that.mode,_that.type,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveDanmakuMode implements LiveDanmakuMode {
  const _LiveDanmakuMode({required this.name, required this.mode, required this.type, required this.status});
  factory _LiveDanmakuMode.fromJson(Map<String, dynamic> json) => _$LiveDanmakuModeFromJson(json);

@override final  String name;
@override final  int mode;
@override final  String type;
@override final  int status;

/// Create a copy of LiveDanmakuMode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDanmakuModeCopyWith<_LiveDanmakuMode> get copyWith => __$LiveDanmakuModeCopyWithImpl<_LiveDanmakuMode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDanmakuModeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveDanmakuMode&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,mode,type,status);

@override
String toString() {
  return 'LiveDanmakuMode(name: $name, mode: $mode, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LiveDanmakuModeCopyWith<$Res> implements $LiveDanmakuModeCopyWith<$Res> {
  factory _$LiveDanmakuModeCopyWith(_LiveDanmakuMode value, $Res Function(_LiveDanmakuMode) _then) = __$LiveDanmakuModeCopyWithImpl;
@override @useResult
$Res call({
 String name, int mode, String type, int status
});




}
/// @nodoc
class __$LiveDanmakuModeCopyWithImpl<$Res>
    implements _$LiveDanmakuModeCopyWith<$Res> {
  __$LiveDanmakuModeCopyWithImpl(this._self, this._then);

  final _LiveDanmakuMode _self;
  final $Res Function(_LiveDanmakuMode) _then;

/// Create a copy of LiveDanmakuMode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? mode = null,Object? type = null,Object? status = null,}) {
  return _then(_LiveDanmakuMode(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
