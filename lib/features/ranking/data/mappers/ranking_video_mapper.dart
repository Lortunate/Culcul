import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';

extension RankingVideoMapper on VideoModel {
  RankingVideo toDomain() {
    return RankingVideo(
      bvid: bvid,
      title: title,
      coverUrl: pic,
      duration: duration,
      ownerName: owner.name,
      viewCount: stat.view,
      danmakuCount: stat.danmaku,
    );
  }
}
