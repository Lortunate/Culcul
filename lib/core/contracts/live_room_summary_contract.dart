import 'package:culcul/core/utils/json_utils.dart';

final class LiveWatchedShow {
  const LiveWatchedShow({
    required this.switchStatus,
    required this.num,
    required this.textSmall,
    required this.textLarge,
    required this.icon,
    required this.iconWeb,
  });

  factory LiveWatchedShow.fromJson(Map<String, dynamic> json) {
    final watchedCount = JsonUtils.parseInt(json['num']);
    if (watchedCount == null) {
      throw FormatException('Expected numeric watched count, got ${json['num']}');
    }
    return LiveWatchedShow(
      switchStatus: json['switch'] as bool,
      num: watchedCount,
      textSmall: json['text_small'] as String,
      textLarge: json['text_large'] as String,
      icon: json['icon'] as String,
      iconWeb: json['icon_web'] as String,
    );
  }

  final bool switchStatus;
  final int num;
  final String textSmall;
  final String textLarge;
  final String icon;
  final String iconWeb;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveWatchedShow &&
            runtimeType == other.runtimeType &&
            switchStatus == other.switchStatus &&
            num == other.num &&
            textSmall == other.textSmall &&
            textLarge == other.textLarge &&
            icon == other.icon &&
            iconWeb == other.iconWeb;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      switchStatus,
      num,
      textSmall,
      textLarge,
      icon,
      iconWeb,
    );
  }

  @override
  String toString() {
    return 'LiveWatchedShow('
        'switchStatus: $switchStatus, '
        'num: $num, '
        'textSmall: $textSmall, '
        'textLarge: $textLarge, '
        'icon: $icon, '
        'iconWeb: $iconWeb'
        ')';
  }
}

final class LiveRoomSummary {
  const LiveRoomSummary({
    required this.roomId,
    required this.uid,
    required this.title,
    required this.uname,
    required this.cover,
    required this.face,
    required this.online,
    required this.areaName,
    required this.parentAreaName,
    required this.link,
    this.keyframe,
    this.watchedShow,
    this.isAutoPlay,
  });

  factory LiveRoomSummary.fromJson(Map<String, dynamic> json) {
    return LiveRoomSummary(
      roomId: (json['roomid'] as num).toInt(),
      uid: (json['uid'] as num).toInt(),
      title: json['title'] as String,
      uname: json['uname'] as String,
      cover: json['cover'] as String,
      face: json['face'] as String,
      online: (json['online'] as num).toInt(),
      areaName: json['area_v2_name'] as String,
      parentAreaName: json['area_v2_parent_name'] as String,
      link: json['link'] as String,
      keyframe: json['keyframe'] as String?,
      watchedShow: json['watched_show'] == null
          ? null
          : LiveWatchedShow.fromJson(json['watched_show'] as Map<String, dynamic>),
      isAutoPlay: (json['is_auto_play'] as num?)?.toInt(),
    );
  }

  final int roomId;
  final int uid;
  final String title;
  final String uname;
  final String cover;
  final String face;
  final int online;
  final String areaName;
  final String parentAreaName;
  final String link;
  final String? keyframe;
  final LiveWatchedShow? watchedShow;
  final int? isAutoPlay;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveRoomSummary &&
            runtimeType == other.runtimeType &&
            roomId == other.roomId &&
            uid == other.uid &&
            title == other.title &&
            uname == other.uname &&
            cover == other.cover &&
            face == other.face &&
            online == other.online &&
            areaName == other.areaName &&
            parentAreaName == other.parentAreaName &&
            link == other.link &&
            keyframe == other.keyframe &&
            watchedShow == other.watchedShow &&
            isAutoPlay == other.isAutoPlay;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      roomId,
      uid,
      title,
      uname,
      cover,
      face,
      online,
      areaName,
      parentAreaName,
      link,
      keyframe,
      watchedShow,
      isAutoPlay,
    );
  }

  @override
  String toString() {
    return 'LiveRoomSummary('
        'roomId: $roomId, '
        'uid: $uid, '
        'title: $title, '
        'uname: $uname, '
        'cover: $cover, '
        'face: $face, '
        'online: $online, '
        'areaName: $areaName, '
        'parentAreaName: $parentAreaName, '
        'link: $link, '
        'keyframe: $keyframe, '
        'watchedShow: $watchedShow, '
        'isAutoPlay: $isAutoPlay'
        ')';
  }
}
