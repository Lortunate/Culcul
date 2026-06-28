// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_detail_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleDetailData {

 String get url; String get commentOid; int get commentType; String get title; String get summary; String? get bannerUrl; String get authorName; int get authorMid; String get authorAvatar; int get publishTime; ArticleStats get stats; List<ArticleBlock> get blocks;
/// Create a copy of ArticleDetailData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDetailDataCopyWith<ArticleDetailData> get copyWith => _$ArticleDetailDataCopyWithImpl<ArticleDetailData>(this as ArticleDetailData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDetailData&&(identical(other.url, url) || other.url == url)&&(identical(other.commentOid, commentOid) || other.commentOid == commentOid)&&(identical(other.commentType, commentType) || other.commentType == commentType)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMid, authorMid) || other.authorMid == authorMid)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.publishTime, publishTime) || other.publishTime == publishTime)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.blocks, blocks));
}


@override
int get hashCode => Object.hash(runtimeType,url,commentOid,commentType,title,summary,bannerUrl,authorName,authorMid,authorAvatar,publishTime,stats,const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'ArticleDetailData(url: $url, commentOid: $commentOid, commentType: $commentType, title: $title, summary: $summary, bannerUrl: $bannerUrl, authorName: $authorName, authorMid: $authorMid, authorAvatar: $authorAvatar, publishTime: $publishTime, stats: $stats, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $ArticleDetailDataCopyWith<$Res>  {
  factory $ArticleDetailDataCopyWith(ArticleDetailData value, $Res Function(ArticleDetailData) _then) = _$ArticleDetailDataCopyWithImpl;
@useResult
$Res call({
 String url, String commentOid, int commentType, String title, String summary, String? bannerUrl, String authorName, int authorMid, String authorAvatar, int publishTime, ArticleStats stats, List<ArticleBlock> blocks
});


$ArticleStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$ArticleDetailDataCopyWithImpl<$Res>
    implements $ArticleDetailDataCopyWith<$Res> {
  _$ArticleDetailDataCopyWithImpl(this._self, this._then);

  final ArticleDetailData _self;
  final $Res Function(ArticleDetailData) _then;

/// Create a copy of ArticleDetailData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? commentOid = null,Object? commentType = null,Object? title = null,Object? summary = null,Object? bannerUrl = freezed,Object? authorName = null,Object? authorMid = null,Object? authorAvatar = null,Object? publishTime = null,Object? stats = null,Object? blocks = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,commentOid: null == commentOid ? _self.commentOid : commentOid // ignore: cast_nullable_to_non_nullable
as String,commentType: null == commentType ? _self.commentType : commentType // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMid: null == authorMid ? _self.authorMid : authorMid // ignore: cast_nullable_to_non_nullable
as int,authorAvatar: null == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String,publishTime: null == publishTime ? _self.publishTime : publishTime // ignore: cast_nullable_to_non_nullable
as int,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ArticleStats,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ArticleBlock>,
  ));
}
/// Create a copy of ArticleDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleStatsCopyWith<$Res> get stats {
  
  return $ArticleStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArticleDetailData].
extension ArticleDetailDataPatterns on ArticleDetailData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleDetailData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleDetailData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleDetailData value)  $default,){
final _that = this;
switch (_that) {
case _ArticleDetailData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleDetailData value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleDetailData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String commentOid,  int commentType,  String title,  String summary,  String? bannerUrl,  String authorName,  int authorMid,  String authorAvatar,  int publishTime,  ArticleStats stats,  List<ArticleBlock> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleDetailData() when $default != null:
return $default(_that.url,_that.commentOid,_that.commentType,_that.title,_that.summary,_that.bannerUrl,_that.authorName,_that.authorMid,_that.authorAvatar,_that.publishTime,_that.stats,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String commentOid,  int commentType,  String title,  String summary,  String? bannerUrl,  String authorName,  int authorMid,  String authorAvatar,  int publishTime,  ArticleStats stats,  List<ArticleBlock> blocks)  $default,) {final _that = this;
switch (_that) {
case _ArticleDetailData():
return $default(_that.url,_that.commentOid,_that.commentType,_that.title,_that.summary,_that.bannerUrl,_that.authorName,_that.authorMid,_that.authorAvatar,_that.publishTime,_that.stats,_that.blocks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String commentOid,  int commentType,  String title,  String summary,  String? bannerUrl,  String authorName,  int authorMid,  String authorAvatar,  int publishTime,  ArticleStats stats,  List<ArticleBlock> blocks)?  $default,) {final _that = this;
switch (_that) {
case _ArticleDetailData() when $default != null:
return $default(_that.url,_that.commentOid,_that.commentType,_that.title,_that.summary,_that.bannerUrl,_that.authorName,_that.authorMid,_that.authorAvatar,_that.publishTime,_that.stats,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc


class _ArticleDetailData implements ArticleDetailData {
  const _ArticleDetailData({required this.url, required this.commentOid, required this.commentType, required this.title, required this.summary, this.bannerUrl, required this.authorName, required this.authorMid, required this.authorAvatar, required this.publishTime, required this.stats, required final  List<ArticleBlock> blocks}): _blocks = blocks;
  

@override final  String url;
@override final  String commentOid;
@override final  int commentType;
@override final  String title;
@override final  String summary;
@override final  String? bannerUrl;
@override final  String authorName;
@override final  int authorMid;
@override final  String authorAvatar;
@override final  int publishTime;
@override final  ArticleStats stats;
 final  List<ArticleBlock> _blocks;
@override List<ArticleBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of ArticleDetailData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDetailDataCopyWith<_ArticleDetailData> get copyWith => __$ArticleDetailDataCopyWithImpl<_ArticleDetailData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDetailData&&(identical(other.url, url) || other.url == url)&&(identical(other.commentOid, commentOid) || other.commentOid == commentOid)&&(identical(other.commentType, commentType) || other.commentType == commentType)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMid, authorMid) || other.authorMid == authorMid)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.publishTime, publishTime) || other.publishTime == publishTime)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}


@override
int get hashCode => Object.hash(runtimeType,url,commentOid,commentType,title,summary,bannerUrl,authorName,authorMid,authorAvatar,publishTime,stats,const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'ArticleDetailData(url: $url, commentOid: $commentOid, commentType: $commentType, title: $title, summary: $summary, bannerUrl: $bannerUrl, authorName: $authorName, authorMid: $authorMid, authorAvatar: $authorAvatar, publishTime: $publishTime, stats: $stats, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$ArticleDetailDataCopyWith<$Res> implements $ArticleDetailDataCopyWith<$Res> {
  factory _$ArticleDetailDataCopyWith(_ArticleDetailData value, $Res Function(_ArticleDetailData) _then) = __$ArticleDetailDataCopyWithImpl;
@override @useResult
$Res call({
 String url, String commentOid, int commentType, String title, String summary, String? bannerUrl, String authorName, int authorMid, String authorAvatar, int publishTime, ArticleStats stats, List<ArticleBlock> blocks
});


@override $ArticleStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$ArticleDetailDataCopyWithImpl<$Res>
    implements _$ArticleDetailDataCopyWith<$Res> {
  __$ArticleDetailDataCopyWithImpl(this._self, this._then);

  final _ArticleDetailData _self;
  final $Res Function(_ArticleDetailData) _then;

/// Create a copy of ArticleDetailData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? commentOid = null,Object? commentType = null,Object? title = null,Object? summary = null,Object? bannerUrl = freezed,Object? authorName = null,Object? authorMid = null,Object? authorAvatar = null,Object? publishTime = null,Object? stats = null,Object? blocks = null,}) {
  return _then(_ArticleDetailData(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,commentOid: null == commentOid ? _self.commentOid : commentOid // ignore: cast_nullable_to_non_nullable
as String,commentType: null == commentType ? _self.commentType : commentType // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMid: null == authorMid ? _self.authorMid : authorMid // ignore: cast_nullable_to_non_nullable
as int,authorAvatar: null == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String,publishTime: null == publishTime ? _self.publishTime : publishTime // ignore: cast_nullable_to_non_nullable
as int,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ArticleStats,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ArticleBlock>,
  ));
}

/// Create a copy of ArticleDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleStatsCopyWith<$Res> get stats {
  
  return $ArticleStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

/// @nodoc
mixin _$ArticleStats {

 int get view; int get favorite; int get like; int get dislike; int get reply; int get share; int get coin; int get dynamicCount;
/// Create a copy of ArticleStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleStatsCopyWith<ArticleStats> get copyWith => _$ArticleStatsCopyWithImpl<ArticleStats>(this as ArticleStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleStats&&(identical(other.view, view) || other.view == view)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.like, like) || other.like == like)&&(identical(other.dislike, dislike) || other.dislike == dislike)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.share, share) || other.share == share)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.dynamicCount, dynamicCount) || other.dynamicCount == dynamicCount));
}


@override
int get hashCode => Object.hash(runtimeType,view,favorite,like,dislike,reply,share,coin,dynamicCount);

@override
String toString() {
  return 'ArticleStats(view: $view, favorite: $favorite, like: $like, dislike: $dislike, reply: $reply, share: $share, coin: $coin, dynamicCount: $dynamicCount)';
}


}

/// @nodoc
abstract mixin class $ArticleStatsCopyWith<$Res>  {
  factory $ArticleStatsCopyWith(ArticleStats value, $Res Function(ArticleStats) _then) = _$ArticleStatsCopyWithImpl;
@useResult
$Res call({
 int view, int favorite, int like, int dislike, int reply, int share, int coin, int dynamicCount
});




}
/// @nodoc
class _$ArticleStatsCopyWithImpl<$Res>
    implements $ArticleStatsCopyWith<$Res> {
  _$ArticleStatsCopyWithImpl(this._self, this._then);

  final ArticleStats _self;
  final $Res Function(ArticleStats) _then;

/// Create a copy of ArticleStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? favorite = null,Object? like = null,Object? dislike = null,Object? reply = null,Object? share = null,Object? coin = null,Object? dynamicCount = null,}) {
  return _then(_self.copyWith(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,dislike: null == dislike ? _self.dislike : dislike // ignore: cast_nullable_to_non_nullable
as int,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as int,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int,dynamicCount: null == dynamicCount ? _self.dynamicCount : dynamicCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleStats].
extension ArticleStatsPatterns on ArticleStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleStats value)  $default,){
final _that = this;
switch (_that) {
case _ArticleStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleStats value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int view,  int favorite,  int like,  int dislike,  int reply,  int share,  int coin,  int dynamicCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleStats() when $default != null:
return $default(_that.view,_that.favorite,_that.like,_that.dislike,_that.reply,_that.share,_that.coin,_that.dynamicCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int view,  int favorite,  int like,  int dislike,  int reply,  int share,  int coin,  int dynamicCount)  $default,) {final _that = this;
switch (_that) {
case _ArticleStats():
return $default(_that.view,_that.favorite,_that.like,_that.dislike,_that.reply,_that.share,_that.coin,_that.dynamicCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int view,  int favorite,  int like,  int dislike,  int reply,  int share,  int coin,  int dynamicCount)?  $default,) {final _that = this;
switch (_that) {
case _ArticleStats() when $default != null:
return $default(_that.view,_that.favorite,_that.like,_that.dislike,_that.reply,_that.share,_that.coin,_that.dynamicCount);case _:
  return null;

}
}

}

/// @nodoc


class _ArticleStats implements ArticleStats {
  const _ArticleStats({required this.view, required this.favorite, required this.like, required this.dislike, required this.reply, required this.share, required this.coin, required this.dynamicCount});
  

@override final  int view;
@override final  int favorite;
@override final  int like;
@override final  int dislike;
@override final  int reply;
@override final  int share;
@override final  int coin;
@override final  int dynamicCount;

/// Create a copy of ArticleStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleStatsCopyWith<_ArticleStats> get copyWith => __$ArticleStatsCopyWithImpl<_ArticleStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleStats&&(identical(other.view, view) || other.view == view)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.like, like) || other.like == like)&&(identical(other.dislike, dislike) || other.dislike == dislike)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.share, share) || other.share == share)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.dynamicCount, dynamicCount) || other.dynamicCount == dynamicCount));
}


@override
int get hashCode => Object.hash(runtimeType,view,favorite,like,dislike,reply,share,coin,dynamicCount);

@override
String toString() {
  return 'ArticleStats(view: $view, favorite: $favorite, like: $like, dislike: $dislike, reply: $reply, share: $share, coin: $coin, dynamicCount: $dynamicCount)';
}


}

/// @nodoc
abstract mixin class _$ArticleStatsCopyWith<$Res> implements $ArticleStatsCopyWith<$Res> {
  factory _$ArticleStatsCopyWith(_ArticleStats value, $Res Function(_ArticleStats) _then) = __$ArticleStatsCopyWithImpl;
@override @useResult
$Res call({
 int view, int favorite, int like, int dislike, int reply, int share, int coin, int dynamicCount
});




}
/// @nodoc
class __$ArticleStatsCopyWithImpl<$Res>
    implements _$ArticleStatsCopyWith<$Res> {
  __$ArticleStatsCopyWithImpl(this._self, this._then);

  final _ArticleStats _self;
  final $Res Function(_ArticleStats) _then;

/// Create a copy of ArticleStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = null,Object? favorite = null,Object? like = null,Object? dislike = null,Object? reply = null,Object? share = null,Object? coin = null,Object? dynamicCount = null,}) {
  return _then(_ArticleStats(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as int,like: null == like ? _self.like : like // ignore: cast_nullable_to_non_nullable
as int,dislike: null == dislike ? _self.dislike : dislike // ignore: cast_nullable_to_non_nullable
as int,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as int,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as int,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as int,dynamicCount: null == dynamicCount ? _self.dynamicCount : dynamicCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
