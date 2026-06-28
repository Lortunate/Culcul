import 'package:culcul/core/models/video_model_contract.dart';

final class FavoriteFolder {
  const FavoriteFolder({
    required this.id,
    required this.fid,
    required this.mid,
    required this.attr,
    required this.title,
    this.favState = 0,
    this.mediaCount = 0,
    this.cover,
    this.upper,
    this.intro,
    this.ctime,
    this.mtime,
    this.state,
  });

  factory FavoriteFolder.fromJson(Map<String, dynamic> json) {
    return FavoriteFolder(
      id: (json['id'] as num).toInt(),
      fid: (json['fid'] as num).toInt(),
      mid: (json['mid'] as num).toInt(),
      attr: (json['attr'] as num).toInt(),
      title: json['title'] as String,
      favState: (json['fav_state'] as num?)?.toInt() ?? 0,
      mediaCount: (json['media_count'] as num?)?.toInt() ?? 0,
      cover: json['cover'] as String?,
      upper: json['upper'] == null
          ? null
          : VideoOwner.fromJson(json['upper'] as Map<String, dynamic>),
      intro: json['intro'] as String?,
      ctime: (json['ctime'] as num?)?.toInt(),
      mtime: (json['mtime'] as num?)?.toInt(),
      state: (json['state'] as num?)?.toInt(),
    );
  }

  final int id;
  final int fid;
  final int mid;
  final int attr;
  final String title;
  final int favState;
  final int mediaCount;
  final String? cover;
  final VideoOwner? upper;
  final String? intro;
  final int? ctime;
  final int? mtime;
  final int? state;

  bool get isPrivate => attr != 0 && (attr & 1) == 1;

  FavoriteFolder copyWith({
    int? id,
    int? fid,
    int? mid,
    int? attr,
    String? title,
    int? favState,
    int? mediaCount,
    Object? cover = _copySentinel,
    Object? upper = _copySentinel,
    Object? intro = _copySentinel,
    Object? ctime = _copySentinel,
    Object? mtime = _copySentinel,
    Object? state = _copySentinel,
  }) {
    return FavoriteFolder(
      id: id ?? this.id,
      fid: fid ?? this.fid,
      mid: mid ?? this.mid,
      attr: attr ?? this.attr,
      title: title ?? this.title,
      favState: favState ?? this.favState,
      mediaCount: mediaCount ?? this.mediaCount,
      cover: identical(cover, _copySentinel) ? this.cover : cover as String?,
      upper: identical(upper, _copySentinel) ? this.upper : upper as VideoOwner?,
      intro: identical(intro, _copySentinel) ? this.intro : intro as String?,
      ctime: identical(ctime, _copySentinel) ? this.ctime : ctime as int?,
      mtime: identical(mtime, _copySentinel) ? this.mtime : mtime as int?,
      state: identical(state, _copySentinel) ? this.state : state as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteFolder &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            fid == other.fid &&
            mid == other.mid &&
            attr == other.attr &&
            title == other.title &&
            favState == other.favState &&
            mediaCount == other.mediaCount &&
            cover == other.cover &&
            upper == other.upper &&
            intro == other.intro &&
            ctime == other.ctime &&
            mtime == other.mtime &&
            state == other.state;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      fid,
      mid,
      attr,
      title,
      favState,
      mediaCount,
      cover,
      upper,
      intro,
      ctime,
      mtime,
      state,
    );
  }

  @override
  String toString() {
    return 'FavoriteFolder('
        'id: $id, '
        'fid: $fid, '
        'mid: $mid, '
        'attr: $attr, '
        'title: $title, '
        'favState: $favState, '
        'mediaCount: $mediaCount, '
        'cover: $cover, '
        'upper: $upper, '
        'intro: $intro, '
        'ctime: $ctime, '
        'mtime: $mtime, '
        'state: $state'
        ')';
  }
}

const Object _copySentinel = Object();
