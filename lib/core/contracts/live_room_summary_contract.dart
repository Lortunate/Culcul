class LiveWatchedShow {
  final bool switchStatus;
  final int num;
  final String textSmall;
  final String textLarge;
  final String icon;
  final String iconWeb;

  const LiveWatchedShow({
    required this.switchStatus,
    required this.num,
    required this.textSmall,
    required this.textLarge,
    required this.icon,
    required this.iconWeb,
  });
}

class LiveRoomSummary {
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
    required this.keyframe,
    required this.watchedShow,
    required this.isAutoPlay,
  });
}
