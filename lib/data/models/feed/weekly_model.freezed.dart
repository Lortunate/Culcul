// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyModel {

 List<VideoModel> get list;
/// Create a copy of WeeklyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyModelCopyWith<WeeklyModel> get copyWith => _$WeeklyModelCopyWithImpl<WeeklyModel>(this as WeeklyModel, _$identity);

  /// Serializes this WeeklyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyModel&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'WeeklyModel(list: $list)';
}


}

/// @nodoc
abstract mixin class $WeeklyModelCopyWith<$Res>  {
  factory $WeeklyModelCopyWith(WeeklyModel value, $Res Function(WeeklyModel) _then) = _$WeeklyModelCopyWithImpl;
@useResult
$Res call({
 List<VideoModel> list
});




}
/// @nodoc
class _$WeeklyModelCopyWithImpl<$Res>
    implements $WeeklyModelCopyWith<$Res> {
  _$WeeklyModelCopyWithImpl(this._self, this._then);

  final WeeklyModel _self;
  final $Res Function(WeeklyModel) _then;

/// Create a copy of WeeklyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyModel].
extension WeeklyModelPatterns on WeeklyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyModel value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyModel value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VideoModel> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VideoModel> list)  $default,) {final _that = this;
switch (_that) {
case _WeeklyModel():
return $default(_that.list);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VideoModel> list)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyModel() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyModel implements WeeklyModel {
  const _WeeklyModel({required final  List<VideoModel> list}): _list = list;
  factory _WeeklyModel.fromJson(Map<String, dynamic> json) => _$WeeklyModelFromJson(json);

 final  List<VideoModel> _list;
@override List<VideoModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of WeeklyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyModelCopyWith<_WeeklyModel> get copyWith => __$WeeklyModelCopyWithImpl<_WeeklyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyModel&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'WeeklyModel(list: $list)';
}


}

/// @nodoc
abstract mixin class _$WeeklyModelCopyWith<$Res> implements $WeeklyModelCopyWith<$Res> {
  factory _$WeeklyModelCopyWith(_WeeklyModel value, $Res Function(_WeeklyModel) _then) = __$WeeklyModelCopyWithImpl;
@override @useResult
$Res call({
 List<VideoModel> list
});




}
/// @nodoc
class __$WeeklyModelCopyWithImpl<$Res>
    implements _$WeeklyModelCopyWith<$Res> {
  __$WeeklyModelCopyWithImpl(this._self, this._then);

  final _WeeklyModel _self;
  final $Res Function(_WeeklyModel) _then;

/// Create a copy of WeeklyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_WeeklyModel(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,
  ));
}


}

// dart format on
