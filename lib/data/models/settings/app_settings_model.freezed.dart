// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppSettings {

 String? get language; String? get theme; bool get notificationsEnabled; bool get autoPlayEnabled; bool get highQualityVideoEnabled; bool get darkModeEnabled; bool get showExplicitContent; DateTime? get updatedAt;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.language, language) || other.language == language)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.autoPlayEnabled, autoPlayEnabled) || other.autoPlayEnabled == autoPlayEnabled)&&(identical(other.highQualityVideoEnabled, highQualityVideoEnabled) || other.highQualityVideoEnabled == highQualityVideoEnabled)&&(identical(other.darkModeEnabled, darkModeEnabled) || other.darkModeEnabled == darkModeEnabled)&&(identical(other.showExplicitContent, showExplicitContent) || other.showExplicitContent == showExplicitContent)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,theme,notificationsEnabled,autoPlayEnabled,highQualityVideoEnabled,darkModeEnabled,showExplicitContent,updatedAt);

@override
String toString() {
  return 'AppSettings(language: $language, theme: $theme, notificationsEnabled: $notificationsEnabled, autoPlayEnabled: $autoPlayEnabled, highQualityVideoEnabled: $highQualityVideoEnabled, darkModeEnabled: $darkModeEnabled, showExplicitContent: $showExplicitContent, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String? language, String? theme, bool notificationsEnabled, bool autoPlayEnabled, bool highQualityVideoEnabled, bool darkModeEnabled, bool showExplicitContent, DateTime? updatedAt
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = freezed,Object? theme = freezed,Object? notificationsEnabled = null,Object? autoPlayEnabled = null,Object? highQualityVideoEnabled = null,Object? darkModeEnabled = null,Object? showExplicitContent = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoPlayEnabled: null == autoPlayEnabled ? _self.autoPlayEnabled : autoPlayEnabled // ignore: cast_nullable_to_non_nullable
as bool,highQualityVideoEnabled: null == highQualityVideoEnabled ? _self.highQualityVideoEnabled : highQualityVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,darkModeEnabled: null == darkModeEnabled ? _self.darkModeEnabled : darkModeEnabled // ignore: cast_nullable_to_non_nullable
as bool,showExplicitContent: null == showExplicitContent ? _self.showExplicitContent : showExplicitContent // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? language,  String? theme,  bool notificationsEnabled,  bool autoPlayEnabled,  bool highQualityVideoEnabled,  bool darkModeEnabled,  bool showExplicitContent,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.language,_that.theme,_that.notificationsEnabled,_that.autoPlayEnabled,_that.highQualityVideoEnabled,_that.darkModeEnabled,_that.showExplicitContent,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? language,  String? theme,  bool notificationsEnabled,  bool autoPlayEnabled,  bool highQualityVideoEnabled,  bool darkModeEnabled,  bool showExplicitContent,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.language,_that.theme,_that.notificationsEnabled,_that.autoPlayEnabled,_that.highQualityVideoEnabled,_that.darkModeEnabled,_that.showExplicitContent,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? language,  String? theme,  bool notificationsEnabled,  bool autoPlayEnabled,  bool highQualityVideoEnabled,  bool darkModeEnabled,  bool showExplicitContent,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.language,_that.theme,_that.notificationsEnabled,_that.autoPlayEnabled,_that.highQualityVideoEnabled,_that.darkModeEnabled,_that.showExplicitContent,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppSettings implements AppSettings {
  const _AppSettings({this.language, this.theme, required this.notificationsEnabled, required this.autoPlayEnabled, required this.highQualityVideoEnabled, required this.darkModeEnabled, required this.showExplicitContent, this.updatedAt});
  factory _AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

@override final  String? language;
@override final  String? theme;
@override final  bool notificationsEnabled;
@override final  bool autoPlayEnabled;
@override final  bool highQualityVideoEnabled;
@override final  bool darkModeEnabled;
@override final  bool showExplicitContent;
@override final  DateTime? updatedAt;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.language, language) || other.language == language)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.autoPlayEnabled, autoPlayEnabled) || other.autoPlayEnabled == autoPlayEnabled)&&(identical(other.highQualityVideoEnabled, highQualityVideoEnabled) || other.highQualityVideoEnabled == highQualityVideoEnabled)&&(identical(other.darkModeEnabled, darkModeEnabled) || other.darkModeEnabled == darkModeEnabled)&&(identical(other.showExplicitContent, showExplicitContent) || other.showExplicitContent == showExplicitContent)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,theme,notificationsEnabled,autoPlayEnabled,highQualityVideoEnabled,darkModeEnabled,showExplicitContent,updatedAt);

@override
String toString() {
  return 'AppSettings(language: $language, theme: $theme, notificationsEnabled: $notificationsEnabled, autoPlayEnabled: $autoPlayEnabled, highQualityVideoEnabled: $highQualityVideoEnabled, darkModeEnabled: $darkModeEnabled, showExplicitContent: $showExplicitContent, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String? language, String? theme, bool notificationsEnabled, bool autoPlayEnabled, bool highQualityVideoEnabled, bool darkModeEnabled, bool showExplicitContent, DateTime? updatedAt
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = freezed,Object? theme = freezed,Object? notificationsEnabled = null,Object? autoPlayEnabled = null,Object? highQualityVideoEnabled = null,Object? darkModeEnabled = null,Object? showExplicitContent = null,Object? updatedAt = freezed,}) {
  return _then(_AppSettings(
language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoPlayEnabled: null == autoPlayEnabled ? _self.autoPlayEnabled : autoPlayEnabled // ignore: cast_nullable_to_non_nullable
as bool,highQualityVideoEnabled: null == highQualityVideoEnabled ? _self.highQualityVideoEnabled : highQualityVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,darkModeEnabled: null == darkModeEnabled ? _self.darkModeEnabled : darkModeEnabled // ignore: cast_nullable_to_non_nullable
as bool,showExplicitContent: null == showExplicitContent ? _self.showExplicitContent : showExplicitContent // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
