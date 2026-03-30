import 'package:culcul/data/models/live/live_room_model.dart';
import 'package:culcul/features/live/domain/entities/live_room_summary.dart';

extension WatchedShowMapper on WatchedShow {
  LiveWatchedShow toDomain() {
    return LiveWatchedShow(
      switchStatus: switchStatus,
      num: this.num,
      textSmall: textSmall,
      textLarge: textLarge,
      icon: icon,
      iconWeb: iconWeb,
    );
  }
}

extension LiveRoomSummaryMapper on LiveRoomModel {
  LiveRoomSummary toDomain() {
    return LiveRoomSummary(
      roomId: roomId,
      uid: uid,
      title: title,
      uname: uname,
      cover: cover,
      face: face,
      online: online,
      areaName: areaName,
      parentAreaName: parentAreaName,
      link: link,
      keyframe: keyframe,
      watchedShow: watchedShow?.toDomain(),
      isAutoPlay: isAutoPlay,
    );
  }
}
